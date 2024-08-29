;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; 雑多な設定
;;-----------------------------------------------------------------------------
;; バッファローカル変数デフォルト値設定
;; (defun miya-make-list (interval up-bound)
;;   (let ((temp (list up-bound)))
;; 	(while (> up-bound interval)
;; 	  (setq up-bound (- up-bound interval))
;; 	  (setq temp (cons up-bound temp)))
;; ;	(copy-sequence temp)))
;; 	temp))

;; (setq-default tab-width 4				;タブ幅を 4 に設定
;; 			  truncate-lines t			;切り捨て表示
;; 			  tab-stop-list	(miya-make-list 4 120)) ;タブストップ

;;タブではなくスペースを使う
;(setq indent-tabs-mode nil)
;(setq indent-line-function 'indent-relative-maybe)

;; 関数使用許可設定
;; (put 'upcase-region 'disabled nil)
;; (put 'downcase-region 'disabled nil)
;; (put 'set-goal-column 'disabled nil)
;; (custom-set-faces)
;; (put 'narrow-to-region 'disabled nil)

;; レジスタの中にファイル名を保存する方法(C-x r jでファイルにジャンプ)
;(set-register ?レジスタ名 '(file . "ファイルパス"))

;; find-file(C-x C-f) hook の使用例
;(add-hook 'find-file-hooks
;          (function (lambda ()
;                  (if (string-match "makoto/writing" buffer-file-name)
;            (setq fill-column 44))
;                  (if (string-match "makoto/writing/jk" buffer-file-name)
;            (setq fill-column 84))
;                  (if (string-match "vertical/" buffer-file-name)
;            (setq fill-column 40))
;                  (if (string-match "Mail/draft/" buffer-file-name)
;            (setq fill-column 60)) ;; not good now
;                  (if (string-match "makoto/diary/" buffer-file-name)
;            (setq default-buffer-file-coding-system 'euc-japan)
;            (setq default-buffer-file-coding-system 'iso-2022-jp ))
;                  )))

;; C言語で"FiXME"という単語を強調表示する例
; (font-lock-add-keywords
;  'c-mode
;  '(("\\<\\(FIXME\\):" 1 font-lock-warning-face t)))

;; デフォルトメジャーモード設定
;(setq default-major-mode 'lisp-interaction-mode)

;; 補完モードON
;(setq-default abbrev-mode t)

;; タブストップリスト作成用
;; (defun miya-make-tab-stop-list ()
;;   (let ((index 120)
;; 		(def 4)
;; 		(list))
;; 	(while (>= index def)
;; 	  (setq list (cons index list))
;; 	  (setq index (- index def)))
;; 	list))

;; タブストップリスト作成
;; (setq-default tab-stop-list (miya-make-tab-stop-list))

;; (setq make-backup-files nil)			;; ファイルバックアップなし
(setq mode-require-final-newline nil)	;; 保存時に改行コードをつけない


;;=========================================================
;; 日付入力
;;=========================================================
;; (autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;; (define-key global-map "\C-cs" 'instamp)

;;=========================================================
;; grep
;;=========================================================
(setq grep-command "grep -rne ")

;;=========================================================
;; <C-x C-c>終了時にプロセスを自動終了
;;=========================================================
(defadvice save-buffers-kill-terminal (before my-save-buffers-kill-terminal activate)
 (when (process-list)
   (dolist (p (process-list))
     (set-process-query-on-exit-flag p nil))))

;;=========================================================
;; ediff
;;=========================================================
;; Ediff Control Panelを同じフレーム内に表示する
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; 差分を横に分割して表示する
(setq ediff-split-window-function 'split-window-horizontally)
;; 余計なバッファを(確認して)削除する
(setq ediff-keep-variants nil)

;;=========================================================
;; mouse
;;=========================================================
;; マウスホイールでスクロール
;; (global-set-key (kbd "<wheel-up>")
;; 				'(lambda () (interactive) (scroll-down 3)))
;; (global-set-key (kbd "<wheel-down>")
;; 				'(lambda () (interactive) (scroll-up 3)))

;; スクロールステップ 3に設定
;(setq scroll-step 3)

;;=========================================================
;; find-file
;;=========================================================
;; 大文字、小文字を区別しない
;; (setq completion-ignore-case t)
;; (setq read-file-name-completion-ignore-case t)

;;=========================================================
;; ido-mode
;;=========================================================
;; (require 'ido)
;; (ido-mode t)
;; (ido-everywhere t)

;; (custom-set-variables
;;  '(ido-case-fold t)						; 大文字、小文字を区別しない
;;  '(ido-create-new-buffer 'always)
;;  '(ido-enable-flex-matching t)			; あいまいマッチ
;;  '(ido-use-virtual-buffers t)
;;  ;;'(ido-max-directory-size 100000)

;;  (when (boundp 'confirm-nonexistent-file-or-buffer)
;;    '(confirm-nonexistent-file-or-buffer nil)) ; 即、newバッファを作る
;;  )

;; (when (require 'ido-vertical-mode nil t)
;;   (ido-vertical-mode t)

;;   (custom-set-faces
;;    '(ido-vertical-first-match-face ((t (:underline (:inherit ido-first-match)))))
;;    )

;;   (custom-set-variables
;;    '(ido-vertical-define-keys 'C-n-and-C-p-only)
;;    '(ido-vertical-show-count t)
;;    )
;;   )

;; ido-modeのmapは設定不可？
;; (define-key ido-common-completion-map (kbd "C-l") 'ido-delete-backward-updir)

;;=========================================================
;; ivy/counsel/swiper
;;=========================================================
;; (when (and (>= emacs-major-version 24) (not (msys2p)))
;;   (add-to-list 'load-path (concat emacs-dir "elisp/swiper-0.8.0"))
;;   (require 'ivy)
;;   (require 'counsel)
;;   (ivy-mode 1)

;;   ;; カスタム変数設定
;;   (custom-set-variables
;;    '(ivy-count-format "(%d/%d) ")
;;    '(ivy-wrap t)
;;    ;; '(ivy-height 20)	; デフォルト10
;;    )

;;   (defun isearch-forward-or-swiper (use-swiper)
;; 	(interactive "P")
;; 	(let (current-prefix-arg)
;; 	  (call-interactively (if use-swiper 'swiper 'isearch-forward))))

;;   ;; キー設定
;;   (global-set-key (kbd "C-s") 'isearch-forward-or-swiper)
;;   ;;(global-set-key (kbd "C-M-s") 'swiper)
;;   ;;(global-set-key (kbd "M-x") 'counsel-M-x)
;;   (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;   (global-set-key (kbd "C-c C-r") 'ivy-resume)

;;   (define-key ivy-minibuffer-map (kbd "C-l") 'counsel-up-directory)
;;   (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-delete-char)
;;   (define-key swiper-map (kbd "C-r") 'ivy-previous-line-or-history)
;;   )

;;=========================================================
;; キーボードマクロを保存
;;=========================================================
;; (defvar kmacro-save-file "~/kmacro-save.el")

;; (defun kmacro-save (symbol)
;;   (interactive "SName for last kbd macro: ")
;;   (name-last-kbd-macro symbol)		; 名前を付ける
;;   (with-current-buffer (find-file-noselect kmacro-save-file)
;; 	(goto-char (point-max))
;; 	(insert-kbd-macro symbol)
;; 	(basic-save-buffer)))

;;=========================================================
;; 略語展開機能選択
;;=========================================================
;; (setq hippie-expand-try-functions-list
;; 	  '(
;; 		;; カスタム
;; 		;; try-expand-jsdoc-keyword

;; 		;; 標準
;; 		try-expand-dabbrev
;; 		try-expand-dabbrev-all-buffers
;; 		try-expand-dabbrev-from-kill
;; 		;; try-expand-all-abbrevs
;; 		try-expand-list
;; 		try-expand-line
;; 		try-complete-lisp-symbol-partially
;; 		try-complete-lisp-symbol
;; 		try-complete-file-name-partially
;; 		try-complete-file-name
;; 		))

;; ;; JSDocキーワードリスト
;; (setq jsdoc-keyword-list
;; 	  '(
;; 		"@author" "@code" "@const" "@constructor" "@define" "@deprecated" "@dict" "@enum"
;; 		"@export" "@expose" "@extends" "@externs" "@fileoverview" "@implements" "@inheritDoc" "@interface"
;; 		"@lends" "@license" "@noalias" "@nocompile" "@nosideeffects" "@override" "@param" "@preserve"
;; 		"@private" "@protected" "@public" "@return" "@see" "@struct" "@supported" "@suppress" "@template"
;; 		"@this" "@type" "@typedef"
;; 		))

;; ;; JSDocキーワード補完サブ関数
;; (defun he-jsdoc-command-beg ()
;;   (let ((p)
;; 		(min (save-excursion
;; 			   (progn (beginning-of-line) (point)))))
;;     (save-excursion
;;       (search-backward "@" min t)
;;       (setq p (point)))
;;     p))

;; ;; JSDocキーワード補完メイン関数
;; (defun try-expand-jsdoc-keyword (old)
;;   (unless old
;;     (he-init-string (he-jsdoc-command-beg) (point))
;;     (setq he-expand-list (sort
;;                           (all-completions he-search-string (mapcar 'list jsdoc-keyword-list))
;;                           'string-lessp)))
;; ;;  (y-or-n-p (format "%s" he-search-string))
;;   (while (and he-expand-list
;;               (he-string-member (car he-expand-list) he-tried-table))
;;     (setq he-expand-list (cdr he-expand-list)))
;;   (if (null he-expand-list)
;;       (progn
;;         (when old (he-reset-string))
;;         ())
;;     (he-substitute-string (car he-expand-list))
;;     (setq he-tried-table (cons (car he-expand-list) (cdr he-tried-table)))
;;     (setq he-expand-list (cdr he-expand-list))
;;     t))

;; (add-hook 'js2-mode-hook
;; 		  '(lambda ()
;; 			 ;; 先頭に登録
;; 			 (add-to-list 'hippie-expand-try-functions-list 'try-expand-jsdoc-keyword)
;; 				 ))

;;=========================================================
;; 環境依存文字表示(①とか⊿)
;;=========================================================
;; (when (>= emacs-major-version 23)
;;   (set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
;;                         'katakana-jisx0201 'iso-8859-1 'unicode)

;;   ;; "japanese-shift-jis"ではなく、"cp932"とすれば表示できる。
;;   (set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)
;;   )

;;=========================================================
;; ediff-directories (Compare Emacs dir)
;;=========================================================
;; (defun ediff-directories-emacs ()
;;   (interactive)
;;   (if (boundp 'my-git-dir)
;; 	  (let ((git-dir (concat my-git-dir "Emacs/.emacs.d/miya-elisp/"))
;; 			(local-dir (concat (getenv "HOME") "/.emacs.d/miya-elisp/")))
;; 			(ediff-directories git-dir local-dir "\\.el$"))
;; 	(message "Not found my-git-dir.")))

;;=========================================================
;; Chrome操作(Macのみ)
;;=========================================================
;; (when (macp)
;;   (setq chrome-script-path "~/Dropbox/home/Program/AppleScript/Chrome/")

;; 	(defun chrome-reload ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "reload.scpt")))

;; 	(defun chrome-close ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "close.scpt")))

;; 	(defun chrome-switch-tab-forward ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "switch_tab.scpt forward")))

;; 	(defun chrome-switch-tab-back ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "switch_tab.scpt back")))

;; 	(defun chrome-scroll-down ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "scroll.scpt down")))

;; 	(defun chrome-scroll-up ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "scroll.scpt up")))

;; 	(defun chrome-scroll-down2 ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "scroll2.scpt down")))

;; 	(defun chrome-scroll-up2 ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "scroll2.scpt up")))

;; 	(defun chrome-go-back ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "go_back_forward.scpt back")))

;; 	(defun chrome-go-forward ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "go_back_forward.scpt forward")))

;; 	(defun chrome-view-source ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path "view_source.scpt")))

;; 	(defun chrome-open-file ()
;; 	  (interactive)
;; 	  (shell-command (concat "osascript " chrome-script-path
;; 							 (concat "open_file.scpt " (buffer-file-name)))))

;; 	(smartrep-define-key global-map "A-c"
;; 	  '(("r" . 'chrome-reload)
;; 		("c" . 'chrome-close)
;; 		("<tab>" . 'chrome-switch-tab-forward)
;; 		("S-<tab>" . 'chrome-switch-tab-back)
;; 		("j" . 'chrome-scroll-down)
;; 		("k" . 'chrome-scroll-up)
;; 		("SPC" . 'chrome-scroll-down2)
;;  		("S-SPC". 'chrome-scroll-up2)
;; 		("h" . 'chrome-go-back)
;; 		("l". 'chrome-go-forward)
;; 		("v". 'chrome-view-source)
;; 		("o". 'chrome-open-file)
;; 	  ))
;; 	)


;;=========================================================
;; sdic(辞書)
;;=========================================================
(setq sdic-default-coding-system 'utf-8)

(add-to-list 'load-path (concat others-emacs-dir "sdic"))

;; 英和辞書設定
(setq sdic-eiwa-dictionary-list
		(list (list 'sdicf-client (concat others-emacs-dir "sdic/gene-utf8.sdic"))))

;; 和英辞書設定
(setq sdic-waei-dictionary-list
	  (list (list 'sdicf-client (concat others-emacs-dir "sdic/jedict-utf8.sdic"))))

(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

;; 見出し語のスタイル
(setq sdic-face-style 'bold) ; デフォルトで bold

;; 見出し語の色
(setq sdic-face-color "hot pink")

;; emacs26以降対策 (default-fill-columnが無くなった)
(when (>= emacs-major-version 26)
  (setq default-fill-column (default-value 'fill-column)))


;;=========================================================
;; undo-tree
;;=========================================================
(use-package undo-tree
  :bind	;; グローバルキー設定
  (("C-M-/" . undo-tree-redo))			; redoキー設定

  :config ;; パッケージ読み込み後に実行
  (global-undo-tree-mode)
  )

;;=========================================================
;; ace-jump, ace-isearch
;;=========================================================
;; (use-package ace-jump-mode
;;   :config ;; パッケージ読み込み後に実行
;;   ;; (global-ace-isearch-mode t)

;;   ;; (defun add-keys-to-ace-jump-mode (prefix c &optional mode)
;;   ;; 	(define-key global-map
;;   ;; 	  (read-kbd-macro (concat prefix (string c)))
;;   ;; 	  `(lambda ()
;;   ;; 		 (interactive)
;;   ;; 		 (funcall (if (eq ',mode 'word)
;;   ;; 					  #'ace-jump-word-mode
;;   ;; 					#'ace-jump-char-mode) ,c))))

;;   ;; ;; H-0～H-9、H-a～H-zで任意のところにジャンプ
;;   ;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c))
;;   ;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c))
;;   ;; (loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-A-" c 'word))
;;   ;; (loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-A-" c 'word))
;;   )

;;=========================================================
;; expand-region
;;=========================================================
;; (use-package expand-region
;;   :config ;; パッケージ読み込み後に実行
;;   (global-set-key (kbd "C-@") 'er/expand-region)
;;   (global-set-key (kbd "C-M-@") 'er/contract-region)
;;   )


;;=========================================================
;; iedit
;;=========================================================
(use-package iedit
  :defer t

  :bind ;; グローバルキー設定
  (("C-c ;" . iedit-mode))

  :config ;; パッケージ読み込み後に実行
  (setq iedit-toggle-key-default nil) 	;; これが無いと、"C-c ;"を設定しても使えない

  (bind-keys :map iedit-mode-keymap
		("C-m" . iedit-toggle-selection)
  		("M-p" . iedit-expand-up-a-line)
		("M-n" . iedit-expand-down-a-line)
		("M-h" . iedit-restrict-function)
		("M-i" . iedit-restrict-current-line)
		("C-g" . iedit-mode) ;; Exit iedit-mode
		("C-h" . delete-backward-char))
  )


;;=========================================================
;; quickrun
;;=========================================================
(use-package quickrun
;;  :straight
;;  (el-patch :host github :repo "emacsorphanage/quickrun" :branch "master")

  :bind	;; グローバルキー設定
  (("C-x @" . my-quickrun))

  :config ;; パッケージ読み込み後に実行
  ;; region選択:quickrun-region, 非選択:quickrun
  (defun my-quickrun ()
	(interactive)
	(if mark-active
		(quickrun :start (region-beginning) :end (region-end))
	  (quickrun)))

  ;; [Python]
  (when (boundp 'my-python)
	;; Override existing command
	(quickrun-add-command "python"
						  (list (cons :command my-python))
						  :override t))

  ;; [Go]
  ;; Override existing command
  (quickrun-add-command "go/go"
						'((:tempfile . t)) 	; tempfileが無効だと、保存ファイルしか実行できない
						:override t)

  ;; (custom-set-variables
  ;;  '(quickrun-option-outputter 'message)	;; 実行結果をエコーエリアに出力
  ;;  )
  )


;;=========================================================
;; multiple-cursors
;;=========================================================
(use-package multiple-cursors

  :bind	;; グローバルキー設定
  (("C-M-c" . mc/edit-lines)
   ("C-M-m" . mc/mark-all-in-region))

  :config ;; パッケージ読み込み後に実行
  ;; (defun mc/mark-all-dwim-or-expand-region (arg)
  ;; 	(interactive "p")
  ;; 	(cl-case arg
  ;; 	  (16 (mc/mark-all-dwim t))
  ;; 	  (4 (mc/mark-all-dwim nil))
  ;; 	  (1 (call-interactively 'er/expand-region))))

  ;; ;; C-M-SPCでer/expand-region
  ;; ;; C-u C-M-SPCでmc/mark-all-in-region
  ;; ;; C-u C-u C-M-SPCでmc/edit-lines
  ;; (global-set-key (kbd "C-M-SPC") 'mc/mark-all-dwim-or-expand-region)


  ;; (defun mc/edit-lines-or-string-rectangle (s e)
  ;; 	"C-x r tで同じ桁の場合にmc/edit-lines (C-u M-x mc/mark-all-dwim)"
  ;; 	(interactive "r")
  ;; 	(if (eq (save-excursion (goto-char s) (current-column))
  ;; 			(save-excursion (goto-char e) (current-column)))
  ;; 		(call-interactively 'mc/edit-lines)
  ;; 	  (call-interactively 'string-rectangle)))

  ;; (global-set-key (kbd "C-x r t") 'mc/edit-lines-or-string-rectangle)

  ;; (defun mc/mark-all-dwim-or-mark-sexp (arg)
  ;; 	"C-u C-M-SPCでmc/mark-all-dwim, C-u C-u C-M-SPCでC-u M-x mc/mark-all-dwim"
  ;; 	(interactive "p")
  ;; 	(cl-case arg
  ;; 	  (16 (mc/mark-all-dwim t))
  ;; 	  (4 (mc/mark-all-dwim nil))
  ;; 	  (1 (mark-sexp 1))))

  ;; (global-set-key (kbd "C-M-SPC") 'mc/mark-all-dwim-or-mark-sexp)

;;  (declare-function smartrep-define-key "smartrep")

  ;; (global-unset-key "\C-t")

  ;; (smartrep-define-key global-map "C-t"
  ;; 	'(("C-t"  . 'mc/mark-next-like-this)
  ;; 	  ("n"    . 'mc/mark-next-like-this)
  ;; 	  ("p"    . 'mc/mark-previous-like-this)
  ;; 	  ("m"    . 'mc/mark-more-like-this-extended)
  ;; 	  ("N"    . 'mc/unmark-next-like-this)
  ;; 	  ("P"    . 'mc/unmark-previous-like-this)
  ;; 	  ("s"    . 'mc/skip-to-next-like-this)
  ;; 	  ("S"    . 'mc/skip-to-previous-like-this)
  ;; 	  ("*"    . 'mc/mark-all-like-this)
  ;; 	  ("d"    . 'mc/mark-all-like-this-dwim)
  ;; 	  ("i"    . 'mc/insert-numbers)
  ;; 	  ("o"    . 'mc/sort-regions)
  ;; 	  ("O"    . 'mc/reverse-regions)
  ;; 	  ))
  )

;;=========================================================
;; multiple-cursors
;;=========================================================
(use-package multiple-cursors
  :config ;; パッケージ読み込み後に実行
  ;; (defun mc/mark-all-dwim-or-expand-region (arg)
  ;; 	(interactive "p")
  ;; 	(cl-case arg
  ;; 	  (16 (mc/mark-all-dwim t))
  ;; 	  (4 (mc/mark-all-dwim nil))
  ;; 	  (1 (call-interactively 'er/expand-region))))

  ;; ;; C-M-SPCでer/expand-region
  ;; ;; C-u C-M-SPCでmc/mark-all-in-region
  ;; ;; C-u C-u C-M-SPCでmc/edit-lines
  ;; (global-set-key (kbd "C-M-SPC") 'mc/mark-all-dwim-or-expand-region)


  ;; (defun mc/edit-lines-or-string-rectangle (s e)
  ;; 	"C-x r tで同じ桁の場合にmc/edit-lines (C-u M-x mc/mark-all-dwim)"
  ;; 	(interactive "r")
  ;; 	(if (eq (save-excursion (goto-char s) (current-column))
  ;; 			(save-excursion (goto-char e) (current-column)))
  ;; 		(call-interactively 'mc/edit-lines)
  ;; 	  (call-interactively 'string-rectangle)))

  ;; (global-set-key (kbd "C-x r t") 'mc/edit-lines-or-string-rectangle)

  ;; (defun mc/mark-all-dwim-or-mark-sexp (arg)
  ;; 	"C-u C-M-SPCでmc/mark-all-dwim, C-u C-u C-M-SPCでC-u M-x mc/mark-all-dwim"
  ;; 	(interactive "p")
  ;; 	(cl-case arg
  ;; 	  (16 (mc/mark-all-dwim t))
  ;; 	  (4 (mc/mark-all-dwim nil))
  ;; 	  (1 (mark-sexp 1))))

  ;; (global-set-key (kbd "C-M-SPC") 'mc/mark-all-dwim-or-mark-sexp)

  (global-set-key (kbd "C-M-c") 'mc/edit-lines)
  (global-set-key (kbd "C-M-m") 'mc/mark-all-in-region)

  ;; (require 'smartrep)
  ;; (declare-function smartrep-define-key "smartrep")
  ;; (global-unset-key "\C-t")

  ;; (smartrep-define-key global-map "C-t"
  ;; 	'(("C-t"  . 'mc/mark-next-like-this)
  ;; 	  ("n"    . 'mc/mark-next-like-this)
  ;; 	  ("p"    . 'mc/mark-previous-like-this)
  ;; 	  ("m"    . 'mc/mark-more-like-this-extended)
  ;; 	  ("N"    . 'mc/unmark-next-like-this)
  ;; 	  ("P"    . 'mc/unmark-previous-like-this)
  ;; 	  ("s"    . 'mc/skip-to-next-like-this)
  ;; 	  ("S"    . 'mc/skip-to-previous-like-this)
  ;; 	  ("*"    . 'mc/mark-all-like-this)
  ;; 	  ("d"    . 'mc/mark-all-like-this-dwim)
  ;; 	  ("i"    . 'mc/insert-numbers)
  ;; 	  ("o"    . 'mc/sort-regions)
  ;; 	  ("O"    . 'mc/reverse-regions)
  ;; 	  ))
  ;; )
  )


;;=========================================================
;; Migemo
;;=========================================================
(use-package migemo
  :if (executable-find "cmigemo")

  ;; 遅延ロード(autoload)
  :commands (migemo-init)

  :init ;; パッケージ読み込み前に実行
  (add-hook 'emacs-startup-hook 'migemo-init)

  :config ;; パッケージ読み込み後に実行
  (setq migemo-command "cmigemo")
  ;; Migemoのコマンドラインオプション
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  ;; Migemo辞書の場所
  (setq migemo-dictionary my-migemo-dic)

  ;; cmigemoで必須の設定
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)

  ;; キャッシュの設定
  (setq migemo-use-pattern-alist t) ;※この行を有効にすると何故か動かない
  (setq migemo-use-frequent-pattern-alist t)
  (setq migemo-pattern-alist-length 1024)

  (setq migemo-coding-system 'utf-8)

  ;; 小菊(find-fileでの日本語名補完)
  ;; (require 'kogiku)
  ;; (kogiku-mode-change)				; デフォルトON

  ;; anything
  ;; (when (featurep 'anything)
  ;; 	(require 'anything-migemo nil t))

  ;; moccur
  ;; (setq moccur-use-migemo t)

  ;; ;; buffer-file-coding-system から言語判別
  ;; ;; unicode も入れた方がいいのかも。
  ;; (defun my-language-check (lang)
  ;;   (let ((coding
  ;; 		 (coding-system-base buffer-file-coding-system)))
  ;; 	(memq
  ;; 	 coding
  ;; 	 (cdr (assoc 'coding-system
  ;; 				 (assoc lang language-info-alist))))))

  ;; ;; 日本語じゃないときは migemo を使わない
  ;; (eval-after-load "migemo"
  ;;   '(progn
  ;; 	 (defadvice isearch-mode
  ;; 	   (before my-migemo-off activate)
  ;; 	   (unless (my-language-check "Japanese")
  ;; 		 (make-local-variable 'migemo-isearch-enable-p)
  ;; 		 (setq migemo-isearch-enable-p nil)))
  ;; 	 (add-hook 'isearch-mode-end-hook
  ;; 			   (lambda ()
  ;; 				 (unless (my-language-check "Japanese")
  ;; 				   (setq migemo-isearch-enable-p t))))))

  (defun migemo-on ()
	(interactive)
	(setq migemo-isearch-enable-p t))

  (defun migemo-off ()
	(interactive)
	(setq migemo-isearch-enable-p nil))

  ;; 終了時に"migemo"を自動終了
  (defadvice save-buffers-kill-emacs (before my-kill-migemo activate)
	(let ((p (get-process "migemo")))
	  (when p
		(set-process-query-on-exit-flag p nil))))
  )

;;=========================================================
;; スクラッチバッファ保存
;;=========================================================
(use-package persistent-scratch
  :defer nil
  :config ;; パッケージ読み込み後に実行
  (persistent-scratch-setup-default))

;;=========================================================
;; ミニマップ
;;=========================================================
;; (use-package minimap
;;   :commands
;;   (minimap-bufname minimap-create minimap-kill)
;;   :custom
;;   (minimap-major-modes '(prog-mode))

;;   (minimap-window-location 'right)
;;   (minimap-update-delay 0.2)
;;   (minimap-minimum-width 20)
;;   :bind
;;   ;; ("M-t m" . ladicle/toggle-minimap)
;;   :preface
;;   (defun ladicle/toggle-minimap ()
;;     "Toggle minimap for current buffer."
;;     (interactive)
;;     (if (null minimap-bufname)
;;         (minimap-create)
;;       (minimap-kill)))
;;   :config
;;   (custom-set-faces
;;    '(minimap-active-region-background
;;      ((((background dark)) (:background "#555555555555"))
;;       (t (:background "#C847D8FEFFFF"))) :group 'minimap)))

;;=========================================================
;; 変更範囲と操作を可視化
;;=========================================================
(use-package git-gutter
    :custom
    (git-gutter:modified-sign "~")
    (git-gutter:added-sign    "+")
    (git-gutter:deleted-sign  "-")
    :custom-face
    (git-gutter:modified ((t (:background "#f1fa8c"))))
    (git-gutter:added    ((t (:background "#50fa7b"))))
    (git-gutter:deleted  ((t (:background "#ff79c6"))))
    :config
    (global-git-gutter-mode +1))

;;=========================================================
;; ディレクトリツリー
;;=========================================================
;; (use-package neotree
;;   :after
;;   projectile
;;   :commands
;;   (neotree-show neotree-hide neotree-dir neotree-find)
;;   :custom
;;   (neo-theme 'nerd2)
;;   :bind
;;   ("<f9>" . neotree-projectile-toggle)
;;   :preface
;;   (defun neotree-projectile-toggle ()
;;     (interactive)p
;;     (let ((project-dir
;;            (ignore-errors
;; ;;; Pick one: projectile or find-file-in-project
;;              (projectile-project-root)
;;              ))
;;           (file-name (buffer-file-name))
;;           (neo-smart-open t))
;;       (if (and (fboundp 'neo-global--window-exists-p)
;;                (neo-global--window-exists-p))
;;           (neotree-hide)
;;         (progn
;;           (neotree-show)
;;           (if project-dir
;;               (neotree-dir project-dir))
;;           (if file-name
;;               (neotree-find file-name)))))))

;;=========================================================
;; smartparens
;;=========================================================
(use-package smartparens
  :ensure t
  :delight
  :hook
  (after-init-hook . smartparens-global-strict-mode)
  :custom
  (electric-pair-mode nil)
  :config
  (require 'smartparens-config))

;;=========================================================
;; mwim
;; コードの先頭・末尾への移動と行頭・行末への移動を行う
;;=========================================================
;; (use-package mwim
;;   :ensure t
;;   :bind (("C-a" . mwim-beginning-of-code-or-line)
;;          ("C-e" . mwim-end-of-code-or-line))
;;   )
