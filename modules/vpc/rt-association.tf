# Associating Subnets to the route table

resource "aws_route_table_association" "liengerta" {
  count          = length(var.azsubnet_pub)
  route_table_id = aws_route_table.liengert_public[0].id
  subnet_id      = aws_subnet.liengesubpub[count.index].id

}

resource "aws_route_table_association" "liengerta1" {
  count          = length(var.azsubnet_priv0)
  route_table_id = aws_route_table.liengert_private[1].id
  subnet_id      = aws_subnet.liengesubpriv[count.index].id

}

resource "aws_route_table_association" "liengerta2" {
  count          = length(var.azsubnet_priv1)
  route_table_id = aws_route_table.liengert_private1[0].id
  subnet_id      = aws_subnet.liengesubpriv1[count.index].id

}