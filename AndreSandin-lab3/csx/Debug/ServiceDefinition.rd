<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="AndreSandin_lab3" generation="1" functional="0" release="0" Id="41c3b11c-6187-44dc-8059-d89c918328c7" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="AndreSandin_lab3Group" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="WebRole1:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/LB:WebRole1:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="WebRole1:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWebRole1:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WebRole1Instances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWebRole1Instances" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleFRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWorkerRoleFRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleFRSInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWorkerRoleFRSInstances" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleHRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWorkerRoleHRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="WorkerRoleHRSInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/MapWorkerRoleHRSInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:WebRole1:Endpoint1">
          <toPorts>
            <inPortMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapWebRole1:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWebRole1Instances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1Instances" />
          </setting>
        </map>
        <map name="MapWorkerRoleFRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleFRS/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleFRSInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleFRSInstances" />
          </setting>
        </map>
        <map name="MapWorkerRoleHRS:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleHRS/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapWorkerRoleHRSInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleHRSInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="WebRole1" generation="1" functional="0" release="0" software="C:\Users\sandi\OneDrive\Skrivbord\Sandin-Andre\AndreSandin-lab3\AndreSandin-lab3\csx\Debug\roles\WebRole1" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="-1" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WebRole1&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebRole1&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleFRS&quot; /&gt;&lt;r name=&quot;WorkerRoleHRS&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1Instances" />
            <sCSPolicyUpdateDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1UpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1FaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRoleFRS" generation="1" functional="0" release="0" software="C:\Users\sandi\OneDrive\Skrivbord\Sandin-Andre\AndreSandin-lab3\AndreSandin-lab3\csx\Debug\roles\WorkerRoleFRS" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRoleFRS&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebRole1&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleFRS&quot; /&gt;&lt;r name=&quot;WorkerRoleHRS&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleFRSInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleFRSUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleFRSFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="WorkerRoleHRS" generation="1" functional="0" release="0" software="C:\Users\sandi\OneDrive\Skrivbord\Sandin-Andre\AndreSandin-lab3\AndreSandin-lab3\csx\Debug\roles\WorkerRoleHRS" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaWorkerHost.exe " memIndex="-1" hostingEnvironment="consoleroleadmin" hostingEnvironmentVersion="2">
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;WorkerRoleHRS&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;WebRole1&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;WorkerRoleFRS&quot; /&gt;&lt;r name=&quot;WorkerRoleHRS&quot; /&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleHRSInstances" />
            <sCSPolicyUpdateDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleHRSUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WorkerRoleHRSFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="WebRole1UpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRoleHRSUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="WorkerRoleFRSUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="WebRole1FaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRoleFRSFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="WorkerRoleHRSFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="WebRole1Instances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRoleFRSInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="WorkerRoleHRSInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="fb01a910-38e0-4ae7-8278-5dbda1ef61f8" ref="Microsoft.RedDog.Contract\ServiceContract\AndreSandin_lab3Contract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="29b07acb-5f2b-42c6-a0c6-6476a5941927" ref="Microsoft.RedDog.Contract\Interface\WebRole1:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/AndreSandin_lab3/AndreSandin_lab3Group/WebRole1:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>