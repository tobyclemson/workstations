dep 'ir_black profile.plist' do
  target '~/Library/Preferences/com.apple.Terminal.plist'
  entries [
    {
      :hash_path => ":'Window Settings'",
      :key_path => ":'IR_Black'",
      :type => 'hash-entry',
      :file => "#{__FILE__.p.parent}/../files/ir_black.profile.plist"
    },
    {
      :path => ":'Startup Window Settings'",
      :type => 'string',
      :value => "IR_Black"
    },
    {
      :path => ":'Default Window Settings'",
      :type => 'string',
      :value => "IR_Black"
    }
  ]
end

dep 'terminal' do
  requires 'ir_black profile.plist'
end
