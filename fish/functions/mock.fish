function mock
    node -e "const mcase = require('/opt/homebrew/lib/node_modules/@strdr4605/mockingcase/src/mockingcase.js'); console.log(mcase('$argv', { random: true }));"
end
