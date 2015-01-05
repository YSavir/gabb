require 'pry'
require_relative '../spec_helper.rb'
require_relative './../../lib/gabb/console_commands.rb'

class Commands
    include GABB::ConsoleCommands
end

describe GABB::ConsoleCommands do
    before do
        @command_proxy = Commands.new
    end

    describe '#wait' do
        before do
            def capture_input
                $stdin.gets.chomp
            end
            $stdin = StringIO.new(" ")	
        end
        after do
            $stdin = STDIN
        end
        it 'should ask the user to press enter to proceed' do
            output = capture(:stdout) do
                @command_proxy.wait
            end
            expect(output).to eq("Press Enter to proceed.\n")
        end
        it 'should wait until the user presses enter' do
            expect(capture_input).to eq(" ")
        end
        it 'should be able to use a custom instruction' do
            output = capture(:stdout) do
                @command_proxy.wait("test command")
            end
            expect(output).to eq("test command\n")
        end
    end
    
    describe '#line_break' do
        it 'should output a line break' do
            output = capture(:stdout) do
                @command_proxy.line_break
            end
            expect(output).to match(/=+\n/)
        end
    end

    describe '#beat' do
        it 'should output an empty string' do
            output = capture(:stdout) do
                @command_proxy.beat
            end
            expect(output).to eq("\n")
        end
    end

    describe 'clear_screen' do
        it 'should clear the screen' do
            expect(@command_proxy).to receive(:system).with('clear')
            @command_proxy.clear_screen
        end
    end

end

