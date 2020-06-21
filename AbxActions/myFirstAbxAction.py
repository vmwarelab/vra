

def handler(context, inputs):
    
    new_value = '5678'
    
    outputs = {}
    
    outputs["customProperties"] = inputs["customProperties"]
    outputs["customProperties"]["userDefinedVariableNumber"] = new_value
    
    print("userDefinedVariableNumber new value is : " + new_value)
    
    return outputs


