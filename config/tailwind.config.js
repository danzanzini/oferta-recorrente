const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans:  ['IBM Plex Serif', ...defaultTheme.fontFamily.serif],
        serif: ['IBM Plex Serif', ...defaultTheme.fontFamily.serif],
      },
      colors: {
        // Figma: color-neutral-*
        'neutral-0': '#FFFFFF',
        'neutral-1': '#FBFBFB',
        'neutral-2': '#F3F3F3',
        'neutral-3': '#5D5C5C',
        // Figma: color-main-*
        'main-0': '#DBFAC7',
        'main-1': '#107758',
        'main-2': '#083835',
        // Figma: color-border-* (aliases)
        'color-border':       'rgba(8, 56, 53, 0.10)',   // = color-transparency-1
        'color-border-light': '#F3F3F3',                  // = color-neutral-2
        // Figma: color-transparency-*
        'color-transparency-0': 'rgba(16, 119, 88, 0.05)', // #1077580D
        'color-transparency-1': 'rgba(8, 56, 53, 0.10)',   // #0838351A
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
