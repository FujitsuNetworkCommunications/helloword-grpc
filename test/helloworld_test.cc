#include "gtest/gtest.h"

class Helloworld_test : public ::testing::Test {
};

TEST_F(Helloworld_test, place_holder) {
  ASSERT_EQ(0, 0);
}
