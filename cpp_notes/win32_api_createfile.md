���ļ����򿪹�����û�йر�ʱ����������ļ��ķ�����
https://support.microsoft.com/en-us/kb/316609


1 | ��д��� | ������
----|----|----
��һ�δ� | GENERIC_READ &#124; GENERIC_WRITE | 0
�ڶ��δ� | GENERIC_READ |��FILE_SHARE_READ��or FILE_SHARE_WRITE or FILE_SHARE_READ &#124; FILE_SHARE_WRITE ʧ��

2 | ��д��� | ������
----|----|----
��һ�δ� | GENERIC_READ &#124; GENERIC_WRITE | FILE_SHARE_READ
�ڶ��δ� | GENERIC_READ |��FILE_SHARE_READ��or FILE_SHARE_WRITE or FILE_SHARE_READ &#124; FILE_SHARE_WRITE ʧ��

 3 | ��д��� | ������
 ----|----|----
��һ�δ� | GENERIC_READ &#124; GENERIC_WRITE | FILE_SHARE_WRITE
�ڶ��δ� | GENERIC_READ |��FILE_SHARE_READ��or FILE_SHARE_WRITE or or FILE_SHARE_READ &#124; FILE_SHARE_WRITE ʧ��

4 | ��д��� | ������
----|----|----
��һ�δ� | GENERIC_READ &#124; GENERIC_WRITE | FILE_SHARE_READ &#124; FILE_SHARE_WRITE
�ڶ��δ� | GENERIC_READ |��FILE_SHARE_READ ʧ�� FILE_SHARE_WRITE ʧ�� FILE_SHARE_READ &#124; FILE_SHARE_WRITE �ɹ�
