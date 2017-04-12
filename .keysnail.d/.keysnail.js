// ========================== KeySnail Init File =========================== //

// You can preserve your code in this area when generating the init file using GUI.
// Put all your code except special key, set*key, hook, blacklist.
// ========================================================================= //
//{{%PRESERVE%
//TODO ESC not working on select
// Put your codes here

plugins.options["hok.hint_keys"] = 'asdfghjklqweruiopzxcvmn';
plugins.options["kkk.sites"] = [
    "^https?://([0-9a-zA-Z]+\\.)?github\\.com/",
    "^https?://emacs-china\\.org/"
];
plugins.options["bmany.default_open_type"] = "tab";

const JJ_TAB_CURRENT = 'current';
const JJ_TAB_NEW = 'tab';

const openConfigs = [
    {
        keys: ['o'],
        place: JJ_TAB_CURRENT,
        template: '%s',
        msg: 'open:',
        description: 'open in current tab'
    },
    {
        keys: ['O'],
        template: '%s',
        msg: 'open:',
        description: 'open in new tab'
    },
    {
        keys: [['SPC', 'SPC']],
        template: 'http://cn.bing.com/search?q=%s',
        msg: 'Bing:',
        description: 'search with bing'
    },
    {
        keys: ['SPC', 'g', 'g'],
        template: 'http://www.google.com/search?q=%s',
        msg: 'Google:',
        description: 'search with google'
    },
    {
        keys: ['SPC', 'd', 'd', 'g'],
        template: 'http://duckduckgo.com/?q=%s',
        msg: 'DuckDuckGo:',
        description: 'search with DuckDuckGo'
    },
    {
        keys: ['SPC', 's', 's'],
        template: 'http://cn.bing.com/search?q=%s+site:stackoverflow.com',
        msg: 'search stackoverflow:',
        description: 'search stackoverflow with bing'
    },
    {
        keys: ['SPC', 's', 'm'],
        template: 'http://cn.bing.com/search?q=%s+site:developer.mozilla.org',
        msg: 'search mdn:',
        description: 'search mdn with bing'
    },
    {
        keys: ['SPC', 's', 'e'],
        template: 'http://cn.bing.com/search?q=%s+site:emacs.stackexchange.com',
        msg: 'search emacs stackexchange:',
        description: 'search emacs stackexchange with bing'
    },
    {
        keys: ['SPC', 's', 'p'],
        template: 'http://cn.bing.com/search?q=%s+site:php.net',
        msg: 'search php.net:',
        description: 'search php.net with bing'
    },
    {
        keys: ['SPC', 's', 'g'],
        template: 'https://github.com/search?q=%s',
        msg: 'search github:',
        description: 'search github'
    }
];

openConfigs.forEach(conf => {
    key.setViewKey(conf.keys, function (ev, arg) {
        prompt.read(conf.msg, function (input) {
            if (input)
                openUILinkIn(
                    conf.template.replace('%s', input.replace(/\s/g, '+')),
                    conf.place || JJ_TAB_NEW
                );
            // use msg as history namespace
        }, null, null, null, 0, conf.msg);
    }, conf.description);
});

//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "C-q";
key.macroStartKey        = "<f3>";
key.macroEndKey          = "<f4>";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";
key.suspendKey           = "<f2>";

// ================================= Hooks ================================= //

hook.setHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) return;

    command.closeFindBar();

    let marked = command.marked(aEvent);

    if (util.isCaretEnabled()) {
        if (marked) {
            command.resetMark(aEvent);
        } else {
            if ("blur" in aEvent.target) aEvent.target.blur();

            gBrowser.focus();
            _content.focus();
        }
    } else {
        goDoCommand("cmd_selectNone");
    }

    if (KeySnail.windowType === "navigator:browser" && !marked) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
    }

    // always close prompt
    prompt.finish(true);

    // always blur
    window.content.document.activeElement.blur();
});


// ============================= Key bindings ============================== //

key.setGlobalKey('ESC', function (ev, arg) {
    let elem = document.commandDispatcher.focusedElement;
    if (elem) {
        elem.blur();
    }
    gBrowser.focus();
    content.focus();
}, 'Focus to the content', true);

key.setGlobalKey('M-x', function (ev, arg) {
                ext.select(arg, ev);
            }, 'List exts and execute selected one', true);

key.setGlobalKey('M-:', function (ev) {
                command.interpreter();
            }, 'Command interpreter', true);

key.setGlobalKey(['<f1>', 'b'], function (ev) {
                key.listKeyBindings();
            }, 'List all keybindings');

key.setGlobalKey(['<f1>', 'F'], function (ev) {
                openHelpLink("firefox-help");
            }, 'Display Firefox help');

key.setGlobalKey('C-m', function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RETURN, true);
            }, 'Generate the return key code');

key.setGlobalKey(['C-x', '1'], function (ev) {
                window.loadURI(ev.target.ownerDocument.location.href);
            }, 'Show current frame only', true);

key.setGlobalKey(['C-x', 'l'], function (ev) {
    command.focusToById("urlbar");
}, 'Focus to the location bar', true);

key.setGlobalKey(['C-x', 'g'], function (ev) {
    command.focusToById("searchbar");
}, 'Focus to the search bar', true);

key.setGlobalKey(['C-x', 't'], function (ev) {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, 'Focus to the first textarea', true);

key.setGlobalKey(['C-x', 's'], function (ev) {
    command.focusElement(command.elementsRetrieverButton, 0);
}, 'Focus to the first button', true);

key.setGlobalKey(['C-x', 'k'], function (ev) {
                BrowserCloseTabOrWindow();
            }, 'Close tab / window');

key.setGlobalKey(['C-x', 'K'], function (ev) {
                closeWindow(true);
            }, 'Close the window');

key.setGlobalKey(['C-x', 'n'], function (ev) {
                OpenBrowserWindow();
            }, 'Open new window');

key.setGlobalKey(['C-x', 'C-c'], function (ev) {
                goQuitApplication();
            }, 'Exit Firefox', true);

key.setGlobalKey(['C-x', 'o'], function (ev, arg) {
                command.focusOtherFrame(arg);
            }, 'Select next frame');

key.setGlobalKey(['C-x', 'C-f'], function (ev) {
                BrowserOpenFileWindow();
            }, 'Open the local file', true);

key.setGlobalKey('M-w', function (ev) {
                command.copyRegion(ev);
            }, 'Copy selected text', true);

key.setGlobalKey('C-M-l', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'Select next tab');

key.setGlobalKey('C-M-h', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(-1, true);
            }, 'Select previous tab');

key.setViewKey(['SPC', 'f', 'e', 'r'], function (ev) {
    userscript.reload();
}, 'Reload the initialization file', true);

key.setViewKey(['SPC', 'f', 'l'], function (ev) {
    command.focusToById("urlbar");
}, 'Focus to the location bar', true);

key.setViewKey(['SPC', 'f', 's'], function (ev) {
    command.focusToById("searchbar");
}, 'Focus to the search bar', true);

key.setViewKey([['SPC', 'f', 't'], ['SPC', 'i']], function (ev) {
    command.focusElement(command.elementsRetrieverTextarea, 0);
}, 'Focus to the first textarea', true);

key.setViewKey(['SPC', 'f', 'b'], function (ev) {
    command.focusElement(command.elementsRetrieverButton, 0);
}, 'Focus to the first button', true);

key.setViewKey(['SPC', 'f', 'f'], function (ev) {
    BrowserOpenFileWindow();
}, 'Open the local file', true);

key.setViewKey(['SPC', 'f', 'p'], function (ev, arg) {
    return !document.getElementById("keysnail-prompt").hidden
        && document.getElementById("keysnail-prompt-textbox").focus();
}, 'focus to the prompt');

key.setViewKey([['SPC', 'w', 'd'], ['x']], function (ev) {
    BrowserCloseTabOrWindow();
}, 'Close tab / window');

key.setViewKey(['SPC', 'w', 'D'], function (ev) {
    closeWindow(true);
}, 'Close the window');

key.setViewKey(['SPC', 'n'], function (ev) {
    OpenBrowserWindow();
}, 'Open new window');

key.setViewKey(['SPC', 'q', 'q'], function (ev) {
    goQuitApplication();
}, 'Exit Firefox', true);

key.setViewKey(['SPC', 'q', 'r'], function (ev) {
    command.restartApp();
}, 'Restart Firefox', true);

key.setViewKey(['SPC', 'j', 'o'], function (ev) {
    toJavaScriptConsole();
}, 'Display JavaScript console', true);

key.setViewKey(['SPC', 'j', 'c'], function (ev) {
    command.clearConsole();
}, 'Clear Javascript console', true);

key.setViewKey(['SPC', 'o', 'p'], function (ev) {
    KeySnail.openPreference();
}, 'Select all', true);

key.setViewKey('/', function (ev) {
    command.iSearchForward(ev);
}, 'Incremental search forward', true);

key.setViewKey('?', function (ev) {
    command.iSearchBackward(ev);
}, 'Incremental search backward', true);

key.setViewKey('C-s', function (ev) {
    saveDocument(window.content.document);
}, 'Save current page to the file', true);

key.setViewKey('X', function (ev) {
    undoCloseTab();
}, 'Undo closed tab');

key.setViewKey(['v', 'i', 'g'], function (ev) {
    goDoCommand("cmd_selectAll");
}, 'Select all', true);

key.setViewKey('r', function (ev) {
    BrowserReload();
}, 'Reload the page', true);

key.setViewKey([['j']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
            }, 'Scroll line down');

key.setViewKey([['k']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
            }, 'Scroll line up');

key.setViewKey([['l']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
            }, 'Scroll right');

key.setViewKey([['h']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
            }, 'Scroll left');

key.setViewKey('u', function (ev) {
    let linesPerHalf = 7;
    while(linesPerHalf-->0) {
        key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
    }
}, 'Scroll half page down');

key.setViewKey('d', function (ev) {
    let linesPerHalf = 7;
    while(linesPerHalf-->0) {
        key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
    }
}, 'Scroll half page down');

key.setViewKey([['M-v']], function (ev) {
                goDoCommand("cmd_scrollPageUp");
            }, 'Scroll page up');

key.setViewKey('C-v', function (ev) {
                goDoCommand("cmd_scrollPageDown");
            }, 'Scroll page down');

key.setViewKey([['M-<'], ['g']], function (ev) {
                goDoCommand("cmd_scrollTop");
            }, 'Scroll to the top of the page', true);

key.setViewKey([['M->'], ['G']], function (ev) {
                goDoCommand("cmd_scrollBottom");
            }, 'Scroll to the bottom of the page', true);

key.setViewKey('L', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'Select next tab');

key.setViewKey('H', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(-1, true);
            }, 'Select previous tab');

key.setViewKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'List and execute commands', true);

key.setViewKey('R', function (ev) {
                BrowserReloadSkipCache();
            }, 'Reload the page (skip cache)', true);

key.setViewKey('K', function (ev) {
                BrowserBack();
            }, 'Back');

key.setViewKey('J', function (ev) {
    BrowserForward();
}, 'Forward');

key.setViewKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, 'Focus to the next button');

key.setViewKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, 'Focus to the previous button');

key.setViewKey('C-M-J', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, 'Scroll line down');

key.setViewKey('<', function (ev) {
    let browser = getBrowser();
    if (browser.mCurrentTab.previousSibling) {
        browser.moveTabTo(browser.mCurrentTab, browser.mCurrentTab._tPos - 1);
    } else {
        browser.moveTabTo(browser.mCurrentTab, browser.mTabContainer.childNodes.length - 1);
    }
}, 'move tab to left');

key.setViewKey('>', function (ev) {
    let browser = getBrowser();
    if (browser.mCurrentTab.nextSibling) {
        browser.moveTabTo(browser.mCurrentTab, browser.mCurrentTab._tPos + 1);
    } else {
        browser.moveTabTo(browser.mCurrentTab, 0);
    }
}, 'move tab to right');

key.setViewKey(['SPC', 'w', 'w'], function (ev, arg) {
    ext.exec('tanything', arg, ev);
}, 'view all tabs');

key.setViewKey([['f'], ['SPC', 'o', 'c']], function (ev, arg) {
    ext.exec('hok-start-foreground-mode', arg, ev);
}, 'hok in current tab');

key.setViewKey([['F'], ['SPC', 'o', 'n']], function (ev, arg) {
    ext.exec('hok-start-background-mode', arg, ev);
}, 'hok in new tab');

key.setViewKey([['SPC', 'm'], ['SPC', 'o', 'm']], function (ev, arg) {
    ext.exec('hok-start-continuous-mode', arg, ev);
}, 'hok multiple');

key.setViewKey([['SPC', 'o', 'e']], function (ev, arg) {
    ext.exec('hok-start-extended-mode', arg, ev);
}, 'hok extended');

key.setViewKey(['SPC', 'b'], function (ev, arg) {
        ext.exec("bmany-list-all-bookmarks", arg, ev);
}, 'bmany - List all bookmarks');

// key.setViewKey(['SPC', 'b', 'l'], function (ev, arg) {
//         ext.exec("bmany-list-bookmarklets", arg, ev);
// }, "bmany - List all bookmarklets");

// key.setViewKey(['SPC', 'b', 'k'], function (ev, arg) {
//         ext.exec("bmany-list-bookmarks-with-keyword", arg, ev);
// }, "bmany - List bookmarks with keyword");

// key.setViewKey(['SPC', 'b', 't'], function (ev, arg) {
//         ext.exec("bmany-list-bookmarks-with-tag", arg, ev);
// }, "bmany - List bookmarks with tag");

key.setViewKey(['SPC', 'h'], function (ev, arg) {
    ext.exec("history-show", arg, ev);
}, "list history");

key.setViewKey(['m'], function (ev, arg) {
        ext.exec("scrollet-set-mark", arg, ev);
}, "set mark");

key.setViewKey(['\''], function (ev, arg) {
        ext.exec("scrollet-jump-to-mark", arg, ev);
}, "jump to mark");

key.setViewKey(['SPC', 'd', 't'], function (ev, arg) {
    openUILinkIn(
        window.content.location.href,
        JJ_TAB_NEW
    );
}, "duplicate tab");

key.setEditKey('C-c', function (ev) {
    command.copyRegion(ev);
}, 'Copy selected text', true);

key.setEditKey('C-w', function (ev) {
    command.deleteBackwardWord(ev);
}, 'backward delete word', true);

key.setEditKey('m-b', function (ev) {
    command.deleteForwardWord(ev);
            }, 'forward delete word', true);

key.setEditKey('C-s', function (ev) {
    command.iSearchForwardKs(ev);
}, 'Emacs like incremental search forward', true);

key.setEditKey('C-r', function (ev) {
    command.iSearchBackwardKs(ev);
}, 'Emacs like incremental search backward', true);

key.setEditKey(['C-x', 'h'], function (ev) {
                command.selectAll(ev);
            }, 'Select whole text', true);

key.setEditKey([['C-x', 'u'], ['C-/']], function (ev) {
                display.echoStatusBar("Undo!", 2000);
                goDoCommand("cmd_undo");
            }, 'Undo');

key.setEditKey(['C-x', 'r', 'd'], function (ev, arg) {
                command.replaceRectangle(ev.originalTarget, "", false, !arg);
            }, 'Delete text in the region-rectangle', true);

key.setEditKey(['C-x', 'r', 't'], function (ev) {
                prompt.read("String rectangle: ", function (aStr, aInput) {
                                command.replaceRectangle(aInput, aStr);
                            },
                            ev.originalTarget);
            }, 'Replace text in the region-rectangle with user inputted string', true);

key.setEditKey(['C-x', 'r', 'o'], function (ev) {
                command.openRectangle(ev.originalTarget);
            }, 'Blank out the region-rectangle, shifting text right', true);

key.setEditKey(['C-x', 'r', 'k'], function (ev, arg) {
                command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
            }, 'Delete the region-rectangle and save it as the last killed one', true);

key.setEditKey(['C-x', 'r', 'y'], function (ev) {
                command.yankRectangle(ev.originalTarget, command.kill.buffer);
            }, 'Yank the last killed rectangle with upper left corner at point', true);

key.setEditKey([['C-SPC'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'Set the mark', true);

key.setEditKey('C-o', function (ev) {
    command.openLine(ev);
    command.nextLine(ev);
            }, 'Open line');

key.setEditKey('C-?', function (ev) {
                display.echoStatusBar("Redo!", 2000);
                goDoCommand("cmd_redo");
            }, 'Redo');

key.setEditKey('C-a', function (ev) {
                command.beginLine(ev);
            }, 'Beginning of the line');

key.setEditKey('C-e', function (ev) {
                command.endLine(ev);
            }, 'End of the line');

key.setEditKey('C-f', function (ev) {
                command.nextChar(ev);
            }, 'Forward char');

key.setEditKey('C-d', function (ev) {
                command.previousChar(ev);
            }, 'Backward char');

key.setEditKey('M-f', function (ev) {
                command.forwardWord(ev);
            }, 'Next word');

key.setEditKey('M-d', function (ev) {
                command.backwardWord(ev);
            }, 'Previous word');

key.setEditKey('C-n', function (ev) {
                command.nextLine(ev);
            }, 'Next line');

key.setEditKey('C-p', function (ev) {
                command.previousLine(ev);
            }, 'Previous line');

key.setEditKey('C-v', function (ev) {
    command.yank(ev);
}, 'paste');

key.setEditKey('M-v', function (ev) {
                command.pageUp(ev);
            }, 'Page up');

key.setEditKey('M-<', function (ev) {
                command.moveTop(ev);
            }, 'Beginning of the text area');

key.setEditKey('M->', function (ev) {
                command.moveBottom(ev);
            }, 'End of the text area');

key.setEditKey('C-b', function (ev) {
                goDoCommand("cmd_deleteCharForward");
            }, 'Delete forward char');

key.setEditKey('C-h', function (ev) {
                goDoCommand("cmd_deleteCharBackward");
            }, 'Delete backward char');

key.setEditKey('M-b', function (ev) {
                command.deleteForwardWord(ev);
            }, 'Delete forward word');

key.setEditKey([['C-<backspace>'], ['M-<delete>']], function (ev) {
                command.deleteBackwardWord(ev);
            }, 'Delete backward word');

key.setEditKey('M-u', function (ev, arg) {
                command.wordCommand(ev, arg, command.upcaseForwardWord, command.upcaseBackwardWord);
            }, 'Convert following word to upper case');

key.setEditKey('M-l', function (ev, arg) {
                command.wordCommand(ev, arg, command.downcaseForwardWord, command.downcaseBackwardWord);
            }, 'Convert following word to lower case');

key.setEditKey('M-c', function (ev, arg) {
                command.wordCommand(ev, arg, command.capitalizeForwardWord, command.capitalizeBackwardWord);
            }, 'Capitalize the following word');

key.setEditKey('C-k', function (ev) {
                command.killLine(ev);
            }, 'Kill the rest of the line');

key.setEditKey('C-y', command.yank, 'Paste (Yank)');

key.setEditKey('M-y', command.yankPop, 'Paste pop (Yank pop)', true);

key.setEditKey([['C-M-y'], ['C-V']], function (ev) {
                if (!command.kill.ring.length)
                    return;

                let ct = command.getClipboardText();
                if (!command.kill.ring.length || ct != command.kill.ring[0]) {
                    command.pushKillRing(ct);
                }

                prompt.selector(
                    {
                        message: "Paste:",
                        collection: command.kill.ring,
                        callback: function (i) { if (i >= 0) key.insertText(command.kill.ring[i]); }
                    }
                );
            }, 'Show kill-ring and select text to paste', true);

key.setEditKey(['C-x', 'x'], function (ev) {
                goDoCommand("cmd_copy");
                goDoCommand("cmd_delete");
                command.resetMark(ev);
            }, 'Cut current region', true);

key.setEditKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverTextarea, true, true);
            }, 'Focus to the next text area');

key.setEditKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverTextarea, false, true);
            }, 'Focus to the previous text area');

key.setCaretKey([['C-a'], ['^']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
            }, 'Move caret to the beginning of the line');

key.setCaretKey([['C-e'], ['$'], ['M->'], ['G']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
            }, 'Move caret to the end of the line');

key.setCaretKey([['C-n'], ['j']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
            }, 'Move caret to the next line');

key.setCaretKey([['C-p'], ['k']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
            }, 'Move caret to the previous line');

key.setCaretKey([['C-f'], ['l']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
            }, 'Move caret to the right');

key.setCaretKey([['C-d'], ['h'], ['C-h']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
            }, 'Move caret to the left');

key.setCaretKey([['M-f'], ['w']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
            }, 'Move caret to the right by word');

key.setCaretKey([['M-b'], ['W']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
            }, 'Move caret to the left by word');

key.setCaretKey([['C-v'], ['SPC']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
            }, 'Move caret down by page');

key.setCaretKey([['M-v'], ['b']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
            }, 'Move caret up by page');

key.setCaretKey([['M-<'], ['g']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
            }, 'Move caret to the top of the page');

key.setCaretKey('J', function (ev) {
                util.getSelectionController().scrollLine(true);
            }, 'Scroll line down');

key.setCaretKey('K', function (ev) {
                util.getSelectionController().scrollLine(false);
            }, 'Scroll line up');

key.setCaretKey(',', function (ev) {
                util.getSelectionController().scrollHorizontal(true);
                goDoCommand("cmd_scrollLeft");
            }, 'Scroll left');

key.setCaretKey('.', function (ev) {
                goDoCommand("cmd_scrollRight");
                    util.getSelectionController().scrollHorizontal(false);
            }, 'Scroll right');

key.setCaretKey('z', function (ev) {
                command.recenter(ev);
            }, 'Scroll to the cursor position');

key.setCaretKey([['C-SPC'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'Set the mark', true);

key.setCaretKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'List and execute commands', true);

key.setCaretKey('r', function (ev) {
                BrowserReload();
            }, 'Reload the page', true);

key.setCaretKey('B', function (ev) {
                BrowserBack();
            }, 'Back');

key.setCaretKey('F', function (ev) {
                BrowserForward();
            }, 'Forward');

key.setCaretKey(['C-x', 'h'], function (ev) {
                goDoCommand("cmd_selectAll");
            }, 'Select all', true);

key.setCaretKey('f', function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, 'Focus to the first textarea', true);

key.setCaretKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, 'Focus to the next button');

key.setCaretKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, 'Focus to the previous button');
