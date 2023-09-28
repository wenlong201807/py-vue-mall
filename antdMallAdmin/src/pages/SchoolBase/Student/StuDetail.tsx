import { useState, useEffect } from 'react';
import { Table } from 'antd';
import { stuDetailCRUDApi } from '@/services/index';
import BatchUpload from '@/components/BatchUpload';
import { sexSet } from '@/utils';

export default () => {
  // const [actionType, setActionType] = useState(''); // add edit
  const [dataSource, setDataSource] = useState([]);

  const initList = async () => {
    const resObj = await stuDetailCRUDApi('get');
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
      title: '昵称',
      dataIndex: 'nickname',
      key: 'name',
    },
    {
      title: '性别',
      dataIndex: 'sex',
      key: 'sex',
      render: (key: number) => <div>{sexSet[key]}</div>,
    },
    {
      title: '头像',
      dataIndex: 'avatar',
      key: 'avatar',
      render: (key: string) => (
        <img src={`http://localhost:8000${key}`} width="30px" height="30px" />
      ),
    },
    {
      title: '家庭地址',
      dataIndex: 'family_addr',
      key: 'family_addr',
    },
    {
      title: '生日',
      dataIndex: 'birthday',
      key: 'birthday',
    },
    {
      title: '父亲名字',
      dataIndex: 'father_name',
      key: 'father_name',
    },
    {
      title: '母亲名字',
      dataIndex: 'mother_name',
      key: 'mother_name',
    },
  ];

  return (
    <>
      <div>
        <BatchUpload batchAddUrl="student/schoolBatchAdd?category=3" initList={initList} />
      </div>
      <Table bordered columns={columns} dataSource={dataSource} />
    </>
  );
};
