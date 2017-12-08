from random import randint


# 快速计算 (a * b ) mod m
def mod_mul(a, b, m):
    res = 0
    while b:
        if b & 1:
            res = (res + a) % m

        b >>= 1
        a = (a + a) % m
    return res


# 快速计算 (a ^ b) mod m
def mod_pow(a, b, m):
    res = 1
    while b:
        if b & 1:
            res = (mod_mul(res, a, m))
        b >>= 1
        a = mod_mul(a, a, m)

    return res


# 当a为合数n的证据是，witness返回true
def witness(a, n):
    temp = n - 1
    t = 0
    while temp % 2 == 0:
        temp //= 2
        t = t + 1
    u = (n - 1) // (1 << t)

    x = mod_pow(a, u, n)
    for i in range(t):
        y = mod_mul(x, x, n)  # y=x_i,x=x_{i-1}
        if y == 1 and x != 1 and x != (n - 1):
            return True
        x = y  # x=x_i

    if x != 1:
        return True
    return False


def miller_rabin(n, s):
    if n == 2:
        return True
    if n < 2 or n % 2 == 0:
        return False

    for i in range(s):
        a = randint(1, n - 1)
        if witness(a, n):
            return False
    return True


for N in [561, 1105, 1729, 2465, 2821, 6601]:
    if miller_rabin(N, 5):
        print('Yes')
    else:
        print('No')
