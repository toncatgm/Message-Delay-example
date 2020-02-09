Class Demo.MessageDelay.Operation Extends Ens.BusinessOperation
{

/// This is the default message handler.  All request types not declared in the message map are delivered here
Method OnMessage(pRequest As Demo.MessageDelay.Request, Output pResponse As %Library.Persistent) As %Status
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
    
    set status = $$$OK

    set delayed = ##class(Demo.MessageDelay.Delayed).InsertUpdate(pRequest.NHSNumber,pRequest.AccountNumber,pRequest.MessageId,.status)

    return status
}

}
