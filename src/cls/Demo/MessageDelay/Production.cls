Class Demo.MessageDelay.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="Demo.MessageDelay.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="MsgRouter" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="This handles message routing logic." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">Demo.MessageDelay.Production.RoutingRule</Setting>
    <Setting Target="Host" Name="BadMessageHandler">BadMessageHandler</Setting>
  </Item>
  <Item Name="BadMessageHandler" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="Bad messages are sent to this operation." LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Ens.Alert" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="0" Enabled="true" Foreground="false" Comment="This handles Alert routing logic." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Demo.MessageDelay.Production.AlertRule</Setting>
  </Item>
  <Item Name="EMailAlert" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="This sends alerts via e-mail." LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="PagerAlert" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="This sends alerts to a pager via e-mail." LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="HL7FileService" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="false" Foreground="false" Comment="This is a default HL7 File Service." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">MsgRouter</Setting>
  </Item>
  <Item Name="HL7FileOperation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="This is a default HL7 File Operation." LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/Applications/InterSystems/ensemble/HL7/Out/</Setting>
  </Item>
  <Item Name="Demo.MessageDelay.Service" Category="" ClassName="Demo.MessageDelay.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Delay">1</Setting>
    <Setting Target="Host" Name="TargetHostname">HL7FileOperation</Setting>
    <Setting Target="Adapter" Name="CallInterval">5</Setting>
  </Item>
  <Item Name="Demo.MessageDelay.Operation" Category="" ClassName="Demo.MessageDelay.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
