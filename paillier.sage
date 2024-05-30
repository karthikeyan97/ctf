from sage.all import *
from random import randint

class Paillier:
    def __init__(self, bits):
        self.bits = bits
        self.pub, self.priv = self.keygen()

    def __init__(self ,public,private):
        self.bits = 1024
        self.pub, self.priv = (public,private)

    def keygen(self):
        p = random_prime(2**self.bits)
        q = random_prime(2**self.bits)
        Lambda = (p - 1) * (q - 1)
        n = p * q
        Zn = IntegerModRing(n)
        Zn2 = IntegerModRing(n**2)
        g = Zn2(n + 1)
        mu = Zn(Lambda)**-1
        return ((n, g), (Lambda, mu))

    def encrypt(self, m):
        (n, g) = self.pub
        Zn2 = IntegerModRing(n**2)
        r = Zn2(randint(0, n))
        c = g**Zn2(m) * r**n
        return c

    def decrypt(self,c):
        Zn = IntegerModRing(public[0])
        Zn2 = IntegerModRing(public[0]**2)
        return Zn((int(Zn2(c**self.priv[0]))//public[0])*self.priv[1])


    def add(self, cipher_1, cipher_2):
        (n, g) = self.pub
        Zn2 = IntegerModRing(n**2)
        r = Zn2(randint(0, n))
        return cipher_1 * cipher_2 * r**n

    def sub(self, cipher_1, cipher_2):
        (n, g) = self.pub
        Zn2 = IntegerModRing(n**2)
        r = Zn2(randint(0, n))
        inv_cipher_2 = Zn2(cipher_2)**-1
        return cipher_1 * inv_cipher_2 * r**n

    def get_keys(self):
        return self.pub, self.priv

def toStr(msg):
    return int.to_bytes(int(msg))

# Generate key pairs
def main():
    paillier = Paillier(1024)
    pub_key, priv_key = paillier.get_keys()
    message_1 = randint(0, 420)
    cipher_1 = paillier.encrypt(message_1)
    message_2 = int.from_bytes(b"im so smrt, check me out mom")
    cipher_2 = paillier.encrypt(message_2)
    flag_message = int.from_bytes(b"L3AK{FAKE_FLAG_FAKE_FLAG}")
    flag_cipher = paillier.encrypt(flag_message)
    diff_cipher = paillier.sub(cipher_2, cipher_1)
    flag_cipher_modified = paillier.add(flag_cipher, diff_cipher)
    with open("challenge.txt", "w") as f:
        f.write(f"Ciphertext #1 = {hex(int(cipher_1))}\n")
        f.write(f"Ciphertext #2 = {hex(int(cipher_2))}\n")
        f.write(f"Modified Flag Cipher = {hex(int(flag_cipher_modified))}\n")
        f.write(f"Public Key = {hex(int(pub_key[0]))}, {hex(int(pub_key[1]))}\n")
        f.write(f"Private Key = {hex(int(priv_key[0]))}, {hex(int(priv_key[1]))}\n")
    

ct1= 0x14060da59e64dc74087b911f612d2c45d8253cb3d7cb322b3aea545b05460880b7c5cd99cdaad15d2bf7b92a5315c9cf6e1c962ebb1100e1b9d0b5f768419069cb4e53281c15d8a432f90ad33c6a3680c7a56df8680bf22765b4b5977bc30cdb49ea1dab83694268bf6869dcd587a8be2475330c339d441e8ce254559c3fe5e2b0296dd0239924e318d86b4c9f2babd2b49bf103fb6cc340e0bffe0dac3fda06aeb1e763f9d6713d62aee4aa9b7806b9dd1f311a528cd9531d997dfe31190f457af2576a79e4f873da57a28da763e07037dd6c7d14ef978bdcb857c7559ebe774c8db2ca34fc5841df1362ae768db89690216594c48ef23bd131618c3978a3bb36d420907947d862490376e20a9af43583960641b37a5733ee4082f8eb750d30eb8177e8af1d2589785b81d7e74c9ad386ef8280bc6c0d275bb95bb0cffd8b3e73db2e438880ff2f7bdd2bdfc0c8f3ee5265196d11eb9e4f5db8d643d5dc2d7c5372bad82d62cd2966ce033c5c609db288ef8484a664f4e33d19ce218ced0e7f46256c41d827813f4cb65425240762cc6e1c87421ff851c50f0c011e39655640bf3b8db0f43cb5ed93fb1967209d446d996c29abd76fa952fe31050b85d0e350dddc924421c3606d686e72d5764e0a596c95607ecb92a7cc7fe8c8b031e2877774f7df1e842107a4048306449ca7d66eb0cbfcd13b6b6cd3e2ae719b8e20530
ct2= 0x50258985886970e93e6b0105d26e42efe033a8216f721eaf981f89e9287b04ddfe5f16d3f6fcef6e814376c266e6738b29e47eb70b97fa9ff03e0e29e17d32d131550b94df94b7484f73592ecd15848594e9fc93e3401848b437bd6a8c67159c5410a32eebeab7285365ea69bfeeaaef975af1dd55c250bc30c709cdc631aa678f7e2795c6c5d66187974de4c6bfb30da14a9f9a91fcac9eccb463196d621ecdbeda28d682401c960a2dca58730766a6cecb83630ca92523b5bdd7c97019adc1754d0598d082cf51337e434bd2683d70ca074c276dc0e386a3a9a9ef189eff84a2acbdd7c1891c113589244d41d541dbc7a88639ab05b3c57cdd8fdfdbc7d3a9619bb8b0db85ce3e66640d2e1821da55ebdfb09e73230a08ad49d72707d4639763c8196568eb5654466743dd66c6cf37fafc97004aa0c063f54b145fb8d33dea6eb371af6e66d3e6fb3fa082712b5e4ad70580808fd650cc056aa17a88cc4ad0387701237f81a7039071aac653314a7dfe6fccd2b1e87cdf43832425a97ff9c5383133b6e984d9fb2132a80ee9b05cc7a2a493f9bc2197ba940826cdedd667a515d1554539eabc1ebdc9dd2075b80f98fa5e125a78891e64eb57f5e5eba97200d5c76f5d49646eda8671f5d289c1f8ca7c5033466b636052f10fbf0026c3c15f19b805271f9322a1c674cc33f69b725feb8a9087c05cc490c63fb467f499d9f
flag= 0x410f09e83a921ff2e06f9af688d56962be6b6db5472d84c802c89505bc80dcb06f09fba8cea712f3bd0af654b1e9c7010a20fe4bee9537c3e44771b90547103f9a313df10de3df68862c98ce7bfff47dc0547b65867b0990fd9ac496bf8e5df6c4fc8ad2ad074fb5083532dbb1f2373b9183770e2fda35498fa1753bb8ec4b1fcf80f100ae20eb8e865ef80e46435f75ec998af6cebb64717d76af38f926470207b8753bd94c0e55d7eaf7a5c352d718feead815aa886e585865c812f840da04fa24f411fc5917efcfc7549a41a22aed031842309709d93eb4818c62a00614f0ac13ac909454cb56780658d6188f813ba77ae52b76b2979423d9e62118a17114b8572a3219fda1e9399d91249fbb32b4e06615ce91de513f14231f42fe6b1e27027a22841554399b5c699a68dd308f0d11ed00580d703e9ea61710378b06bf3e55a4c6405e523184a3f4f9838c06ee650c7002b69106c8d7569c7f0628093fe61acbd2ce52654f6ebed132789daba9b26b989e3c6283326dec6c63df9ecfb60620cac002e680691d3cb8e4b4139596973a333eb5942f8512919e6b338631675c2c9ab58115aeaee009870a2a3d121c16574476211cdac81b78618f101315c694005ab7478546538e43559c3d29fb9508a1ca5a6e7afc046d0b450165f34ed611156ab9485adffd118013f8477ed8b7cf95f9008d0f140226644c99920af5633
public = (0x250fb952a1b9ed84701fa2fe7b90615e4144635d26a566231e2eeefae591c74fdf8a775425cf26ee84b48460417ff1859f4279c703258b325e7196656293c9225db58a9b6054fa83a2e44fc00eb058dd3e1660fbdc79cfd427aa90b0e0efdc40e02753c715ea9e7de1f282554d99c22ba883ca433577f8eac31dcfa55117c933cb69c969d91065a5276eb07e81caaf4fb332cc0f40cf5c049b8e8c78288f7b7a7d71fc5e1dba03eab6359bca909157e8a422c03ec852ae8b6fd8eaf7a37b2e3b680448f42724a3431aa73df3debdc052791ee2d0d57499fa2f1a21cb10bfdd14c148545d59fb7c90b679d44d4ad298ea6e15f4782faf9c53b8c3cda7536f11a5, 0x250fb952a1b9ed84701fa2fe7b90615e4144635d26a566231e2eeefae591c74fdf8a775425cf26ee84b48460417ff1859f4279c703258b325e7196656293c9225db58a9b6054fa83a2e44fc00eb058dd3e1660fbdc79cfd427aa90b0e0efdc40e02753c715ea9e7de1f282554d99c22ba883ca433577f8eac31dcfa55117c933cb69c969d91065a5276eb07e81caaf4fb332cc0f40cf5c049b8e8c78288f7b7a7d71fc5e1dba03eab6359bca909157e8a422c03ec852ae8b6fd8eaf7a37b2e3b680448f42724a3431aa73df3debdc052791ee2d0d57499fa2f1a21cb10bfdd14c148545d59fb7c90b679d44d4ad298ea6e15f4782faf9c53b8c3cda7536f11a6)
private = (0x250fb952a1b9ed84701fa2fe7b90615e4144635d26a566231e2eeefae591c74fdf8a775425cf26ee84b48460417ff1859f4279c703258b325e7196656293c9225db58a9b6054fa83a2e44fc00eb058dd3e1660fbdc79cfd427aa90b0e0efdc40e02753c715ea9e7de1f282554d99c22ba883ca433577f8eac31dcfa55117c933057d339c308438050366c6b40808a18b4448dfe495c06abe52abdaaeb86381c86a14ad5d91ff1b25aaf1e82d0e429c8622cd435389169a066357ef488c1725ec0812d3a8edd7bc93d5ac7344c074169dbfd52949913cb9779ce1f7aab96b9a8a554fb17493075a862ab37d30ea4fe91e5ee6f9b95e280b297e91357454800c60, 0x21c0ff97d130be489dd28344be8a9022b1ecbca51a8555c52e3512f65786623289f7effbda90d9e52e3066af88464b5157984983fdbd4a0a60eea984bb427230d6f4e0de54954ccc8efc58127b58fb02fed0ea47f4bd28072be2e02fa58abf65d15a644a55f847feca9e29596aa9fb6137d0bfa68c1a69e1f425f20063c8bf256b7aa3920b149169ca4cabbe2c3668d8edbca2d0f7e7d0d131397a0b102339f6824153f7b6bc7837f255dd947ef53607e0ef91f08665e9125fc374689c3d515985d28313e1b9d4c2554e8780bb485f3e7c5999a30b94d2b5d0762b5adf7a031782a0488249ca109e9590aa9e611ed2dbc4ea9758d397d30ce11b0f8c2a683bc6)

Cipher=Paillier(public,private)
diff = Cipher.sub(ct2,ct1)
actualFlag = Cipher.sub(flag,diff)
print(Cipher.decrypt(actualFlag))
