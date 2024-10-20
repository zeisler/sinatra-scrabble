FROM ruby:2.7-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the working directory
COPY Gemfile Gemfile.lock ./

RUN gem install bundler:1.17.2

# Install the required gems
RUN bundle install

# Copy the rest of the application code into the working directory
COPY . .

# Expose the port that the application runs on
EXPOSE 3000

ENV RAILS_ENV=production
ENV RACK_ENV=production

CMD ["bundle", "exec", "rackup", "-p", "3000"]
