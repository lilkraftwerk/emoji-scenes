require_relative 'custom_twitter'
require 'pry'

class EmojiArrayTools

  def self.get_random_slot(array)
    available = array.each_index.select{|slot| array[slot] == ' '}
    available.sample
  end

  def self.get_evenly_distributed_slot(array)

    available = array.each_index.select{|slot| array[slot] == ' '}
    taken = array.each_index.reject{|slot| array[slot] == ' '}

    return rand(array.length) unless taken.any?

    slot = available.detect{|slot| array[slot + 1] == " " && array[slot - 1] == " " && array[slot - 2] == " " && array[slot + 2] == " " } 
    slot = available.detect{|slot| array[slot + 1] == " " && array[slot - 1] == " "}  unless slot 
    slot = available.detect{|slot| array[slot + 2] == " " && array[slot - 2] == " " } unless slot
    slot = available.detect{|slot| array[slot + 3] == " " && array[slot - 3] == " " } unless slot 
    slot = available.sample unless slot 
    slot
  end

end

class EmojiDictionary
  attr_reader :emojis

  def initialize
    @emojis = {
      city_buildings: "🏠 🏡 🏢 🏬 🏭 🏣 🏤 🏥 🏦 🏨 🏩 💒 ⛪️ 🏪 🏫",
      cars: "🚌 🚕 🚙 🚗 🚌 🚕 🚎 🚐 🚑 🚎 🚐 🚙 🚚 🚛 🚑 🚒 🚓 ",
      side_of_road: "🚏 ⛽️ 🚧 ",
      snow: "❄️ ❄️",
      snowy_things: "🌲 🌳 🐏 🐃 🐅 🐇 🐉 🐐 🐓 🐕 🐁 🍃 🍂 🍄",
      ocean_plants: "🌱 🌿",
      mountains: "🗻 🗻",
      forest_trees: "🌷 🌸 🌹 🌺 🌻 🌼 🌲 🌳 🌾 🌿 🍀 🍁 🍂 🍃",
      forest_animals: "🐂 🐃 🐄 🐉 🐊 🐛 🐌 🐞 🐜 🐝 🐐 🐕 🐘 🐖 🐪 🐓 🐇 🐏 🐅 🐆",
      beach_plants:  "🌴 🐚",
      beach_inhabitants: "🍍 🐕 🐩 🐒 🐫 👫 👬 👭 🎣 🏇", 
      animals: "🐶 🐺 🐱 🐭 🐹 🐰 🐸 🐯 🐨 🐻 🐷 🐽 🐮 🐗 🐵 🐒 🐴 🐑 🐘 🐼 🐧 🐦 🐤 🐥 🐣 🐔 🐍 🐢 🐛 🐝 🐜 🐞 🐌 🐙 🐚 🐠 🐟 🐬 🐳 🐋 🐄 🐏 🐀 🐃 🐅 🐇 🐉 🐎 🐐 🐓 🐕 🐖 🐁 🐂 🐲 🐡 🐊 🐫 🐪 🐆 🐈 🐩 🐾",
      plants: "💐 🌸 🌷 🍀 🌹 🌻 🌺 🍁 🍃 🍂 🌿 🌾 🍄 🌵 🌴 🌲 🌳 🌰 🌱 🌼",
      bottom_of_sea: "⚓ 💍 💰 💎",
      shells: "🐚 🐚",
      planets: "🌞 🌝 🌚 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 🌜 🌛 🌙",
      stars: "⭐ 🌟 ✨",
      planets_and_stars: "⭐ 🌟 ✨ 🌞 🌝 🌚 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 🌜 🌛 🌙",
      boats: "🚤 ⛵ 🏄 🏊",
      clouds: "☁️ ☁️",
      planes: '🚁 ✈️',
      fish: "🐙 🐠 🐟 🐬 🐳 🐋",
      weather: "🌐 🌞 🌝 🌚 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 🌜 🌛 🌙 🌍 🌎 🌏 🌋 🌌 🌠 ⭐ ☀ ⛅ ☁ ⚡ ☔ ❄ ⛄ 🌀 🌁 🌈 🌊",
      food: "☕ 🍵 🍶 🍼 🍺 🍻 🍸 🍹 🍷 🍴 🍕 🍔 🍟 🍗 🍖 🍝 🍛 🍤 🍱 🍣 🍥 🍙 🍘 🍚 🍜 🍲 🍢 🍡 🍳 🍞 🍩 🍮 🍦 🍨 🍧 🎂 🍰 🍪 🍫 🍬 🍭 🍯",
      fruit: "🍎 🍏 🍊 🍋 🍒 🍇 🍉 🍓 🍑 🍈 🍌 🍐 🍍 🍠 🍆 🍅 🌽",
      buildings: "🏠 🏡 🏫 🏢 🏣 🏥 🏦 🏪 🏩 🏨 💒 ⛪ 🏬 🏤 🌇 🌆 🏯 🏰 ⛺ 🏭 🗼 🗾 🗻 🌄 🌅 🌃 🗽 🌉 🎠 🎡 ⛲ 🎢 🚢",
      transport: "⛵ 🚤 🚣 ⚓ 🚀 ✈ 💺 🚁 🚂 🚊 🚉 🚞 🚆 🚄 🚅 🚈 🚇 🚝 🚋 🚃 🚎 🚌 🚍 🚙 🚘 🚗 🚕 🚖 🚛 🚚 🚨 🚓 🚔 🚒 🚑 🚐 🚲 🚡 🚟 🚠 🚜 💈 🚏 🎫 🚦 🚥 ⚠ 🚧 🔰 ⛽ 🏮 🎰 ♨ 🗿 🎪 🎭 📍 🚩",
    }

    @emojis.each do |key, value|
      @emojis[key] = value.split(" ")
    end
  end

  def get_random(category)
    @emojis[category].sample
  end
end

class EmojiScene
  def initialize
    @LINE_LENGTH = 10
    @MODIFIER = @LINE_LENGTH - 5

    @dict = EmojiDictionary.new
    @emoji_array = Array.new(10) {Array.new(@LINE_LENGTH, ' ')}
  end

  ## utilities ##

  def row(number)
    @emoji_array[number]
  end

  def ends_are_empty(array)
    array[7] == " " && array[8] == " " && array[9] == " "
  end

  def place_in_not_so_random_cell(array, emoji)
    return unless array.include?(" ")
    if ends_are_empty(array)
      slot = [7, 8, 9].sample
    else
      slot = EmojiArrayTools.get_evenly_distributed_slot(array)
    end
    array[slot] = emoji
  end

  def place_in_random_cell(array, emoji)
    return unless array.include?(" ")
    slot = EmojiArrayTools.get_random_slot(array)
    array[slot] = emoji
  end

  def fill_row_once_maybe(row_number, emoji_set)
    rand(0..1).times { place_in_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def fill_row_randomly(row_number, emoji_set)
    rand(1..@MODIFIER).times { place_in_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def fill_row_not_so_randomly(row_number, emoji_set)
    rand(1..@MODIFIER).times { place_in_not_so_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def fill_row_slightly(row_number, emoji_set)
    rand(1..2).times { place_in_not_so_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def maybe_add_one_to_row(row_number, emoji)
    place_in_random_cell(row(row_number), emoji) if rand(1..6) > 4
  end

  def fill_row_totally(row_number, emoji_or_category)
    row(row_number).map!{|cell| cell = emoji_or_category } if emoji_or_category.is_a?(String)
    row(row_number).map!{|cell| cell = @dict.get_random(emoji_or_category) } if emoji_or_category.is_a?(Symbol)
  end

  def fill_empty_spots(row, emoji)
    row.each { |slot| slot = emoji if slot == " " }
  end

  def space_scene
    10.times { |row| fill_row_not_so_randomly(row, :planets_and_stars) }
    3.times do 
      place_in_random_cell(row(rand(10)), '🚀')
      place_in_random_cell(row(rand(10)), '🌠')
    end

    @emoji_array.each do |array|
      empty = array.each_index.select{|slot| array[slot] == ' '}
      empty.each do |slot| 
        array[slot] = '⬛'
      end
    end
  end

  def beach_scene
    make_sky
    fill_row_totally(4, "🌊")
    make_boats
    make_beach
  end

  def make_beach
    fill_row_not_so_randomly(5, :beach_plants)
    fill_row_not_so_randomly(6, :beach_plants)
    fill_row_not_so_randomly(7, :beach_plants)
    fill_row_not_so_randomly(8, :beach_plants)
    fill_row_not_so_randomly(9, :beach_plants)
    fill_row_slightly(5, :beach_inhabitants)
    fill_row_slightly(6, :beach_inhabitants)
    fill_row_slightly(7, :beach_inhabitants)
    fill_row_slightly(8, :beach_inhabitants)
    fill_row_slightly(9, :beach_inhabitants)
    maybe_add_one_to_row(rand(5..9), "🗿")
  end

  def make_sky
    place_in_random_cell(row(0), @dict.get_random(:planets))
    fill_row_not_so_randomly(0, :stars)
    fill_row_not_so_randomly(1, :stars)
    fill_row_not_so_randomly(2, :clouds)
    fill_row_once_maybe(rand(1..2), :planes)
  end

  def make_boats
    fill_row_randomly(3, :boats)
  end

  def make_ocean
    fill_row_slightly(5, :fish)
    fill_row_slightly(6, :fish)
    fill_row_slightly(7, :fish)
    fill_row_slightly(8, :shells)
    fill_row_slightly(8, :bottom_of_sea) if (rand(2)) == 1
    fill_row_totally(9, :ocean_plants)
  end

  def forest_scene
    make_sky
    make_forest
  end

  def city_scene
  make_sky
  fill_row_not_so_randomly(3, :city_buildings)
  fill_row_not_so_randomly(4, :city_buildings)
  fill_row_not_so_randomly(5, :side_of_road)
  fill_row_not_so_randomly(6, :cars)
  fill_row_not_so_randomly(7, :side_of_road)
  fill_row_not_so_randomly(8, :city_buildings)
  fill_row_not_so_randomly(9, :beach_inhabitants)  
  end

  def make_forest
    fill_row_totally(3, "🗻")
    fill_row_not_so_randomly(4, :forest_trees)
    fill_row_not_so_randomly(5, :forest_trees)
    fill_row_not_so_randomly(6, :forest_trees)
    fill_row_not_so_randomly(7, :forest_trees)
    fill_row_not_so_randomly(8, :forest_trees)
    fill_row_not_so_randomly(9, :forest_trees)
    fill_row_slightly(4, :forest_animals)
    fill_row_slightly(5, :forest_animals)
    fill_row_slightly(6, :forest_animals)
    fill_row_slightly(7, :forest_animals)
    fill_row_slightly(8, :forest_animals)
    fill_row_slightly(9, :forest_animals)
  end

  def winter_scene
    make_sky
    fill_row_not_so_randomly(3, :snow)
    fill_row_not_so_randomly(4, :snow)
    fill_row_not_so_randomly(5, :snow)
    fill_row_randomly(6, :mountains)
    fill_row_not_so_randomly(7, :snowy_things)
    fill_row_not_so_randomly(8, :snowy_things)
    fill_row_not_so_randomly(9, :snowy_things)
  end

  def ocean_scene
    fill_row_totally(4, "🌊")
    make_sky
    make_boats
    make_ocean
  end

  def print
    @emoji_array.each {|x| p x }
    @emoji_array.map!{|array| array.join("")}
    @emoji_array = @emoji_array.join("\n")
    p "*" * 30
    puts @emoji_array
  end

  def joined_scene
    @emoji_array
  end
end

def random_scene
  [
    :space_scene, 
    :ocean_scene, 
    :city_scene, 
    :beach_scene, 
    :forest_scene, 
    :winter_scene
  ].sample  
end

def tweet
  scene = EmojiScene.new
  scene.send(random_scene)
  scene.print
  puts scene_to_do
  twit = CustomTwitter.new
  twit.update(scene.joined_scene)
end

def test_scene(name = :random)
  name == :random ? scene_to_do = random_scene : scene_to_do = name
  scene = EmojiScene.new
  scene.send(scene_to_do)
  scene.print
  puts scene_to_do
end
