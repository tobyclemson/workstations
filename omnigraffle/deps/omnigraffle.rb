# dep 'omnigraffle license file.plist' do
#   requires 'omnigraffle.cask'
#
#   def key
#     GpgHelper.decrypt('omnigraffle/files/key.gpg')
#   end
#
#   def user
#     shell('whoami')
#   end
#
#   target '~/Library/Containers/com.omnigroup.OmniGraffle6/Data/Library/Application Support/Omni Group/Software Licenses/OmniGraffle-762283.omnilicense'
#   entries [
#     {
#       :path => ":AddedByUser",
#       :type => 'string',
#       :value => user
#     },
#     {
#       :path => ":Application",
#       :type => 'string',
#       :value => '1000215'
#     },
#     {
#       :path => ":DateAdded",
#       :type => 'string',
#       :value => '01/01/2015 00:00 Europe/London'
#     },
#     {
#       :path => ":Owner",
#       :type => 'string',
#       :value => 'ThoughtWorks'
#     },
#     {
#       :path => ":Key",
#       :type => 'string',
#       :value => key
#     },
#   ]
# end

dep 'omnigraffle' do
  requires 'omnigraffle.cask'
  # requires 'omnigraffle license file.plist'
end
