Class Demo.MessageDelay.Delayed Extends (%Library.Persistent, %Populate)
{

Property Timestamp As %Library.TimeStamp [ InitialExpression = {$zdt($zts,3)} ];

Property NHSNumber As %String;

Property AccountNumber As %String;

Property MessageId As %Integer;

Index idxNHSAccNumbers On (NHSNumber, AccountNumber) [ Unique ];

ClassMethod InsertUpdate(pNHSNumber, pAccountNumber, pMessageId, pStatus As %Status = {$$$OK}) As Demo.MessageDelay.Delayed
{
    /*
    The discharge summary goes through the normal transformation and then gets routed to the Discharge Summary Delayed Business Operation.
    The Discharge Summary Delayed Business Operation queries the Discharge Summary Delayed Table for the existence of a record for NHS Number and Account Number. 
    If found it updates the MessageID to the new MessageID else it inserts a new record (INSERT OR UPDATE may be a good choice here): 
    select * from DischargeSummaryDelayedTable where NHSNumber=? and AccountNumber=?
    if exists then
        update DischargeSummaryDelayedTable set MessageID=? where NHSNumber=? and AccountNumber=?
    else         
        insert into  DischargeSummaryDelayedTable (NHSNumber,AccountNumber,Timestamp, MessageID) values (?,?,?,?)
    */
    set delayed = ##class(Demo.MessageDelay.Delayed).idxNHSAccNumbersOpen(pNHSNumber,pAccountNumber)
    if ""=delayed {
        set delayed = ##class(Demo.MessageDelay.Delayed).%New()
        set delayed.NHSNumber = pNHSNumber
        set delayed.AccountNumber = pAccountNumber
    }
    ;     
    set delayed.MessageId = pMessageId
    set pStatus = delayed.%Save()
    return delayed
}

Query Process(pDelay As %Integer, pTimestampNow = {$zdt($zts,3)}) As %SQLQuery [ SqlProc ]
{
    /*
    The Discharge Summary Latest Business Service:
        Every Call Interval queries the Discharge Summary Delayed Table for records where the time difference 
        between the current time and the Timestamp >= to the Delay setting: 
            select MessageID from DischargeSummaryDelayedTable where (Now – Timestamp) >= Delay
            Loops over the result set to send message and on success delete record from the Discharge Summary Delayed Table
                Send message with MessageID to the Downstream Systems Business Service
                delete from DischargeSummaryDelayedTable where MessageID=?

    s ts1="2020-02-07 21:08:00"          
    s ts2="2020-02-08 01:08:00"          
    s h=$system.SQL.DATEDIFF("n",ts1,ts2)
    w
    h=240
    ts1="2020-02-07 21:08:00"
    ts2="2020-02-08 01:08:00" 

    s count = ##class(Demo.MessageDelay.Delayed).Populate()
    d ##class(%ResultSet).RunQuery("Demo.MessageDelay.Delayed","Process",240)
    */
select MessageId from Demo_MessageDelay.Delayed
 where DATEDIFF('n',Timestamp,:pTimestampNow) >= :pDelay
 order by MessageId
}

ClassMethod DeleteByMessageId(pMessageId) As %Status
{
    set status = $$$OK
    &sql(delete from Demo_MessageDelay.Delayed where MessageId = :pMessageId)
    if 0'=SQLCODE {
        set status = $$$ERROR($$$GeneralError,"Delete of record with MessageId="_pMessageId_" failed with SQLCODE="_SQLCODE)    
    }
    return status
}

Storage Default
{
<Data name="DelayedDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Timestamp</Value>
</Value>
<Value name="3">
<Value>NHSNumber</Value>
</Value>
<Value name="4">
<Value>AccountNumber</Value>
</Value>
<Value name="5">
<Value>MessageId</Value>
</Value>
</Data>
<DataLocation>^Demo.MessageDelay.DelayedD</DataLocation>
<DefaultData>DelayedDefaultData</DefaultData>
<IdLocation>^Demo.MessageDelay.DelayedD</IdLocation>
<IndexLocation>^Demo.MessageDelay.DelayedI</IndexLocation>
<StreamLocation>^Demo.MessageDelay.DelayedS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
