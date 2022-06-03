module.exports = {
  theme: {
    extend: {
      colors: {
        richblack: {
          400: '#011627',
          DEFAULT: '#011627'
        }
      }
    },
  },
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}
