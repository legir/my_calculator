# define calc method for sting https://github.com/theodorton/ruby-string-calculate
class String
  def calculate
    [:+, :-, :*, :/].each do |op|
      factors = split(op.to_s)
      return factors.map(&:calculate).inject(op) if factors.size > 1
    end
    # Improve outlook
    to_f
  end
  alias_method :calc, :calculate
end
