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

    slot = available.detect{|slot| array[slot + 1] == " " && array[slot - 1] == " " }
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
      ocean_plants: "🌱 🌿",
      animals: "🐶 🐺 🐱 🐭 🐹 🐰 🐸 🐯 🐨 🐻 🐷 🐽 🐮 🐗 🐵 🐒 🐴 🐑 🐘 🐼 🐧 🐦 🐤 🐥 🐣 🐔 🐍 🐢 🐛 🐝 🐜 🐞 🐌 🐙 🐚 🐠 🐟 🐬 🐳 🐋 🐄 🐏 🐀 🐃 🐅 🐇 🐉 🐎 🐐 🐓 🐕 🐖 🐁 🐂 🐲 🐡 🐊 🐫 🐪 🐆 🐈 🐩 🐾",
      plants: "💐 🌸 🌷 🍀 🌹 🌻 🌺 🍁 🍃 🍂 🌿 🌾 🍄 🌵 🌴 🌲 🌳 🌰 🌱 🌼",
      shells: "🐚 🐚",
      planets: "🌞 🌝 🌚 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 🌜 🌛 🌙",
      stars: "⭐ 🌟 ✨",
      boats: "🚤 ⛵ 🏄",
      clouds: "☁️ ☁️",
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

  def row(number)
    @emoji_array[number]
  end

  def evenly_distribute(array, emoji)
    slot = EmojiArrayTools.get_evenly_distributed_slot(array)
    array[slot] = emoji
  end

  def place_in_random_cell(array, emoji)
    return unless array.include?(" ")
    slot = EmojiArrayTools.get_evenly_distributed_slot(array)
    array[slot] = emoji
  end

  def fill_row_randomly(row_number, emoji_set)
    rand(1..@MODIFIER).times { place_in_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def fill_row_slightly(row_number, emoji_set)
    rand(2..4).times { place_in_random_cell(row(row_number), @dict.get_random(emoji_set)) }
  end

  def fill_row_totally(row_number, emoji_or_category)
    row(row_number).map!{|cell| cell = emoji_or_category } if emoji_or_category.is_a?(String)
    row(row_number).map!{|cell| cell = @dict.get_random(emoji_or_category) } if emoji_or_category.is_a?(Symbol)
  end

  def ocean_scene
    fill_row_totally(4, "🌊")
    make_sky
    make_boats
    make_ocean
  end

  def make_sky
    place_in_random_cell(row(0), @dict.get_random(:planets))
    fill_row_randomly(0, :stars)
    fill_row_randomly(1, :stars)
    fill_row_randomly(2, :clouds)
  end

  def make_boats
    fill_row_randomly(3, :boats)
  end

  def make_ocean
    fill_row_slightly(5, :fish)
    fill_row_slightly(6, :fish)
    fill_row_slightly(7, :fish)
    fill_row_slightly(8, :shells)
    fill_row_totally(9, :ocean_plants)
  end

  def print
    @emoji_array.map!{|array| array.join("")}
    @emoji_array = @emoji_array.join("\n")
    p "*" * 30
    puts @emoji_array
  end

  def joined_scene
    @emoji_array
  end
end

scene = EmojiScene.new
scene.ocean_scene
scene.print
# twit = CustomTwitter.new
# twit.update(scene.joined_scene)
