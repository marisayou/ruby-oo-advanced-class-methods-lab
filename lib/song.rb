require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    new_song = self.new
    self.all << new_song
    new_song
  end

  def self.new_by_name(name)
    new_song = self.new
    new_song.name = name
    new_song
  end

  def self.create_by_name(name)
    new_song = self.new_by_name(name)
    self.all << new_song
    new_song
  end

  def self.find_by_name(name)
    self.all.each do |song|
      if song.name == name
        return song
      end
    end
    return nil
  end

    def self.find_or_create_by_name(name)
      song = self.find_by_name(name)
      if song
        return song
      end
      self.create_by_name(name)
    end

    def self.alphabetical
      sorted_names = self.all.map do |song|
        song.name
      end.sort
      sorted_names.map do |name|
        self.find_by_name(name)
      end
    end

    def self.new_from_filename(filename)
      components = filename.split(" - ")
      components[1] = components[1].split(".")
      components.flatten!
      artist = components[0]
      name = components[1]

      song = self.create_by_name(name)
      song.artist_name = artist 
      song
    end

    def self.create_from_filename(filename)
      song = self.new_from_filename(filename)
      self.all << song
      song
    end

    def self.destroy_all
      self.all.clear
    end
end

