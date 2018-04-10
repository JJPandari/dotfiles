#include "gh60.h"
#include "action_layer.h"

#define _DEFAULT 0
#define _FN 1

#define _HP(k) LSFT(LALT(LGUI(k)))

// the TT macro: hold, or 2 taps to switch
#define TAPPING_TOGGLE 2

// Fillers to make layering more clear
#define ______ KC_TRNS

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* Qwerty layer
 * ,-----------------------------------------------------------------------------------------.
 * | Esc |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  |  -  |  =  |     `     |
 * |-----------------------------------------------------------------------------------------+
 * | Tab    |  Q  |  W  |  E  |  R  |  T  |  Y  |  U  |  I  |  O  |  P  |  [  |  ]  |  BSPC  |
 * |-----------------------------------------------------------------------------------------+
 * | Ctrl    |  A  |  S  |  D  |  F  |  G  |  H  |  J  |  K  |  L  |  ;  |  '  |    Enter    |
 * |-----------------------------------------------------------------------------------------+
 * | Shift (   |  Z  |  X  |  C  |  V  |  B  |  N  |  M  |  ,  |  .  |  /  | RShift )  |     |
 * |-----------------------------------------------------------------------------------------+
 * | FN   | LGUI | LAlt  |               Space                | RAlt   | RGUI | Menu |   \   |
 * `-----------------------------------------------------------------------------------------'
 */
  [_DEFAULT] = KEYMAP(
      KC_ESC,  KC_1,    KC_2,    KC_3, KC_4, KC_5,   KC_6, KC_7, KC_8,    KC_9,    KC_0,    KC_MINS, KC_EQL,  KC_GRV, \
      KC_TAB,  KC_Q,    KC_W,    KC_E, KC_R, KC_T,   KC_Y, KC_U, KC_I,    KC_O,    KC_P,    KC_LBRC, KC_RBRC, KC_BSPC,  \
      KC_LCTL, KC_A,    KC_S,    KC_D, KC_F, KC_G,   KC_H, KC_J, KC_K,    KC_L,    KC_SCLN, KC_QUOT, KC_ENT,  \
      KC_LSPO, KC_Z,    KC_X,    KC_C, KC_V, KC_B,   KC_N, KC_M, KC_COMM, KC_DOT,  KC_SLSH, KC_RSPC, ______, \
      TT(_FN),    KC_LGUI, KC_LALT,             KC_SPC,             KC_RALT,  KC_RGUI, KC_APP, KC_BSLS \
      ),

/* HYPER & FN Layer
 * letter keys output Hyper-letter to switch apps or do whatever with the help of Autohotkey/hammerspoon
 * Hyper = Shift-Alt-GUI (Ctrl has some issue on macOS)
 * ,-----------------------------------------------------------------------------------------.
 * | FN  | F1  | F2  | F3  | F4  | F5  | F6  | F7  | F8  | F9  | F10 | F11 | F12 | F13 | F14 |
 * |-----------------------------------------------------------------------------------------+
 * |        | H-Q | H-W | H-E | H-R | H-T | H-Y | H-U | H-I | H-O | H-P |     |     |        |
 * |-----------------------------------------------------------------------------------------+
 * |         | H-A | H-S | H-D | H-F | H-G |  ←  |  ↓  |  ↑  |  →  |PSCR |     |             |
 * |-----------------------------------------------------------------------------------------+
 * |           | H-Z | H-X | H-C | H-V | H-B | H-N | H-M |Vol- |Vol+ |     |           |     |
 * |-----------------------------------------------------------------------------------------+
 * |      |      |       |                F24                 |        |      |      |       |
 * `-----------------------------------------------------------------------------------------'
 */
  [_FN] = KEYMAP(
      TG(_FN),   KC_F1,      KC_F2,    KC_F3,     KC_F4,     KC_F5,     KC_F6,     KC_F7,     KC_F8,     KC_F9,     KC_F10,  KC_F11, KC_F12, KC_F13, KC_F14, \
      ______, _HP(KC_Q), _HP(KC_W), _HP(KC_E), _HP(KC_R), _HP(KC_T), _HP(KC_Y), _HP(KC_U), _HP(KC_I), _HP(KC_O), _HP(KC_P),    ______, ______, ______,  \
      ______, _HP(KC_A), _HP(KC_S), _HP(KC_D), _HP(KC_F), _HP(KC_G), KC_LEFT,   KC_DOWN,   KC_UP,     KC_RIGHT,  KC_PSCR, ______, ______,  \
      ______, _HP(KC_Z), _HP(KC_X), _HP(KC_C), _HP(KC_V), _HP(KC_B), _HP(KC_N), _HP(KC_M), KC_VOLD,    KC_VOLU,    ______, ______, ______, \
      ______,  ______,  ______,                KC_F24,                   ______,  ______, ______,  ______ \
      )
};
