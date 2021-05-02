extends Node;
# Singleton for various global scope constants and enums


enum PaddleSizes {
	PSIZE_SMALL,
	PSIZE_REGULAR,
	PSIZE_LARGE,
	PSIZE_MAX,
	PSIZE_DEFAULT = 1,
};

enum BallSizes {
	BSIZE_SMALL,
	BSIZE_REGULAR,
	BSIZE_LARGE,
	BSIZE_MAX,
	BSIZE_DEFAULT = 1,
};

enum BallSpeeds {
	BSPEED_VERY_SLOW,
	BSPEED_SLOW,
	BSPEED_REGULAR,
	BSPEED_FAST,
	BSPEED_VERY_FAST,
	BSPEED_MAX,
	BSPEED_DEFAULT = 2,
};

const PADDLE_SIZES: Array = [
	150,
	200,
	240,
];

const BALL_SIZES: Array = [
	10,
	15,
	25,
];

const BALL_SPEEDS: Array = [
	190,
	250,
	300,
	350,
	420,
];

var paddle_current_size: int = PADDLE_SIZES[PaddleSizes.PSIZE_DEFAULT];
var ball_current_size: int = BALL_SIZES[BallSizes.BSIZE_DEFAULT];
# this one will be very important
var ball_current_speed: int = BALL_SPEEDS[BallSpeeds.BSPEED_DEFAULT];

# why not just use class_name (if it works as I expect) and put constants
# in their respective nodes?

var mouse_sensitivity: float = PI;
