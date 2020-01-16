{% macro user(name, uid, gid=None, groups=None, home=None) -%}
{% if not gid -%}
{%   set gid = uid -%}
{% endif -%}
{% if home -%}
{%   set home_dir = home -%}
{% else -%}
{%   set home_dir = '/home/' + name -%}
{% endif -%}
create group {{ name }}:
  group.present:
    - name: {{ name }}
    - gid: {{ gid }}

create user {{ name }}:
  user.present:
    - name: {{ name }}
    - uid: {{ uid }}
    - gid_from_name: true
{%- if groups %}
    - groups: {{ groups }}
{%- endif %}
{%- if home %}
    - home: {{ home }}
{%- endif %}

create .ssh dir for {{ name }}:
  file.directory:
    - name: {{ home_dir }}/.ssh
    - user: {{ name }}
    - group: {{ name }}
    - mode: 0700

create authorized keys for {{ name }}:
  file.managed:
    - name: {{ home_dir }}/.ssh/authorized_keys
    - user: {{ name }}
    - group: {{ name }}
    - mode: 0600
    - source: salt://users/keys/{{ name }}
{%- endmacro %}

{{ user('kbolino', 1000, groups=['wheel', 'docker']) }}
