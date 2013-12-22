(defconst gpl-text
  '("This program is free software; you can redistribute it and/or modify"
    "it under the terms of the GNU General Public License as published by"
    "the Free Software Foundation; either version 2 of the License, or (at"
    "your option) any later version."
    " "
    "This program is distributed in the hope that it will be useful, but"
    "WITHOUT ANY WARRANTY; without even the implied warranty of"
    "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU"
    "General Public License for more details."
    " "
    "You should have received a copy of the GNU General Public License"
    "along with this program; if not, write to the Free Software"
    "Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,"
    "USA."))

(defconst wtfpl-text
  '("This program is free software. It comes without any warranty, to"
    "the extent permitted by applicable law. You can redistribute it"
    "and/or modify it under the terms of the Do What The Fuck You Want"
    "To Public License, Version 2, as published by Sam Hocevar. See"
    "http://sam.zoy.org/wtfpl/COPYING for more details."))

(defun copyright-line ()
  (concat "Copyright (C) "
          (format-time-string "%Y" (current-time)) 
          " " user-full-name " <" user-mail-address ">"))

(defun header-label (&optional prefix)
  (let* ((fn (buffer-name))
	 (hl (upcase (concat prefix fn))))
    (mapconcat 'char-to-string
	       (mapcar (lambda (x)
			 (if (and (>= x ?A)
				  (<= x ?Z))
			     x ?\_))
		       hl) "")))

(defun center-fill-line (str &optional fill_character surrounding_spaces)
  (let* ((spc (if (null surrounding_spaces) 1 surrounding_spaces))
	 (strlen (+ (length str) spc))
	 (chr (if (null fill_character) ?\= fill_character)))
    (if (< strlen fill-column)
	(let ((seplen (/ (- fill-column strlen) 2))
	      (surspc (make-string spc ?\s)))
	  (insert-char chr seplen)
	  (insert (format "%s%s%s" surspc str surspc))
	  (insert-char chr (if (or (zerop strlen)
				   (not (zerop (mod strlen 2))))
			       seplen (- seplen 1)))
	  (newline))
      str)))

(defun adh-if ()
  (interactive)
  (let ((teks (read-string "#if"))
	(beg (or (and mark-active
		      (region-beginning))
		 nil))
	(end (or (and mark-active
		      (region-end))
		 nil)))	     
    (save-excursion
      (if end (goto-char end)
	(insert ?\n))
      (insert "#endif /* " teks " */\n"))
    (when beg (goto-char beg))
    (insert "#if" teks ?\n)))

(defun adh-def ()
  (interactive)
  (let ((teks (read-string "#define "))
	(beg (or (and mark-active
		      (region-beginning))
		 nil))
	(end (or (and mark-active
		      (region-end))
		 nil)))	     
    (save-excursion
      (if end (goto-char end)
	(insert ?\n))
      (insert "#undef " teks "\n"))
    (when beg (goto-char beg))
    (insert "#define " teks ?\n)))

(defun adh-header-protect ()
  "Memberi makro pembatas pada header program C/C++"
  (interactive)
  (let* ((prf-pembatas (read-string "Prefiks makro: "))
	 (pembatas (header-label prf-pembatas))
	 (awal (or (and mark-active
			(region-beginning))
		   (point-min)))
	 (akhir (or (and mark-active
			 (region-end))
		    (point-max))))
    (save-excursion
      (goto-char akhir)
      (insert "\n"
	      (if (bolp) "" "\n")
	      "#endif /* " pembatas " */\n")
      (goto-char awal)
      (insert "#ifndef " pembatas "\n"
	      "#define " pembatas "\n"
	      "\n"))))

(defun adh-center-fill-line (arg)
  (interactive "*P")
  (let* ((str (read-string "Teks baris: "))
	 (filler (or (and (zerop (length str)) ?\=)
		     (string-to-char str)))
	 (str (or (and (> (length str) 1)
		       (substring str 1))
		  ""))
	 (strlst (split-string str "\n")))
    (when (and (boundp 'block-comment-start)
	       block-comment-start)
      (insert block-comment-start)(newline))

    (if arg (dotimes (i arg) (center-fill-line "" filler 0)))
    (mapc (lambda (str) (center-fill-line str filler)) strlst)
    (if arg (dotimes (i arg) (center-fill-line "" filler 0)))

    (when (and (boundp 'block-comment-end)
	       block-comment-end)
      (newline)(insert block-comment-end))))
    
(defun adh-emacs-epilogue ()
  (interactive)
  (let* ((mode-fun (read-command "Modus mayor: " ""))
	 (mode-nam (substring (format "%s" mode-fun) 0 -5))
	 (akhir (or (and mark-active
			 (region-end))
		    (point-max))))
    (funcall mode-fun)
    (save-excursion
      (goto-char akhir)
      (insert "-\n"
	      "Local Variables:\n"
	      (format "mode: %s\n" mode-nam)
	      "End:\n"
	      "-\n")
      (comment-region akhir (point)))))

(defun adh-gpl-code-header ()
  (interactive)
  (let ((judul (read-string "Teks pembatas: " ""))
	(toleransi 3))
    (save-excursion
      (goto-char 0)
      (let ((awal-wilayah (point)))
	(insert "$Id: $\n\n")
	(unless (= (length judul) 0)
	  (insert judul ?\n))
	(insert (copyright-line))
	(insert "\n\n")
	(mapc (lambda (x)
		(insert x ?\n)) gpl-text)
	(insert ?\n)
	(comment-region awal-wilayah (point))))
    ))

;; What a hideously bad name...
(defun adh-deregexify-buffer ()
 (interactive)
 (save-excursion
   (goto-char 0)
   (while (re-search-forward "\\([\\\\\\+*?]\\|\\[\\|\\]\\)" nil t)
     (replace-match "\\\\\\1"))))

(provide 'adh)
