%获取surface的顶点和三角面片
%vertices是顶点的三维坐标，face是组成三角面片的顶点的下标
g=gifti('Mouse_brain.surf.gii');
face=g.faces;
vertices=g.vertices;

A = length(vertices)
B = length(face)

