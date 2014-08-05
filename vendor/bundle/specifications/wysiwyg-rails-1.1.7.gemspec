# -*- encoding: utf-8 -*-
# stub: wysiwyg-rails 1.1.7 ruby lib

Gem::Specification.new do |s|
  s.name = "wysiwyg-rails"
  s.version = "1.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Froala"]
  s.date = "2014-07-20"
  s.description = "A nice flat designed jQuery WYSIWYG editor based on HTML5."
  s.email = ["stefan@froala.com"]
  s.homepage = "https://github.com/froala/wysiwyg-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "an asset gemification of the Froala WYSIWYG Editor library"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, ["< 5.0", ">= 3.2"])
      s.add_runtime_dependency(%q<font-awesome-rails>, ["= 4.1.0.0"])
    else
      s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2"])
      s.add_dependency(%q<font-awesome-rails>, ["= 4.1.0.0"])
    end
  else
    s.add_dependency(%q<railties>, ["< 5.0", ">= 3.2"])
    s.add_dependency(%q<font-awesome-rails>, ["= 4.1.0.0"])
  end
end
