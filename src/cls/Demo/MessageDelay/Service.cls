Class Demo.MessageDelay.Service Extends Ens.BusinessService
{

Parameter ADAPTER = "Demo.MessageDelay.InboundAdapter";

Parameter SETTINGS = "TargetHostname:Message Delay:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId}";

Property TargetHostname As %String [ InitialExpression = "Demo.MessageDelay.SendOperation" ];

Method OnProcessInput(pStringContainer As Ens.StringContainer, Output pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
    set messageId = pStringContainer.StringValue
    set request = ##class(EnsLib.HL7.Message).%OpenId(messageId)
    set status = ..SendRequestAsync(..TargetHostname,request)
	return status
}

}
