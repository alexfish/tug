class Xcode

  def build
    `xctool -project /Users/alexfish/src/tissue/tissue.xcodeproj -scheme tissue`
  end
end