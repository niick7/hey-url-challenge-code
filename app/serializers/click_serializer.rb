class ClickSerializer
  include FastJsonapi::ObjectSerializer
  set_type :clicks
  attributes :browser, :platform
end
