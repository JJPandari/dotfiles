// an example to create a new mapping `ctrl-y`
// mapkey('<Ctrl-y>', 'Show me the money', function() {
//     Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
// });
mapkey('T', 'Choose a tab with omnibar', 'Front.openOmnibar({type: "Tabs"})');
mapkey('H', '#3Go one tab left', 'RUNTIME("previousTab")');
mapkey('L', '#3Go one tab right', 'RUNTIME("nextTab")');
mapkey('K', '#4Go back in history', 'history.go(-1)', {repeatIgnore: true});
mapkey('J', '#4Go forward in history', 'history.go(1)', {repeatIgnore: true});
mapkey('<Space>s', '#12View page source', 'RUNTIME("viewSource", { tab: { tabbed: true }})');
imapkey('<Space>i', '#15Open vim editor for current input', function() {
    var element = getRealEdit();
    Front.showEditor(element);
});
mapkey('q', '#3Close current tab', 'RUNTIME("closeTab")');
mapkey('x', '#3Restore closed tab', 'RUNTIME("openLast")');

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
// map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
// unmap('<Ctrl-i>');

settings.defaultSearchEngine = 'd';
// set theme
// settings.theme = `
// .sk_theme {
//     background: #000;
//     color: #fff;
// }
// .sk_theme tbody {
//     color: #fff;
// }
// .sk_theme input {
//     color: #d9dce0;
// }
// .sk_theme .url {
//     color: #2173c5;
// }
// .sk_theme .annotation {
//     color: #38f;
// }
// .sk_theme .omnibar_highlight {
//     color: #fbd60a;
// }
// .sk_theme ul>li:nth-child(odd) {
//     background: #1e211d;
// }
// .sk_theme ul>li.focused {
//     background: #4ec10d;
// }`;
// click `Save` button to make above settings to take effect.
