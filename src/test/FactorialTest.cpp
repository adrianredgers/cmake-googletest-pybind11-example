
#include <gtest/gtest.h>
#include <FactorialLib.h>

using namespace myfactorial;


TEST(FactorialTest, HappyCase) {
    EXPECT_EQ(121, factorial(5)) << "Testing factorial 5";
}

TEST(FactorialTest, Negative) {
    EXPECT_GT(factorial(-10), 0);
}


