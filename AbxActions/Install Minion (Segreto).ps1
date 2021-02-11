function Handler($context, $inputs) {
    $inputsString = $inputs | ConvertTo-Json -Compress
    $tmpl_pass = $context.getSecret($inputs.customProperties.tmpl_pass)
    $tmpl_user = $inputs.customProperties.tmpl_user
    $mioSegreto = $context.getSecret($inputs.customProperties.mioSegreto)   
    $vcuser = $context.getSecret($inputs.vcUsername)
    $vcpassword = $context.getSecret($inputs.vcPassword)  
    $vcfqdn = $context.getSecret($inputs.customProperties.vcfqdn)
    $vrss = $context.getSecret($inputs.vrss) 

    $name = $inputs.resourceNames[0]
    $hostname = $inputs.resourceNames[0]
    
    Connect-VIServer $vcfqdn -User $vcuser -Password $vcpassword -Force
    write-host “Waiting for VM Tools to Start”
    do {
    $toolsStatus = (Get-vm -name $name | Get-View).Guest.ToolsStatus
    write-host $toolsStatus
    sleep 3
    } until ( $toolsStatus -eq ‘toolsOk’ )
    $vm = Get-vm -name $name
    $output = $inputs.customProperties.softwareName
    Write-Host "VM OS Type is "$output
    
    $windowsString = 'Microsoft Windows Server 2016 or later (64-bit)'
    
    if ($output.Equals($windowsString)) {
        $os_type = "Minion installed on Windows"
        $script = "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force; Invoke-WebRequest https://repo.saltstack.com/windows/Salt-Minion-3002-Py3-x86-Setup.exe -UseBasicParsing -OutFile ~\Downloads\minion.exe"
        $script2 = "~\Downloads\minion.exe /S /master=$vrss /minion-name=$hostname"
        
        Start-Sleep -s 60
        Write-Host $tmpl_user
        Write-Host $tmpl_pass
        
        $runscript = Invoke-VMScript -VM $vm -ScriptText $script -GuestUser $tmpl_user -GuestPassword $tmpl_pass -ToolsWaitSecs 300
        Write-Host $runscript.ScriptOutput
        
        $runscript2 = Invoke-VMScript -VM $vm -ScriptText $script2 -GuestUser $tmpl_user -GuestPassword $tmpl_pass -ToolsWaitSecs 300
        Write-Host $runscript2.ScriptOutput
        
        Write-Host "Minion installed on Windows using EXE"

    } else {
        $os_type = "Minion installed on Linux"
        $script = "echo $tmpl_pass | sudo -S curl -L https://bootstrap.saltstack.com -o install_salt.sh && echo $tmpl_pass | sudo -S hostnamectl set-hostname $hostname && echo $tmpl_pass | sudo -S chmod 777 install_salt.sh && echo $tmpl_pass | sudo -S sh install_salt.sh -A $vrss"
        <#Write-Host $script#>
        Start-Sleep -s 60
        $runscript = Invoke-VMScript -VM $vm -ScriptText $script -GuestUser $tmpl_user -GuestPassword $tmpl_pass -ToolsWaitSecs 300
        <#Write-Host $runscript.ScriptOutput#>
        Write-Host = "Used bootstrap"
    }

}


