from rest_framework.authentication import BaseAuthentication
from rest_framework.exceptions import AuthenticationFailed
from .redis_pool import POOL
from Course.models import Account
import redis

CONN = redis.Redis(connection_pool=POOL)


class LoginAuth(BaseAuthentication):
    def authenticate(self, request):
        # print('请求头信息:', request.META)  # 获取所有的进程的环境变量信息
        '''
        
        # {
        'PATH': '/Users/zhuwenlong/Desktop/py-vue-mall/dj10Mall/venv/bin:/opt/homebrew/opt/nvm/versions/node/v16.13.1/bin:/opt/homebrew/bin:/Library/Frameworks/Python.framework/Versions/3.6/bin:/Library/Frameworks/Python.framework/Versions/3.10/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:/Library/Apple/usr/bin:/Users/zhuwenlong/.pub-cache/bin:/usr/local/maven/apache-maven-3.9.2/bin:/opt/homebrew/opt/nvm/versions/node/v16.13.1/bin/node:/Users/zhuwenlong/flutter/bin:/opt/homebrew/opt/mysql@5.7/bin', 
        'PUB_HOSTED_URL': 'https://pub.flutter-io.cn', 
        'LDFLAGS': '-L/opt/homebrew/opt/mysql-client/lib', 
        'PS1': '(venv) ', 
        'MAVEN_HOME': '/usr/local/maven/apache-maven-3.9.2', 
        'VIRTUALENVWRAPPER_WORKON_CD': '1', 'LOGNAME': 'zhuwenlong',
         'PWD': '/Users/zhuwenlong/Desktop/py-vue-mall/dj10Mall', 'PYCHARM_HOSTED': '1', 
         'INFOPATH': '/opt/homebrew/share/info:', 
         'PYTHONPATH': '/Users/zhuwenlong/Desktop/py-vue-mall/dj10Mall:/Applications/PyCharm.app/Contents/plugins/python/helpers/pycharm_matplotlib_backend:/Applications/PyCharm.app/Contents/plugins/python/helpers/pycharm_display', 'NVM_CD_FLAGS': '-q', 'SHELL': '/bin/zsh', 'CPPFLAGS': '-I/opt/homebrew/opt/mysql-client/include', 'PAGER': 'less', 'SECURITYSESSIONID': '18a71', 'OLDPWD': '/', 'HOMEBREW_CELLAR': '/opt/homebrew/Cellar', 'ZSH': '/Users/zhuwenlong/.oh-my-zsh', 'TMPDIR': '/var/folders/2w/yd926tnx21n38lj81c_2ttn00000gn/T/', 'VIRTUAL_ENV': '/Users/zhuwenlong/Desktop/py-vue-mall/dj10Mall/venv', 'XPC_FLAGS': '0x0', '__CF_USER_TEXT_ENCODING': '0x1F5:0x19:0x34', 'FLUTTER_STORAGE_BASE_URL': 'https://storage.flutter-io.cn', 'LESS': '-R', 'LC_CTYPE': 'zh_CN.UTF-8', 
         'MANPATH': '/opt/homebrew/opt/nvm/versions/node/v16.13.1/share/man:/opt/homebrew/share/man::', 
         'WORKON_HOME': '/Users/zhuwenlong/Documents/python_envs', 'VIRTUALENVWRAPPER_PYTHON': '/Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10', 
         'HOMEBREW_PREFIX': '/opt/homebrew', 'COMMAND_MODE': 'unix2003', 'VIRTUALENVWRAPPER_SCRIPT': '/Library/Frameworks/Python.framework/Versions/3.10/bin/virtualenvwrapper.sh', 'NVM_INC': '/opt/homebrew/opt/nvm/versions/node/v16.13.1/include/node', 'HOMEBREW_REPOSITORY': '/opt/homebrew', 'XPC_SERVICE_NAME': 'application.com.jetbrains.pycharm.75097098.75097759', 'PYCHARM_DISPLAY_PORT': '63342', '__CFBundleIdentifier': 'com.jetbrains.pycharm', 'NVM_DIR': '/opt/homebrew/opt/nvm', 'LSCOLORS': 'Gxfxcxdxbxegedabagacad', 'PYTHONIOENCODING': 'UTF-8', 'USER': 'zhuwenlong', 'VIRTUALENVWRAPPER_HOOK_DIR': '/Users/zhuwenlong/Documents/python_envs', 'LaunchInstanceID': '58B7846C-2FD9-4108-BBEB-17E95EC805D3', 'SSH_AUTH_SOCK': '/private/tmp/com.apple.launchd.3XddYjvall/Listeners', 'DJANGO_SETTINGS_MODULE': 'dj10Mall.settings', 'PYTHONUNBUFFERED': '1', 'VIRTUALENVWRAPPER_PROJECT_FILENAME': '.project', 'NVM_BIN': '/opt/homebrew/opt/nvm/versions/node/v16.13.1/bin', 'HOME': '/Users/zhuwenlong', 'TZ': 'UTC', 'RUN_MAIN': 'true', 'SERVER_NAME': '1.0.0.127.in-addr.arpa', 'GATEWAY_INTERFACE': 'CGI/1.1', 'SERVER_PORT': '8000', 'REMOTE_HOST': '', 'CONTENT_LENGTH': '', 'SCRIPT_NAME': '', 'SERVER_PROTOCOL': 'HTTP/1.1', 'SERVER_SOFTWARE': 'WSGIServer/0.2', 'REQUEST_METHOD': 'GET', 'PATH_INFO': '/api/test_auth', 'QUERY_STRING': '', 'REMOTE_ADDR': '127.0.0.1', 'CONTENT_TYPE': 'text/plain', 'HTTP_AUTHORIZATION': '8425fd46-769e-434d-b383-cec756c50eea', 'HTTP_USER_AGENT': 'PostmanRuntime/7.29.0', 'HTTP_ACCEPT': '*/*', 'HTTP_POSTMAN_TOKEN': 'ba61179a-a560-4f72-9875-e40e919bf0f6', 'HTTP_HOST': '127.0.0.1:8000', 'HTTP_ACCEPT_ENCODING': 'gzip, deflate, br', 'HTTP_CONNECTION': 'keep-alive', 'wsgi.input': <django.core.handlers.wsgi.LimitedStream object at 0x125b759f0>, 'wsgi.errors': <_io.TextIOWrapper name='<stderr>' mode='w' encoding='utf-8'>, 'wsgi.version': (1, 0), 'wsgi.run_once': False, 'wsgi.url_scheme': 'http', 'wsgi.multithread': True, 
         'wsgi.multiprocess': False, 'wsgi.file_wrapper': <class 'wsgiref.util.FileWrapper'>}
        '''
        # 从请求头中获取前端带过来的token
        token = request.META.get("HTTP_AUTHENTICATION", "")

        # 自定义请求头中的参数，必须全部大写,且只能是大写字母
        # other_ead = request.META.get("HTTP_AA-BB", "")  # 错误
        # other_ead = request.META.get("HTTP_AA", "")  # 正确
        # print('token:', token, other_ead)
        if not token:
            raise AuthenticationFailed("没有携带token")
        # 去redis比对
        user_id = CONN.get(str(token))
        if user_id == None:
            raise AuthenticationFailed("token过期")
        user_obj = Account.objects.filter(id=user_id).first()
        return user_obj, token
