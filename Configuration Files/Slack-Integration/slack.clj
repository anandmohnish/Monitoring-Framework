(ns examplecom.etc.slack
    (:require [riemann.slack :refer :all]))

(def credentials {:account "riemann-com", :token "D4uydoq0e6vKa2cVLwNKKZZX
"})

(defn slack-format
  "Format our Slack message"
  [event]
  (str "Service " (:service event) " on host " (:host event) " is in state " (:state event) ".\n"
   "See http://graphitea.example.com:3000/dashboard/script/riemann.js?host="(:host event) ))

(defn slacker
  "Send notifications to Slack"
  [& {:keys [recipient]
      :or {recipient "#monitoring"}}]
  (slack credentials {:username "Riemann bot"
                      :channel recipient
                      :formatter (fn [e] { :text (slack-format e) } )
                      :icon ":smile:"}))
