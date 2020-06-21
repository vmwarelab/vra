
import requests

def handler(context, inputs):
    
    response = requests.get('https://raw.githubusercontent.com/vmwarelab/vra/master/AbxActions/properties/userDefinedVariableNumber.txt')
    response.encoding = 'utf-8'
    new_value = response.text.replace("\n","")
    print(new_value)
    old_userDefinedVariableNumber = inputs["customProperties"]["userDefinedVariableNumber"]
    new_userDefinedVariableNumber = new_value
    
    
    outputs = {}
    
    outputs["customProperties"] = inputs["customProperties"]
    outputs["customProperties"]["userDefinedVariableNumber"] = new_userDefinedVariableNumber
    
    print("Setting userDefinedVariableNumber value from {0} to {1}".format(old_userDefinedVariableNumber, new_userDefinedVariableNumber))
    
    return outputs


