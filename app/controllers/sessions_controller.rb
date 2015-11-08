class SessionsController < Devise::SessionsController

def new
  Event.create(event_type: "Login Page View")
  super
end

def create
  super
end

end
