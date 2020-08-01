#!/bin/bash
set -e
RESET='\e[0m'
# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';

INSTALL_PRJ_DIR=$HOME
PRJ_NAME="ci4-react"

function usage
{
    echo -e "${IRed}usage: ./ci4-react.sh [[-i installdir ] | [-h]]${RESET}"
    echo -e "${IRed}-i | --installdir  Directory in which to install CodeIgniter4-React project (default $INSTALL_PRJ_DIR)${RESET}"
    echo -e "${IRed}-n | --name  Project directory (default $PRJ_NAME)${RESET}"
    echo -e "${IRed}-h | --help  This message${RESET}"
}

if [ "$1" == ""  ] ; then
  usage
  exit 1
fi

# Iterate through command line inputs
while [ "$1" != "" ]; do
    case $1 in
        -i | --installdir )     shift
                                INSTALL_PRJ_DIR=$1
                                ;;
        -n | --name )           shift
                                PRJ_NAME=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ -d "$INSTALL_PRJ_DIR" ]; then
  ### Take action if $DIR exists ###
  echo  -e "${On_Pur}Installing project files in ${INSTALL_PRJ_DIR}...${RESET}"
else
  ### if $DIR does NOT exists try add $HOME ###
  INSTALL_PRJ_DIR="$HOME/${INSTALL_PRJ_DIR}"
  echo  -e "${On_Pur}Installing project files in ${INSTALL_PRJ_DIR}...${RESET}"
fi

DIR=$INSTALL_PRJ_DIR/CodeIgniter4
if [ -d "$DIR" ]; then
   echo  -e "${IRed} ${DIR} already exist. It will to be remove. Do you want to continue?${RESET}"
   read -p '[Y/n]' ck
   if [ "$ck" != "Y"  ] ; then
    exit 1
   fi
   rm -rf $DIR
fi

DIR=$INSTALL_PRJ_DIR/$PRJ_NAME
if [ -d "$DIR" ]; then
   echo  -e "${IRed} ${DIR} already exist. It will to be remove. Do you want to continue?${RESET}"
   read -p '[Y/n]' ck
   if [ "$ck" != "Y"  ] ; then
    exit 1
   fi
   rm -rf $DIR
fi

cd $INSTALL_PRJ_DIR

echo -e "${On_Pur}Cloning CodeIgniter4${RESET}"
git clone https://github.com/codeigniter4/CodeIgniter4.git
echo -e "${On_Pur}Rename CodeIgniter4 to ${PRJ_NAME} ${RESET}"

mv CodeIgniter4 $PRJ_NAME
cd $PRJ_NAME
chmod +777 -R writable
echo -e "${IGre}Init project ${PRJ_NAME}${RESET}"
npm init -y
echo -e "${IGre}Create React application to ${PRJ_NAME}${RESET}"
#npx create-react-app react-app
mkdir -p react-app/src

cd react-app/src
echo "import React from 'react';

function App() {
  return (
    <div className=\"App\">
      <header className=\"App-header\">
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className=\"App-link\"
          href=\"https://reactjs.org\"
          target=\"_blank\"
          rel=\"noopener noreferrer\"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
" | tee  App.js
echo "import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';


ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA

" | tee  index.js

echo "body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
" | tee index.css

echo "<!DOCTYPE html>
<html>
  <head>
    <title>Webpack + React Setup</title>
  </head>
  <body>
    <div id="root"></div>
  </body>
</html>" | tee index.html

cd $INSTALL_PRJ_DIR/$PRJ_NAME

echo -e "${IGre}Install webpack to ${PRJ_NAME}${RESET}"

npm install --save path @babel/core @babel/preset-react react babel-loader react-dom 
#npm install --save-dev --global   webpack  webpack-cli  
npm install --save-dev webpack webpack-cli html-webpack-plugin webpack-dev-server webpack-dev-middleware
npm i webpack -g; npm link webpack --save-dev

#npm install -D babel-loader @babel/core @babel/cli @babel/preset-env @babel/preset-react babel-plugin-react-transform  babel-plugin-lodash  webpack webpack-cli  --save-dev

#npm install -D babel-loader@7 babel-core babel-cli babel-preset-env babel-preset-react babel-plugin-react-transform babel-plugin-lodash webpack webpack-cli --save-dev
#ERROR <React.StrictMode>


npm install --save-dev  css-loader style-loader sass-loader node-sass file-loader  react-hot-loader clean-webpack-plugin html-webpack-plugin  webpack-dev-server 



echo -e "${IGre}create webpack configure to ${PRJ_NAME}${RESET}"

echo "
var path = require('path');
//const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
//const CleanWebpackPlugin = require('clean-webpack-plugin');

module.exports = {
  entry: './react-app/src/index.js',
  output: {
    path: path.resolve(__dirname, './public/dist'),
    filename: '[name].js'
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
           loader: 'babel-loader',
             options: 
             {
               presets: ['@babel/preset-react',],
               //plugins: ['react-hot-loader/babel'],
             },
          },
          //{ loader: 'style-loader' },
          //{ loader: 'css-loader' },
          //{ loader: 'sass-loader' },
          //{ loader: 'file-loader' },
         ]
        },
        {
          test: /\.css$/,
          exclude: /(node_modules)/,
          use: [
            { loader: 'style-loader' },
            { loader: 'css-loader' },
          ],
        },
        {
          test: /\.scss$/,
          exclude: /(node_modules)/,
          use: [
            { loader: 'style-loader' },
            { loader: 'css-loader' },
            { loader: 'sass-loader' },
          ],
        },
        {
          test: /\.png$/,
          exclude: /(node_modules)/,
          use: [
            { loader: 'file-loader' },
          ],
        },
    ]
  },
 plugins: [
    //new CleanWebpackPlugin(),
    //new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      template: './react-app/src/index.html',
    }),
  ],
  devServer: {
    hot: true,
  },
}

" | tee webpack.config.js

echo -e "${IGre}Create react components directory to ${PRJ_NAME}${RESET}"

webpack --config webpack.config.js

echo -e "${IGre}Run project ${PRJ_NAME}${RESET}"
php spark serve

