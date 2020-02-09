Class Demo.MessageDelay.InboundAdapter Extends Ens.InboundAdapter
{

Parameter SETTINGS = "Delay:Message Delay";

/// Delay in minutes.
Property Delay As %Integer [ InitialExpression = 240 ];

Method OnTask() As %Status
{
    /*
    The Discharge Summary Latest Business Service:
    Every Call Interval queries the Discharge Summary Delayed Table for records where the time difference between the current time and the Timestamp >= to the Delay setting: 
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
        
        ; Map debug global to IRISTEMP
        set ^temp.debug($namespace,$ClassName(),messageId,"ProcessInput()","status") = $system.Status.GetErrorText(status)
        set ^temp.debug($namespace,$ClassName(),messageId,"delete","status") = $system.Status.GetErrorText(status)
    */
    set statement = ##class(%SQL.Statement).%New()
 	set status = statement.%PrepareClassQuery("Demo.MessageDelay.Delayed", "Process")
    if $$$ISOK(status) { 
        #dim statementResult as %SQL.StatementResult = statement.%Execute(..Delay)
        set ^temp.debug($namespace,$ClassName(),"OnTask()",1) = $g(^temp.debug($namespace,$ClassName(),"OnTask()",2))
        set ^temp.debug($namespace,$ClassName(),"OnTask()",2) = $h
        while statementResult.%Next(.status) {
            quit:$$$ISERR(status)
            set messageId = statementResult.%Get("MessageId")
            set stringContainer = ##class(Ens.StringContainer).%New(messageId) 
            set status = ..BusinessHost.ProcessInput(stringContainer)
            ; Map debug global to IRISTEMP
            set ^temp.debug($namespace,$ClassName(),messageId,"ProcessInput()","status") = $system.Status.GetErrorText(status)
            if $$$ISOK(status) {
                set status = ##class(Demo.MessageDelay.Delayed).DeleteByMessageId(messageId)
                set ^temp.debug($namespace,$ClassName(),messageId,"delete","status") = $system.Status.GetErrorText(status)
            }   
        }
    }
    return status
}

}
