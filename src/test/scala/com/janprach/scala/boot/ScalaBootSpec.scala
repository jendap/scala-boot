package com.janprach.scala.boot

import org.scalatest.FlatSpec
import org.scalatest.Matchers

class ScalaBootSpec extends FlatSpec with Matchers {
  it should "assert 1 + 1 using shouldBe" in {
    (1 + 1) shouldBe 2
  }

  it should "assert 1 + 1 using ===" in {
    assert(1 + 1 === 2)
  }
}
