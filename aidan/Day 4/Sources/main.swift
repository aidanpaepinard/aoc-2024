import Foundation

struct Coord<T: Numeric & Comparable> {
    let x: T
    let y: T

    static func + (left: Self, right: Self) -> Self {
        return Self(x: left.x + right.x, y: left.y + right.y)
    }

    static func * (self: Self, scalar: T) -> Self {
        return Self(x: self.x * scalar, y: self.y * scalar)
    }
}

enum Direction: CaseIterable {
    case up, down, left, right, leftup, rightup, leftdown, rightdown

    var offset: Coord<Int> {
        switch self {
        case .up:
            return Coord(x: 0, y: -1)
        case .down:
            return Coord(x: 0, y: 1)
        case .left:
            return Coord(x: -1, y: 0)
        case .right:
            return Coord(x: 1, y: 0)
        case .leftup:
            return Coord(x: -1, y: -1)
        case .leftdown:
            return Coord(x: -1, y: 1)
        case .rightup:
            return Coord(x: 1, y: -1)
        case .rightdown:
            return Coord(x: 1, y: 1)
        }
    }

    func oppositeOffset() -> Coord<Int> {
        return offset * -1
    }
}

extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}

func loadData() throws -> [[Character]] {
    let file = "input.txt"
    var filePath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    filePath.appendPathComponent(file)
    let contents = try String(contentsOf: filePath, encoding: .utf8)
    return contents.split(whereSeparator: \.isNewline).map {
        Array($0)
    }
}

func withinRect(check value: Coord<Int>, isWithin limit: Coord<Int>) -> Bool {
    return value.x >= 0 && value.y >= 0 && value.x <= limit.x && value.y <= limit.y
}

func day1(_ lines: [[Character]]) -> Int {
    guard lines.count > 0 else {
        return -1
    }
    guard lines[0].count > 0 else {
        return -1
    }
    let limit = Coord(x: lines[0].count - 1, y: lines.count - 1)
    var count = 0
    let xmas = Array("XMAS")

    func checkDir(x: Int, y: Int, dir: Direction) -> Bool {
        for idx in 0..<xmas.count {
            let offset = Coord(x: x, y: y) + dir.offset * idx

            if !withinRect(check: offset, isWithin: limit)
                || xmas[idx] != lines[offset.y][offset.x]
            {
                return false
            }
        }
        return true
    }

    for y in 0...limit.y {
        for x in 0...limit.x {
            for dir in Direction.allCases {
                if checkDir(x: x, y: y, dir: dir) {
                    count += 1
                }
            }
        }
    }

    return count
}

func day2(_ lines: [[Character]]) -> Int {
    guard lines.count > 0 else {
        return -1
    }
    guard lines[0].count > 0 else {
        return -1
    }
    let limit = Coord(x: lines[0].count - 1, y: lines.count - 1)
    var count = 0
    let directions: [Direction] = [.leftup, .leftdown, .rightup, .rightdown]

    func checkForXMAS(x: Int, y: Int) -> Bool {
        guard lines[y][x] == "A" else {
            return false
        }
        let center = Coord(x: x, y: y)

        var count = 0
        for dir in directions {
            let possibleM = center + dir.offset

            if lines[possibleM.y][possibleM.x] != "M" {
                continue
            }

            let possibleS = center + dir.oppositeOffset()

            if lines[possibleS.y][possibleS.x] != "S" {
                continue
            }
            count += 1
        }

        return count == 2
    }

    // reduce by 1 on each side, as we are searching for A characters
    for y in 1..<limit.y {
        for x in 1..<limit.x {
            let res = checkForXMAS(x: x, y: y)
            if res {
                count += 1
            }
        }
    }

    return count
}

let contents = try loadData()
let day1Result = day1(contents)
let day2Result = day2(contents)
print("Solution 1: \(day1Result)\nSolution 2: \(day2Result)")
