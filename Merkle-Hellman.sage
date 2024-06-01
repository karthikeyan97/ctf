# open the public key and strip the spaces so we have a decent array
from sage.all import Matrix,ZZ

# open the encoded message
encoded = open('enc.txt','r').read().split(",")
flag=""
for k in range(0,len(encoded)):
    # create a large matrix of 0's (dimensions are public key length +1)
    cipher=encoded[k]
    fileKey = open("key.txt", 'r')
    pubKey = fileKey.read().replace(' ', '').replace('L','').split(',')
    nbit = len(pubKey)
    A = Matrix(ZZ,nbit+1,nbit+1)
    # fill in the identity matrix
    for i in range(nbit):
        A[i,i] = 1
    # replace the bottom row with your public key
    for i in range(nbit):
        A[i,nbit] = pubKey[i]
    # last element is the encoded message
    A[nbit,nbit] = -int(cipher)

    res = A.BKZ(block_size=42)
    isFlag=True
    for i in res:
        isFlag=True
        flag=""
        for j in range(0,len(i)-1):
            if not (i[j] == 0 or i[j] ==1):
                isFlag=False
        if isFlag:
            for j in range(0,len(i)-1):
                flag+=str(i[j])
            print(k,flag)
            break
#    if not isFlag:
 #       print("===============================")
  #      print(res)
