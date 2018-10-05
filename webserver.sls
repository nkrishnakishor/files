httpd:                                        # ID Declaration
  pkg:                                        # State Declaration
    - name: httpd
    - installed
  service.running:
    - name: httpd
    - require:
        - pkg: httpd

/var/www/html/minionid:
  file:
    - directory
    - name: /var/www/html/{{ grains['id'] }}.com
    - makedirs: True
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
        - user
        - group
        - mode
    - require:
        - pkg: httpd

/var/www/index.html:                          # ID declaration
  file:                                       # state declaration
    - managed                                 # function
    - source: salt://webserver/index.html     # function arg
    - require:                                # requisite declaration
        - pkg: httpd                          # requisite refernce

/var/log/httpd/minionid:
  file:
    - directory
    - name: /var/log/httpd/{{ grains['id'] }}.com
    - makedirs: True
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
        - user
        - group
        - mode
    - require:
        - pkg: httpd

/var/www/html/minionid/index:
   file:
     - copy
     - name: /var/www/html/{{ grains['id'] }}.com
     - source: /tmp/index.html
     - require:
         - pkg: httpd

/etc/httpd/confd/vhost:
   file:
     - copy
     - name: /etc/httpd/conf.d/
     - source: /tmp/vhost.conf
     - require:
         - pkg: httpd

restart/if/vhost.conf/file/changed:
  cmd.run:
    - name: systemctl restart httpd.service
    - unless: which httpd
    - require:
        - pkg: httpd
    - reload_modules: True
