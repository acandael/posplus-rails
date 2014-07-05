class AuthenticatedController < ApplicationController
  before_filter :require_signin
end
