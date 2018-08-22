//
//  Build.cpp
//  Designs
//
//  Created by Tibi Kolozsi on 2018. 08. 22..
//  Copyright © 2018. ITK-iOS. All rights reserved.
//

#include "Build.hpp"

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
    func<IsPrime<1223>>::typen<1>();
    return 0;
}
