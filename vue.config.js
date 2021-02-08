module.exports = {
  chainWebpack: (config) => {
    // Dyson Sphere Planner data loader
    config.module
      .rule('asset')
      .test(/\.asset$/)
      .use('raw-loader')
      .loader('raw-loader')
      .end();
  },
  publicPath: process.env.NODE_ENV === 'production'
    ? '/DysonSpherePlanner/'
    : '/',
  pages: {
    index: {
      entry: 'src/main.ts',
      title: 'Dyson Sphere Planner',
    },
  },
};
