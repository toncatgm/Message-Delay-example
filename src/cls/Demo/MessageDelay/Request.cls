/// The Discharge Summary message needs to be transformed into this request. 
Class Demo.MessageDelay.Request Extends Ens.Request
{

Property NHSNumber As %String;

Property AccountNumber As %String;

Property MessageId As %Integer;

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>NHSNumber</Value>
</Value>
<Value name="2">
<Value>AccountNumber</Value>
</Value>
<Value name="3">
<Value>MessageId</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
