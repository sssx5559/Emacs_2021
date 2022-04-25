;;;; -*- coding: utf-8 -*-

;;------------------------------------------------
;; 起動時間調査 ※デバッグ用
;;------------------------------------------------
;; (require 'profiler)
;; (profiler-start 'cpu)


;;------------------------------------------------
;; 起動時間短縮用
;;------------------------------------------------
(setq gc-cons-threshold most-positive-fixnum) ; 初期化中のGC無効

;; Magic File Name を一時的に無効にする
;; (defconst my-saved-file-name-handler-alist file-name-handler-alist)
;; (setq file-name-handler-alist nil)


;;------------------------------------------------
;; 環境固有設定
;;------------------------------------------------
(defconst my-emacs-dir "~/.emacs.d/my-elisp/")
(defconst others-emacs-dir "~/.emacs.d/others-elisp/")
(defconst my-screen-width 125)
(defconst my-screen-height 50)
(defconst my-screen-top 207)
(defconst my-screen-left 894)
(defconst my-font "ＭＳ 明朝-12")
(defconst my-migemo-dic "~/tool/cmigemo-default-win64/dict/utf-8/migemo-dict")


;;------------------------------------------------
;;  環境識別
;;------------------------------------------------
;; OS識別
(defun windowsp () (or (string-match "mingw" system-configuration)
					   (string-match "-nt" system-configuration)))
(defun linuxp () (string-match "linux" system-configuration))
(defun macp () (string-match "apple" system-configuration))

;; MSYS2識別用
(defun msys2p () (string-match "x86_64-w64-mingw32" system-configuration))


;;------------------------------------------------
;; straight.el設定ファイル
;;------------------------------------------------
;; straight.el自身のインストールと初期設定を行ってくれる
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-packageをインストール
(straight-use-package 'use-package)

;; オプションなしで自動的にuse-packageをstraight.elにフォールバックする
;; 本来は (use-package hoge :straight t) のように書く必要がある
(setq straight-use-package-by-default t)


;;------------------------------------------------
;; 基本設定
;;------------------------------------------------
;; カスタマイズ変数
(custom-set-variables
 '(tab-width 4)
 '(inhibit-startup-message t)					; 起動時の画面なし
 '(backup-directory-alist '(("." . "~/.emacs.d/backup")))
 '(kill-whole-line t)							; C-k(kill-line) で行末の改行も含めて kill する
 '(visible-bell t)								; 警告音のかわりに画面フラッシュ
 '(truncate-lines t)
 '(bookmark-save-flag 1)						; ブックマーク自動保存
 '(byte-compile-warnings '(cl-functions))		; ver27から出るようになった警告'Package cl is deprecated'を抑制
 )

;; 起動するディレクトリ
(cd "~")

;; ロードパス追加
(add-to-list 'load-path my-emacs-dir)
(add-to-list 'load-path others-emacs-dir)

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(when (eq system-type 'windows-nt)
  (set-file-name-coding-system 'cp932)
  (set-keyboard-coding-system 'cp932)
  (set-terminal-coding-system 'cp932))

(global-auto-revert-mode +1)
(global-hl-line-mode -1)
(show-paren-mode +1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default case-fold-search t)	;検索時の大文字、小文字の区別(t だと区別しない)

;; 環境変数をシェルと共有(Windows以外)
(unless (windowsp)
  (use-package exec-path-from-shell
	:init ;; パッケージ読み込み前に実行
	;; (exec-path-from-shell-copy-envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH"))
	(exec-path-from-shell-copy-envs '("PATH"))
	))


;;------------------------------------------------
;; 画面関連
;;------------------------------------------------
(load-library "my-screen.el")


;;------------------------------------------------
;; フォント関連
;;------------------------------------------------
(load-library "my-font.el")


;;------------------------------------------------
;; IME
;;------------------------------------------------
;; (when (eq system-type 'windows-nt)
;;   (setq default-input-method "japanese-mozc")
;;   (use-package mozc))


;;------------------------------------------------
;; Helm
;;------------------------------------------------
(load-library "my-helm.el")


;;------------------------------------------------
;; Dired
;;------------------------------------------------
(add-hook 'dired-mode-hook
		 (lambda () (load-library "my-dired.el")))


;;------------------------------------------------
;; 補完関連
;;------------------------------------------------
(load-library "my-completion.el")


;;------------------------------------------------
;; 細々したもの
;;------------------------------------------------
(load-library "my-util.el")


;;------------------------------------------------
;; 自作関数群
;;------------------------------------------------
(load-library "my-func.el")


;;------------------------------------------------
;; キー関連設定
;;------------------------------------------------
;; globalキー設定
(load-library "my-key.el")

;; キーバインドの可視化
(use-package which-key
  :config ;; パッケージ読み込み後に実行
  (which-key-mode +1))

wb;;------------------------------------------------
;; Org-mode
;;------------------------------------------------
(load-library "my-org.el")


;;------------------------------------------------
;; プログラム言語設定
;;------------------------------------------------
(load-library "my-prog-mode.el")


;;======================================================
;; Emacs操作メモ
;;======================================================
; (replace-string)での改行入力
; ・C-q, C-jと入力するとラインが変わるので、そこで改行を入力する。
;
; 複数ファイル名変更
; ・diredモード(C-x d)で M-x dired-mark-files-regexpで'*'マークをつける
;   M-x dired-do-rename-regexpで置換部分を指定する
;
; TAGファイル置換
; ・"etags ./**/*.[cChH]"でTAGファイル作成
;   tags-query-replaceで置換


; C-c > runs the command python-shift-right
; C-c < runs the command python-shift-left

;; migemo isearch on/off設定
; 有効 (setq migemo-isearch-enable-p t)
; 無効 (setq migemo-isearch-enable-p nil)

;; wgrep(ag版)使い方
; 1. 検索結果バッファ上でr → 編集できるように
; 2. C-x C-s (もしくは C-c C-e or C-c C-c) で検索元のファイルを更新
; 3. M-x wgrep-save-all-buffers で更新を保存


;; ivy-modeで、候補があることによりファイルやフォルダを作成できないとき
;; C-M-j (https://qiita.com/xargs/items/d54ee21a55c10ece2eeb)

;;------------------------------------------------
;; 起動時間調査 ※デバッグ用
;;------------------------------------------------
;; (profiler-report)
;; (profiler-stop)


;;------------------------------------------------
;; 起動時間短縮用
;;------------------------------------------------
; 初期化中無効にしていたGCを有効にする(16MB)
(setq gc-cons-threshold 16777216)

;; Magic File Name を有効
;; (setq file-name-handler-alist my-saved-file-name-handler-alist)
