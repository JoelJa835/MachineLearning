format rat

m1 = [-5 ; 5]
m2 = [10 ; 15]

s1 = [11 9 ; 9 11]
s2 = [2 0 ; 0 2]

Sw = 1/2*(s1 + s2)

inv_Sw = inv(Sw)

w = inv_Sw * (m1 - m2)


