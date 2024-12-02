const std = @import("std");
const u32PriorityQueue = std.PriorityQueue(u32, void, lessThan);

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const Queues = struct {
    left: u32PriorityQueue,
    right: u32PriorityQueue,

    fn deinit(self: @This()) void {
        self.left.deinit();
        self.right.deinit();
    }
};

fn lessThan(context: void, left: u32, right: u32) std.math.Order {
    _ = context;
    return std.math.order(left, right);
}

fn readInput(allocator: std.mem.Allocator) ![]const u8 {
    const file = try std.fs.cwd().openFile("src/input.txt", .{});
    defer file.close();

    const file_contents = try file.readToEndAlloc(allocator, std.math.maxInt(usize));
    return file_contents;
}

fn parseQueues(allocator: std.mem.Allocator, data: []const u8) !Queues {
    var leftQueue = u32PriorityQueue.init(allocator, {});
    var rightQueue = u32PriorityQueue.init(allocator, {});
    var items = std.mem.splitScalar(u8, data, '\n');
    while (items.next()) |item| {
        var iter = std.mem.tokenizeAny(u8, item, " ");
        const first = iter.next() orelse continue;
        const second = iter.next() orelse continue;
        const first_num = std.fmt.parseInt(u32, first, 10) catch continue;
        const second_num = std.fmt.parseInt(u32, second, 10) catch continue;
        try leftQueue.add(first_num);
        try rightQueue.add(second_num);
    }
    return .{
        .left = leftQueue,
        .right = rightQueue,
    };
}

fn solveDistance(leftQueue: *u32PriorityQueue, rightQueue: *u32PriorityQueue) u32 {
    var distance: u32 = 0;
    while (true) {
        const left = leftQueue.removeOrNull() orelse break;
        const right = rightQueue.removeOrNull() orelse break;
        if (left > right) {
            distance += left - right;
        } else {
            distance += right - left;
        }
    }
    return distance;
}

fn solveSimilarity(allocator: std.mem.Allocator, leftQueue: *u32PriorityQueue, rightQueue: *u32PriorityQueue) u32 {
    var similarity: u32 = 0;
    var right_items = std.AutoHashMap(u32, u32).init(allocator);
    defer right_items.deinit();
    for (rightQueue.items) |item| {
        const entry = right_items.getOrPutValue(item, 0) catch continue;
        entry.value_ptr.* += 1;
    }
    while (leftQueue.removeOrNull()) |item| {
        const item_similarity = right_items.get(item) orelse continue;
        similarity += item * item_similarity;
    }
    return similarity;
}

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const allocator = gpa.allocator();
    defer {
        _ = gpa.deinit();
    }
    const file_contents = try readInput(allocator);
    defer allocator.free(file_contents);

    // Solution 1
    {
        var queues = try parseQueues(allocator, file_contents);
        defer queues.deinit();
        const distance = solveDistance(&queues.left, &queues.right);
        try stdout.print("Solution 1: {}\n", .{distance});
        try bw.flush();
    }

    // Solution 2
    {
        var queues = try parseQueues(allocator, file_contents);
        defer queues.deinit();
        const similarity = solveSimilarity(allocator, &queues.left, &queues.right);
        try stdout.print("Solution 2: {}\n", .{similarity});
        try bw.flush();
    }
}
