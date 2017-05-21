# setup bundles

bundle install

# update libraries

carthage bootstrap --platform iOS
bundle exec pod repo update
bundle exec pod install
