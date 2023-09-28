import { UploadOutlined } from '@ant-design/icons';
import type { UploadProps } from 'antd';
import { Button, message, Upload } from 'antd';
import axios from 'axios';

const BatchUpload = ({ batchAddUrl, initList }: any) => {
  const props: UploadProps = {
    name: 'file',
    // action: 'https://run.mocky.io/v3/435e224c-44fb-4773-9faf-380c5e6a2188',
    // headers: {
    //   authorization: 'authorization-text',
    // },
    onChange(info: any) {
      if (info.file.status !== 'uploading') {
        console.log(info.file, info.fileList);
      }
      if (info.file.status === 'done') {
        if (!batchAddUrl) return;

        // message.success(`${info.file.name} file uploaded successfully`);
        const file = info.file.originFileObj;
        // // 实例化
        const formdata = new FormData();
        formdata.append('excel_file', file);
        // formdata.append('other', 'file');
        axios({
          method: 'post',
          url: batchAddUrl,
          // url: 'http://127.0.0.1:8000/api/student/batchAddClss',
          data: formdata,
          headers: {
            'Content-Type': 'multipart/form-data',
            // 'Authorization': localStorage.getItem("authorization")
          },
        }).then(() => {
          initList();
          message.success(`批量添加成`);
        });
      } else if (info.file.status === 'error') {
        message.error(`${info.file.name} file upload failed.`);
      }
    },
  };
  return (
    <Upload {...props}>
      <Button icon={<UploadOutlined />}>批量导入</Button>
    </Upload>
  );
};

export default BatchUpload;
