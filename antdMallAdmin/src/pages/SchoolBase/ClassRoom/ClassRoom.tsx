import { useState, useEffect } from 'react';
import { Table } from 'antd';
import { classRoomCRUDApi } from '@/services/index';
import BatchUpload from '@/components/BatchUpload';

export default () => {
  // const [actionType, setActionType] = useState(''); // add edit
  const [dataSource, setDataSource] = useState([]);

  const initList = async () => {
    const resObj = await classRoomCRUDApi('get');
    setDataSource(resObj);
  };

  // const editableHandle = async (data: any) => {
  //   console.log(999, data);
  //   setActionType('');
  //   const curMethod = actionType === 'edit' ? 'put' : 'post';
  //   const res = await clssCRUDApi(curMethod, { name: data.name });
  //   console.log(11, res);
  //   if (res) {
  //     await initList();
  //     message.success('编辑成功');
  //   }
  // };
  // const delHandle = async (id: number) => {
  //   const res = await clssCRUDApi('delete', { del_list: String(id) });
  //   console.log(444, res);
  //   if (res) {
  //     await initList();
  //   }
  // };

  useEffect(() => {
    initList();
  }, []);

  const columns: any = [
    {
      title: '序号',
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: '教室名称',
      dataIndex: 'name',
      key: 'name',
    },
    {
      title: '教室地址',
      dataIndex: 'room_addr',
      key: 'room_addr',
    },
    {
      title: '可容纳人数',
      dataIndex: 'capacity_num',
      key: 'cap_num',
    },
    {
      title: '是否是多媒体教室',
      dataIndex: 'isMedia_room',
      key: 'isMedia_room',
      render: (key: boolean) => <div>{key ? '是' : '否'}</div>,
    },
  ];

  return (
    <>
      <div>
        <BatchUpload batchAddUrl="student/schoolBatchAdd?category=1" initList={initList} />
      </div>
      <Table bordered columns={columns} dataSource={dataSource} />
    </>
  );
};
