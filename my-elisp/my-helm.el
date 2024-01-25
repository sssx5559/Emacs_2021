;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; Helm設定ファイル
;;-----------------------------------------------------------------------------
(use-package helm
  :defer t

  :bind
  ;; グローバルキー設定
  (("C-;" . helm-mini)
   ("M-x" . helm-M-x)
   ("C-c b" . helm-descbinds)
   ("C-c o" . helm-recentf)
   ("C-c I" . 'helm-imenu)
   ("C-c i" . helm-imenu-in-all-buffers)
   ("M-y" . helm-show-kill-ring)
   ("C-M-;" . helm-resume))

  :config ;; パッケージ読み込み後に実行
  ;; helm-mapキー設定
  (bind-keys :map helm-map
			 ("C-M-n" . helm-next-source)
			 ("C-M-p" . helm-previous-source)
			 ("C-h" . delete-backward-char)
			 ("C-<up>" . helm-scroll-other-window-down)
			 ("C-<down>" . helm-scroll-other-window)
			 ("M-*" . helm-keyboard-quit))
  )

(use-package helm-swoop
  :defer t

  :bind	;; グローバルキー設定
  (("C-]" . helm-swoop))
  )

(use-package helm-descbinds
  :defer t
  )


;;=========================================================
;; helm-ag
;;=========================================================
;; The Silver Searcher
(when (executable-find "ag")
  (use-package helm-ag
		:defer t
		:bind
		(("C-c a" . helm-ag))

		:custom
;		(helm-ag-command-option "-ai")			; 大文字小文字無視 & 隠しファイルも検索
    (helm-ag-command-option "-i")			; 大文字小文字無視
		))


;;=========================================================
;; helm-rg
;;=========================================================
;; (when (executable-find "rg")
;;   (use-package rg)
;;   (use-package helm-rg))


;;=========================================================
;; helm-gtags
;;=========================================================
(use-package helm-gtags
  :defer t

  :commands (helm-gtags-mode)

  :config ;; パッケージ読み込み後に実行
  (add-hook 'c-mode-hook 'helm-gtags-mode)
  (add-hook 'c++-mode-hook 'helm-gtags-mode)

  (local-set-key (kbd "M-.") 'helm-gtags-find-tag)
  (local-set-key (kbd "C-c r") 'helm-gtags-find-rtag)
  (local-set-key (kbd "C-c p") 'helm-gtags-find-pattern)
  (local-set-key (kbd "C-c s") 'helm-gtags-find-symbol)
  (local-set-key (kbd "M-*") 'helm-gtags-pop-stack)
  ;; (local-set-key (kbd "C-c C-r") 'helm-gtags-resume)
  (local-set-key (kbd "C-c t") 'miya-remake-gtags)

  ;; タグから検索を行う際, 大文字小文字を無視する
  ;(setq helm-gtags-ignore-case t)

  ;; ジャンプ直後に、行がずれてチカチカする場合があるので禁止
  (setq helm-gtags-pulse-at-cursor nil)
  )

;;=========================================================
;; helm-project
;;=========================================================
;; (use-package helm-project
;;   :config ;; パッケージ読み込み後に実行
;;   ;; ディレクトリを除外する
;;   (setq hp:project-files-filters
;; 		(list
;; 		 (lambda (files)
;; 		   (remove-if 'file-directory-p files))))

;;   (add-hook 'helm-gtags-mode-hook
;; 			(lambda ()
;; 			  (hp:add-project
;; 			   :name 'global
;; 			   :look-for '("GTAGS")
;; 			   ;;				 :include-regexp '("\\.c$" "\\.h$" "\\.s$")
;; 			   ;; 				 :exclude-regexp "/out" ; can be regexp or list of regexp
;; 			   :exclude-regexp '("/out" "~$") ; can be regexp or list of regexp
;; 			   ))))

;;=========================================================
;; helm関連のキー設定
;;=========================================================
;;(global-set-key (kbd "C-c y") 'helm-show-kill-ring)
;;(global-set-key (kbd "C-x r l") 'helm-bookmarks)
;;(global-set-key (kbd "C-M-g") 'helm-ghq)
;;(global-set-key (kbd "M-d") 'helm-for-document)

;; projectile関連
;(global-set-key (kbd "C-:") 'helm-projectile-find-file)
;(global-set-key (kbd "C-:") 'helm-project)

;; TABキー割り当て
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;;(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
