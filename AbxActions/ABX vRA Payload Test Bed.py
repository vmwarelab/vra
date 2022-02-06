def handler(context, inputs):
    
    ###################################################
    #              Capture Needed Data                #
    #                From Payload                     #
    ###################################################
    
    #Assigning variabels from the inputs payload
    vmName = inputs["payload"]['resourceNames'][0]
    vmAddr = inputs["payload"]["addresses"][0][0]
    
    #Assigning variabels from the inputs payload customProperties key for a VCT property called dnsZone
    dnsZone = inputs["payload"]["customProperties"]["dnsZone"]
    
    #Assigning variabels from the action default inputs
    abxInputNameIn = inputs["abxInputNameIn"]
    
    # Assigning Decrypted secret variabels from the inputs payload customProperties key for a VCT property called tmplPass
    tmplPassword1 = context.getSecret(inputs["payload"]["customProperties"]["tmplPass"])
    
    #Assigning Encrypted secret variabels from the inputs payload customProperties key for a VCT property called tmplPass
    tmplPassword2 = inputs["payload"]["customProperties"]["tmplPass"]
   
    #Assigning Decrypted secret variabels from the action default inputs
    vcPass1 = context.getSecret(inputs["vcPassword"])
    tmplPass1 = context.getSecret(inputs["template_password_linux"])
    
    #Assigning Encrypted secret variabels  from the action default inputs
    vcPass2 = inputs["vcPassword"]
    tmplPass2 = inputs["template_password_linux"]
    
    
    #Testing Printing Variables in the log
    print(f'VM Name: {vmName}')
    print(f'IP Address: {vmAddr}')
    print(f'DNS Zone: {dnsZone}')
    print(f'ABX abxInputNameIn Input: {abxInputNameIn}')
    
    print(f'Decrypted Custom Property Secret: {tmplPassword1}')
    print(f'Decrypted ABX Secret Action Constant Input: {vcPass1}')
    print(f'Decryped ABX Secret Input: {tmplPass1}')
    
    print(f'Encrypted Custom Property Secret: {tmplPassword2}')
    print(f'Encrypted ABX Secret Input: {tmplPass2}')
    print(f'Encrypted ABX Secret Action Constant Input: {vcPass2}')
   
   
    ###################################################
    #                Your Main Code                   #
    ###################################################
    
    
    #Returing the custom propretie dictionalry back to the output variable
    outputs = inputs["payload"]["customProperties"]

    return outputs

