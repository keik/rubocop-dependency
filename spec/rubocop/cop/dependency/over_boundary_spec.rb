# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Dependency::OverBoundary, :config do
  context 'when simple Rules' do
    let(:cop_config) do
      RuboCop::Config.new('Rules' => [{ 'BannedConstPatterns' => 'B', 'FromNamespacePatterns' => 'A' }])
    end

    it 'registers an offense when referring const `B` from expression of class `A`' do
      expect_offense(<<~RUBY)
        class A
          B.new
          ^ Const `B` cannot use from namespace `A`.
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from instance method of class `A`' do
      expect_offense(<<~RUBY)
        class A
          def a
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from class method of class `A`' do
      expect_offense(<<~RUBY)
        class A
          def self.a
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from class method of class `A::X`' do
      expect_offense(<<~RUBY)
        class A::X
          def self.a
            B.new
            ^ Const `B` cannot use from namespace `A::X`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from class method of class `X::A`' do
      expect_offense(<<~RUBY)
        class X::A
          def self.a
            B.new
            ^ Const `B` cannot use from namespace `X::A`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from class method of inner class `X` of outer class `A`' do
      expect_offense(<<~RUBY)
        class A
          class X
            def self.a
              B.new
              ^ Const `B` cannot use from namespace `A::X`.
            end
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from class method of inner class `A` of outer class `X`' do
      expect_offense(<<~RUBY)
        class X
          class A
            def self.a
              B.new
              ^ Const `B` cannot use from namespace `X::A`.
            end
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from expression of module `A`' do
      expect_offense(<<~RUBY)
        module A
          B.new
          ^ Const `B` cannot use from namespace `A`.
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from module method of module `A`' do
      expect_offense(<<~RUBY)
        module A
          def a
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from singleton method of module `A`' do
      expect_offense(<<~RUBY)
        module A
          def self.a
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'registers an offense when referring const `B` from expression of class `A`' do
      expect_offense(<<~RUBY)
        class A
          B.new
          ^ Const `B` cannot use from namespace `A`.
        end
      RUBY
    end

    it 'registers an offense when define const `B` in singleton class of class `A`' do
      expect_offense(<<~RUBY)
        class A
          class << self
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'registers an offense when define const `B` in block in class `A`' do
      expect_offense(<<~RUBY)
        class A
          foo do
            B.new
            ^ Const `B` cannot use from namespace `A`.
          end
        end
      RUBY
    end

    it 'does not registers an offense when define const `B` in class `A`' do
      expect_no_offenses(<<~RUBY)
        class A
          B = 1
        end
      RUBY
    end
  end

  context 'when complex Rules' do
    let(:cop_config) do
      RuboCop::Config.new('Rules' => [{ 'BannedConstPatterns' => '\ABar\z', 'FromNamespacePatterns' => '\AFoo\z' }])
    end

    it 'registers an offense when referring const `Bar` from class `Foo`' do
      expect_offense(<<~RUBY)
        class Foo
          Bar.new
          ^^^ Const `Bar` cannot use from namespace `Foo`.
        end
      RUBY
    end

    it 'registers an offense when referring const `Bar::X` from class `Foo`' do
      expect_offense(<<~RUBY)
        class Foo
          Bar::X.new
          ^^^^^^ Const `Bar::X` cannot use from namespace `Foo`.
        end
      RUBY
    end

    it 'does not registers an offense when referring const `X::Bar` from class `Foo`' do
      expect_no_offenses(<<~RUBY)
        class Foo
          X::Bar.new
        end
      RUBY
    end

    it 'does not registers an offense when referring const `Bar` from class `FooFoo`' do
      expect_no_offenses(<<~RUBY)
        class FooFoo
          Bar.new
        end
      RUBY
    end

    it 'does not registers an offense when referring const `Bar` from class `Foo::X`' do
      expect_no_offenses(<<~RUBY)
        class Foo::X
          Bar.new
        end
      RUBY
    end

    it 'does not registers an offense when referring const `Bar` from class `X::Foo`' do
      expect_no_offenses(<<~RUBY)
        class X::Foo
          Bar.new
        end
      RUBY
    end
  end
end
