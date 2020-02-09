/// 
Class Demo.MessageDelay.Production.RoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="Demo.MessageDelay.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="" disabled="false">
<when condition="1">
<send transform="Demo.MessageDelay.ADTA08ToMessageDelayRequestDTL" target="Demo.MessageDelay.Operation"></send>
<return></return>
</when>
</rule>
<rule name="">
<constraint name="source" value="HL7FileService"></constraint>
<when condition="1">
<send transform="" target="HL7FileOperation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
