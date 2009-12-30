require File.dirname(__FILE__) + '/../test_helper'

class TestCldrNumericFormat < Test::Unit::TestCase
  define_method "test: interpolates a number" do
    assert_equal '123', Cldr::Format::Numeric.new('###').apply(123)
  end

  define_method "test: interpolates a number on the right side" do
    assert_equal '0123', Cldr::Format::Numeric.new('0###').apply(123)
  end

  define_method "test: strips optional digits" do
    assert_equal '123', Cldr::Format::Numeric.new('######').apply(123)
  end

  define_method "test: single group" do
    assert_equal '1,23', Cldr::Format::Numeric.new('#,##').apply(123)
  end

  define_method "test: multiple groups with a primary group size" do
    assert_equal '1,23,45,67,89', Cldr::Format::Numeric.new('#,##').apply(123456789)
  end

  define_method "test: multiple groups with a primary and secondary group size" do
    assert_equal '12,34,56,789', Cldr::Format::Numeric.new('#,##,##0').apply(123456789)
  end

  define_method "test: does not group when no digits left of the grouping position" do
    assert_equal '123', Cldr::Format::Numeric.new('#,###').apply(123)
  end

  define_method "test: interpolates a fraction" do
    assert_equal '123.45', Cldr::Format::Numeric.new('###.##').apply(123.45)
  end

  define_method "test: rounds a fraction" do
    assert_equal '123.46', Cldr::Format::Numeric.new('###.##').apply(123.456)
  end

  define_method "test: interpolates fraction on the left side" do
    assert_equal '123.4500', Cldr::Format::Numeric.new('###.0000#').apply(123.45)
  end

  define_method "test: cldr example #,##0.## => 1 234,57" do
    assert_equal '1 234,57', Cldr::Format::Numeric.new('#,##0.##', :decimal => ',', :group => ' ').apply(1234.567)
  end

  define_method "test: cldr example #,##0.### => 1 234,567" do
    assert_equal '1 234,567', Cldr::Format::Numeric.new('#,##0.###', :decimal => ',', :group => ' ').apply(1234.567)
  end

  define_method "test: cldr example ###0.##### => 1234,567" do
    assert_equal '1234,567', Cldr::Format::Numeric.new('###0.#####', :decimal => ',', :group => ' ').apply(1234.567)
  end

  define_method "test: cldr example ###0.0000# => 1234,5670" do
    assert_equal '1234,5670', Cldr::Format::Numeric.new('###0.0000#', :decimal => ',', :group => ' ').apply(1234.567)
  end

  define_method "test: cldr example 00000.0000 => 01234,5670" do
    assert_equal '01234,5670', Cldr::Format::Numeric.new('00000.0000', :decimal => ',', :group => ' ').apply(1234.567)
  end
end

