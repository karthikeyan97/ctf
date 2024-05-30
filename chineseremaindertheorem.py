import gmpy2
from Crypto.Util.number import inverse, long_to_bytes
from Crypto.Util.number import long_to_bytes
import pandas as pd
import sys
gmpy2.get_context().precision=400
df=pd.read_csv("rsa.csv")[0:1337]
print(len(df))
n=[]
a=[]
for iter,row in df.iterrows():
    n.append(int(row['n']))
    a.append(int(row['a']))

N = 1
# Calcul N value
for i in n:
    N = N * int(i)

# Compute E
E = [N // n[i] for i in range(len(n))]

# Get all y values
y = [gmpy2.powmod(E[i],-1,n[i]) for i in range(len(n))]

# do the calcul x = ai * Ni * yi ... 
x = 0
for i in range(len(n)):
        x += a[i]*E[i]*y[i]
# Get the uniq solution
x%=N
x=int(gmpy2.root(x,len(df)))
print(long_to_bytes(x))

