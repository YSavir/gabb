require_relative '../spec_helper'
require_relative '../../lib/gabb/directory_mapper'

describe GABB::DirectoryMapper do
  describe '.scripts_path' do
    it "should return the path to the scripts folder" do
      expect(GABB::DirectoryMapper.scripts_path).to eq(File.expand_path "./scripts")
    end
  end  

  describe '.script_path_for(exercise)' do
    before do
      @exercise = Exercise.new
    end
    it "should return the path for the given exercise" do
      expect(GABB::DirectoryMapper.script_path_for(@exercise)).to eq(File.expand_path('./scripts/test.rb'))
    end
  end

  describe '.exercises_path_for(exercise)' do
    before do
      @exercise = Exercise.new
    end
    it "should return the path to that exercise's directory" do
      expect(GABB::DirectoryMapper.exercises_path_for(@exercise)).to eq(File.expand_path("./lib/exercises/#{@exercise.directory_name}"))
    end
  end

  describe '.template_path_for(exercise)' do
    before do
      @exercise = Exercise.new
    end
    it "should return teh path to that exercise's template" do
      expect(GABB::DirectoryMapper.template_path_for(@exercise)).to eq(File.expand_path("./lib/exercises/#{@exercise.directory_name}/template.rb"))
    end
  end

  describe '.log_path' do
    it "should return the path to the log file" do
      expect(GABB::DirectoryMapper.log_path).to eq(File.expand_path('./log.txt'))
    end
  end
end

class Exercise
  def directory_name
    'test'
  end  
end
