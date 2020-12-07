(ns advent.util
  (:require [clojure.java.io :as io]
            [clj-http.client :as client]))

(def session-cookie ["session" {:value (slurp (io/resource "session"))}])

(defn get-input [year day]
  (->>
    (client/get
      (str "https://adventofcode.com/" year "/day/" day "/input")
      {:cookies [session-cookie]})
    (:body)))

(defn parse-int [str]
  (Integer/parseInt str))