import os
from . import BASE_DIR

DEBUG = True

SECRET_KEY = 'this is a not very secret key'

ALLOWED_HOSTS = ['localhost', 'ip6-localhost', '127.0.0.1', '[::1]']

'''
LOGGING
'''
LOGGING_DIR = os.path.join(BASE_DIR, 'log/')
LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue'
        }
    },
    'formatters': {
        'default': {
            'format': '[%(asctime)s] %(levelname)s: %(message)s'
        },
        'name': {
            'format': '[%(asctime)s] %(levelname)s %(name)s: %(message)s'
        },
        'console': {
            'format': '[%(asctime)s] %(message)s'
        },
        'verbose': {
            'format': '%(asctime)s [%(levelname)s] %(filename)s %(lineno)d: %(message)s',
            'datefmt': '%H:%M:%S'
        },
        'fullverbose': {
            'format': '%(asctime)s [%(levelname)s] %(pathname)s %(lineno)d: %(message)s'
        },
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'error_log': {
            'level': 'ERROR',
            'class': 'logging.FileHandler',
            'filename': os.path.join(LOGGING_DIR, 'rdmo_error.log'),
            'formatter': 'default'
        },
        'rdmo_log': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': os.path.join(LOGGING_DIR, 'rdmo.log'),
            'formatter': 'fullverbose'
        },
        'console': {
            'level': 'DEBUG',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
            'formatter': 'console'
        }
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': 'INFO',
        },
        'django.request': {
            'handlers': ['mail_admins', 'error_log'],
            'level': 'ERROR',
            'propagate': True
        },
        'rdmo': {
            'handlers': ['rdmo_log'],
            'level': 'DEBUG',
            'propagate': False
        }
    }
}


# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.postgresql_psycopg2',
#         'NAME': '',
#         'USER': '',
#         'PASSWORD': '',
#         'HOST': '',
#         'PORT': '',
#     }
# }

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.mysql',
#         'NAME': '',
#         'USER': '',
#         'PASSWORD': '',
#         'HOST': '',
#         'PORT': '',
#     }
# }

# DATABASES = {
#     'default': {
#         'ENGINE': 'django.db.backends.sqlite3',
#         'NAME': '',
#     }
# }
