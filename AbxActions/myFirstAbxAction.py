

def handler(context, inputs):
    
    
    outputs = {}
    
    outputs["__metadata"] = inputs["__metadata"]
    user_account = outputs["__metadata"]["userName"]
    
    print("User Account Name : " + user_account)
    
    return outputs


