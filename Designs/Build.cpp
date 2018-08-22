//
//  Build.cpp
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 08. 22..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

#include "Build.hpp"
#include <stdio.h>

template < int i >
class  A
{
public:
    int a;
private:
    A<i-1>   x;
    A<i-2>   y;
};

template <> class A<0>
{
    char a;
};

template <> class A<1>
{
    char a;
};

template < int i >
class  B
{
public:
    int a;
private:
    B<i-1>   x;
    B<i-2>   y;
};

template <> class B<0>
{
    char a;
};

template <> class B<1>
{
    char a;
};

template < int i >
class  C
{
public:
    int a;
private:
    C<i-1>   x;
    C<i-2>   y;
};

template <> class C<0>
{
    char a;
};

template <> class C<1>
{
    char a;
};

template<bool V> struct answer { answer(int) {} bool operator()(){return V;}};

template<bool no, bool yes, int f, int p> struct IsPrimeHelper
: IsPrimeHelper<p % f == 0, f * f >= p, f + 2, p> {};
template<bool yes, int f, int p> struct IsPrimeHelper<true, yes, f, p> { using type = answer<false>; };
template<int f, int p> struct IsPrimeHelper<false, true, f, p> { using type = answer<true>; };

template<int I> using IsPrime = typename IsPrimeHelper<!(I&1), false, 3, I>::type;
template<int I>
struct X { static const int i = I; int a[i]; };

template<typename A> struct func;
template<>struct func<answer<true>>{
    template<int I> using typen = X<I>;
};
template<> struct func<answer<false>>{
    static const int typen = 0;
};

int foo(void)
{
    A<900> a;
    B<900> b;
    C<900> c;
    func<IsPrime<1>>::typen<1>();
    return a.a + b.a + c.a;
}
