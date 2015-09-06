require 'gtk3'
require 'lib/string_calc'
# define calc methods
class MyCalc

  def on_click(sender)
    @line << sender.label
    display
  end

  def display
    @builder.get_object('screen').label = @line
  end

  def result
    @line = @line.calculate.to_s
    display
  end

  def backspace
    @line.chop!
    display
  end

  def change_sign
    if @line.chr == '-'
      @line.slice!(0)
      display
    else
      @line.prepend('-')
      display
    end
  end

  def initialize
    @line = ""

    Gtk.init

    @builder = Gtk::Builder.new
    @builder.add_from_file('calc.glade')
    @builder.connect_signals { |handler| method(handler) }

    window1 = @builder.get_object('Calculator')
    window1.show_all

    Gtk.main
  end

  def gtk_main_quit
    puts 'Gtk.main_quit'
    Gtk.main_quit
  end
end

hello = MyCalc.new
