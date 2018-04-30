(ns examplecom.etc.email
  (:require [riemann.email :refer :all]))

(def email (mailer {:host "smtp.gmail.com" 
	         :user "mohnish111@gmail.com" 
		     :pass "ilovebunnies" 
             :tls true 
             :port 465 
             :from "you@example.com"}))