import { useState, useEffect } from 'react';
import { Table, Tooltip } from 'antd';
import { studentCRUDApi } from '@/services/index';
import BatchUpload from '@/components/BatchUpload';
import { sexSet } from '@/utils';

export default () => {
  // const [actionType, setActionType] = useState(''); // add edit
  const [dataSource, setDataSource] = useState([]);

  const initList = async () => {
    const resObj = await studentCRUDApi('get');
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
      width: 80,
      fixed: 'left',
    },
    {
      title: '姓名',
      dataIndex: 'name',
      width: 100,
      fixed: 'left',
      ellipsis: {
        showTitle: false,
      },
      render: (val: string) => (
        <Tooltip placement="topLeft" title={val}>
          {val}
        </Tooltip>
      ),
    },
    {
      title: '昵称',
      dataIndex: 'nickname',
      width: 100,
      ellipsis: {
        showTitle: false,
      },
      render: (val: string) => (
        <Tooltip placement="topLeft" title={val}>
          {val}
        </Tooltip>
      ),
    },
    {
      title: '手机号',
      dataIndex: 'mobile',
      width: 150,
    },
    {
      title: '性别',
      dataIndex: 'sex',
      key: 'sex',
      render: (key: number) => <div>{sexSet[key]}</div>,
      width: 80,
    },
    {
      title: '头像',
      dataIndex: 'avatar',
      key: 'avatar',
      render: (key: string) => (
        <img src={`http://localhost:8000${key}`} width="20px" height="20px" />
      ),
      width: 100,
    },
    {
      title: '家庭地址',
      dataIndex: 'family_addr',
      key: 'family_addr',
      width: 200,
      ellipsis: {
        showTitle: false,
      },
      render: (address: string) => (
        <Tooltip placement="topLeft" title={address}>
          {address}
        </Tooltip>
      ),
    },
    {
      title: '出生日期',
      dataIndex: 'birthday',
      key: 'birthday',
      width: 200,
    },
    {
      title: '父亲名字',
      dataIndex: 'father_name',
      key: 'father_name',
      width: 150,
    },
    {
      title: '母亲名字',
      dataIndex: 'mother_name',
      key: 'mother_name',
      width: 150,
    },
    {
      title: '操作',
      key: 'operation',
      fixed: 'right',
      width: 100,
      render: () => <span>待定</span>,
    },
  ];

  return (
    <>
      {/* <div>
        <BatchUpload batchAddUrl="student/schoolBatchAdd?category=3" initList={initList} />
      </div> */}
      <Table bordered columns={columns} dataSource={dataSource} scroll={{ x: 1000 }} />
    </>
  );
};
