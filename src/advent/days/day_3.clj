(ns advent.days.day-3
  (:require [advent.util :as util]
            [clojure.string :as str]))

(def test-input
  "..##.........##.........##.........##.........##.........##.......\n#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..\n.#....#..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.\n..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#\n.#...##..#..#...##..#..#...##..#..#...##..#..#...##..#..#...##..#.\n..#.##.......#.##.......#.##.......#.##.......#.##.......#.##.....\n.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#\n.#........#.#........#.#........#.#........#.#........#.#........#\n#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...#.##...#...\n#...##....##...##....##...##....##...##....##...##....##...##....#\n.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#.#..#...#.#")

(defn how-many-trees? [tree-lines right down]
  (loop [tree-lines tree-lines
         position right
         tree-count 0]
    (if (or (empty? tree-lines) (>= down (count tree-lines)))
      tree-count
      (let [tree-line (str/split (nth tree-lines down) #"")
            rest-tree-line (drop down tree-lines)
            new-position (mod (+ position right) (count tree-line))
            new-count (if (= (get tree-line position) "#")
                        (inc tree-count)
                        tree-count)]
        (recur rest-tree-line new-position new-count)))))


(defn part-1 [all-tree-lines]
  (how-many-trees? all-tree-lines 3 1))

(defn part-2 [all-tree-lines]
  (*
    (how-many-trees? all-tree-lines 1 1)
    (how-many-trees? all-tree-lines 3 1)
    (how-many-trees? all-tree-lines 5 1)
    (how-many-trees? all-tree-lines 7 1)
    (how-many-trees? all-tree-lines 1 2)))

(defn run []
  (let [input (util/get-input 2020 3)
        lines (str/split-lines input)]
    [(part-1 lines) (part-2 lines)]))