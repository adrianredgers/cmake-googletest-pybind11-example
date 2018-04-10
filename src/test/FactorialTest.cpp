
#include <gtest/gtest.h>
#include <FactorialLib.h>


TEST(FactorialTest, HappyCase) {
    EXPECT_EQ(120, factorial(5)) << "Testing factorial 5";
}

TEST(FactorialTest, Negative) {
    EXPECT_GT(factorial(-10), 0);
}


