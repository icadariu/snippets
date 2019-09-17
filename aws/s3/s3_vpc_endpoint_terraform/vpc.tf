# Resources
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "publicsubnet01" {
  cidr_block = "10.0.0.0/25"
  vpc_id     = "${aws_vpc.vpc.id}"
}

resource "aws_subnet" "publicsubnet02" {
  cidr_block = "10.0.0.128/25"
  vpc_id     = "${aws_vpc.vpc.id}"
}

resource "aws_internet_gateway" "aws_internet_gateway" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "public_aws_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "publicsubnet01_route_table_association" {
  subnet_id      = "${aws_subnet.publicsubnet01.id}"
  route_table_id = "${aws_route_table.public_aws_route_table.id}"
}

resource "aws_route_table_association" "publicsubnet02_route_table_association" {
  subnet_id      = "${aws_subnet.publicsubnet02.id}"
  route_table_id = "${aws_route_table.public_aws_route_table.id}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public_aws_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.aws_internet_gateway.id}"
}
