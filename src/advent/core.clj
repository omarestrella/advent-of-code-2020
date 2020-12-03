(ns advent.core
  (:require [advent.days.day-1]
            [advent.days.day-2]
            [advent.days.day-3])
  (:gen-class))

(defn -main [& args]
  (let [day (do (print "Which day are you running? ")
                (flush)
                (read-line))
        [part-1 part-2] (case day
                          "1" (advent.days.day-1/run)
                          "2" (advent.days.day-2/run)
                          "3" (advent.days.day-3/run)
                          (throw (AssertionError. "Bad day")))]
    (println "Part 1:" part-1)
    (println "Part 2:" part-2)))

