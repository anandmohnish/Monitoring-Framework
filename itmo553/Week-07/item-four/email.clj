(ns examplecom.etc.email
(:require [riemann.email :refer :all]))
(def email (mailer {:host "smtp.gmail.com"
:user "manand1@hawk.iit.edu"
:pass "xxxx"
:tls true
:port 465
:from "you@example.com"}))
; URL to IIT student email https://ots.iit.edu/email/student-mail