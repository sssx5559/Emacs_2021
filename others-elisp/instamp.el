;; -*- Emacs-Lisp -*-
;; instamp.el - Insert TimeStamp on the point
;; $Id: instamp.el,v 1.9 2005/08/16 01:12:13 yuuji Exp $
;; Last modified Tue Aug 16 10:09:38 2005 on firestorm
;; Update count: 56

;; This file contains Japanese characters.

;;[What's this]
;;
;;	Insert time string at the point.
;;	$B%]%$%s%H0LCV$K;~9o$rA^F~$9$k!#(B
;;
;;[How to use]
;;
;;	M-x instamp   (or certain key stroke you defined in .emacs)
;;
;;	If you don't like that time format, you can switch format by
;;	typing C-p/C-n immediately after M-x instamp.
;;
;;[$B;H$$J}(B]
;;	M-x instamp   ($B$=$l$+(B .emacs $B$GDj5A$7$?%-!<(B)
;;	$BD>8e$J$i=q<0$O(B C-p/C-n $B$G<+M3$KJQ$($i$l$k!#(B
;;
;;
;;[How to install]
;;
;;	Put the next expressions in your ~/.emacs
;;
;;	(autoload 'instamp "instamp" "Insert TimeStamp on the point" t)
;;	(define-key global-map "\C-cs" 'instamp)
;;	;; "\C-cs" is an example. Choose your favorable key sequence)
;;
;;	$B>e$N(BEmacs-Lisp$B$r(B ~/.emacs $B$KF~$l$h$&!#(B"\C-cs" $B$NItJ,$OC1$J$kNc$G!"(B
;;	$B9%$-$J%-!<$KJQ$($^$7$g!<!#(B
;;
;;[Customization]
;;
;;	You can define the format list of inserted time string by
;;	setting the variable instamp-date-format-list-private.  If you
;;	want to get the time formats "Jan/24/2004" and "01/24/2004", for
;;	example, set like this;
;;
;;	(setq instamp-date-format-list-private
;;	     '("%b/%d/%Y" "%m/%d/%Y"))
;;
;;	$B",$_$?$$$KDj5A$7$F$*$/$H!"(B"Jan/24/2004" $B$H$+(B "01/24/2004" $B$_$?$$(B
;;	$B$J=q<0$G$NJ8;zNs$,A^F~8uJd$H$7$FDI2C$5$l$k!#(B
;;
;;[Other function]
;;
;;	M-x instamp-reset-date-format-list resets the order of format list
;;

(defvar instamp-date-command "date"
  "*date command name(for emacs19 or former.")
(defvar instamp-date-format-list-default
  '("%Y/%m/%d" "%Y/%m/%d(%a)"
    "%Y/%m/%d %H:%M:%S" "%Y/%m/%d(%a) %H:%M:%S"
    "%Y-%m-%d" "%Y-%m-%d(%a)"
    "%Y-%m-%d %H:%M:%S" "%Y-%m-%d(%a) %H:%M:%S"
    "%y/%m/%d" "%y/%m/%d(%a)"
    "%y-%m-%d" "%y-%m-%d(%a)"
    "%m/%d" "%m/%d(%a)"
    "%m-%d" "%m-%d(%a)"
    "%m$B7n(B%d$BF|(B(%j)%H$B;~(B%M$BJ,(B" "%m$B7n(B%d$BF|(B(%j)%H$B;~(B%M$BJ,(B%S$BIC(B"
    "%m$B7n(B%d$BF|(B(%j)" "%Y$BG/(B%m$B7n(B%d$BF|(B(%j)"
    "%m/%d(%j)" "%Y/%m/%d(%j)")
  "Default Format passed to strftime.
%j $B$OF|K\8l$NMKF|L>$KJQ$($i$l$k!#(B")
(defvar instamp-date-format-list-private nil
  "*List of time format string.
See the manpage of strftime(3).
Good example is defined in instamp-date-format-list.")

(defvar instamp-date-format-list nil
  "*List of time format string.
See the documentation of instamp-date-format-list.")

(defvar instamp-remove-preceding-zero t
  "*Non-nil removes preceding zeros")

(defun instamp-reset-date-format-list ()
  "Reset date-format list."
  (interactive)
  (setq instamp-date-format-list
	(append instamp-date-format-list-private
		instamp-date-format-list-default)))
(instamp-reset-date-format-list)

(defun instamp-format-time-string (format)
  (if (string< "19" emacs-version)
      (format-time-string format (current-time))
    (let ((tmpbuf (get-buffer-create " *instamp tmp*"))
	  (cb (current-buffer))
	  (-c (cond
	       ((boundp 'shell-command-option) shell-command-option)
	       ((boundp 'shell-command-switch) shell-command-switch)
	       (t "-c"))))
      (unwind-protect
	  (save-excursion
	    (set-buffer tmpbuf)
	    (erase-buffer)
	    (call-process shell-file-name
			  nil t nil
			  -c
			  (format "%s \"+%s\"" instamp-date-command format))
	    (buffer-string))
	(set-buffer cb)
	(kill-buffer tmpbuf)))))

(defun instamp-japanese-wday (str)
  "Translate %j to Japanese weekday name."
  (let ((new str)
	(wday (instamp-format-time-string "%w"))
	(wtable '("$BF|(B" "$B7n(B" "$B2P(B" "$B?e(B" "$BLZ(B" "$B6b(B" "$BEZ(B"))
	p)
    (or (string-match "[0-9]" wday)
	(error "Your system does not have date command."))
    (setq wday (string-to-int wday))
    (while (setq p (string-match "%j" new))
      (setq new (concat (substring new 0 p)
			(nth wday wtable)
			(substring new (+ 2 p)))))
    new))

(defun instamp-remove-zeroprefix (string)
  (let ((ptn "\\(^\\|[^0-9]\\)\\<0\\([0-9]+\\)")
	(new string) p)
    (if (fboundp 'replace-regexp-in-string)
	(replace-regexp-in-string ptn "\\1\\2" string)
      (while (setq p (string-match ptn new))
	(setq new (concat (substring new 0 (1+ p))
			  (substring new (match-beginning 1)))))
      new)))

(defun instamp (n)
  "Insert TimeStamp on the point.
Define your favorite time format(list) in instamp-date-format-list."
  (interactive "P")
  (let*((len (length instamp-date-format-list))
	(up (car (where-is-internal 'previous-line)))
	(upkey (key-description up))
	(dn (car (where-is-internal 'next-line)))
	(dnkey (key-description dn))
	(p (point)) (mf (buffer-modified-p)) date
	(n (or n 0)) key r fmt
	(msg (format "Continue=SPC up=[%s] down=[%s] quit=q z=zero"
		     upkey dnkey)))
    (if (catch 'done
	  (while t
	    (setq n (% (+ len n) len)
		  fmt (nth n instamp-date-format-list))
	    (if (string-match "%j" fmt)
		(setq fmt (instamp-japanese-wday fmt)))
	    (setq date (instamp-format-time-string fmt))
	    (if instamp-remove-preceding-zero
		(setq date (instamp-remove-zeroprefix date)))
	    (delete-region (point) p)
	    (insert date)
	    (setq key (char-to-string (read-char msg)))
	    (cond
	     ((or (eq (key-binding key) 'previous-line)
		  (string-match "\C-e\\|C-p" key))
	      (setq n (1- n))
	      (delete-region (point) p))
	     ((or (eq (key-binding key) 'next-line)
		  (string-match "\C-x\\|C-n" key))
	      (setq n (1+ n)))
	     ((equal key " ")
	      (throw 'done t))
	     ((equal key "q")
	      (delete-region (point) p)
	      (set-buffer-modified-p mf)
	      (throw 'done nil))
	     ((equal key "z")
	      (setq instamp-remove-preceding-zero
		    (not instamp-remove-preceding-zero)))
	     (t (setq unread-command-char (aref key 0))
		(throw 'done t)))))
	;; date string is inserted, put selected result at the head.
	(setq instamp-date-format-list
	      (cons fmt (delq fmt instamp-date-format-list))))
    (message "")))


; Local variables:
; fill-prefix: ";;	"
; paragraph-start: "^$\\|\\|;;$"
; paragraph-separate: "^$\\|\\|;;$"
; buffer-file-coding-system: junet
; coding: junet
; End:
