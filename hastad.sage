from sage.all import *

# All the variable names mean the same as mentioned in the explanation
# For eg, a,b are the values in the function f = ax + b

def gcd(a, b): 
    while b:
        a, b = b, a % b
    return a.monic()

def franklinreiter(C1, C2, e, N, a1, b1,a2,b2):
    P.<X> = PolynomialRing(Zmod(N))
    g1 = (a1*X + b1)^e - C1
    g2 = (a2*X+b2)^e - C2
    result = -gcd(g1, g2).coefficients()[0]
    return int(result)

C1=7133574145118001624468851232768367610776481589816189114081484875167835285211475440236501712634938993477027789627285581268361018888589847771555770716521123959004389671272089766710340921550798461319697963644164596608774387203602804547184454077314801365322929817266934087883757605888082111393091270686060676504784482770435773757625762542094784777964406426404482882414828990658303263295993951921074284755818657012216398826105099627761519486438690405668440835527144374828045319113524249938249744799530870449189528166252037249009094063960558703857141043081099174412277124506544776530125652348821688752923438304710034397792
C2=8778761624514690203726370366823530128900480928985439769115219364620387269991756967930541323829570453896164780238656562595733025340650482503284244625778872560261904887674968133049252085507078563540106328260114811619983171932648876602484063356832075687231100750407167402096299904835776594509894740386041222719008023556447633524625419665210188090816622517361786836014525679069179481575048514551967532281399777505866483289055530051032001545010914680661193107730444980281645735808124289602346876529763644878375393094200846185413267940739865639764057094273259729425291615810027734657664217752026488492540376475948687563210
e=257
N=23446116820809956009508921267229329419806339208735431213584717790131416299556366048048977867380629435292555358502917305856047632651197352306945681062223443217527823509039445684919455982744684852068434951030105274549124012946448685060750456093120953320196777137936137902703756422225716380021864017594031233341531336018572970546112899850343992552126107820367629786159724290948728494321350895295087900001068499072242213916345639268473176748281877628559969801359815109260695490545357491404689132480248206287353580339535458835525161032145136894301169515951010316007454927062229765757932923091679510627796469997185047770119
a1 = 8104040836262507446864591234691358718164908580334110843106050982408624642389131164005601569999434432648709609777743793997208912520844943698036947408725027128235833538793471035056805185723079446135588491317378316082567779128276652380455054959975686544145446500257748715018799178783100289455255670805079936852471138049711583797615770901244436979110584710970079641409159097959783566594440737682826559724447739807028855072087914855150495360099989261682566388742966224528680792157619533719489447251411976029565538810357759752921276377948448704648350306514866111068184157760563297810978279434204440014428745729905509605285
b1 = 1728445028759460100268916851157941317747744991464848324630394207912877842639961858831903114707815701742483947978256582554473425946268457939887471248397622887505458768276338958573804608581353987536415380192782284575648580559755923454408763552113403890642303139141765381991794536720006159278517578791058556250982111713910060167032647218698362613084823406687399478088149985930840603408274198692032083156828441656375986195794109996772306557258447129571560905620272546405603257541870547380051900022925294193741417962861863860715434297040138205460211370506997331099668562619882982110566078451957682401843673938997454325985
a2 = 6932198124642373427967232343817468902255209063707505631753623131468591968939116907766874533903771236309508029958603993113318003707536772796355326212684792901937391081839814883783063784050698582961314998290360613480778658142959804536224436521802834308095784814005774038096434723020316915995654759582638114351622288228138452404715021874261743824588698845194567350953613460211780903933501965152586633117799392776012574047439430079820078546000748259648002297803211427390366076552057374120223207399161502626197672749700677144769182115211864885324511059266535644202147069163420794861424973102200053615106664642762054707456
b2 = 17570492860498497589391311850810042101436988882059207563836745301643757694348737390349588510867234608796253222240056487274815481193573640552151307710984790365040907600873879523821340341063776797845384078798440533883164972773525749702026085462782235008812515983104980108840777316735468521572249232663287631112374534186975231033281807029801530398687397396929300293283833448151885674196708775598652356402354479252567714152805778278207736053329489014866155493921442482258381840272615320018058870234668488517354399053820878325928972260161611818894133121294554947400621261460441395783860055835185154356326202402937413717222


print(franklinreiter(C1, C2, 257, N, a1, b1,a2,b2))