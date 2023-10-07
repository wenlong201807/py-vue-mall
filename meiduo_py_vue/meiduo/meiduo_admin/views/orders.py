from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.viewsets import ReadOnlyModelViewSet
from rest_framework.permissions import IsAdminUser, AllowAny

from meiduo_admin.serializers.orders import OrederSerialzier
from utils.my_pagination import MyPageNumberPagination
from orders.models import OrderInfo


class OrderView(ReadOnlyModelViewSet):
    queryset = OrderInfo.objects.all()
    serializer_class = OrederSerialzier
    pagination_class = MyPageNumberPagination
    permission_classes = [AllowAny]

    # 搜索查询单条数据时，内部运行机制
    # def get_object(self):
    #     queryset=self.get_queryset()
    #
    #     obj=self.get_func(queryset,{'pk':1})
    #
    #     return obj

    # 重写获取查询集数据的方法
    def get_queryset(self):
        if self.request.query_params.get('keyword') == '':
            return OrderInfo.objects.all()

        # 如果查询条件为空时，走这里
        elif self.request.query_params.get('keyword') is None:
            return OrderInfo.objects.all()

        else:
            return OrderInfo.objects.filter(order_id__contains=self.request.query_params.get('keyword'))

    @action(methods=['put'], detail=True)  # 自定义生成路由规则，methods=['put']请求方式, detail=True 是否需要url正则匹配
    def status(self, request, pk):
        """
            修改订单状态 -> 在实际操作中，是需要接入第三方快递平台的信息的
            比如：走的是顺丰快递，那么，这个订单运输的快递信息，就要接入 顺丰开放平台 https://open.sf-express.com/
        :param request:
        :PK  订单编号 -> url里头 通过正则匹配获取
        :return:
        """

        # 1、查询要修改的订单对象
        try:
            order = OrderInfo.objects.get(order_id=pk)
        except:
            return Response({'error': '订单编号错误'})

        # 2、修改订单状态
        # 获取订单状态
        status = request.data.get('status')
        if status is None:
            return Response({'error': '缺少状态值'})
        order.status = status
        order.save()  # 保存到数据库中
        # 3、返回修改信息
        return Response(
            {
                'order_id': pk,
                'status': status
            }
        )
