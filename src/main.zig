const std = @import("std");

// linear regression: y = mx + b

pub fn main() !void {
    const House = struct {
        size: f32, // square feet
        price: f32,
    };

    const houses = [_]House{
        .{ .size = 1200, .price = 200000 },
        .{ .size = 1500, .price = 250000 },
        .{ .size = 1800, .price = 300000 },
        .{ .size = 2000, .price = 350000 },
        .{ .size = 2500, .price = 450000 },
        .{ .size = 3000, .price = 500000 },
    };

    var sum_x: f32 = 0;
    var sum_y: f32 = 0;

    for (houses) |house| {
        sum_x += house.size;
        sum_y += house.price;
    }

    const mean_x = sum_x / houses.len;
    const mean_y = sum_y / houses.len;

    var numerator: f32 = 0;
    var denominator: f32 = 0;

    for (houses) |house| {
        numerator += (house.size - mean_x) * (house.price - mean_y);
        denominator += (house.size - mean_x) * (house.size - mean_x);
    }

    const m = numerator / denominator; // slope

    const b = mean_y - m * mean_x; // y-intercept

    const size = 2200.0;

    const price = m * size + b;

    std.debug.print("Predicted price for a house of size {d:.0} sq ft is ${d:.2}\n", .{ size, price });
}
