package com.janprach.scala.boot

import org.scalatest.{FlatSpec, Matchers}

class ScalaBootSpec extends FlatSpec with Matchers {
  it should "add 1 + 1" in {
    (1 + 1) should equal(2)
  }
}
