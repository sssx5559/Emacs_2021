;;;; -*- coding: utf-8 -*-

;;=========================================================
;; corfu 入力補完パッケージ
;;=========================================================
(use-package corfu
  :ensure t
  :custom ((corfu-auto t)
           (corfu-auto-prefix 3)	;
           (corfu-auto-delay 0.2)
	   (corfu-quit-at-boundary nil)	; orderlessと合わせて順序のない検索を使用(単語の境界を無効)
	   ;; (corfu-quit-no-match 'separator)
	   ;; (corfu-scroll-margin 2)	; 候補スクロール開始位置が、候補ウィンドウの下から何行目か
           (corfu-cycle t))

  :bind (nil
         :map corfu-map
	 ;; ("SPC" . corfu-insert-separator)
         ;; ("M-i" . corfu-insert)
	 ("TAB" . corfu-insert)
         ("RET" . nil)
         ("<return>" . nil))

  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

;; 順序のない検索を使用
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(partial-completion orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion))))
  )

;; completion-at-pointを自分好みにカスタマイズ
(use-package cape
  :ensure t
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-history)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'tempel-complete)
  ;; (add-to-list 'completion-at-point-functions #'cape-tex)
  ;; (add-to-list 'completion-at-point-functions #'cape-sgml)
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-ispell)
  ;; (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  ;; (add-to-list 'completion-at-point-functions #'cape-line)
)

;; (use-package cape
;;   :init
;;   (defun my/set-super-capf (&optional arg)
;;     (setq-local completion-at-point-functions
;;                 (list (cape-capf-noninterruptible
;;                        (cape-capf-buster
;;                         (cape-capf-properties
;;                          (cape-capf-super
;;                           (if arg
;;                               arg
;;                             (car completion-at-point-functions))
;;                           #'tempel-complete
;;                           ;; #'tabnine-completion-at-point
;;                           #'cape-dabbrev
;;                           #'cape-file)
;;                          :sort t
;;                          :exclusive 'no))))))

;;   :hook (((prog-mode
;;            text-mode
;;            conf-mode
;;            eglot-managed-mode
;;            lsp-completion-mode) . my/set-super-capf))
;;   :config
;;   (setq cape-dabbrev-check-other-buffers nil)

;;   ;; 複数のcompletion-at-pointが格納でき、格納された順番に評価される
;;   (add-to-list 'completion-at-point-functions #'tempel-complete)
;;   ;; (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
;;   (add-to-list 'completion-at-point-functions #'cape-file t)
;;   (add-to-list 'completion-at-point-functions #'cape-tex t)
;;   (add-to-list 'completion-at-point-functions #'cape-dabbrev t)
;;   (add-to-list 'completion-at-point-functions #'cape-keyword t))


;;=========================================================
;; tempel
;; Simple templates for Emacs
;;=========================================================
(use-package tempel
  :ensure t

  :custom
  (tempel-path "/Users/miyazaki/.emacs.d/my-elisp/templates")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert)
	 ;; ("M-{" . tempel-previous)
	 ;; ("M-}" . tempel-next)
	 )
  :init
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-complete
                      completion-at-point-functions)))
  :hook
  (prog-mode . tempel-setup-capf)
  (text-mode . tempel-setup-capf)
  (org-mode . tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
  ;; (global-tempel-abbrev-mode)
  )


;;=========================================================
;; corfuにアイコンをつける
;;=========================================================
(use-package kind-icon
  :ensure t
  :after corfu
  :custom (kind-icon-default-face 'corfu-default) ; to compute blended backgrounds correctly
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; (use-package nerd-icons :ensure t)
;; ;; (use-package all-the-icons :ensure t)

;; ;; ;; dired で nerd icon を表示
;; (use-package nerd-icons-dired
;;   :ensure t
;;   :hook (dired-mode-hook . nerd-icons-dired-mode))

;; ;; completion で nerd icon を表示
;; (use-package nerd-icons-completion
;;   :ensure t
;;   :after marginalia
;;   :config
;;   (nerd-icons-completion-mode)
;;   :hook (marginalia-mode-hook . #'nerd-icons-completion-marginalia-setup))

;; ;; corfu で nerd icon を表示
;; (use-package nerd-icons-corfu
;;   :ensure t
;;   :after corfu
;;   :config
;;   (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


;;=========================================================
;; vertico: ミニバッファ用ファジーファインダーUI
;; consult: コマンドの提供、候補リストの作成
;; marginalia.el: 付加情報の表示
;; orderless.el: マッチ方法を変更し、スペース区切りで入力をマッチさせる
;; embark.el: アクションを実行する
;;=========================================================
;; (use-package vertico
;;   :custom ((vertico-mode 1)
;; 	   ;; (vertico-cycle t)
;;            (vertico-count 10))
;;   )

;; (use-package extensions/vertico-directory
;;   :straight (:type built-in)
;;   :after vertico
;;   :ensure nil
;;   :bind (:map vertico-map
;;               ("C-l" . vertico-directory-up)
;;               ("\d" . vertico-directory-delete-char)))

;; (use-package consult
;;   :bind
;;   (
;;    ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
;;    ("M-g g" . consult-goto-line)             ;; orig. goto-line
;;    ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
;;    )
;;   :hook (completion-list-mode . consult-preview-at-point-mode)
;;   :config
;;   (setq consult-project-root-function #'projectile-project-root)
;;   )

;; (use-package orderless
;;   :ensure t
;;   :custom (completion-styles '(orderless)))

;; (use-package marginalia
;;   :init
;;   (marginalia-mode))


;;=========================================================
;; counsel
;;=========================================================
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
(use-package yasnippet
  :init ;; パッケージ読み込み前に実行
  (custom-set-variables
   ;; '(yas-snippet-dirs
   ;; 	 (list (const user-emacs-directory "snippets")				  	;; 自作用(省略可能)
   ;; 		   (const user-emacs-directory "elisp/yasnippet/snippets")	;; 最初から入っていたスニペット(省略可能)
   ;; 		   ))
   )

  (yas-global-mode 1)

  ;; 既存スニペットを挿入する
  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  ;; 新規スニペットを作成するバッファを用意する
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  ;; 既存スニペットを閲覧・編集する
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)

  ;; (when (require 'helm nil t)
  ;; 	(el-get-bundle helm-c-yasnippet
  ;; 	  (custom-set-variables
  ;; 	   '(helm-yas-space-match-any-greedy t)
  ;; 	   )
  ;; 	  (global-set-key (kbd "C-c y") 'helm-yas-complete)))

  ;; (eval-after-load "yasnippet"
  ;; '(progn
  ;;    ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
  ;;    (define-key yas-keymap (kbd "<tab>") nil)
  ;;    (yas-global-mode 1))))

  :config ;; パッケージ読み込み後に実行
  )

;;=========================================================
;; git-complete.el
;;=========================================================
(use-package git-complete
  :straight (:host github :repo "zk-phi/git-complete" :branch "master")
  :bind	;; グローバルキー設定
  (("s-i" . git-complete))
  )

;;=========================================================
;; Copilot
;;=========================================================
;; ※明示的に"M-x copilot-mode"としないと使用できない
;; (use-package copilot
;;   :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
;;   :ensure t
;;   :custom
;;   (copilot-indent-offset-warning-disable t)

;;   ;; :hook
;;   ;; (prog-mode . copilot-mode)

;;   :bind
;;   ("M-i" . copilot-accept-completion)
;;   ("M-[" . copilot-next-completion)
;;   ("M-]" . copilot-previous-completion)

;;   :config ;; パッケージ読み込み後に実行
;;   ;; (copilot-mode t)
;;   )

