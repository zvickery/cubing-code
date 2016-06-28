require 'spec_helper'

def run_shell(command)
  path = File.expand_path(File.dirname(__FILE__))
  `echo #{command} | #{path}/../../bin/shell.rb`
end

describe 'load shell' do
  it 'can exit shell' do
    output = run_shell('exit')
    expect(output).to eq('> ')
  end

  it 'can get shell help' do
    output = run_shell('help')
    expect(output).to eq("> You'll just have to support yourself!\n> \n")
  end
end
