require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  def initialize(id:, name:, type:, db:, hp:60)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
  end

  def self.insert(name, type, db, hp=60)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.update()
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    current = db.execute('SELECT * FROM pokemon WHERE pokemon.id = id')
    pokemon = new(id: current[0][0], name:current[0][1], type:current[0][2], db:db)
    pokemon.hp = current[0][3] if current[0][3]
    pokemon
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon SET hp = ? WHERE id = ?
      SQL
    db.execute(sql, hp, id)
    @hp = hp
  end

end
