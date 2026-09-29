
def transition_function(curr_state:str, delta:dict, letter:str)->str:
    return delta[curr_state][letter]

def matchDFA(init,sigma,F,delta,lang):
    curr = init
    for l in lang:
        if l not in sigma:
            return False
        curr = transition_function(curr,delta,l)
        #print(curr,l)

    return True if curr in F else False

#Main event Loop

def main():
    #Set of states (Q)

    #Symbols in the alphabet (Sigma)
    sigma = {"a","b"}

    #Starting state (q0)
    start_state = "q0"

    #Set of Final States (F)
    accepting_states = {"q3"}

    #Transition function (delta)
    transition_table = {}
    transition_table["q0"] = {"a":"q1","b":"q3"}
    transition_table["q1"] = {"a":"q0","b":"q2"}
    transition_table["q2"] = {"a":"q0","b":"q2"}
    transition_table["q3"] = {"a":"q1","b":"q3"}

    lang  = ["aba"  ,"aaab" ,"aabaabb", "aaab","bbbbb", "baaaaaaaa","abbaa",""]
    #False, False, True, False, True, False, False, False
    
    res =  []
    for l in lang:
        res.append(matchDFA(start_state, sigma, accepting_states, transition_table,l)) 
    print(res)




if __name__ == "__main__":
    main()





##Problem 3
##Set of states (Q)
#states = {"q0","q1","q2","q3"}
#
##Symbols in the alphabet (Sigma)
#sigma = {"a","b"}
#
##Starting state (q0)
#start_state = "q0"
#
##Set of Final States (F)
#accepting_states = {"q3"}
#
##Transition function (delta)
#transition_table = {}
#transition_table["q0"] = {"a":"q0","b":"q1"}
#transition_table["q1"] = {"a":"q2","b":"q1"}
#transition_table["q2"] = {"a":"q0","b":"q3"}
#transition_table["q3"] = {"a":"q0","b":"q0"}


##problem 2

##Symbols in the alphabet (Sigma)
#sigma = {"a","b"}
#
##Starting state (q0)
#start_state = "q0"
#
##Set of Final States (F)
#accepting_states = {"q4","q7"}
#
##Transition function (delta)
#transition_table = {}
#transition_table["q0"] = {"a":"q1","b":"q5"}
### A Path
#transition_table["q1"] = {"a":"q2","b":"q5"}
#transition_table["q2"] = {"a":"q2","b":"q3"}
#transition_table["q3"] = {"a":"q4","b":"q3"}
#transition_table["q4"] = {"a":"q4","b":"q4"}
### B Path
#transition_table["q5"] = {"a":"q6","b":"q5"}
#transition_table["q6"] = {"a":"q7","b":"q6"}
#transition_table["q7"] = {"a":"q7","b":"q7"}
#
#lang  = ["aba"  ,"aaab" ,"aabaabab", "aaa","bbbbb", "baaaaaaaa","abbaa"]
