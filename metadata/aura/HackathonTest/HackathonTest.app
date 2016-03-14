<aura:application >
	<aura:registerEvent name="mu" type="c:GroupAddWindowPersonLineMouseUp"/>
	<aura:handler name="init" value="{!this}" action="{!c.doInit}" />

    <div  class="mainDiv" align="center">
    	<c:MainWindow />
    </div>
</aura:application>