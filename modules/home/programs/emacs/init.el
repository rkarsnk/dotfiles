;;; init.el --- Emacs設定 -*- lexical-binding: t; -*-

;;; Commentary:
;; home-manager (modules/home/programs/emacs) から ~/.emacs.d/init.el として配置される。
;; 直接編集せず、dotfiles側のこのファイルを編集すること。

;;; Code:

;;;; 日本語 / UTF-8

;; 言語環境を日本語にする（暗黙にUTF-8優先の設定も入る）
(set-language-environment "Japanese")

;; 文字コードはUTF-8(LF)を最優先にする
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)

;; ファイル名・外部プロセスとのやり取りもUTF-8にする
(set-file-name-coding-system 'utf-8-unix)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; クリップボードとの受け渡しはUTF-8にする
(set-selection-coding-system 'utf-8)

;;;; 日本語入力 (mac-ime)

;; mac-ime は nix の emacsWithPackages で導入している。
;; 初回の有効化時に、動的モジュール(mac-ime-module.so)を curl でGitHubから取得する。
;; 既定の保存先はパッケージ自身のディレクトリ(nix store, 読み取り専用)で書き込めないため、
;; 書き込み可能な ~/.emacs.d/mac-ime/ に変更する。require より前に設定する必要がある。
(defvar mac-ime-module-path
  (expand-file-name "mac-ime/mac-ime-module.so" user-emacs-directory))
(make-directory (file-name-directory mac-ime-module-path) t)

(when (and (eq system-type 'darwin)
           (require 'mac-ime nil t))
  (setq default-input-method "mac-ime")
  ;; モジュールの取得に失敗しても、init.el 以降の読み込みを止めない
  (with-demoted-errors "mac-ime: %S"
    (mac-ime-enable))

  ;; C-j を macSKK のひらがなモードへの切り替えにする。
  ;; C-j はEmacsが先に処理してしまい macSKK に届かないため、Emacs側で代替する。
  ;; (macSKKの入力ソースIDは macSKK.app の Info.plist で確認したもの)
  (defun my/macskk-hiragana ()
    "macSKK をひらがなモードにする。"
    (interactive)
    (mac-ime-set-input-source "net.mtgto.inputmethod.macSKK.hiragana"))

  ;; マイナーモードのキーマップはメジャーモードのキーマップより優先されるため、
  ;; lisp-interaction-mode の C-j (eval-print-last-sexp) なども上書きできる。
  ;; ミニバッファでは元のC-j (入力確定) を残す。
  (define-minor-mode my/macskk-c-j-mode
    "C-j で macSKK をひらがなモードにするグローバルマイナーモード。"
    :global t
    :keymap (let ((map (make-sparse-keymap)))
              (define-key map (kbd "C-j")
                          '(menu-item "" my/macskk-hiragana
                                      :filter (lambda (cmd) (unless (minibufferp) cmd))))
              map))
  (when (featurep 'mac-ime-module)
    (my/macskk-c-j-mode 1)))

;;; init.el ends here
