import React, { useState, useEffect } from 'react';
import { message, Space, Table } from 'antd';
import { clssCRUDApi } from '@/services/student';
import UploadClss from './com/UploadClss';

type DataSourceType = {
  id: React.Key;
  name: string;
};

export default () => {
  const [actionType, setActionType] = useState(''); // add edit
  const [dataSource, setDataSource] = useState<DataSourceType[]>([]);

  const initList = async () => {
    const resObj = await clssCRUDApi('get');
    setDataSource(resObj);
  };

  const editableHandle = async (data: any) => {
    console.log(999, data);
    setActionType('');
    const curMethod = actionType === 'edit' ? 'put' : 'post';
    const res = await clssCRUDApi(curMethod, { name: data.name });
    console.log(11, res);
    if (res) {
      await initList();
      message.success('编辑成功');
    }
  };
  const delHandle = async (id: number) => {
    const res = await clssCRUDApi('delete', { id: [id] });
    console.log(444, res);
    if (res) {
      await initList();
    }
  };

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
      title: '班级名称',
      dataIndex: 'name',
      key: 'name',
    },
    // {
    //   title: 'Tags',
    //   key: 'tags',
    //   dataIndex: 'tags',
    //   render: (_, { tags }) => (
    //     <>
    //       {tags.map((tag) => {
    //         let color = tag.length > 5 ? 'geekblue' : 'green';
    //         if (tag === 'loser') {
    //           color = 'volcano';
    //         }
    //         return (
    //           <Tag color={color} key={tag}>
    //             {tag.toUpperCase()}
    //           </Tag>
    //         );
    //       })}
    //     </>
    //   ),
    // },
    {
      title: 'Action',
      key: 'action',
      render: (_, record) => (
        <Space size="middle">
          <a onClick={() => editableHandle(record)}>编辑</a>
          <a onClick={() => delHandle(record.id)}>删除</a>
        </Space>
      ),
    },
  ];

  return (
    <>
      <div>
        <UploadClss initList={initList} />
      </div>
      <Table columns={columns} dataSource={dataSource} />
    </>
  );
};
