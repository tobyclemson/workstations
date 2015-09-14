dep "all fonts" do
  requires "forza.otf",
           "gothamc.otf",
           "idlewild.otf",
           "vitesse.otf",
           "opensans.ttf",
           "source sans.otf",
           "sullivan.otf",
           "crimson.otf",
           "mensch.ttf",
           "metropolis.otf",
           "deconeue.ttf"

end

dep "user font dir exists" do
  met? {
    "~/Library/Fonts".p.dir?
  }
  meet {
    log_shell "Creating ~/Library/Fonts", "mkdir ~/Library/Fonts"
  }
end

dep "forza.otf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/Forza.zip"
  otf_filename "Forza-Black.otf"
end

dep "gothamc.otf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/GothamCond.zip"
  otf_filename "GothamCond-Black.otf"
end

dep "idlewild.otf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/Idlewild.zip"
  otf_filename "Idlewild-Bold.otf"
end

dep "vitesse.otf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/Vitesse.zip"
  otf_filename "Vitesse-Black.otf"
end

dep "sullivan.otf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/Sullivan.zip"
  otf_filename "Sullivan-Regular.otf"
end

dep "opensans.ttf" do
  source "https://dl.dropboxusercontent.com/u/103175/Fonts/OpenSans.zip"
  ttf_filename "OpenSans-Bold.ttf"
end

dep "source sans.otf" do
  source "https://github.com/adobe-fonts/source-sans-pro/archive/2.010R-ro/1.065R-it.zip"
  otf_filename "SourceSansPro-Black.otf"
end

dep "crimson.otf" do
  source "http://internode.dl.sourceforge.net/project/crimsontext/crimson_101217.zip"
  otf_filename "Crimson-Roman.otf"
end

dep "mensch.ttf" do
  ttf_filename "Mensch.ttf"
  meet {
    `curl https://dl.dropboxusercontent.com/u/103175/Fonts/Mensch.ttf > ~/Library/Fonts/Mensch.ttf`
  }
end

dep "metropolis.otf" do
  otf_filename "Metropolis.otf"
  meet {
    `curl https://dl.dropboxusercontent.com/u/103175/Fonts/Metropolis.otf > ~/Library/Fonts/Metropolis.otf`
  }
end

dep "deconeue.ttf" do
  ttf_filename "DecoNeue-Light.ttf"
  meet {
    `curl https://dl.dropboxusercontent.com/u/103175/Fonts/DecoNeue-Light.ttf > ~/Library/Fonts/DecoNeue-Light.ttf`
  }
end
