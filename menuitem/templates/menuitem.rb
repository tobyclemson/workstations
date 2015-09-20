meta "menuitem" do
  accepts_value_for :menuitem

  template {
    met? {
      shell("defaults read com.apple.systemuiserver menuExtras | grep \"#{menuitem}\"")
    }

    meet {
      shell("defaults write com.apple.systemuiserver menuExtras -array-add \"#{menuitem}\"")
    }
  }
end
