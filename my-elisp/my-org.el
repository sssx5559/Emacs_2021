;;;; -*- coding: utf-8 -*-

;;-----------------------------------------------------------------------------
;; org-mode 設定ファイル
;;-----------------------------------------------------------------------------

;; ディレクトリ/ファイルの場所
(setq org-directory my-org-dir)
(setq org-default-notes-file (concat org-directory my-default-note))
(setq my-task-file (concat org-directory "gtd.org"))
(setq my-trade-journal-file (concat org-directory "trade_journal.org"))
(setq my-pere-file (concat org-directory "pere.org"))
(setq my-kaze-note-file (concat org-directory "kaze_note.org"))

;;=========================================================
;; Org-capture
;;=========================================================
(global-set-key (kbd "C-c C-o") 'org-capture)

;; Org-captureのテンプレート（メニュー）の設定
;; (setq org-capture-templates
;;       '(("n" "Note" entry (file+headline org-default-notes-file "Notes")
;;          "* %?\nEntered on %U\n %i\n %a")
;;         ))

(setq org-capture-templates
	    ;; ノート
	    '(("n" "Note" entry (file+headline org-default-notes-file "Notes")
         "* %?\nEntered on %U\n %i\n %a")

		    ;; タスク
		    ("t" "Todo" entry (file+headline my-task-file)
		     "* TODO %?
       %i
       %a")

		    ;; トレード日誌
		    ("j" "Trade Journal" entry (file+datetree my-trade-journal-file)
		     "* %?
     Entered on %U
       %i
       %a")

		    ;; ペレ
		    ("p" "Pere" entry (file+datetree my-pere-file)
		     "* %?\nEntered on %U\n %i\n %a")

		    ;; 風ノート
		    ("k" "Kaza note" entry (file+datetree my-kaze-note-file)
		     "* %?\nEntered on %U\n %i\n %a")
		    )
	    )
