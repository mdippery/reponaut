module Reponaut
  module Env
    def cucumber?
      self['REPONAUT_ENV'] == 'cucumber'
    end
  end
end

ENV.extend(Reponaut::Env)
