;;;; -*- coding: utf-8 -*-

;;=========================================================
;; company
;;=========================================================
(use-package company
  :defer t

  :bind	;; グローバルキー設定
  (("M-i" . company-complete))

  :config ;; パッケージ読み込み後に実行
  (setq company-selection-wrap-around t)

  ;;------------------
  ;; 画面設定
  ;;------------------
  (set-face-attribute 'company-tooltip nil
					  :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
					  :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
					  :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
					  :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
					  :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
					  :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
					  :background "gray40")

  (bind-keys :map company-active-map
        ("M-n" . nil)
        ("M-p" . nil)

		;; 1つしか候補がなかったらtabで補完、複数候補があればtabで次の候補へ行くように
        ("M-i" . company-complete-common-or-cycle)

		;; C-n, C-pで補完候補を次/前の候補を選択
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)

		;; 絞り込み検索
		("C-s" . company-filter-candidates)

		;; 候補を設定
		("C-i" . company-complete-selection)
		("<tab>" . company-complete-selection)

		;; C-hのドキュメント表示を変更
        ("C-h" . nil)
		("M-h" . company-show-doc-buffer)
		("C-o" . company-show-doc-buffer))

  (bind-keys :map company-search-map
		("C-n" . company-select-next)
		("C-p" . company-select-previous)
		("C-h" . nil)
		("C-o" . company-show-doc-buffer)
		("C-o" . company-show-doc-buffer))

  ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
  ;; (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)

  ;; quick-help
  ;; (el-get-bundle pos-tip)
  ;; (el-get-bundle company-quickhelp
  ;; 	(company-quickhelp-mode +1)		;; 使うと重たくなる
  ;; 	)

  (global-company-mode))

;;=========================================================
;; company-jedi(Python入力補完)
;;=========================================================
;; (el-get-bundle jedi-core)
;; (el-get-bundle company-jedi
;; 	(require 'company-jedi)
;; 	(add-hook 'python-mode-hook 'jedi:setup)
;; 	(add-to-list 'company-backends 'company-jedi) ; backendに追加

;; 	(custom-set-variables
;; 	 '(jedi:complete-on-dot t)
;; 	 '(jedi:use-shortcuts t)
;; 	 )
;; 	)


;;=========================================================
;; ivy/counsel/swiper
;;=========================================================
;; (use-package swiper)
;; (use-package counsel)

;; (defun isearch-forward-or-swiper (use-swiper)
;;   (interactive "P")
;;   (let (current-prefix-arg)
;; 	(call-interactively (if use-swiper 'swiper 'isearch-forward))))

;; ;; キー設定
;; (global-set-key (kbd "C-s") 'isearch-forward-or-swiper)
;; ;;(global-set-key (kbd "C-M-s") 'swiper)
;; ;;(global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; ;;(global-set-key (kbd "C-c C-r") 'ivy-resume)

;; (define-key ivy-minibuffer-map (kbd "C-l") 'counsel-up-directory)
;; (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-delete-char)
;; (define-key swiper-map (kbd "C-r") 'ivy-previous-line-or-history)

(use-package counsel

  :bind	;; グローバルキー設定
  (("C-x C-f" . counsel-find-file))

  :config ;; パッケージ読み込み後に実行
  ;; (defun isearch-forward-or-swiper (use-swiper)
  ;; 	(interactive "P")
  ;; 	(let (current-prefix-arg)
  ;; 	  (call-interactively (if use-swiper 'swiper 'isearch-forward))))

  (define-key ivy-minibuffer-map (kbd "C-l") 'counsel-up-directory)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-delete-char)
  (define-key swiper-map (kbd "C-r") 'ivy-previous-line-or-history)
  )


;;=========================================================
;; yasnippet
;;=========================================================
;; (use-package yasnippet
;;   :init ;; パッケージ読み込み前に実行
;;   (custom-set-variables
;;    ;; '(yas-snippet-dirs
;;    ;; 	 (list (const user-emacs-directory "snippets")				  	;; 自作用(省略可能)
;;    ;; 		   (const user-emacs-directory "elisp/yasnippet/snippets")	;; 最初から入っていたスニペット(省略可能)
;;    ;; 		   ))
;;    )

;;   (yas-global-mode 1)

;;   ;; 既存スニペットを挿入する
;;   (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
;;   ;; 新規スニペットを作成するバッファを用意する
;;   (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
;;   ;; 既存スニペットを閲覧・編集する
;;   (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

;;   ;; (when (require 'helm nil t)
;;   ;; 	(el-get-bundle helm-c-yasnippet
;;   ;; 	  (custom-set-variables
;;   ;; 	   '(helm-yas-space-match-any-greedy t)
;;   ;; 	   )
;;   ;; 	  (global-set-key (kbd "C-c y") 'helm-yas-complete)))

;;   ;; (eval-after-load "yasnippet"
;;   ;; '(progn
;;   ;;    ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
;;   ;;    (define-key yas-keymap (kbd "<tab>") nil)
;;   ;;    (yas-global-mode 1))))

;;   :config ;; パッケージ読み込み後に実行
;;   )
