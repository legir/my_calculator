
  require 'gtk3'
  require_relative 'string_calc'

  # define calc methods
  class MyCalc
    def initialize
      @line = ''

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

    def on_click(sender)
      @line == '0' ? @line = sender.label : @line << sender.label
      display
    end

    def display
      @builder.get_object('screen').label = @line
    end

    def result
      @line = @line.calculate
      if /\A-/ =~ @line.to_s
        @line = @line.to_i > @line ? @line.to_s : @line.to_i.to_s
      else
        @line = @line.to_i < @line ? @line.to_s : @line.to_i.to_s
      end
      display
      @builder.get_object('entry').text = '' #не работает
    end

    def backspace
      @line.chop!
      display
    end

    def clear
      @line = '0'
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

    def push_line(sender)
      @line = sender.text
      display
    end
  end
