GDPC                �                                                                         X   res://.godot/exported/133200997/export-79e4528e86b81c004fd427dc362ba82b-game_room.scn         �      ��o��<)�ԟ�Xp�m�    P   res://.godot/exported/133200997/export-a29d5d0e6346c53fac340b6edd16221e-ball.res 	      $
      "{��/ĝĒIڼ�L�Y    P   res://.godot/exported/133200997/export-f46c71a9b7f0892a5bf2bd9cf0943875-ball.scnP      �      �Q���Y�R+�9����    X   res://.godot/exported/133200997/export-fff17282759ef4fb3eae077216de873f-default_font.res�y           �K�m��'�I��    ,   res://.godot/global_script_class_cache.cfg  ��     �       so�U:ԒYe@����    X   res://.godot/imported/Blue_Nebula_08-512x512.png-be40ccdfdcb54196ab7f70e4ddc321b5.ctex         ��     ��]~����NL+�_�    L   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.s3tc.ctex         �U      SW!|��2���v�5�U       res://.godot/uid_cache.bin  І     �       m����<(i	a��eA    (   res://Blue_Nebula_08-512x512.png.import       �       <~��^Uk ��]��       res://MouseController.gd�u     �      ����z��">,z|       res://TestBall.gd   �{     1      3���A��ʧH!�9�       res://WorldBounds.gd�|     �      �U��G���+�t�t�       res://ball.gd           	      ;���nQ��Y2�ٿ       res://ball.tres.remap   ��     a       ������@�6�p��x
       res://ball.tscn.remap   0�     a       ;�#$�#ui�+�9KY)        res://default_font.tres.remap   �     i       �0�q�p9���(	       res://game_room.tscn.remap  ��     f       ��=C���+�Cn�Z�       res://icon.svg  �     �      C��=U���^Qu��U3       res://icon.svg.import   �t     �       ,YF��D*�['��a�       res://project.binary��     d      ���6��%a�m�    extends RigidBody2D

class_name Ball

var health: int = 10
var size: int = 1
var direction: float = 0

const healthy_color = Color.LIME
const unhealthy_color = Color.RED

const MAX_SPEED: int = 800

@export var debug_font: Font

@onready var mesh := $OutlineMesh as MeshInstance2D
@onready var rng = RandomNumberGenerator.new()
@onready var collision := $CollisionShape2D as CollisionShape2D
@onready var scene := load(scene_file_path) as PackedScene

func _ready():
	mass = size
	var s = size * 0.75
	mesh.scale = Vector2(s, s)
	collision.scale = Vector2(s, s)
	health = calculate_max_health()
	update_health_color()
	body_shape_entered.connect(on_collision)
	set_axis_velocity((
		Vector2.from_angle(direction) * rng.randf_range(1, MAX_SPEED)
	).limit_length(MAX_SPEED))

func on_collision(body_rid: RID, 
				  body: Node,
				  body_shape_index: int,
				  local_shape_index: int):
	if body is Ball:
		var ball = body as Ball
		take_damage(ball.size)
	else:
		take_damage(1)

func take_damage(damage: int) -> void:
	health -= damage
	update_health_color()
	queue_redraw()
	if (health <= 0):
		split()
	
func split():
	if size > 1:
		var ball1 = scene.instantiate() as Ball
		var ball2 = scene.instantiate() as Ball
		ball1.size = size - 1
		ball1.position = position
		ball1.direction = direction
		ball2.size = size - 1
		ball2.position = position
		ball2.direction = direction
		get_parent().add_child(ball1)
		get_parent().add_child(ball2)
	queue_free()

func calculate_max_health() -> float:
	return (size * 10.0)

func update_health_color() -> void:
	var c = unhealthy_color.lerp(healthy_color,health / calculate_max_health())
	mesh.modulate = Color.from_hsv(c.h, 1, 1, c.a)

func _draw():
	var fs = 16
	var s = size * 10
	var p = Vector2(-s/2,((s * 0.75) - fs)/ 2)
	var o = 2
	draw_string(debug_font, Vector2(p.x - o, p.y - o), str(health), HORIZONTAL_ALIGNMENT_CENTER, s, fs, Color.BLACK)
	draw_string(debug_font, Vector2(p.x - o, p.y + o), str(health), HORIZONTAL_ALIGNMENT_CENTER, s, fs, Color.BLACK)
	draw_string(debug_font, Vector2(p.x + o, p.y - o), str(health), HORIZONTAL_ALIGNMENT_CENTER, s, fs, Color.BLACK)
	draw_string(debug_font, Vector2(p.x + o, p.y + o), str(health), HORIZONTAL_ALIGNMENT_CENTER, s, fs, Color.BLACK)
	
	draw_string(debug_font, p, str(health), HORIZONTAL_ALIGNMENT_CENTER, s, fs, Color.WHITE)
��RSRC                    StandardMaterial3D            ��������                                            n      resource_local_to_scene    resource_name    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    script        !   local://StandardMaterial3D_5xwon �	         StandardMaterial3D    m      RSRC���$�	���RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    is_hemisphere    custom_solver_bias 	   _bundled       Script    res://ball.gd ��������   SystemFont    res://default_font.tres ¡m����|      local://PhysicsMaterial_5pjvp �         local://SphereMesh_mdr4t �         local://CircleShape2D_0srm1 *         local://PackedScene_2olwo H         PhysicsMaterial                               �?         SphereMesh             A        �A                           CircleShape2D             PackedScene          	         names "         Ball    z_index    physics_material_override    gravity_scale    max_contacts_reported    contact_monitor    script    debug_font    RigidBody2D    OutlineMesh    self_modulate    mesh    MeshInstance2D    CenterMesh    scale    CollisionShape2D    shape    	   variants                                                          ���>���>���>  �?   ����         
   ��L?��L?               node_count             nodes     6   ��������       ����                                                              	   ����   
                                   ����      	                           ����      
             conn_count              conns               node_paths              editable_instances              version             RSRC��{�M��M|�fWGST2            ����                        �� RIFF�� WEBPVP8L�� /�� �m���<��@q����	����Y�m��L?g�a�k)�@J�t����$��j����xhP�R ҵ�%m�:��bG2�D2Rv�|�$1��/�l�F�-��о:�cL�i��F�������IkG�նmømNy Dd�B  �P�+p���1��FF o�4�xۉ@�st�q6z<��m��pA�a�uv���ȱ�T�D��t[\Y,���"���5���uw�-$�|�"���")_�f"�t9�O7����,�|���-��@���퀃  ���0C-"��)� �G�x�C �d��L�ߞ��y�a�������љ�࣠�s�Y[R�u��Qn���e��ifw��$����%�%��\s�K"����H�w���յd�l@�i^�r6��&7m�ֿ�$�ף����<Y���|o�NZ33�
p<���ܝќS���!��E豵��$��Wv��@� 
;���`������pUZ���p�3�Ͽp����/����ɶmնm;ʥ�u;%Ş�%E���.�^c�Y۶l{i��7c��k�bA3��a�aX]);�>95]Ǐ� |׶m��d[�Ed�>X�q}� L'?�L�|aA�|t�m��m�ZL�ͽ�9��g۶u���m۶�;�5�hζmٶ=Y���R�`��B!�>gw���I�`�f�����/���#Mخ��y$e�I��((�h�\��E��(Z�Q��?�m���=Nmc��  xH ��rZ��4�����3{L��Z۶mm�m.{�Ϋ �w�>������j����u�J��kN��\۶�&�+�����E�'9�âO ���7�ڶ][[�Ǻ�@�L�C* �2Q.#o#�R	Q�]
ߞ1|�����s?o躶t�]�K� >��Dj��G�9S��$���9 ���DP����� 9r^�P$�#�[m�4�vt�Ԓ-W���V��P��<�p����8 s�E��ɪ����yx|G��ڶm[��������_���p���ޫ������$I��y=^�V�����(�m�6׶m���(�m3+"#2rl����������m�|������N�8�	ܘ�]���]?9��ѹ)]��eL�R����H�����lg��ض�ڶ�g���΃{����ʣ()*��"�뷘�b|߻��^c�V۶l� Y�y�&ʨ%K%�V�$�r�l@WHN(f�с�?VDY��%DA)�l�v��B$d��0�(����>��B�=?>���G�mնm��>��
���C���d�,Y�h��m;�M������(��eFeD""Ƕ��m۶m�������@FV'ڶ��^�x����m��6w��d��efK*�t�b8���qI
Ê��O2�������5$�O϶m���m[.m��z^�^?�l۶y<�/�m�l��o��}�^c4k�v���������6b;�qfc�e0Fv�����$C�Fw�U]��{F�I۶eo#���Kv�����ʩq=�m/�y�y�z���JUuw8v,�߭۶mS۶��q=�?��l圜�L6m������{�� ������ƹￜ�)��v�$V�=�n����	���=�2w����_eZ������X�����B��m��X�yU�w�H
�q5@���Z{A�b��19����կ������Ɇ�9���ڶ���>��"f�ρ;���=��F�	Фm��t^����)��b��B��aZC�x�8ff�n�QK��f�����Q1���Exζm��L��ˁ?V!@�Z�L�p�I�� p<(�n {��y��f۶U۶��k_�܇C���3�!�"�n��"5m�vl��i?���b��5G�X���޲�V��v;]�̪�ض��Q�x��m�H��yel�gƾ�ϩ�>;�|�@�[�������.N�m��m;*����}O��,ŕ�(�93�ߧ=Z$'[ێm���e���/�?����b�j;Hٶ�����߀�m=�̒�{_�N�m[�$)sY��QȐ2=�� 2��Jd� �3E7�0kD�1Pk-BN5��B�IRm۶-�lk]f��W|�O~o��� Nֶ-��َ��L �T����J��̌����mg��O_I�X�����ɶk;N.�(����Z#>�Zæ���f�<Z��c۶j۶�\�\�A,��\1C�e1K&�C4��kL����um3A`96��=��sR`[���4�1��V�g���x�vsmG* Ȗ�-�%H��VA[E����8e�P���đ��n8�o�x��M<��f��F0o���>�Ϧhd�r��Y��@���-@5�36o�l���l¶��um�����d����l�����˷_ń .d�� {-{�,!J/�;%�r�|�T��~��|םr)�-���2+�s��l;�02j�7�]�80�=z�y�i���mO��xi��}�Y�Y�d���K���lj{أ����#��������	160�������O36����� �2̒"�ϳ-6�:n;Z��t�͇���ā�C�{O��?���ڹ�S_�R��}W�)�̒K�����z����`%J2�M*Z\�k�-���fR�%`��V1����W�*�kWQ����|<x3h�!M �tԝ/_}��㫫{�.W�B�_��&Z!ɔ[�#sO�:�e�X��1e�đN"��@i�*I[i�YdE]Hӎ!`�D`�X@ac�Q6��ru��8m;fd_~��O��B�4c��!�T������M������/$-b�%A�v�8�DY�t&l�T��jz�w�&����-	E1�;ؐ�RA`�TKT�k׃Q��Z=�P��
E���[߾w	4Lp�{,wۤǛ^�֦k'<�����l3 �o޿�Ԍ�@t�DD�xs�ƕ`<6�m4=Sq�*���TiY��!@lT,b�� 2��-%����>�5市�u��!��0UK�����!URV�Tpue��"*�I]�U��Y���@����

�$�|)���I.�����p��sW�T_E �V�7�؇�VvC1�I#FZǌ�^�
ihl���ZE*�($�	q��ʩ��hYI��MX,J�U�& &f������A:E\���G��jl�� p�|R������W����)����R].QF� V.�q*mi��0�n� c�6a@�R`�d�<68�	([m[�k��7���j�]qmUF���t�=��i{uP �T�L�_�ވ)��/F~�Zoޜ���1T�� �����*�("�ț���2o�R�B�M*�2*i��1�L��xi��`,�)F�(WU*DeRґ@�����\+RE$`��PeB�U�f�(S�ʠJ��dRUG�E�;���5�M([#��<����c -UH�NUՑ(��S]E��+U�Ḣ��3�9R6-�d����V�+[5�P���Ҧ�QK!Q�X��Y�*ERIY,	h.Y� A�.�`6�x�%@,B�%E6����PY��-#�K�#�@	V]�"D$L�O�*�uT*P��|\]�4�lW��:a$fa<MC{�d�K:�"��"B�\Ql�l齮~ůmc|��dSӝGYS��tȂ�u)cƛ�Ɲ��Um�����o���@20.a��NWwF\6���6,�R�&T����;xv�m�1��*��1 B@�!M�UBEP�/����L%BUU5��)V�UeJ��"T9�b��RH���R��q�ܭ|��f&��ho5�굯.����P�RʩV]�V��H�ת*:]WwKQRLۼy>ϩ)������Mk�l�p+�G�bQ*F�������j�D1��f	XVX��.GdET�P	�-Lh�XJ���4��B���Y����H@�c�T�O��T.��ĝ�Qm%�H����\�V���?�����Ϲ�|TG� &��1`,��4��M"�ҕ��
�@.��Ĳ
�ƛ�-�h��l�[x!�U�});Z
��$���qSo��j������t�
2{u�ǶF��DSD�`e"G��R���r�d�iF#��J�V�c����j���D��"ۮ*�P0 �mh�I'��R��Nw�"�HP�TL��S�����%�*v9dSH�3WY�"�R���������Ց�l���-�[�q�����]]�驮����9#��u�B�c��3M�E�5���Ӣ��b�i�����(�������F�YʈVg�ʶԢ�����,$"K ی�i��<𦤳D(%[צ3�Z+S���&�H2�K!� lD.���cHD�(%uMw"�w^S�Q��V1�{����������X�THAWI�/_J�Ͼ���:�zsG�1:�#�y���0�cC{״"�P�,*�h���r����	o�}��/��{׵f�� �o��}����J[A0�I��u9�r�"���k�f�jU��z�m��:��)6������4P1�u�'_�N�*`�B@F�pV�*	U�.L�R%U%��d 	2s��`E�"��5GHI&�{���l^��(���x���;ߓ��q�IuuO]�ԺVJ]U�������pf�zXb������Fi�d�Ue˲�ڶX�XX5*bb�jm� ɢ�[O���|��]��L@��Mؘ�0�cʖ�29�3�!������lT�bQU�P��\`y� eNI�U�"�D��X��b<��tP�tU�UQe\�t��O�r���������%Q9Kꨭ�:���f��eX1�����������?��3Se���P�>������۞�f����e�U-�/I�*����{~{J�ȥT�.�BA�e\���,wJD ��*���^5E�m��Wn��e����ͺܥ]]�J��R�U�P���=��D���n�	vUXU�|��}��`��`�D*�́�@	&%+C��e�Xe������W.,��sO�����S�ﺫK�U��wNIUw��Y,G�!ke{������p�6Y¨X�N�X�lj
T�Ū�mA�%�~�����V����:$�����|�bA\�
e��Ybli��l1� �T�")� �%f>)I�VBR9]�D���Zi&�4�,�Q�JE-3����Buw:qU���M���<�ho.];h ˤ5�!o�������#����w�R�QKQ��\���{b7�׋��� (/L,e"IS\����c�V� eJ(�� ��%"%dg���(�2��.��t�r�u�֘VYU5�l���0�4��'lT�%�"�Ur�$^n}�B�@DUE�͕\I���.>��Ki �Jd
0P0�bd2�v���7����6a�Ufk����tujwu�S]�r������:��r\Y2ZjLd ��)`��>�q�v,k+*]E^V��e�0Ef%K(�JG҈8�]u���]Ww�/���q O3 �C�B���Y��1��YRV�B� �9" ��"%e��
*��(E@��( ��4�D:EQj:�JJ_]�"F�금�Ġ�(����U~`4R���R��Ԫ(R˵]�;];�N{km5oT7�U̎L�٦HSER�jU!!�Ra�vu�& jt��������=?di�tDպ\Fn��d��ɶ�q[<0�����o,%�Z���HrU#�eD@�H�b�YҮPSQ�$[b4�PSQ�
sT&ö٘ml����kt��6=�\:�U����|��T������H�T�O�@T�]Z3�� "a����|f,]tM��Tm�d�(�Z�r�,J����}T*�.�h׾s�j�K�'��r�jm7�`H��	� (�X��Y� 1L���(
15j+��,0 JA��w;ũ ��R`R����ũv�Hɚ�E��)UE �RTGRYF��Tl�^�	�Ԉ���U\_&#���8�����Ԛ���_s��ltU�Nt-]�[x���(�����U%JW�[���0Z�&lLd9�ꅫ���Et�K*GO��hᝲյ�AͪF6�x�����I�GʖH�u�Zt�B�T�$A��䓋��A4U�X���`�d�d{��c�6flKe��#	<E9�2UI���;�RU%0�)�T�F�I0h���9�H�1������B7T˚���
Vk�J�Sd���|�]Og\��K��N����|������/?��Ȃ��#�n�޿L�0��H�l��& &VT�����x�0�+h��Ku��(ՑV�e r���T�.��Uu�N��wT\�2������
�m�X*�M��cC6�\�n��;P�����V�lWϾ����N�����}v���)�bu�ԍ�Y�alA��u���U�����c�������Oc�Qˤ�PEUB.�#r�Ջ].j֖��>cR!�+����Y^k]j%��V��UQ�*.P�JR%�
KKaI��r/o+s�L/o�4�@�(�3ӆ+6�5{���4V����{)��յ�J.��� P�T�ۖS�4�)7���Rs#�����k�l��j�,�ք���Q8$�$>���>���R�N��{q.�|����r�}���A�a*�¤��)QZe�i�Ԁ�Y�� ��-C�0a�!r)��2�J(1P�U�B�N�D�;wݹs珷T�d���J�Ge]li+���x��� �c$�.�F���r�[��e���*��>t�\5����l}�]~}��+Wg)�Νw�W�̘�dҠA�@Ir����.J�V���3	P�,D�R��D:E���եo}�^}*��L���d�M��K��il��K�b�$Ӏ��:�B
I$	�CE��z�)�)�6i�L����LZ�m4�VX{<�L[�S�n��C ���q���𧾸�� �F�:f#mE̤	���[��&$�"[]{y�'�=wbSV�$T7� K���%DW���(O��X�-aH�9.׾W��Η����:J��v��B��@L�QȀ!i�1@E��Hc�ƴ)& �B&��r9
��W� ������(U�v%Uո�S��ӕ.��P��S������1`-i����`?y���\~;(��2��w��w�vl�/����Muǣ��Z���2�fh=�Ue���rgu96W� &�TDEJܻ�{9�(6��櫁X�I�"�Q�׎Kz۫��SG�nӺud%-�)ä�YP��?���'�46[��ik̨��DA�������r�*�fV���LeG�l�mU`Ă�,m#�m�¶�-��؛��	�,V&]r9�-^I)P�W?��_|���W��������J5%D�^�V���_\?8��6Y�{;��rC��4�����׵q"UT*-Q!�"D�Rej���j5�2`G풙�ݾ�ϫ��f !-._�]Ҭ��d3@([1!��H� m��o-�:� IMAM�Q.܉�Z�J2����W@�[ʡ
����+Q�$J)�E ���)����Vy�2�O/�}��RRQg*����_|��;_�����$bq}Y���u/���}t�W~>$jYU���3u	@�l���B��*T/orl�������"d3B2E���i�\+Q��멷�|��G�ٿ����`�Y�b��&���Rx�؊Z��1��lk´%4J�)�����"	�A;3U�
��
���$�Q�lZ�,̖l<{�$Z��2Y9J��"�����~�󯼽�?�������F,�� ��2b֗Ƕ��"�#��&FV�H)��mښ�y��*��H@V�" �DF���U�\+ٕ8�����{��MPn.U��J�$ޘbB��ls<@�0	�1FC((q����� F)Q A%� 0IaG���]Um����X*�2eD�T*�8-��ǝ��]��L�խ�r{*����.>X�=U?����>N��~��Wa�E_�kS�=6��Y�����	71T1q�@F�)d �@�
�TIx�U*���������4M[aS�Y$�(�x����&c�Xbl�L��M� iR�)4ձ�$�Vת�X�Ȫm�4"�)s��[�7��jc���
bCNE` qg�.is)'=�4��,��I��-$j���YnJca��L�sC��*j�I��¨�(�N
l�*�@�Y'\���m�m6o061lT f*F�Ʀ`�f����Ҍ�j) <��� p�+&M	�%�BS���)#b.�(sA*�T(����RU�5�������E�w�m�f]��t�X][��0�V��]��ܺ��,��|���R_�qWQ�*VI! l�)�f4K�bMJ%��J�A�d騎"�A���G��DV������E0��`b��lٺ)b�t#��0��l6[����h�R
]���V#:�*�ZU��D$�dBZ5�Y44a(�k�	��x���	�L3AS��ER��vU�����l6@���Q��Z1"c��Y���N0����ba;��r��ZT�"K0�#H�IJD�v-]�ԋ\:w�s�u�r�`A(�2
��2PZ�-`�t�X�.1���c�� ���U+	E�bW&	$L��NZSm�-�>-)aHU��2G�*�I�P 5T�F�b�(��)"W��f_�kW�:�J���>���΋y�5}�]G�YSݮ�Wq��Z�.{93�� ed�G�-��Mg���}��U(����tV��ړ���?m)��  bq��$��7	#� l�C!5�&U��K�(� I ,m'R� !s`�ZP�����m&Fi�|u=�lc��a.����U�����1��6�CT�ښ!k���/��Fd4�L��RK��8̡F�EXG���V���t)�G��.Y�����j1{[ēvb�9��`�6쁂h���S@(1 !@H
�LZ��	�)�fe�`VT o.t'�j"@%�¥TJ�j.	"�ڲ�Hm]�TR.w�TCRo]�j�Ժ�����V���l~I��"i9ר)���:��>���L�M�-��L۬=�S�� �\#+/UMi��)��MA||��o��G��o�Lk��+^D�vkiBݰ֍�5S�h*dS!����H�S
}|���T��ȸ�$i$ j#&�*I�
54s��~*4�ic��H�I[�(	�Y����HmK4���j�%11-2�bc�-JYhv�h�m�Ăwإ��Z�P�L�t^��gW��dM�;�E��r� �m,lP]B6�eB�Jkh[LZ�n���6bi
]3�- j����8R.�����%�2�	)8hM�\9�2�-m$��Ҕ��\.6I�ȸHAQ�D$TQ{Z�Fd!Ҫ;΢jtA�Qi�%c�N���.��κ��e���yuA�����UVN����)�>���f�۶l�oH,RT�PKUCX�յ��Y��{={�~�.�]�]]�L ��D��he4m+r)�vicR���Jio�^n���\��2%�+[SP�l`͒O.��SH��*a20��M���ad@��߾�u��+�B�.!H �ӐTqI�l9aeG4��2�[Ӽsa�)
�)E����2BI���P�أɚKD�hB�a[��>u�e2�c���Ѭl�66���S��i�U�2�S�ʨD)]�Rʥ�	�R
P� ��CDb*D����{�U�H�$vds��G����Đ��u����Q��WO�&(�ԉ�R��jT�UZF����Y��;���@Es��x8%�J�֕[O%�h����>�2���[�̈́M3IW\�)�<
��VH�ӊ�����TMA�f�e�hm���6M�E6�V�;��(G�D
&�)��Z&4Ae)�*�2WKQ(  dmz���Pʘ�%�BX	���BS�C�Js���ߏټ��Z���%d� "�hM3*�ՙT<��ֽ���j[�L��T���)��dS[��-m�B*D�[�,
Vw��1:8I"fk(]����z���*c�MlC�i(��@1�S6������PR �)�r
�	R���*P�{�QPiQ�� B:?���a��$�QwA)2���	!U��Y*+VT���-]wV?���U&�Q}7�ϭT�N
`SI٩�4j�V�i��4<�&hv'.�%e�2�j�yz��h�"�6�V�~�O������0�h�9 h7mp)U\"b�	r\�U�R ���Ҥ�,�QFb�I�A��$�_}�~��dB.���#m2&�`#��zەL0i[�4�U�.�/G���d�EQ����J��T��_�rN���h��b	�V�=wv��VZ�[[�""�E�b�TD�V*T�`D�a�������-4[�&�� ���1 ����ecS6��Q`X�&VSL�0 ��D%$B�b$b A�d�  �*�$1��sm �HB(� DP�TT)�怌�2pՑ�3I���EF����w�Cժs(�x8��q�n��XuuD�2H@�ڀ��B�RUAb�f� Ƞ����}t�ݷ��R���6�Q&�ظ+Ww�R�>��,��e`��TD�vc���*ab(��)Q�JD����P�N�T1#��@-�aI�L�F~��tP���EUg�+�l�����|�`"b�"l�@��R��("T�RѪ U�;�F�[^��AҢ4�I�c9��2�.g�8]�Y�6jm���!JEQ1�"J�]�]���aӢ�_��_�}�O>�O�� %���`H�6[��l1�` `c���	,14C�)�0��(�������� ���#����;wNW��"5�ͧ��8W%��JE��d�6���T��#�5
*(D� u޺�����EzL$�Q�;�rg���UơIV�+���xL�2'5Phl�	L�!���GQ0�`"�YJmZ�֤\Nm,(��U����;� F)@�h:եJ�T(r�2u:E��C$l�O.��6X2Ҥ$3�0U�S.Z@��ӿ;�pP �a�0f\�]_���  �YJRp�]W (Q2�m��X8g֚h��YJd6��\�ޙ>>dQ�7�	�Q UhUVQ!WM}�
���jfM��㏯_?�C�emG\��\n#���f��X���x��Y�
F3c�o AAĈ�fȧ#���@�"J9u��]W_�*����~/oP�t\P�"��P���BE^�����N�����j��J�"b�K�T�'����tF
绊t��!wޠٴ>��kS��PIk�	��-(��H	�@�(e� (P��2�DM�
�ek��ɀ,6���O�����i�&�iT�� ���˖Ƥ(�p� �O�V�P�2� y>�: ���Lr(�\��峳�%��i`@�20���\]�Q#-ժ�U��RuU���G�g6ըF���&L��kV
�)������^�J=ѕ�ެ���B%�2IqqX$�(
�����?��H��O���m�&���E���0�N�,�&K�������X�Y�e06MA���	��H%�PA� ��B���|���((R�U����U\
" qIe��H���q�TI�*��B ����_���9ktW[םNu);;���|@���tWVm�X$a��ڰ�D*U��$t&E�(E��UT2�D��$2i��Q�ؠlSf���䄉۰����� �崵Y&T$�A0i]���}�
	�bb�N_��}�W�
�Z�*Klx��[l �9�؀��G��՗/���JU��DJ���=�pS'R��VX�04���)�ք�f,FY���vy�?��-$���q\Y�$��UQ2)�T�R�@��J-��4HA�.�}�u_>�h��l/����
0�EZl-��T�ZD6bd�3�-���� ���"U�%T-~���o�H; �D)�r"q�Hץ#U\Ֆe�j��39#��ՁTk���{��]9݌c1�FDT.�ժT�S�k��_����w��2]�%��+�*EIlF�k��}8�2�eL�fR��IbL!�JuT��J�* �m�Q�4a�X2�͛RC0�&!��w�S�ƒ6��.�)J �h��n)�Hu)@���K/ǣ�^3$bS]��}��TYQRh��&�f���fh�-����m�d^��]Q*
�H�](2��:"ƈZ�F�y�ڒ�7DL��1�r^�|>߯�ۗ�P/�b����eIQO�N��T�A�ټ�#$i��U2�	�Q~�Uhoaf��6ۼ&������@AwB��Ii��Bɣ�$E	 )JU��ED�
 �̮.(�i�H�o?�����"�R)�	��*6	��F.+)JS�{�ZY�P�Z9�*�y�;wv��.��������#=��\z��b*3��"�1�W��1��|u94�\��qU��D@��*Y%@B�������ʶ 6�:��Ў%4/�-_/?���J�d�زHM�*Z�Ī��^ެĄ�V0�ة
SYg���Ĉ��4�dt��$�mAcs)H��ͼ�]�nT�>��۹�UTb4��m���I��h��T��傡5����n;�����BŶ7����g�)d����� %�ĩ��X{6��
��� %E��.��O��u��f[lc���>�F��%B#A*T�[2��Qe�S����P!���D	�JU���+D9N��D�����׿�QDA�Q,P&Z�������=�"�*�BZ(�Pr��vu�Uٹ���)��,]=��ͷ�� ��BӬRX�J+���vu��dȡ�)Kr�֡��TZ �)�-664�Ȳ��x-��vS5�}�`�d	�@	�+	� �*e@���,(�.UШZ�ԙ	ծj�I"F�b4DR�Tp�����Ց���1M15ز��=���6Uo��������N�)lը5��a2�m�#֚���{ �۪��6B������q�QnOΥ�����p�l`Hf"�]Rt�@��K��Y$���������ؚ̋l� ���Sܮ=���{�v���Y�X�l�TC�r��aFLX" �I,PSJ��
�H�R"�"�(hPYvTH�d,/U�����'�������{�T����D���ﶺ۸����~�8�p":������|?t�']�+�ր���DP���[�A@@T�ZTI�T�\]��TUt" �כj3=���Ƙ�A��)��~?ޗ|���܇�ׇ�h�lZOqlN�#
Q)��*�*ii��T)1�ZJ��h� [l�7�ɚ��ifL!���r�����KH���~��46m�=�(΢�%N9��l#�0P��MH-�H�f���^�;�Ij�J�xzxzt�d��fov;:])]w�1;�	�X�NQ0�!J�Z�s9
�8]>����G���F3f�m1� �]{~I��3��EQM��q��x��B�@!�*�&JJeE
$�eYa�)*�V�!cڢ1�I���S�ܧן��^9H_�)k�P����Z}���~�nwݑpz,q�qҗU'�q�A*�o��U���'_�P���)��*�h)f��*�Fw\�"�Ri���$��%FI���&ۺ�p_����(�}�y���~�TӒ#c3�JEE���JRP��:�(�9$Dil2m����ld6o#c̦iLEWA���b �9���~��C���y�FHQ)Wu������l�4)E�Mլ�B�0�2��q���e������o�_f��H��"�[u{���D�w�%�d�5��v�m��MY�p�|)����N�>I�fZl���?}��f1���4X�1b  c�2���-aJ�����+�����
vI�H$�������#":���M^^D��"��ƶ(��t\}P�岫L�q1Uf�2Յ�˳t���n��Y�λ��W�H�.��6:����?
%&VRT���F���BuU����Y����TQ��t�� ��Hl�aA1��ŘR}x��0K�:�s��g}�������N�w���^۪-$�dbC/Uu�*W�FZՁ��� �@E��T��!1l�=�CP(Һ�Ͷ�l߉��ܡ ���	Ä=��bU�R��&Zb�*, ��*-��_���j�!�,�U)"[�&�O�٘2�ѐ)5�Nw�$)���~�ۅ��t��JR6:����Ȕ٦ll���;՗������k��t6����V����2ؖ�{�=<��J@TD	JF���\]���NR�B%��e]�1V��´	�ź@d%"�� �RE��iy@��eY�x�\���"9�ڔ��]F�&t�Թ���ٮ�՗�q�U!��ȥ�V�V)W�`� ��$U�:����;��˗��W%�iZ +2������ȉ�ɢi'j���ó>�Y���?z��5?���}��|�?�����������7�o�����{�\?�s�#?�G~�~R�AE*U��K�R*q6I���P!`F����
m�F�U�Z�ru�ل��R�"����"�j�h���*� ԑ*%H���g��}��5H �r0D�M����g W��Juc#ډ}��wӐYؔ$�Q�>��.���"[E�f@��*�\������Z��
B�.R
U ����bU��MeT8�*� iJ�6`�0���;�0g��"�"Ng�V�ܵ��Tw�>�k���.�6ն�[��jZ��A��H��24�e+d�Qڛ�VmTۘ�mƵ�rي��F�ڗ�J7��eZ��iC2d�*���R�x���f�iR��ѣ=}����ۿ���O������w�����}�?��n����=.�"��I�Ng�G6@�iՌ�i�l�ش�MAےF%ZE)�iYIm4&ҎN��,����k��r��)_�DF�HB5��M�L�._j�/QbdAf �RPV%����V�U��U�di̒v���^_����h
f-�� :����J�����FR�u�\.�m�rʒD[`L�l6$�@u�@ #�Ҕ�"aK��
AH
�A̪Y�����k [��b��\D���"��T9�"0�N*���˗��6}�Z�!�JG�MP���NG��Z�r�K������ r9�l#szsL��T���W�T)w�k�Z�*�)�ڔA�P���i+0e�U�C��Q$��mՌ���_�y�|�'�~�������'�(Qi��"�t�8ھz��@孉��Ո�,`[$�Q���%#$G�N	ob����XZv�d�â����]}��յtU��ԨHuEZb�hFa{Z뺧��*� �LD!4�U������BI�JI�Wb���O�h��W��L��I�f$T.($UK�D2QUQ� ��´����۟�6f�1i(IE9
�*�)�DYFJK2�V�   �ӏ�1iMH#��7�a�Ĉ8+#]�Q�@�}��z�U�I��vȁ����_���:�{�r(Csʁ����8Tu\����v��8#6��8d`�!Ć$ޒ�تY��:f�ւJ�S.QJ�JjW5��7�B	5�K��]�S�������o��R� �J%^f������?����'i����B�$�Y�R�e[�0�G�F&aL�b[��]*(	@�4�N5��Pk�r9 )�Z��iiFӵ��s�3���.�)��
@H����U���*.W�cF�M��ך3�MiL�X��$%�哪F�Ī>x���#?��������o�z���6vg�UUb[RG��P�%\
�`�ҊTq�NV�4clbob�	@�j M�(�K�UD���C��-��V��& Al���jVl.fA��Y`�E��nG�����/PuXA��uQ��ß>]�|/8#�:w�u�[�Ld6�Z�.�2����8��Sv�0�&���$;�1�{6޴ĺ������v�w:���Z.��V(�@llTHU�0�V�5����]�������63.����{�TfI�����G�L�Q�#�J��)#�H7:�1�ɤ���XmưI҈�*� Q�F��[�0a{(oqg�}H��֬}��b�/�U�˵S)�RR9L�L55c��G[+�VժO�D�l��֬(ʪa!`6��-RY�$��T�u�N�ܫs�w_��o_��~ǧ~�3�����g~=�N��u�VIq�@�P
�*�SB��$(�T���f�M
i��`�S�J�T�I��UHs5��X�Se�~t�4�գ�?��W����6�T�u�Rh&%RhV��VmZ�4Ν;�4it���8Á�_��珞�^��d���(��<����f�0�`M^9��b�5й� X���j��\ݳ�R�mJ�RuD&0����Q!�lU"b�ۛkN�r�k#KF ��}�?�܁{�����!T�D�`�6�%�(@74gc#�2W��PZ$S�)��2lI��F*X)'��LS�i���w�\+w�}T�T�PeDA����h�R�|��\];�ʢ��ll��tl3�m�F�� ԮJv�������;�=�;/���������w?����w���{�^�zζ�Aɒ��#)
45Eҥ�e		�ML2m[1@,��ŌQL��]\g+�I	P��rH� �DP ٘6e\�Pdbb3��`�0����rT_���Q�������v����s����R�]�S��=����&*qJ-.2$�N�#��J6116@��'Bƈ�$.;߉7ʖ���ʜMg�|��|W�ljW��5&0Y�Ąm����Mu�\	JYQ䎻����(1F�@���w4es�����D���-&S��V�M��Ԭ�)de�0�ʔ풮KP#VM�
c#�MYՑ�ӵMV1v�J��/w��w�����	��hQHD�����j�.W��J	��!c&ad�`���٬��k	��V�*�}�������ϼ�V-��廞�MR*���VJR#��C�+���cz�2���f�@2�`�M�v�:�ΐa�('M��P�J��"!r���ab
%Bl�a.�m#r�bʈ(�vQ��NI����P]���:j�%_��QC��X*���������o$,Yu)���m����2�qP��
@�P2LEg��"3Ե�3T*��T���R�.s�k�\�1`��2�;J*M��jb���]<.wܵ�1>6c�8���$Q{���(l�06VoeS� P��`Cm�m4fJK$�T� d��4KR�i[lжn�@����hWwj�˗����Ղ0؋�46�7?���FZI�M3�L��Yj �b(F�v�El�к��Va %�<|���<Tb�w=����D)L.��(aYLAJ�{�� j��xl�M��1�z�:��1$H��e`��.�|Ɓ�@�$�RͰ)�ӥ��81L��K�a$��Δ,՚���Eu,+��E�A�9���_;�j�(��Ta˲���tmx��.UQ�,˺�[��=+��ܠD�"��s �iv��r�ome(ru&*T*�Jo�Eu��E`����[������6]v�Kyu-�0�`��m����k^��t�����/��{��%5�5	��a4e��eec�ImY�ɓ��Y���e�/��_���*�fFM�2[XKZjF�Fcll��BY#hW��宸\:%�J�� �u!ӓ)4̋�>{�J��DI��N&�mI"�Pr�ĘDfk3]�*�TI->��P���V�*jQ�$I� c����F�lƂ�(m�Ƣ���	��ax��MO׻^W M��H�8Ȭ̺d�jVA��q0�� Q��Y,&�U���RHN��"��Āeʛ����mbꌮ���O�7�)�1��Q�B:�R�*�p���튰��LC	���U��4ƨjX���l���Hq�P�R*m��%��	�j����i�t�E�$�1h[5�ˮ���+��<�`��/��\����'�۷���t i&��]{CU��,�#����j�\����"�W~���x�� `H.�����7� �%�d��1fC~������S��׾�V]���7�%�U-�Ԧ�労��+�ԉ�j� `���Ȗ�f���e�D��TGU�TWUbJ��8y��HQ-U'TIťEL��
����`Y
��i,T*\�4 ,! f���X"@�B��B�
�4b L��TҐ& B���s�D� b`�AD��UH��L�L�7%D�ּ1+3��L\�0D���3.�)X�BW��;�V3��u�@y�+ىF@Co0�A}��/����U)�j���ȥ2��	�I�T�ʭ����r�QE.
X@Ǆm�6��zs�S ��2�{���/���Zٺ��g:��^K�M����O��4Y+)`�գ9iA*eBU��Y����*F�V�Ylcm��}�����q_��&J)?>�ˡ��uu7
�3�T�RIj�AB��"iN�*E����60cc6���eŖâa!Wǵ(U�� 4�m0Y��%Tq�J+)���&��EuUU{���z>�`���可η+����U����JU����
�j)R��4"FRBIAU���H��& ���ء�Di�M��r��A"�:-�\z����h��RR������%%�Q�ΰ7��o��&.Jpv��m6�f��=/��h�LeQ�Vw^b��*���4D�|��__:]�]]R'i�E��֝A����=�{�c�媖Ej�4Z����\�IE��V%3�J�H�����Y���I*�e&PE�f�1��1�)i���@�J-��6�X32L�˵��^��E���w��v��!q	 ���#FYdMHŪF�j�Ա�/?�.!��6�f¶昱-ۉ�mJ3�T�J����������s%D�USJ9���%l
�JT)�	_�{`-����?���_���+VTaUU��ԁ���rE����O���"P�
�C�
c�@	��l��\�� �0���AH��Қ @L�DH)%�Zu�<�_""(qGz:?U��`[l�l�65٘A\5�o��?�s?�=o�{^VA㖚�A�,�fTqS`�o������6����]�	���UPkm��A3�����|�j=պ.��ʥ@�lHچ1�ꬵy��d�E���L���k:�.��w�P8��DK�hq�F0�̶i�0��FA��U�jb�XFMr�vWU�C�r׏ۗr?���r�16i��*"����B(IIi2�e���I�f�Ɩذ,-c�V�.$�%]�JER$S��'�V�R!KB�.���&V*VTI������ܟ������ �%E�J9j���KHH׉r  �ʵT*�ԨbH�h6��!Uܩ~� ��� ��i���@��#)% 9�\HDd!���R�]f0��,b2P�%L�N�/������?{�j��%h�V�td)ƛ�qh���]��N�V�(�;��EBu9�J��vmS��V�$��.w�S>������õ�.�DX�.fTl��mc��MP��~��$���e����Y.��Z��
75��L�Q{�Ԧ��0�PWIlK�D���ebź�^��˩����>\.����d31mK�i���&*KT+� U��DȀm�܀�`LC6c�1�=٤@T�s$�BQ(,�%BŨ�tPPRI#Ф�E�@�F��&F�IA��BeR�T�+Jq�$Āġ���vL���cm+p��W�(0e��Ve0<L�����|�UŬ�R6$�Z׫�(!I�HADG�%&����i"+H5*�N0����N�mu�����޸�{��m�PFXz�a� ވ�wⓑ�$m���5�ȝR"���f��,=�H��`L���\��k��?�����.�e�L�Rm�m��ڼ٣)��T�����(��f�T�v��V���R�҈����y�k��aԨj iX҉.U���A�:�/�g��/����X�XL�����M���2LoB�@3
Js�T*����TR	��J
2�,��������_�݈�]RiU��\�`��IK�
KJ�����R�( U�(D�E
�#(���m�Ƙ�*�]��Z!��	1�(�%$�4�`l)�		<F�`b���j�+0�0SL����?�����'v��Ғ���"��щ0�B��<�8���\E̔�1���#���yo�S�����VPg�"��a�]�tk��*���ҹ�Zq�� "1!�$�QH�����&�3��#0�)1ض�k��@�dd��84�`W�-E6�4G�h)�l�Ed��bf+�ȬM��Zb)b��*"�%[B�0�*_����_��(W��"S�I��)��@�U���KaA�U���(�	Y�l'�l`�*��8"6c/���=&y[WU�J�=�7]�V�TW�*���T��R�"ɬ
dUT)�����`�����ؼ����Ԍ-cQ��Q��H�(HZ���ec�-�D	)����f ��b��!��*��R��}z��s@�V%��8��U�-����K	���^mo6`�1�Q�V���w�Eo���wO�Y��SO�'�,�㑇fT�^u�rU�θk����7���(z�u�+�1{�pE��(4szYJg�۪�Ϊ�j��U5Ձ�J:���wm�l#bժ�m& �\�(�WK2lT#�T[5+�!m�l�z��6Le��DɒD�>���4�mT�]�s����ѵ��Ee3̘�B)(j%� ��U����"�f��4� [̰u��m������U�����:���x�m*Q@ejb�"���T*$TZJU��L�*�m���֚[3i��7ӗmlFU�;�����l+�x�M���X".M����q
 H�f�161 &�T3UvI3s1���>}�9էrU�V�����RT<�����]ߧN?_?�Y�ݖn���'Ϗ�	YUfo�� d��ҷʗ��Ǟ�;/lFSv�O��_����)R-e��]��'/��K��z���ٟ~כ�����0��R���!�F��J�&�D�@��%������/�����My�G9�{��Y���Il0�MF�洰G\@�)+�&��je�,�c��I�$UI�!�
0�ܖ��
�N���*Gh�r�#Ֆ��lbVb���&I�R��D�D��k!ǥR��̰���EZ��0���������'�?X͢����Fl]ML*�lS�)G*��!V�h6��N�'��5THb����J��+��K)���7�^�7�Kt�ν���S�*@L5�Kc��_��������5�L`B��Qt"�љJ���H����>�ǲ�X��ߦ���]_�����K@�ʐ��>�������;��}����o���޷~����݇�ۻ����^�}��X'���������o��������<t��EzŉAo�8KY�L�!��7�9�)WXi'�l���ԡ�VQ"V߹��|�}����;��ɳ��k<�������1B�M�̯}�7�����\{�\"(�0YF*k�b15z�B�hkH�&{�T�"�l��ԥ��]�`ɗ�6eNoB<^ -hSL����iI��*]ٰR-ZEI�cʖI&Md�Cˤ-�6fN����#�TA�T��!(W-�4K�j�A�X�\D�j��6V�
���Yb*U��HU�j�
�"P�(��cSL��U��bbS�ե�����`b��0`���$@
�:�#}�V�TՑ��#|��?>�_�e.I��̪r�N9�:�K�����������W_���������K����~���������=���svj������q��y��e��
.����]�%o6{���%*͔��gj�.m*3SM"a�T��ʥ65�w[�'�0�64C6�6�)���H���_%�01 �QL��6�i�a1���$`�lL����K\���%G7�4�d�75�fĦ����ɨ�ɦ�lE�J��Z���Z�@�P&�
i�@�j��JeW��Z�g�k+ ��� E��*�<�PC�j�H��6C�E��
�x3@$CڪC���0�VF��� ��Tj�20d#il0VhC�|�I��PZf�	h�/��n&lBH
v�>݉PLE���az<�KI��H)%�Z��(���I�=k}��ҫ_|�����>�O����������_�	m�f2�� w\�^:��Yں69T-�t����Z�(�CLQ�<�)�������t�Zj&)��ʜQ�M.7?�Ѽj�lB�m�4�2��`s�w����Ͽz"C`�(�G�I��<5��(K�X}r��X�7ƌǆm��S:_K��5+K褋�����i�BfJ�f�>��tUA+�JcZA%�&��&0�+�L3��e���o��M[5[���D�izʈMEņ�b,�&AZ2%��`a�C*@�R�L�
��JkQP�A�j�b�d%�6�FHĈ%c�b�ꬤ�X��`A�@b�3�Mq'��vU�Je�T;��-W��JdGhkپ�SKme�42z��*�*�ƛ��;o?�����҇�gW�My2����ts�{��|�R);��7�?~Iw��R�Z��mLh:���P.(Ku�<]}�λ��۪�K�t+jH�L�8��Ǐ�&q�ؤm1V#�y&3�E�[^����w�}���e�lb��A��l��"���G�,(P�
/�/�fK6)I"P�\��q�䫛x��aS,����-S��F��ۊ��5�D�HJ+D���t��"*�%���KϿ39�ax e�J�l����H��DĆ��J(a��Ӟ)!V5$�<@�lj��B5������* -�!BSV	KD�� 6�)ĸt�Q� &$�ԭIbZK�V��$ib̌� &N::Q�`���Y.��/�RZUUtI���\��9|��#�w��U]�q��c�=�y�=�r�8O�_����}����
e>�n�����t��K�����p��N�ԩ��$�a��N*���C��$�3J�ݺ\e�Җ�t%e,�
�b�ش)�l�4�Q��������@�FHK�9�f�hz⡲Ӵ��Z���}��1V�!	RJ���J'�(�J�l,[��d�����@25ʙ�"�W���/�*�LU����|U�K��J�04`c3�Q�6����e�٬�l�Ji�AU�
U,4$�P����,��r������$)�� ��XSHKz�r����$�B��̐P��R;���M�G^n
� D.��UF� ��X�Z0�M�fa�1:�*U�UPH**�r�x�J��(,��厶o������ 3*�r)ZV�~������N�ض�l���o�M��g���on�zq��A.����ή���zQW՝������:��s�T��KT���H�r+w���]��"B�5U�ί�+�~`��E�˖�&`B7��,)` ��ʘl�µ���2�oS�h53<��/c��$eJ���I����"�mU�$M����-�P��
ږ��U��U�N�R�ꋫ��=�}q�7?O%�M���P�ɶ�e#����.���/<�6�VC���F'PHLJ�(0e������J��&��tCuR*�J�Ǧ�T�@����P�_N�\U��9�P K哒��bK$wU�T%16(#�:S�6�i�Y���A8�.U�$�*UFUQ��@�M�TV�4�k��{���,g�X��5E�!�L�6�W���cnR=���}�ӿ�_�D]kw)W��θ攎�Hg��*WN�r��\��2�#F�s'\�E���Υ|�AeW��V��eQ��C6��Ҋl��]&�lW�06B�،���"��FCp-3m�2 �I�o�4`J��Ċ����܇c�]R�*P䠞&�,i5i��ؖ4��3V�J��R���V�K�T��r 4i�+��=�c����Ęm��
r��)����9��J ��M��RS���E�ͪ*w�W�,�������K�Т E&�*SS��E�FaKK�)#��%�bm2e�b�����_�wϿ�TK#Kx��cL�H�`��&����ZGDidU�
!��EV�W���R6�1������M�Ǜ�u�`��=/if�Ш�*ݼ�ĝU�J�NW����I].W�NO�i�#.�-�`�v�:�����8�K�s����,wv��.��)rQmK,e3�h�����o�Yk�A��]��U�ɗ���� N�͞
 &d�jk j����#�6�QQ`�P�� !��rU�K���gG�^(��6-�f�V<U7�E��$�TQR34"XWQ�%wU5%��d�u �� ��ힶm�������HMhU��$S�RFr�+�0wiS�F!*�MݺrUݵ���?����o�&0bMER,���\UQ�
���`)�0bBV� ��K�RE�J��Զ�&F#�����b
 �0�mb*���Z%���2Uʩt$�d#$9�E[���e�Ҵ��ٶu:ݶ����c۔%�a���6��T�;��a�#;��yu�BVǉ�=�<}WwT=��U��V�m�Ħ�U���]�������>x�*�e�s�M��2��H�����L�.w��.���?4��a3h��_?�����Զ�bа�	�� ���턘�(��X����Kە���B׺]S)ӧK�/�,�� ,Aj�-�H�Œ��Y'��*������r|�ҩ
�Lو�ؠi�����*TZ����b
�(AP �̨j\E��j(���J�)���*�P��%�T� ��%�*�*e	�*AJ�����"T��Ɗa
P.������!  �:�؅P��%���Ɉݡ=�x+�TK���RjD�
J��Hfk�2R�����x~m�k�:�jW��{����S��>~���n�ʞ���6h�յWʵ�ݹ�����|=W-�^�+�������=^{k����-w��]�Nu�b�06�����{�iv%ª"&�jA�7e*��ykK�\o����Cp�l���ҰY��f��ni،%P(˙��!�A��!#�(�-� ��\�r9.�V.�?|s��2�R�=�D̚��YU�D�O.^�D)ؽ���&餮J)i��@a�[ll6�Fu��6�mX���%�R�!�Uf�PL3�QJ��Ƀ�3I7�\�ڔd�$CT�(H��i�䔩��R���c�.�01d,%�.U9�Ho��TYZ3�R�\ݖ�IL�qlfeC(����(�wi��#gVy̦,2W���/)Q�/��z�y3�X���i���׌͌���izK^y�U#%"�����xUǑ��T\U��>t�{�\c�x�F��]�]���ӗ����Ԫ{�n����ꔫ�]o�����{�G2L �.O3�[��l4���#6�V	`Q�mf6o� ka,�`���t��O�d`cc,�3��U��Ծ�jWw��4f}�*}���� ���L��J�Ć����y/��ZU]���J���D����-%m�m�6l�F���J��*m
�;�JΐZ����L�Y?�Ay����9�SEE$2h �D��(�S��
��+��DR�4l��qI�˥��K�J��Tbp��J�r�(Ō��`#mը�{hyY�\9rT�fYDb��R��Rp7m����fl`��f�����ѭ<'�)���F�Qw<���k�ϑ� c˵T]��qG��*U���[% ?��;w.ѹ\ݭsu���8w9(�V����l��7��o��	�3�F�m[��\6�莛M3�����`�:P�;��ӶgO̎a�l^�����vb�Vkt��"�\��\].�vu��;wu����4ɺ�OW�V1$�+j��M[f�,1i2A
W()�)wU�QQ�r�D�����k/�јm6�,���[_�A�]�.����b4KWP��QP��A٪�#ϕU�&�r���	ȥ��ITL�.��=�b�D
VDl*dS����]_�S)�JA�*ec
-���;��` �l�\ʥ\61��(QL�*E�f�"i)V,�i�[�V�ڶm��M��ֱ'����ޤk�m�Kŕk&�HIw��n�P<��n��N7�m��O����O����厞����?��?�M����|������������҉/Η�t:��Y������/���*���[C�� ��_�魲em��3e��ضe6f,�Uj��{Ċi����d����ڰ�Ķ},�"�ؘ�ۤmª�Y�S��-��]�i�hv*��کXʦC$�@R
��diVl"	U���\��\.��J�jPV5��K1�nK���gk[��`����{��"�i�@����� ����
		�ʊ���N�
�*�Du@�t����:C��tM!&�!Fls5�2(�bb@ՀK�Ą�ru�
�$@BUQeF�9�|�\�41�&�a$e|���L4W�R
�E��C������۟ɲ�J��LT#k՝;췾-	,��!CX{�k{�c�����ܹ��NM�5���/����g~kuz(=t�;r\-���o���ϲptuM��u��~�w��������>�G[�d
u��el�*��ͯz��?��[gØi`�m��}f��l��0CMeʰ�l���ef[�h���z��� �x����i���i�l�ƀ)[l���-U�5*�ܩ�.U��U`��v�CW��>Ce�P�(��cd	��h�cي��� H��KU�.�R.��IE�����44D�%l3��lR-���
0�`���UHA)��)A51��,U��(W�#"S��|��V���2��" V@��U��\�+���v����	)�:(C  I;u�s�s�����%1�T�"$J6F6��b������d���j1�NxH��N�ll7k4��׳�x�0k�ǝ{�R\$o��k?��O����Ͽ�z�^���)ݜ"=L�R=P�V�+�S��/~�o��ү����_�������C�z�z�y9�/|�����V�����ˣ�A�J�{����o��?��7S
��9�M�1Ă2� -ݡ�v�P�����D��S��Q�K�����}7o}���'�Y5��x<���Y���U�r�����Zչ��w.ߡ;%]�	�f�X��d�K0��`o�H���v�K�F�\�]�յ�r���R]	��j'٦J�`a���LBUR����R�T�K1�D��  �tJ"s
�EeII%E������sʗKR�D9;&�D�Je)�]}�
@U�*"��Cy:���J@�����J���R����|'�ڀ'&v)(����ek��f��U��Ҙm][e�����;K)׺��t*���>�Ul̩+b[��֯�b�:
���r�*M5U�;��ɯ�/��=:�;�t��w�k'G�in�>�o������~�g�������˳�M��~�����//��y_��(�!R@��fOo���%��1k�}�邮�֢�P�~��k*Ե]Q�Ī;���=�\?O?�:�S�hz�~��6�dJ��W)�M�\�4xH�k��-�vWF��d�Q�K�%�R9��ehB�5Z�q(�ґ�@IUYQq�R.��]W��U���$YT�r����2Z����d�-FlJ��s��՗(�ixC!0��ꋢi@H*��Y�J���t}�;w�˥	���*,	�.|�qϏ�Q%4AQPZWYI�P�j%jQ%fA(M�t�e��nՏV}�s�b�1�͝t��T#F�R�6��N�lL�MMi�*++]�UѠ�N�;W}��j���ז7�kFZ�t��݄J	ԨV:�=��K~=$J�r��C]�*V�Tl������ͳ1���*�.�.�z��Eޘi+�����cZF�����f=BPL�Ϲ9*�q�*�ꪔ;���;�AW���{����-/���}��{�?�d���^f��0B ��V�a[as���h&V۞��Fφ�⣀A��UQ�g��y]!I\hl�i�`L X��C�4��]���A��JU�r\�TѮ�ܩ����U�:.r'⸺��6[Q!� &�	��
����r��@��"����ՑUH]��dU%�R�S>]}���r)�U  Aˠ���T"$�dL$�U�ꦪeD��H��|��])AQ���X�U���r�R�(fCL.�eS6� �*�0�Bۊ��� *de�ª�(\4Z.��A7oޭjP��[���y#c<�n�����N�R��Nhw�T.w
���S���5B��H���7�g�{{��6����H�jU�zo�>��Q[M��=<m0PF�^ޤ��T��[i�!�ٕ%I��)���K�B�\ݣ���=]}u���=ۯz��=�{{��f佻� ��+i��!��U�����=O{b�s96��|����MRJ������`6����N�r�\�S�RJ�T: ���B�hҪ����NY�%r)]Չ�"�&�
3�IBJ�s��;W_��j�0SA�]we��L���JE��t��;w��G~�o�3lP�*"I����R��R@q:�c�T�i�b^��D2��*3UVU�Le]q�\�;��)9 �(M1w�0���2�d�ZŚ�T����U2;	��:?s�;U�&�8�����qe�Ť��+�B�*%�wu��)���9[Iձ��ө"��*��=ރ����}�>�zai���-�2��^A2�ꇿ��x��z� ��{l�A���J:K��p��@��+u��t�� u}����?��?|���a�����6�o���=SD@4�	�Z�ɶP��6[(�%��V]���Z����
�bH��Iǧ�G�[���" TWQRZ"�
�JE���LI��b�B�u����:��@��Y��;�Ru�K\%b���iC��>A�I�(� �K���G_�"ͲV���J*���.�Ua<��
Vш

RV+�)H�
�1,"F���#_��QEAlj}y���� �-I�V1#f�c_��ǯ_eD�T���a��Jݹg�d�]��j0�
���1�D�]�;�2UB�~N�ᔟT�F�{����]R�R]`�2��[����l�?�+?z?6�ɐ���<S�Z['����?�m_�?eS`y�6)a#o�]ݖ�Y.#F�����V�\��=�=���R���z������}��_�-���B5��>#`�]eu�;�۬�FLض6��k*br�\��m]�;�asƚ���
JUʝk?�cl��J ��ʊm2M�Z�`TSɄ�@Ҵ�E4�R�rW:!@&M%]�RWQ���FOC,�	��i�$N'�R´�zz�$���HU`�`DRC��U)`R
z�	����jy#/�T�DD�*�f�e� J9];1���������1Hb�m�ʪ;����Lf6ft��Vg|�4��n�T���Sy�����i�Un]ޤ��ِN9	ծ��{\����W�q�K�d���x]:�r��s�x���G{6��9�������-�=�՚2�u3�e�e��x�M~&��]�uǸ�C:�Ki�-C�$w�S���m/��^��K��k�������l� s�b��S];I��
̶m M��FSgw���$Q�l��l3�PS��,+�V�k��q�Ӷj�
��"1��lc+ �@��1��j��YjR��r�\��(hX���*��Uʮ��w]�d*hbU�TJU���J%X4�y�Y��i�2�  ǖ�޽���ڗB*��T��U1	A-�@*�ղzy�Y&�ȂE�,o�O^�ț�H��%����6@1�]�jW���Fo�2TL@�jH��@]gwů����kkC1m�c�'�~>��^VEr�UW�����=ȕUkw9!���˒=�kdOo�=���x��������9��)oζ�e���MIDy#y`\�* � �|�!	o�U+%��T����O}�}+����ܶ�7�+�,E��(p)*��)�6+,IlbcfS1gF��\��Q�+�a�5�dc��Ύ�vֵӹsiˌ��0�L�aM���e3�s�H�(M�M�M�F��e�*��.�"(D)��JS�N�t:?�cB��5��N��L�J���"�����%� Є�b_~���=?B tII
�ʪT�4aL@UJ�Z��j,�qF6f�,o�JmN"bRa@��\�c+�H�D�c]+����M`����U5 ��!�Uƛ�%6ق9�h-��e_=�T�"��]ºzܹ�sG�\:r�����o��ۿ��[z�b1�b����im����}����a
��r1E�������I�q���N�*bl-�hZl�&7$lޤm�m�z���r�|��RS����Gm��'F�h-02c�M�&�[
F���bS�ABEd m���>�݇;�E��T�n�7[��F�oY�,e����B[D�)����T�JG�JVA�B�.'��N��J��r5A,CD�su9��LbT.i+fD��!���UEW�ʪ� URlհ�U�l��W'�Z6j�(	��,�t��N_����Y1ȉ�6Pg�5�+f
J�UgHR�B@F��H#۱�\�]��܇Zut�Z&��!�5�f�:�����)]�/]�O�"��tE���j�ʾ���C7�^�{�Zd����f�F���lZc�9SX:�ΤUάU�b�P�Jw:�(! ���Β㴡M��M()`e�ֆ��a{���Uj�T�֩���b�	�f/l��0
�A&6fɒ�3�\C��Y�bkBL[�:�-0�P+��8.߹v-�P4����*�5fP=Q�az6ٖ�Ԓ��QT�"�4��T��;r����rTW_��
 H�k�R
L*E�*�BŦ�ifT�U�@)5RQM�@jW��4�D"W@9�K���*�5^-�1$ED��8Nq����@,Q�Z�meC��`��"i�T��6JIl�2�U6eFg�MR.0L�Stbm+Sa���֊G I���֫�ʵ���p>�B�+��n]r�/o��zT����l�ٴ����H�H%��E���Mڈ�G=��G.��M�dV�*�6l�Р�o&�i�����-��wP�Z`�ʪ���-�1�116K�Zu��0�R�`SlW ����	Ĥ�R�>;C,Ց�+�V���"@����X��f��7�ж�D�	H��Z��*	�]������NTpIt]���KU(k���T��E�UMZ��5�b�(�E.E
R�Ue*���8�4�J
4Q|��W�N�rYm^��(%E�!�1p8�8�(Qي�l�!�2�ۊ�l%
)�6ǲdW#��MF6�Q��5 m:J�}�F�o��Nƒ�aoE�T%ݭ��B.]w<:׺�q�j]ǝ�;%b12
b��ֶb�մV#(QJs����r��+��yؠkg��T�
𦱚��������=#fo1[7ccٜ"Qe�IKSU`kSM��{[����)�r����T�؄ � �C�LA�vUEF�*�*���~�w��>1�MrUUJ�Qm���֌ ��dN�iQWW!�Y���w}��]钨0]�:S�;�uJ4�i%���	J���ڒM���RNq�Uu��U*���� W?9� U�r���-�E �HDH��t$P�(�$a[�Z��$0�9�f%�������oV�&�	��e��jdDVV�����L^�{�V�f4��0�PY��*W׮.w��O����R�._z���K�i���B*���\m����ڃ&��J��� �H.SM&�L�Du)UzU��0��f�0` c�X��1��ڛ
�vI�]( �bE!�Nc�?<�� m	Z�4�-!#D��v� 6�	F��Z�Ώ/�cB���@�苫������ȩJS�V�$lhR)UݦRm�Q���VՐR��j_���(�ŦTU�\���/��$[Ve�i�*�il�4l�D���P���D����%"�{���%B�人���}�Q�:廾�gި�RG"" ^^���+!�j�1��l� 0IK�JKJ�ڦ��d�Y�Y���K����r7e���T��Ķ�ѣ��PS)�(���]ǝr�˗�ɗ�k�.ֵ��)eiEʝ�-���a֫�Qs�F`��%6�N�G��F��C��E��JSR�l1�ȶ��*�$Ձ�%��Pb�i��ؔ�A�JN���Z�`֙¶CQ����糿scP&USF�v��[�ZT��ɥTRe���Q�Hri��n���`����������$U� z��A�ئeư0E*�Ri���:ʩ�$D�)��NbW6M��	h4�M�-�6�"��QQ��VG���ث	P嚺�:���U�r��*wN*��>��(�(�``SD�M`b!��X*l  TK_K�B�x�A��dsm_�����1g
��}t��hS!��Қe=;�5JCT�NUSwi?�S.w�v��ӵ�=��S�.A�I7B@H�T��
�W=i���n�G�pz3D�=�8�f8,�(b�:& 
�E�ů>��?��σ�x4���S�.
Y�de��Mo�*���d���穹su�J��Z%���������9�}�M,�r�mK H��dӬ�� �YdQ+w��E�Ej� 2VU��H}z�7�	˕&IHe�D(_�BE����ٖ5`����fP%B&�P�JU�.�
�D�4$
K�FHj��D�7DӬ�xd�mҦj,��4�RRudiԪ�J�0Y�N�T]�!u�N��%
Q���8R� "p)�X��ЌM�b[j���㥯�?S��7iԊ�!#�ꍘ��B�O�w;aϦ�j$GH˴f˦���\�Q]����	�����xU
}�|)�
�J0!A��Ĵ��U�GϾ|yŞ�cz8E�XD�("P�d@�M�:�������f� HU�TG��b&&Cc�Ֆ`D��TN�i�M�ʕ��VV�R}M�rh)b4#F�`
۫Ѧr0�YLAJ������Y�K���@&���V- C)iU�*�UK�ԕ�R�#�x��43��xϷ��^�MPM��%IwL��K���*U�RU;�b���7��̴"�&@�ȿ�����ڑ��t.WW�TuUJEV,X����R��R(�AQɝ�(�e!MdوBF�[�mP٪�)i��%X([��T��VJ*c�L��`��cw}���g�����$Ԫ/�%���˽U$�vU��˭���t�/�n_��3I�Uu�&V(�"Q 0���	<����=��XP��x.e�$&��&��(r��{j�P��(UU���v��7޴�@��V��4 ��U�V��!���,W��*9SFJ\Xi<4 `��T���*("+��UV�hK�(ܟ����Uga����PKA
�KD��5���7�{ym�����fz̶����nHYG	EԪ4զR�l"Q�T%Tm��ϖxk��ĦA"U?����y=? �D)��QJh��("E(�r:�C�""�X�)K	i�i�����[V�	���x_�~����
1�RM��h���@#�v%�Ν�m=�����ɯ3*�rWJ����f+&�wߧW��]r�s��'vt��:�w�(����*��t�[Li�,eyZ�`�Q,�O�&��#E���QK���l<�G�����鍔�%61ĺ��~����f�s+F��w?_\~�S�R݅R�`@Q��\չ��{j���I��-��m��`i��0l���8ʥT%#j�Z R�ˡ��1%��(-UQ�HS��ID
�UPh+HP�@��P��r�"��U%��@�*sa�V�P�(1C�� ҦM�)S�
b�:���
D�N��������Q@i�H4@��*B%B���4�(��?����/�%�
��bb!#6a�b�!�;^�V�+@2�H3_������2���u�ʯ}�7���kR�/�[�Hj~��w>wW��g�8��X.��W�o_�WNU��긩�w�T�uQu�4`Yu�[4��,��I�1{��V��	5�)"P��)���I���4oh�=���NR���+6�v3�J��F���q?z����H��*�!0W�����$����MbK�0۶���̒�F�fӶ�DeP���M�Z0[�!��T*�[H��B���Y�(�Z��@�`�$QE�R�U��UF�i)bUU��"Y����*��TB` �$ANR> �㮮>����GP �D	R%
���*J,HG�T� ����G�_V����Ka(R���
�um�FȰ�Qht�ŦQ+��D������T����j��ݪn��F?�#m���c_:�ޜ:��CΖ�V�\�r%��K�g��$ߡ�U��i��0V%+����Yc�,#c�}�؉c�dYm^���0V�DcPar5�1�@F�f��G���T3a,l:�6��ê��z]Iu���"֩V,)�Vu�h��uAlR펺D��M�)؀9�,����mkO�@ ��
�E�YU���]l�R�R!L��`��JT�Ҕ�f�J�RA�tJ,MQ�$F��*E�]]�*�.IU��l6�0�Rc��E�T� %�@R����NW������z=����;��՗#
��FRŪ)��-�&� E:(⬢�>�$	��$�*�j֬�A0l�T��kM�QE0�T��� t6�# ���]52۶L�`�r��2��ts���+�C�*AR��w��������Ɨε�vIa�ӶK�Q���l��i޳g/�u���H}���V�&*�4Q�02�lb�%��)�H)����xJ���L]�����U�rM��Ve')h�%J���� I&H�*a0� s��6kc6��&�((�Ț�T4�`J�`x�����MZ����*P��T�UT'J��LL��K�")I��s��t)��j��Z$���$UU$EԔ�U]�ց�R���~��ត�R�*�\�R�XRUQ12T���@B�#wVG�R�"�*[�$#��a�\l�6�i[��V5����-,�}�Q���s��+_��>��ӹc��a���h�|�.����B�R-![i*�����w}�r����0�T!e1�Mo�f��{5�L���a&8M�1�G�}�b�2I)Q"�,�ql�;Ø��v��8�8"3O�3e�S�:*���"�V3"uY�*%���M�In�k|���TXDT��P(0�3���� ���zkV3̢۫P�"�������� �&��)���4SUw]�M]BU�I#R�M��ĴR�.�)���s�N�B+$"2j�*;��J��n�Ա�+�R�(9�
	�(%
$��(q�"��T1�Ta,Q�I�,QR�)(S&��4@�r@�����--��͊�H.�<$�;e��R��>�Fr	ۘ 5چ�n �R�s)�����u q��n鮤�NV���T���m�Eޙ��j6���S����i�S(M6��%��P�T���P�	Ȧ���2����c�З;Յ$�;ԭJ��ٴ*�)���(,#�H��NUMY�V@R��TF&��U�+V��,���Z���m��6?�������L 
��6��\�a��E���fb�XM�d�A����U���ډ!QXن�J(Vd$Q�RIJ��R����gU�UJS�JQJIj��\���H���(�J%�p$�D�Ku��(XED� ��������2��h����\J�e�p���� ��jjI�L�)������֘�bf�)giS�R�����;a]wJϣ��2L6mb	d/W�R����J@5��F�����J���,��i�:�抩�Z{az�/�`��n�E;�����o|4�*#:i�  �P�` �!obV܊e)�xx��Q˸$�sՈA�ږ��R���ԝB6( ����IB`D���R�M�y��U�R� ۆ0���J� �m��1��L6 6�I%i�@�M��	cD�"�!�\��R�D�ӠUQUEJ�1Ւj)A�-�,��r9�V���H�fe*��A�(,%�r�R*�$�@EU�# ��ʐ�ʥ����V	U5�#�,-YW9��H8BSP!��%�$!BX�U�bU\L�m҂�d�L1�1��-V(+U�vW�q��T��Ĉ��rF��?���M}�pվC������
_�Kuֿ�����y����N��JYu�2Q���(�fi@�"�&D�u�Z�o}�������?�Zl�PǵX���-�0N ]P����H{�IG�)?k�⒢ �U	�B�ζ�\*�U��K�'��F�B��B�1&XE�ƺIU��h��65�ZI���\m���i{9bA؂�-� ^��-���� �؛�BM��� UG�%U�@�Z	Km��*��*�a"�JE ��Ec6m�T�R�� R+��L"� �DR���T��S��\�(U����D1E� Q$��,U�*T�PՑJ)�e@i*�[�2�%X�ZVεĨDl�6
F�]Pf2Z�|q�ߪ��r�
`[�0W[�`Y��4�Ze��zu�Z�k�����'�oԅ�u����C�r���:[�PPh@��"S0T��%���?�r�@b�fs��JkW��˝a "#F�Ve���Ev�.��H����VQ)Z*�ڒ$�����M�XLRPI��4�l�B�A�V��&H�i�I���5
���~���_�؆����d�(qL��mc�	l�m)R��(u�T"�TuZuTUK�T��JB0U�62&�����?����V@�����6�1A� ��%P
�J�ȭ�V��������D �`�3��Pk]*�AZ�0AЪ=D�Q!��TR���lɲ,�%J*6�4$�1�1�!�����ؗJ�[�Ye0��M5Ś͛j��U�TԄBP��������ɶ�b��]��#Ub�Th����!`1�)�&b�62��5�64��\mfr�.WL�d&9.c��ld*R��)f��e)]e��	!�D���.��jU��*L<
|���."Ylݔ)hI12j�Bb[���2l��\�U��M����7��$�r�*YQ�1cm��xF�	�
��V�l�������VT�.V��Lc��!�w�����v�K����jU�W�^O���}��>I[[���Ȕ�J��*��Rʠ��d�TA��N����彾g	��$
(����DSFJ�J�Ǣm�i�PJDJ�5�2BbTk�Y^�6�,��B�C�;��F@���r��r?��"�V}������L�=֘� "a�jw95,EՒ�R6�`��W��F
.�VU��2�H Ј� �����_����/7ko�Ո
[�VX�p�5skT���*��.\ ��YJ�.V:�q6w4+61�l�ĪP�LE�r�B*��4����_?z:�B�L�(*����λA�.�t�m*VE��#���7>~�����lVɰIX���^��٩����V�T_;�"Z5�6{<�����jM�����*\w�(����*+�Uۨ�`�"!*Jy=����[)Wik�fk�,U����o������~�fl������2�a$�*Jڒ���UeTa��D��U���^�De:,mA����d����b
� ����Ͽ���K�N��I6I&�VͶ*%�7jm��U�l�l�V�*�ɨ0��좾ԮP�:�撽��M	�`���l�v��U.l�q��fii+Sh��4�k����siV`�x�J
%���@	��M���~��O��������6�+�5φ�=I�t�A�o0p���`sy9B������R�k�gX��!bUeS�+� �U� �|�X�I$[e"��xܗNW��\J�B���Ĩ�b[�`�`�ja��̟��L6�KU�˖0�c �yK�V*]�R*�K��TL�6m�0JSD��͘lUHQ�d���[G+���l��C3��;����Qkz��b�BQ��T@iF�� �&S��*MtI �$ ��l�ƴ:j�iZ �Bi�`��^�8����jk�d�ز`�d��f�D ���0KZ*� �Թ��r�J��V^"a�1�Ҷf�1ٞ�s�C�u�����U�.��V*EC#J,�:�AD˥�V����Bk��n�4V��������i��lo	�imh���rDY��@i�lDL�TV���%Sq�&6J���F�R�PJ�m���UQK�R_���\R�j��*IfT�ɂf&�2Ř5���=3��0XT6h]Յp��U ��da���, %9�J:*uOuR@�U��H74%�RU#A`HH�*�Th�II���<�������7��߇}u>������$UQ�T��"(�Z�V�"R@H�Ґ� ������&{+*Wa��("
%H�B:����u��2d����B�`Di��̲v��b���I,I�;w��յ��l��V��m�m��M���;ٝG$i��fʤ��&ۢ	�J��b��[6��O&A@,��^��#�n���X�͕�fy���%v5x�N(�(cӠ�"%�Ĭm��,�` M�1��bՈj ��dB!-���I�*)�إ	����?�~�U���J���b bb�fe��?}������lC��+Mu�����:T����}��H k��21�ꨥ˅��.�@$���"U�$@KTJ䒤*��1�[o۲����}���`_�{{Ky;�r<�8	�����M��� ��H�$e�PIUQ���&}��^c�x1�)&�M��Ĭ�\}m$�z}�!�zy��,�����g&����X��eA Ŗ�-����%LYVE��s����l.#j+�2c3o1;����j4k�����2��f���֝)�����zc[YUl����b�l"vLcC[5��1������1=��b ��t݌�>@S��,c��p�HQ���?��;d��,CSf�G�	�;!㢨B"&+�@E��۵A�r��K�E_\ޏ�o��BeUUao_�^�Fe#*� �M���5$��,�d��sGZmw�KV;�j���#�9h�21 M�.�KuuJ���
�ȨD!"Z��&�A�Q�/@

<a
�.�z7�ƃ�@O���lihh�*�K�dbl��&���IP$iU�DV�P�$�	%P@A�@@������}���\��lj9R�(ъ?��?�����DAm�֖!�V1fVA�`*S�K��Ԯ���3*�( ��'fS�v��E���v(��6��F&f�6��Z�\?�����_|�m�qUb�͢�e�Q�Ycc��4Ief����5�����ôY���>T������1��R
Sۄ�'?�����*�FT6&Վ �eAA�JIH�n���r�*j�b�L�K�Y��W(�p��������_�~��_�!3���ޢ���r@��.�g��ծ.������v������;�����޽f)��Lj	`[]���B�������]j��,S�ƪ�Q��y�6�f�EbA�%�L����!ɀK���f���2���ڮP` [�1��l�R�_��nU�R�\�I�ҝq�PE��W����?3WR�묺�9�\��x�[LLk7KC����a�hk��{��i�D�.�t��)�&�����`�i�SU)�2��f�Y����/߷�d�66S��fk�)x��Vfa�N�lĤ���H�m���H�V%�\�т��'��$S��ܒ��ul%ܪ2Z�τ* )���`�H@�U1iI�J�r����� �TӬP�bJU�S�ꎪ�g?�o��J�
�Q%��[��ܽ?wTUU�t�[uW�������~_nQ!r9B�q�t���_~�ͣӪ�lV�L+aL�LC�w?�}k1ʈ6�m��,e�v�v�����ɢQ(JT�l��hR�\�����9� �0��Ѐ6e�T*(M� MCۧ?�O[ySf3�زЦL�5�e��K������ť�骅��������|gD�u�N��-E@b`hd=X�1�h���sjPŕ,˲30X���P4�[��=��!�����I[jsk�X������=�~���isy��=6��G�J�dl�Έ�U0Ҷ�Y�l��Ɍ7�U�I���+$<DԵ Hi�*����]s���,6ҡ�-� f ����J �
T��P&I;u���vU�Z�+�hr��uE���tU@�ـJJ"�ZL�Q!N_��VE���:tI�^n}��Ih�R+�������X9�А�T���f F�� #�ZUkI3������Y"�#�K�*�`+�H���{:�V�``Ud���vPd�D)30}��s�bf�T�d%.My�"UU�rW����+���*%J�S���i�o�&U������-���f��=�jfM)%�P[�)��At�ˎ���̨"O�~��g��|b�-ͪ��?��|���7���S�j	c4[wޜ�E��x��"���m��y3��FR%�[�����"b(UT���Z2Q��������� Pʩ����VP%@C��"KeW�+[�X�B��]�s��T�5	�(�bPJ�b��˝f���E��	RL
P��R�bц)1E��M [Nw���W����"EK4�%�jva³mCec� &A��V���ڰ2������W�de�w��rJ�JUE"4Dx<��=��j���o��O��bK�d�XE�ЎiC����u[��YE���RH\.�v���EuGݩ}\��|RZ*�ܹTםﺃ�T���R[�%�h0bMO��v�f� ��J�5`Y�u׽��t�6���x�뱧�2Pe�Qoٶ���/Ķ<�[U�i���s������7צ4fC���
<�D���<���ELٖ�!�q	S
6��ʮ.Ƕ��������9ƈ�e������nQi-H)��b�������(Z�U*��R*U�!�L�� թNQL���P( �T� �6�*BIZ�T��d&��#Li��
a$��eX$�ӝ:u*��A�y7kk����elYC�P�`6fC1�ID@���|�����o�!�����jJ� ͚""�f2 �� d�i���P&�Ic��#���1�5a��Ԭi�u�c3�bG8ԧk��]��ڝ�:�ve>�NJʝ{tu}�w�SWW�jyW֊F��LV���i����,�K���	�״˵�����n�<̛�7o�����Ul���#Q�������񖼩L�F`+6V��j�616��� 6�ly���7�Ǜ7[Ӵ���������ر\��;)h�f�I�4�����"H����=N#�r�.V��N(��S����0Ag!@�*� R��|�y�&�Xǀfb��T�O}� &�_�����޴�r$�YE��Z�����Ԩ@�M���(6ch)T�*&M�PJq�\�N�%Bfbc�o6�i���/�������6������Ħ�eC6`�!�)�7�^N��24O��Ѵaz�����[�֒�i���c��X^!L�2��T
��%�V����R��t��T�Ԋʨ�u��܇<��r5�\�ٵ8i�-5�+.��H�M���\�n�je�܄�(��)6��ٳ=���F��_�C�.{���c������;�_����f}��H۪b��a[�ϱ��2����=۲,��a6�zs������[R���6��u���Ыt�ANwi�3J�H��TU(�BA��[������X���������"-&�B�� E�����n���}�>oޔ�
*r�Ӯ�$e.m�J����"�Jb�\�eQ�C�TUT�V�
ؘ �H�F��#�9+�(h%�!3{۶�c<M�~��/����������khB6�h>jKm!V�m�b-�b�Co �V3���1Ƥ��huXa��a�X�c"�$,��2�u)�6�ۚ�Ŧ�{�%�N��R.*�:�v��N�r�.ߣsO]�sܓ랾�t�k�z_[�SlҬ��FΖ$�6+ZYu�ؔ�e6����"�;���ز,��3�25���}�X���LFƬ��-S�m�����
4�V,3eZf�&��) ^����旽�m������f�0�@��]��M��CU����b�.퇥|t	�R���G�sawB`�NSF)�돿����x�����h!�")���T��uS�͛{��A�͛�u�'�k���36��~��'o���>	�\�JA�H��� B�P ��d��c[j�fkP,�٧ߟ�2QJ ��"V���5[˭e�`m�f��]�Y�xk�f{�`X��Ӥ�cz�M��iLc�j��~��`lN�r�b��0�2 �$�����bP�)c��
���"�j��R�;.�r)=�~�Y�Q��6_�)��(U�H\zr�Srݣ���t��k��}�k_U�֬	�A˞ڌb�X ��:�ZGu5��)]�7�l����6m���db�6'�	��1;&�sx�&�-<"�l�`,a2w~�˙5�2!�-�=���,�������[����;�V���LR���uz- r�t��t�PT��sՕV��`s30 �ĝ��(��n߻˻�0@�hX�2��iB�����Rʅ�ݧ��궬�'�
eW��)��RU�$J	�V �Tʬ2lUG���A[ɢ�/�����D����UՙT
&	a<س����fk�a�c�`�L�F�CdՔ'bca�bl�����Ɩ�	`������A"	tu�f6�@@c���~��~�� *���rD(�@!h(�ȥ� ��nw�˥�K\��r]�ĥ��o��_���kչsO=G�>���s�EN_{z�����77�Q�6Wl4��Y LȠ���Zͦ�]�ֆ��̲Z=<���}�,Ƅ��l�R�1댖�ǖ���
�l���l[+�(�ml˘޼ul6o�n�L�40�^]�%�RU	�2�PUջ�/U�GuY�::U�F@�s��0{�@r��
��V��VPT���'�{��e�)w].���0 ���AP@��(�*&%��]r�(�6�bP�&`s!�v��@b"ðN�fh�J3==)l4Z��ت,��c��ZLVe���ZL� h�J��&0 LV*LI�5�L�9�L`�^��J�I�Y[dY(2�.WA�֤C.�\���;�Z�����g	�U��������|v�z��}8�݇�-�������?��ݷ��som�n�������@b��W��O��FP(yL�Ґ!؃,��)MX[������i;Y�Z����~՛/1�0��1��gL�W��fM��ɶ���@jO����[����f��	�^}�r�njU]�Ҭ)��r�NU�\̥�\]����랮��j��V#MAl
��X�\`�6I@L�B������=��/}�S���| v��(�"m�-�]HTji�*�**Q%
� �ܩ���2�
e�F%[�R]���jIl&�V%4hD+)���"XX6�b�_��޶��5��e��l[���b�̈��1#�:��iV�f��ab,<�L�V-a�Msā����!C[cZI�O�w�Nߩ���%�R�T�n� �:�ON�=��s���ͷ������������?����架�vS�ۚb�-H������|��s>�,O���X�j��ٚ�[l��J�*���ƒ~�������[�`�4#���}ϵ�Ο�J$	����J����i���aV#&���y3Q������]]ku"��F�P�JW����ЕK��]�{�뮻��]Z�&&� ��`���2�	�Re�i��	KaB�~�g��S�2�d�T������o��oz���?��+���D��QT&@b�f��j+�.�TV��x�6b#�B�MxIPW�6��TQ+A-ad�	���Y�Fl��X�%�>��C�n9�.7��u�	� ��`.�0��H����MHc�b���r�gMT!M��Ǹ��!�����8�KG���wG�R��~�R�JM���U%�ru�vW������=u��o��}� �0��'���Hn����ֵ-xw�����h�ffY��ec�,�g��S�dVY�d4;��-�9�vBS�S������\��8=���($��4���js3M&����׎��(�k�
�._JU+�٪�$�(U���/.��*T�a�Nת���:b�X���l#��D�N��D��1!ujG�b�~��}�fP����0PRݝ�����������o��o��_��?����<z��y��{�I��D��)I��R" U��҂ ��0�>�x{�����
�:��� ��Zјf$�	���H`�a�⹍�Lo=����V����z_�����e#�*,# �D'IQJ�\ʥDBU�[���)����UDPĊJ"k.�"Q�84AZ�8:Jo_�D+�VJ��
��Z����[���.w��C����������������C4`:7H���6e#6W���(0=Z)Q��uQI�j�< �T�PL�^�=�i���$���Wm��
2�H*�j�UMlK6W��bL6�ɦ&��㱕*9�ԡJsU�N�NXjt�ģP�J�ŏ|��U.wiъu�w�qu�p�kmlN#�D��ꐂ�k(��Q�)���s�A��>A����祗��\|�o�������?o~�ه��Ύ��JbHUB�
��KUPT�
T�S�֤U)������vz�5ٖ$U�*�\R�v�4&��X`�T4��y�� �`#�0P��{z��y�Ër��ך�a����*��E����X�&v����16)�  J9,�9h�b����%���)RY.��_���T��e)��J_�T�#�;r���D%��䮫����������.?�K9E���,6)D@iTc`���"���t�&2�1`]� fM�rK�������]۫6�n��U��Rb�PU�*(�*+�MP8�҆QL�6�#�R�j�չ����JF3	%G)_9��PU]��T��G��:�������������s�06;6ޢIM A�.�-9$�-l���!�K)T������9�\�ݻ��>������������U�Q�)]��b����ww\Q�AhThs��p0����-�G���Q0��׮.w+'�m(%J�V��Icl�l6���1�m� 6�zz����������m��!3�A@��qL�� �[����X.����8b"�A
IZA��,BGL70 �Q��W���J|�.r��<��2EVEVI�N������W�����Ǘ5��j@+f�6u�LeL���Д#��D�����0
2�[��6�X5���Rx]�Juխ��caU��P1�mV��4�lH�&���!ե\��]T ��@Ƞ
�zt����X]Du*���,w���ȟ����?����?��y3�K�@ 9�:1 ⁱ[B*�
I�v�)�*��~��w}�}*�Vk)@U�"Ѩ�����J P6V�.��J�#ZM�#^O/G�����*%�1a�S*$� �m�X�c��F���3��dco�����������ǿ��ټ��l<� H�rBI1 ��d4�Ɛ0E���Ȑ��4@VĂ�j`�,�@d���`B5��.���t�k���%wS�bfհ�B����^:��N��g/?hF5�,,�T����\W~:�ˊ�q�BUե���Mc0��F�#�[7�c��� F��m��N�._����m5��٤��@�&�Ud�����r���nS	H������t���%?�_�������U'uuU�U/�Ǿ�������i6���-1EL1�X6%�����g#+k��DY9UV�&@X�M�K/�;%J�\�( :Ū@���J%��@Ť@R�h6�ض�mLR.���]N���RUNmO	۴QId�*E�J��i��h Ͱ��ß����K������b^�JD������+DH`�@6ģĈ�)��E -)	(�feh�2�L`f�0��E��5�i�ʥ\Ii�%��
F�D�K��]U?��"~:@2&a�U#�feُ�1X7���Q\�lJ)b&/��涶�Vf�il3�іdT�6��i����]�%�4�(�mz�`o%�6�n��Ԩ@5�!�Oݹ|���D�bsG@����t.�$ru�w������W�S_g�t��r��7>�ï|��՟���O���mlc	S�����w��c*��5	V�*E��֥�s'�DU��Q.�D�R�U1�R��b��2HVlYc�u��u%)N�*�dD+B�1�Z�ru�ܡ@%jD�F�����7��VH��rd��_�ۿ����_�)��K �DQ�q�����.' J ��R�`3�K9Jl��
S�!�& ��([����(o���p��8嫬kە9���(&�jц��.C-P���b�*�d+l��^Ɗ��Eq���e�UN	`���S��X)=�M6��s�3#�d"H���q�ԝr�!4�De3b�X�g�X�r�*�r���^uE��HDb��R��=N	�qӏ�^������ߚ���:�M���+�����m��x� P ,�}*�`�v�J���$� U�sH�PV�*�`��㦪Q�2T(��R����JR���rX��m�/o��b�4���ao�]�V"�HI��L��&��5�eg��q�t))b���7��&�`�Ev�������ĊV ���	����Q.��D�lb$ %�)rT�a��)���
� Y�Gsf�>��`���j��b�	<f�rG]��u��,M���Q��[��fIs��jS�aQkL-lU�4�j�������eq[�N��e��#�}�:}���l�`����m�i��b�M�])Uũ�]�����Mi�ej�64Q�=e��h�f�XU����;W�	@�ť��s�N1�j�h����Rڰ	ӶͶ�m�L[(r�R��!��_��(%�&а
$҄4LA2;UY+V���iI�C�`m�Ƙ���Z�\e���Q.�Ki�m�a�yzk��Ǘ$�9�F!��l�S06{��Q�RJu�r��(G$�-�	,WR�uq��j2W��q. L��b��\�tGuQ���r/9�nX�@�$�]c���I��)�(����y3���AJ�-jl3�6�,�U�t��VVR��%��Ԧ�&LSZ� �21BK`�"P�ֶnE}Ge�2)�{���pU]0��`ۆ
̶Vo�Fl����k�+�[�PuAMAfjXmjFb5�d� [7]��럟�oe��T����R����x�/>sA)��*�:_f�2�����^ݞ�P1�f3����I���C�b����ih8�!P��u�B���b�յ�b��b�HBIO����ڥ��e�r9�SJ�(I�j����SW����a%�ڝyY�F�VZ(PJ)�q�R�*w�I���94)ǵ�?͛�t��%Pn��	B��r��P�\%/o���)��x��b�mz�Q�	� ��}MlT�1@�:"�E���jݺ��sQw:R&��0e[i��a�*��iJ9!�M̒�-U�c]�2l�*�L�xqeWwuU���l{kkkSZMe�+^�Wk�jҌ$�b���N*�)g���SM ��b��6�i ���_��C�R�K�*��/���*��GO��w��}�sI#���ƔmW�n��&���٘͆ћ�o�$�T(�КU͈�
 ����|蜴S�⊠& ��4&t�\�	H0��0��� 6��fli�\ծ�g?��˯_]��Uc��h��	�J[������ME���TU9��;v��U�(��{+M0v.����S{�a��򕫌����X��O_�. F�*QŪ��4�@   fk�K�@P@� Am�����f�&0bY���ac��|����\�r9*X�+
L��B!( Mʤo�~:���%��e�������*�8��]��M*�,�Ruխ��Uڌm[�����oY�
�++�Z��5�u��)Z(6�j��͌G�rG����'� �\B�-�Tɪ�Q�{{�w�3R	 6�fl�u�m�c�lc�`��KC�R.7!��E,�`lbs�7���?�l�:��;�\neW�*ʭK�*嘦��T� �H�1��0�0 M=6Ʋ01����aڗ��m�%�TM�lau����hՇ�={l���.`Z���T�|�����l�I Vvvuq..����`��T�v�t\]J`�T ՎH�
٘�(�FbF�5f�(hP1�ʭ0�Y`Kˣy62����S.��!�k�_�r�v�9\T�E�V+����-�En���Λ�ݘX���O��+a�����^�&%
�X-ҕ"J}�|Tu����x�{²�,���:4u�D�6$��u���s�ٙQ\	hC�%�a�A���Z�L��U�	
�Q����D���:#i���֊l֎V�0���{w3� ��b�*�K�!���%��?V�;���O}�G�$-�R�.��NU�]�����M`1P���~�?�m�T��Ę�ʠ��m�5��J�	"���D�!��jU��t5[D���(�� ���0=(7��-6^��H#E�Ȕ^�23�;>D&�M� B���!CJ���R���s�pM ���̠�,�BP:�-�����6fS�Ҫ�ׂvČ
i�֢���U��vs���?~���W��Uf�(,�`�(ڈ���)��(U�r�͢9���U:D+�� l[Q��1eSV�ԪS1��Eu�R���}rS��L3k3nii��&A��S�U������/�T&6�j�
�XU*s�_{�O���$t�niKr�ͭ�-�90�[_��j�9��kVSm	D�%� �ؔ�����\:�r)�O�$c$��J�g}���R:Wgz�&�� ���-YE�Qa2�a��.kӔ+��s�S��j�]E�j�,lMDcc�TŰZ I�l%�6	�8n�92�ڔ<L0��~>?~m�����,��0� C@�@�2� �HH�H��\�K1	`ȀD��"TDcyAq��JP�D�W�6�:��d��,Ք¬JB�`�I�}mo�����/ie0�qt�TmB�N�X��\�o����ꢊ��*#d@u�;�[ۚ�ӘVR�j_*��ݪ*+�@i�ѣж���_���#�I��7��LCiw�T�%q���.Q�.�:b�4�1�4�)0����ūlØޫ�r�x�M����i�4�d���$�s�s�r��ܗ���~�"Q ���W���n�J$�%����> Iz��1��[l���w5�����T+:��ha�Q��&emm6�4�(E�2ˆc#1�V�&2���+<�G�0�v�F�0�%s��i��XM1��HiDLɪRp �8�� hlbl D�fCpM�R���t�8v�
�S��k��`dFABT�$�P �w�c��3�,���UhL�րQc3��Cs�"���&����[��cP��(�͖�)M���;�g-U*�.]Юd#����7!qHl�W�l:�w�6��Ӹ�}���gou�.��˥v��r%��V��l�` �0e���m�x�x��I+��1@CR;GHt�(w.��ͽ}�I)KL"A��c7�yCe�*�_�����b��*UA��m�1Ʌɢ��m֨�$ZW�Te�J�n*Qa��.6�"D5��x���l6�1��lCsCK,e�����|~-�f�[�`��`�6� �	3"�%C�����;61� 6e 04ʆVQ=��)��G�;�b ����̝U:�*�V�L�
�B�IEӜ�Q�vKC-�vk�J�jg��vZ����6���N������L�g_~?sy��a������_y����@��]�r�L�K��*`X��x"z󥔋��&��V"�Vs5�?�T���]�S������]��r�T*�VAY1�F���L b����Pe��(w��7�F�y���t>�H)�ĥ\�\�*%¤M�*;*���*����c�XU` OL`,�4Cl����4�mj�Ց��T�ă�NL��&+�m�m6d��"6dY͛߼�]�z�2M��T�Q�1(03�L� ��v��"a�&a�	��Ę��j�(�!U x���f�pąQU���{��z�q��ӝ:V��f�u}��A&,Y�(���2UB�͕ BԈ�ۺ�Vm��Z��R��`XZ�X�Z�hV�	��J�
��t�R�JM)0Cۼ��������.�n�&�A媛��bq�Q�P�ź���C�{��[��~[)7�MZ�"L��tV}����ﵫ;(��%�J���iR05���UHDH�U�D)�_����7��g��U�)ŹSJTr	L�HD��O

��'{��PV3�
�ac��m�]��a�`e�����*�� wU߹�����i�X��64�ܽ5=�& {����Ǐ�֖��0�0�r���i�K����b�^�1�f<���21�02��|���Y*(�� 8$b�ь�1��,�!�E��8z�Ǯ�y�y����:�����v�XfbV��TSH��P��(@SY%t�vk��3Dc��@�Y7lc�[�-V��͖͛�M��j����i�"#���: 6�bl���@J���?������?�DF3�)�)p!�D����I�7dLB�*iJO,դ)@�;��\}�s����]�@�PVNeS�6�iʐI�X��,$)Dc�JB:�/p�����n_�i���g%	
iͫ�M���y�$?�Ao�D���5�m�b����hf�Dlc4���R��*��WVU�@m5[�l��6�@�Mc<�-�4M�m�mL`PDD �Ă<�1�h|u�E��c�@ la�1���	
%�D�����c�73�+��x�P��ʩ�z���K��>��{�G�Iȳ��K7ڌ%�7%�v�d���%���L� $h&E����Z�Ɍ�fmc��UX7��m�ޓ���^��딉�S�VX-�k�lJ (w�D����=�5lҀ�miF�t*V�|h�������l�Le%e����FU�˝��T�*s:�u9%�(�U����e�b�E)U���%��Q!h��J9hb)!w�Ç�Du�5�\��0��٪�
ȴj������M��fcm%�)ma1c1MU���b-K�������U��1��4hK��-�٢Im����1mlM	cZ$ ���D�r��� b��%^�i�(�,,CL��=	TR]"Paȑ���3c��ٌi9.K��E�d���ݣ�x:z>z>z�磧zjO�S�a��`c�ME�D�n�6�V�C��\%�TP� �le1M�U#��n>S�!-bK�6[#�����1����R���)�N���ꪌ���lՓ� )_����T[�jX��X� �]�>�ե.W[mf %�I����/�)]��եtŝ��5e�����n�_[扅�r�����I	�
#)�Ν/P�t.�ڥ
A)�b� )�Nb ��Z�dm�4C{�&(v����c`l�l�����U��f�"�B�M�� [4,��Z"�����{�-d�0��4mf��!��&��$ @�T�� ���	`, 3��D�SH��(WW��UH�T�Eo�U
�Tԗ/G���͖�����G���y����<=�p�@�ն)6��pMuP]bQ7(
�:����Td�Ɛ�֒`��2g����x���ڊ(�j}Uâ����oe�E��c�Ŧ��  ]��e��6��L/���T�������Ý�>�Nlc6{� UG�R�\�Nu|��*�X�	���Ť_K��)��^��\J���������a��R�s�F.1�\��B�U(Į2�Z�))b�	�r�4��Th� ��flMoh��[�Yf�HPW���DE���TA�!i�l�C�hL�Y���h�����������sZ؉�5M�$���b��L��c ��xs)�ML�od��r9����lmi��dA�p:����tV�Q���g�Ӣ<�t�w��
���n,�M�KQr�r���V��ܔJ�����i�[�%ҊEM�u���
H�
��B�R��t%.��rɈԵ���.��_�gK�8	J����7W�(�)	�Ru�RUm3i�65A�"��=���o}��w]U���]�y�J�����m�v���Y�뭯{�q#�aig�XZ�E���]�.ʖ���a\4b)g��RI��P��~�'TTJǋSF�A����q@SJbR�)�(��9� �P�Ȳ��l�*L�k������4�.L �UU�r��mmGY�4(=�����fk��lmm�Cl61�?���C�@,1?����(%�q��$SbPl0@b��0`�)^��aⱁ��r\(�C$��Z��F�,�E�����N:��2k�N������;������?��~��������?��~6����RW�D�\D�9u[ݙUQI7��!tS�궊�ɠ5�J���DH
$+�� UJ�ե\�K�ż��o���q �*2�٠�1�r`A@�RE�	� � ���������������O���g�_�̿�'��7����6I��4��m�}�{�q_��'ڝV7��1L)i��:��Z+�ޝ��F��d[]��N*+��I�f���:q�+�럎�Xd�K$���j�b[H	��s!���Q �a*O2��Ȣf0Rh��#0�fa [���jW՝�ڥ2Cʥ0�4	ۆ��ewOo�z�I$ �P�jxy������t\o$L�!-��������1b!	
 36���c@J���˛Ճ�`DH�T��餦�H�;!W�Z\]�]�����������4f}�թ�˺�H��X��$��DKE�8�	��H E�*"I���K���� ��FQ�V]+���D���+�
!��i�%b!���1N�Ҵ� i�(#��z�SuR�o�w}�����_�c��������_��?����]�bD�����'0��dL�)���RȜ����K���ۛm#����Y�
(IKU9� �L�
���}�m���{w�`&P�6*l�l6�!��%l��ț��RL�a@6�0h˻b�#� ��`�Qي�ܐ-iE(j��j�5QΎT�6��g��]o�����6�z<6[��`4kZi��Kv�(��` x�1d�����<
0�@ 0"i��Dib�)"�c%J)�BQ
��FDq��(Ѻǥ��������UU==N�3��o�������W�����w~۳�ͫ׷mk�QHKR�wu�Y�%)�K9�ZǨ��ک�K%�Ѯ�T]�ՒHV��h�z ���.���;���A��-���2�i������@	 �aMm���F�p��䪾;�]~���������_oz��+MzD"��M�s;�,���FN�A��+6@�|c�������=�v���h$�4�bՎb��fp,2�������1��c4������ LrW`s3�*�q봹[[�,�U��S������m� 0Z�bi1�� �!�89ʱTW�Y�Nյ�1��۶6���ۼٌ]�1)�6JQH �r�2e 0c���>����~,����L�4�Q�@�
%�\�,G�	�.�!�Rj���ĝ_�(�Z&F���_���~���K�Tuܵ��������������^m��!�u�\�j,����5�Z��h��$S�*�Q%J�jT�H%ِ�`�6a3M� ]2���TN�@G�S0��.ma��{@� F��� c����gW�b]F���5���G�����k?�[��=�7{�6CۊAb}���hg�1�\Z����8�-��Ka�yb�6[[��BKf���-�j�(
�2�a���bc�1~& Cb��c2(��x�W-����l2i��F�$�6!"�&����ڒ��+����GC�;�._�:�ղLz�����y3�� ��0Z�*WGvu$"�fS�`R6}~�@�Ħ`j ��H�D 
�T�%G�Z���:��E�Aa�2�A�UELwRG4x�l;�ױ	HJ�rU�R.��(��Hr��m
~�w�K��
HZתKS5U%�?��/_^4G"5SA4a�%���J�ĆM��d�i���x��MS�l
0�KB�@I����\��?�;>�G�ټ����{U8���C��4PÊ��V7Kؖ��k���t�[�b����%���$��%,�o��j  R�ȣ��� �q` �;����~��˗1�G`�� ����Z(�Ѱ�$2LVh2�h�%�6��ͪ
[�G�?����+EQu�*��HD�m�KL���}�n�	`�1mI�R���\ Ǵ�1`0$�V�Z%MAf؉�
�.�#�x���s	�T��MX�)(��
�>R��Q+��(Y)Dg�U"�E�m{����m[���������]�$�%-�EU9I�w~�ݑC�XNPlIqu���/���x����ZLR��l�����U�*����E۬Ĉ�Y���՛=��V ��PIq���>}�-��j	Ɔ��Y����;<`��+K�/{�����V넳���mKϽ���bȃֽ���%B��F�v�Hl� gH�b�X1]�@&�w��bH	� C��J��O��\��r C,�<�Ɋ�q�,�X�1 F�^����i�o��x
,kc�:��&�T��R:j��6x3^�c�w/�1�͛Ƕ�&v���2��˿���/6��2ג�$B�
����%`Bz>
J	)���@)!�*����(���j���X����;֗���W�w��W~��G5��i�܊�0���n�R�;%��RJ�*�P��.�U��(�T�B�V��Шv��.wdJ,L���5�1� 4�@ 0��!]��<�?��f�"Mc�ӠǛ�^�b����3��Ju ���^y|�����R:�B4�д����O��xL���'H�c�_��/W��I5�c�cA�A)�6�d�ΐ� hdX�)��j�r@0 ( Lk��f�̄Li-�&[YQl�5l��h�T�NtTǥ������om���Zx�͛�`*R���`c���o��R��UX�I��
���4:�\I1�)�攦#(!Q^H��]!��@tJ��l��b�"��r�R.����ul���]�a#$䒤V��ZTKB�9����׮�bB.'����U_�S].w�J�Q�ZB�9�JU(Tr�R�R��JU)ڢ��m[�͆Mk���AcHS�Ǧ<�@H�}r���i`X�6Œ���>�m�ޙm�������o��GZ'[�N��ZM�Fn,#�iCʮkǜ�K���&ɇ�y;��%0�%��*)�"�)a@�H �( pY6��RjǄh6F��DL��L�	��o޾?:�ʄf#LZe1��ɤ*�İ���#5۬�;�:���������|�l6x�GȆ&�x�7j���:F��@���fm#4`�h��R!�L`��\%�\�R�#L1�P����$���qMV�-�^ ��S7�Z���3#�ml�F��JIT�R�ZZ�֪��hW%D*Sm�,�bU�ԝN�N�ݪR�������v�4U %����"%������Q.XJ�z0c��1�����/=��FZ%��	�O�헮�!F�Z([
�$�&{y����l����+�80~������>���t�$fIZ'�N��8��V��\7�&Ɇ�Q����<>�I���)�UJDY�Vf5��Ġ#"oDJ��#�2J)_��1�{�G��ni �P��4�
��������F��4���l�M�ZSi/�bD1l�J��͢��,2�ۻ~��f36c��|��q�ֲ%�iQQQ�k�� Ә�	EP
��M�%v�� �& �Rp)�QJ9�Q�aʝr�A�����$�Z^�!<�"2bȪv�5K��8��9�h���Β9�˝��������響ٖ6m�ZI�AI�܏]��4�ؒ�EZ(���K�\��*ʨ?�v����	c`�U)#)W&64�THKDڤ��4	�6��>������v8�564S�^���M�**����eks�6����	S|��z�~���_=�#	�r�9���Z��Z����]Ǯzw�"�5�N63��z����V�˵Q!��ԙu	��6؊��"&Ʋ)
�@�\�by�Ǐ��tY��N|����e��&Ă/�S6T	��K���d���`�V���`��o��6lm����`���i<��]�6�5�8���h��؄b��*BWA[dL"(�)P�H�X�!��$ )�D XL�P����ѹ��*2u�ȡJ)�J��7�)���̲\� �K6m���]��������k�����vZI�%g�T��{4i�j-{pKmNi��K��R]��U�խ4��M��*QE�"@da�&�t��YM���w|u�������r��������Y1�"T@�(�v�U h4�x��Ɩ�6 ��T���*�-Ԇ����~�?������aߟ���l�H����{s>�1AS׮��U,-����f��([ǆ�R���,����Κ�t�M	3�M/�Lg�ξ|	�=W�������èdh��x�ȩ��x��I�������m���i`��0FM�66�,O�1�
��U�Ac�� K(, �� m�ZU�
�1"�QJD������3p�|�td8}T�3
���Z�lh<JSQ˛�p!�9p
����W]��]�yu�4�ڪHs��Q��6�jm���tQ�JZJ��J����׷�?�����ڶ�V�"�TU�JuJl��R'�Vk%��a����c��\���|�'�b\�$V��J�#��Yq)�J�
M�l2������+�AF�*�����֖V3[�q[#����Ͼ��G�[�<l-x�ox��Ǳ���b,S�u`)�B�B�T���M�`t CS�R��L16	M�Aq��?1�<`�2c���c����U `Pg��h�TW���w����A+[�d��@�n3{�K��c���H+U\"`! ���U~ꔁ`	`�Ba�cD0�� �������9�.��j���:P(IvT˄ey�ZM!��iURU(�bI&UJr��|uOp��j�1j�4f���NK�E<<�YjeZD��Q��BUP�����O_���?k��)Ae��ʕ�ԢMl�x۴�44Q����GI�d�* ͪ[��ʪ��b��mhS�a�ֺ�Z�b;h��~���˂�-	Fc�m��O���~������M��?���i$���/����=*�>`�i��U�FF0�]*[�,��T�1ֵGl]ޣ<5�D\�`L ���^65b�c�b����!�`���e���m���)��5m�-�����ݪE.I�[U�R�i���0�"�N7W���֘ ���b$�iLA1%�7C���!���H4� �;w$��T�4�i��BdRJM/R��Z�D�TCu�$��D�!��tu�"WGY�w���E�^��� ��Fi�zS�՟�ǿ�����oK�RԗZ�J���JR��ن�����
�Jҵ��UfY�Zl���6[F��/���```�ԥ�.%@�"�Lݪ�����ei�I�Z+�Bb������WNG���r�Q��c���~��^���G_V��̊;$����o�xTJ��l	�2�6�$h譍B�6,�(���l1eC\d��`$���CoSVx�i�c�e;^SC"Ƒi���hC�YK�ص���X�l�+�,:R	M�e᚞O�i��R�\Um�g�UUT!U��UF���"Q���0��a)D�dEH"BM�:.R]��XVc�J@D�Ȳ%�F6��J�DT�D�h*��{�]]�����V��
"�@��ĝJBJk顦R~�?�����_���R�L��k%�4�X�2S��Ӏ�v�N)�e- #H�z~�7^��l� Q�Y��U��R��*�@�K�V�"�ʀ���)��2E���h^n
D m��V�(���;�ˁ�n�&�f%�#@Pi���-+�*�*e@�1(e���%����N�4�c\o��Z6�xbI*h<�iM��<ͤe����dXV�&i��]Ӧ�R�H0�a���1T��l�i)�\"a56xPhW��ˑJٖ��QHS$�ч��|L�s�*���+ ��D		���\��r�\�R���,�)/�	2V�������SUT���+�b]w�~�{�����)�es壊��uSI������_����ݨ���+*Z
E�xL�Ҭ(I��UD!Ve[��ǿ}�]I`�JU��{9T�J��Uu�sO���T�1� Q"ɥ� �b
��TYA+  67��S  �Ā4Zk� �Al��]�l�ڭqe�m۵�x3�!�hibHu�a��������Z2y��=3��&�MJ�.3Ĉ-c`���10��:��4㷮Y�,+��[+ò`)����0��[_���{=�ֵVkj�UMڴZaQڊ��ژ %n��dMC4S9Tu2ӛ�x3�g$WWWU%����@
� K��{>3kzlU *�J`����$�X����.W� R;.��z`Q���HY��Z�	U����J"��Zu��莻���z�;��ӝ�D�*���	�$�R-�zb}���ξvt���T�����+�UVEiP�T��RU��p�_�YW-�b��Ҩ��"Uݯ���饫;<�ҥJ�I�
�KA�, @�Uĝe.��Ā@`���� ��^��凧��r�Q���N�ImtS�m���.z�؀6fl$z����x�g�ɰ��ͳ!������?�A�2a����f���1��VC{V^EK��M4h�JÂwI�b�lr�/������s�͕}���}82HC�f[��X��`D	f�2&Z�b0��.a�4m �$�mْ����No����6��B��,@,�%<a)�*�:q��qt$"U|���O�D�TQi�ڪ
6(��V%H�R�r�����`w|WW���{t}|g��2K�v�Dr��h�4�}��]�Ng�)J9�2"%�J�T�QM" JI�U6�D�EK�ل����m?��U��].O�1�͡J�T�*e��r@5!� �.1?y�}zy��]Ŝ��	����}��΄��h�YHs����&�N���y�E�������-6&�	oa�O6���I�6�Vl��*R*[��|TE���e c�1�,Q�HGl� SIm������z�b+�Ȃ��L-�&�ښ���;�yy_�[c�),��Y���`�4�Jf3f0��HuDUQ���0�#h�ma� ��$4$ͬb"k%� �`��U�0!JI�r�:Iħ�p,�<�����H�
E *b�?����/����;SP�B������A��s����T�p(g$a.�Vjs��K(đ ǽ=ޝ,:@1W���ui]��D�� ��U�V�U� l��M]��$`%�`�5Tת�\w�享��d���D�ҵ4
L�T �ru!)�'�}�t2��x`��clf�cQ1����],w`�����Z�x��g�fc=���o~_��7odTim���"6a��b��[��UT�R�d0���%��r��)�*!����x���צ�!��=h�XC5Cl�4��ILi�+-��d�4M[�m�l��l�� �16c�@:�wW�I�
���M?f�Vf�@��4
&fa� ��W��%����6�HS$ʝru-��I B2���t+Q�ʩ��?���?�H%����!���yꩧ����ӥT&۹˭2Ǧ����%	щ{&�Y��<�yu �栂-��N�)SEJai���T�����$ͥ��شhڌ����uO]wGU.G$4�&m��LUq cF��R�����ђ6_�FS��ad˦�հ�Zra�<[n�g-4 ���.3��oU`��P��ƬT	یf[=�AaRteV�6�5aTqDUK!���q�1���%��PG�$�e�MY�6����-��FZ0�D�j&c��{��ښ�c��i2�l�Q�||)Hh�@x3�7��jF1	F��%bc0��(SKY;|�3@�jI"lU9�0��Ip�\�]Q�*u@�� �*��R�T�+FْT�� �n��|�w|���|�}�꯿�G��������E4B�~��w�&'HTэ:v����_|�%�6�e�JU��D��kl.En�R	�.G�
�y,�!���縫������4�F(M*�2 <F����*Sg�T�Ʉ�M,3먌��R�-aJ��U����fk�V��U['ɦqfh
�oh6���$ƈ%�Ȳ���mx+Vm� ɪ 0�e�M�.(��0{m̰tA��$�'���sY�!����T6bRh H3�M��hm���[/����0Y�1�6��*A$�>�����{*H�"���x�X��hlh)�		l� V�XA
�\.)Iւ������Tc�@YI�H�" ��ED'� �0C�h`��.���q������/������_���36�E)XE�w����s5Y�����-NS	�N���-(@	*�2E�$�*� ���
���ҩ��U-��4�TUߓ������?�_?�|����KCC��&Z5eJ��b�$�DEQŲ	I��ʬ��V`����)�T:���idi�5kJ�շC�Z�9�)8b3$b�ڼ�P3X��y���1%�����ը�������A�:qg�(#�4�cF�eF�V}������=U�iҎ�%&�@����v�%T�YJ��[شڬ��x��&����Mc,�i<�Q���y��=�U*$�<N_�!�����f4;���,5��[��f�A�4i�^�ս�SN1�4�.&6���H%�R����Y�Dd��2�H�Z%�BA�h�>���ܥ�꫾�y_�}�'���?�W˶ى,�T-���\�D�}��8ឍ�A�(: 
�*e
��C�تJ��*@:w�$�nc�.'�:܇�J"�DP\W�Gï����������{��TCB���K�D�B ���҈e4bĬBJ�2����ֽ5K�40�Qb�,�0S�01D�1l��0���b2�w��ݶ�{l��2�j�l�6����7/�����w�_�Uc!xb1ӛ�
�L�Ɛ���S�!l$0��b���o���Ī���x�
��4�Y��n�~�f�;k˘M˝�t�R��:��L��A%&�	2-b������!m��b1Ȗ �y���|�ƃ&l��!IJ�(U��*D����D� *
[j������W�GQ@
]A�k�˹S����Ӿ{������g�?����x�����-:��"�JSC��T�t�""p�ܰ'���� "�6+&�*3���r�ֆ��SWW�Fu�����q*w�K�l螤�~�������{���^f��������P(*J�B)���-?u{�t6a�#��X�)Զ�L1�F���n-a�Nkh�b��I�ZD	�(_����"-.�Ͷ-���a*20��ۣG�C	ʸ,��Co٪D,4�XK���m+k�E�`ʒi�T�@�ڠ%��&5ݬ��ټٝ���1�fw��c h˰�ZG�r�B!�@H$"���c<�HZL�M+�����g� aLc턪v�`l���}���=a@�.�D	�ʩܡZS%�%J�Q��kϿ?��������= Q��R��R]�d�t��g��:�:����������Ӷ�̫���QB��V�6�*��&G��%F�+TE�V�"m[1X�G���٥2R]�Ĭ�r�;��l��`�u?͏��G\�%�����F��U��O��?�����������]ou�6���*Ԫ�C.ǁ��Ͽ�=��1m]��w���1�1kgw7���b4��ڭ&b��)�6�H9!� )$�0XJ#��7o��,� ���51B6i�b�	�"k2aL��W��*b�f(�eŖ�H�&KK[b,��x�yo����6����fY�b�OO�VUAQ�J%HLP o�x̶�lތ�X��$v��D���&0Q���j<��Ġ�@�t��R�b�NQ�T����g�QQBj�O��RR)uM�rI��
W�VUZ�4���-�v��)\�׊�EB':���C�VR����f��5M��}8��j�r��\]����
�*�NK�Ǐ���s��*u�T��\��ٴm�+���1?u�����B� �&*�O���=��ɯG`�ʰO.��z�A@تL�5���!��4��r0}�}��o~١�)��Ǚ�Aյ*�(�F*xlU�vl�P�206��FPP ��	"ʦ,sZ3e�-)m�L�VL��i[��`�,�cŌ:�e�%��[?b4���͛7c�˰�6[F�]�f� ��BuH�0�`����3c�mk3�#@L���@�M��t�	�܉@��\.)�X����T*������1[N)E�zy���T��] I�J\����x#�X����u��w�"ŪDZjS�Q�(w�r'H>��	3���Sf�1�O�֤���Z�&�T���U�e0�"IՏ�B�]ݹ뻎Kc̢nj�e���a���&�t�K�/#�Ј���T*��X�������?��WN��UH`�����$�����~ٛ�?���w���^x}O��;�n,��Mt���B
*��豺�DQw"1��l����2Uf֝G�Q�*CuF<�&&KM�fk[KLeN�
Xd�^i�m��$VϪY�V�Ҍ �L�~�җg`**Sd�Ƽy30ӤJ�1x�]l2[RV����do0Y���Fb`1%@�$z�� ���Vյ�Y&JJ�H��(��NW�$�xދ���@��t�.���e�2���$%��Tq�ʰ�x�lk}�f�N)��4�5˄!�U
�DA�H(!��V� UQJ��3�NZ4e�*�~�'�����9�2��)7��J��k�me�uqՔVBQ q�t�������B3�tfN@*K�RD�`|�~��ߓXLH��Әf��7?z��ߋ�r��Tk�be2���	�A�VUcU�T�J]pg8 P!E��Zᚪ�L�:��G36������"(�al+��^o�2��d�M��m�Ȇ�������/?<[����Y[[[[x�2HUU�6[oƫi��%TMm06�ƴ�g�����fk�QX������i�Yh�����ZU�R� 
�#���%�	EEx:{����J8N�Վ(�܎�T�\�E�I*�H#�F�D(�lJ�MH�N��d�G�{wj�F�Բh2�X�V�)�@�@{��	�+$l��-YeU�G?��/�Z�]�3Bi��)��lkۇ���jiD*$$U�"��T�<�r`IIe)L�v)w<(C����O��"`S��*�)O����~�͠�j��,�������Z�N��4��0U�.("t�2�ji}�B6~�������{z�&�2�H`�C�Xc-�*V�|o��J�4h+-���� V6R��f{��xۛ!�&���I�:̮�3�Џ�f�M+�a.����'+&kcm�iLo�c�P��.K ��͛�4�(t\.ǥ�2LZ�dT&!�SR
$RP//�����"P���������ǝ�E)�U)WS	T�(')%161�;E�3�YJY�"k"E�/��w��sRZE�Ǭ�0�%i���$Cb�-�eeDIDo�i@#�z�؏����Gܥ��~�姎��u�u���&�u��h�*�DL�)�b%$U�@J�Q�2kH�=�~�gЧ?�}Sf��F.c����0�&�Xe��bNԡ.w�ԩ���~�۟����R]�����(�BT�T�L��;n�s�L��m
�`j�e�:h�8�ni1����vlb�X�2M%��g��f���a�Y� c���f�lx�i�1�"<cz�،- 
;-����@y�&o6(�CU��3�TBT� %b"F�r�媟�?��WHY���>�����UR�JW	'�+DB1U�.�j)�*K�[g\�HrYfV)��U�$G�M��=�M�� �k�߯�=ڣ=�f#YÈ�
�h�����xæ�$�fK�L��Rc��6?���G)_�����'߹��F��aO H�(rU���D�Ti,�0��Qs	��H"!�"�--Ɛ�!w7��F�Z�E6�	,��jF I���P%����!CP��T�.�.w�Q����1p�յ}Uؕl}�Q�u�D�=h[z3[�i�֙��͔��h�hSV�@��ЫVƓ��P&jؒl�m-c��`�fl�i<��l�13��%F��M#��S?����o��������f�#�RbO�b.&�	6�l�fA�J�K���������GP 0 �Q6e�-Ӈ6�	�i[L�J��"�EɧU�����U�r)ΝO.%���{��r0��+���Ī+sUK��T��~���Ϭ*����u��1k�Z�M "�̖y���-s�k�@��}�z�oI{�Գ8E��_6M�X���!ɔ,�DA`FB2 � !BY!r)Q�r\�K�A'l���&LAA�2kڕ aJ	��wR�R�r���?����|�;��g��������q鷞���\VU��2,ծ.);��mҖ���dk��V�UPX961c�Xo޳���#D3�tTm����1[o��F��-chz<�������l"�6�y<� �42oPJf����@J��1o�(� 1��a���J�$il�����T�S�c-�p?���R�	��ݝfQQ��jL����ԙt���!�hW�k����R:�;r|J�r��������9j�*���v�:#��J�@SH�rE���R`�
3�R*Tf)�7�@�)��a6�h�͘
��:��{����<�jM��D���E�N�4�ĥt"�DR�́�!(i`��&RR�J\}��*�R5VyC��B�(0��Q!��KJdX�ݾ���U���/��|��A��T�>�a���y����U�n0[�z�f�<�_,w�5&�ڳ��{�7�Q �ءTJ4��A�y�[[���6���]�ͻ��L�n��!,c=f
,2$�m��w.��޹��slش�U,m��ֶ(�� �cFoKذ'��0JܡH`X�8�+61P	�B �D)%*bL6Q����0hV�;D�q���Oݹ��9�{����[NE�*���r�P���DUj	�J���6U��+����r�n��2���FE��c� ��@6�1[x祉"�2���/��~7�c�leS����a�T.ߧ�x�MPED�I����0�f F������0�$�ܩ����&06c�#"$X�%20W[A�%�
���ꐪ�_����ÛaTξ�v�~��ݛ��V�	�+�U1�Y�֞¼b��lX�H�r��f�־�yc6/�*�*$�n�ɂ���Ǐg�4��̻���z�X`ی��6P�f�m�6��`[��	 6l��V�yy����g�Ԁ��l�ж��i	��%i��~��}z[Z��j�)�,��) �E6	`[�F�T�]լko�(-��4"s�K�$B������W^�$����ϩ����$֯<�~��P���*W�XiP���Q�B�����U�M��P(J��Ȕ�)qCe�'j�MCxO���g:�_�����׿�=���QPI\��9J����ͱ$�J�E�!bl՛��Ő9��"B��K
iJ $c�� �c#@HH�4d�M2�ê�
a�%�ؔ�z��o��]	����޾M%Ř]��%�i�j�~����7cm���M	�M�m��N�U��maϞ�^f�%�N�U�vE��X��)M������o��7�͆�֊(a�`�e`ZƖ��4���3i[ [�Fhê�L"0dL0x�������"�"?�Oo�EhUITB !qi1�ҩ��6���a�RI�6H�p'qU��m H-�(]�\>V�E>�JB��^>���*T��P�PU&�r��:3���mU��FFY(���������jO�Mo��F��+~c�~��)b%Վ(qDA��K�� $����1cl����K �

)��c��4�ӓ`��VK;�P���@�i6%�0�!0K�;�5�T���GO�������{Ǿ�n����6!:�J�=�-�J)�T���T��Ҍު�����-l6[،'z6IaV��!
4����6z[z���&�Xl��2 ��  ����$�b}��U�D��%*���$�B	#

H�l�l�m��1�;�T�N�N�t�I�cS3��T����2r��ND�*��R 3�����/^����U#[KJ��JT�bbT@l���Ll
1�@�Ucl�ce�ދmj'�ɇ��Eo�w^�	1�V��Bu��4�x (G�����fiV���Q�  T�f`���I`Ħ`ccӊ�DPӐ�X�hV���؊�-.��l��F��KW���*3oyl�c�=�?�f��U7��`f�����(��Yo��&�"R��Ē���孭Y��-b�V���f�l�ƶ��`��'��M��`+����z��Z �aQm,�5��B�R�����?O��XB�$��]�\�Ri�i��Z��K` Xh)��-��L�Y6ո3u�T�GN�H�TX3&L l�)$����I]�2����nW����V5�RKQ1�����1�T�@KV�Z��Bb�3b���f�!EyM!V�<ۺ��=[���ry$��p_���G��;�f��Ri�FEUS�.-,��!�
b`�)L�$�� 2 �d:�clL`�ň�@`�&{���Ml�eHX(;�CF��Cؘ�V�Ne�Lmj�������U�v�R�k˲m�g��6o��c����f˶e6�m�!��U�i⍁dI�"
KD*�o��Ơʄ)&�Z��O[��CLe�4$MP4EA���1� e�`K�j0XS����?� ��BJBU�J�%1i��U@ �T�`�� �al��1J����:��G=�k����s4VI���L�R�R�P:���@U�t��["%֨T�ݑ�*�A-+����6�nm�VEg�U�x�a���<�=b:|�޾����S}����˟7�w�>��m��bH% �5��MH	,�0�&Ѫ��Q��&6�P&�&��c�4<2�ؚMc� cXW�䁀�(�I��-����mM���E�*�>�2�R��/=����/��lY{���[3���R����ۦ=�6LY�ܹ��j0�Q"i��A���bH�՘��y�[�i�c�-l�o���r� &Ѓ�lz�5�����=F#�b�L�Кc��P%U]]��4
(�YJа��]��lF 2Uʥ �9.��İ�l���q�螎{����NU�:ݎ�f[c�II�FY*!U�ʈ��
[�r�\:~��o����A]�(&$u$���μ��@�!C��R+���u�jPl��Z��i�+��޸��7�������>��/z��|W_�A���_|���ݧ_��/^����q�;��ӕF[X!H`�1�� K��\�	�V`i i�ih)
ƌ�  `,F`�&����do�3zl��ɦ�$���N�`fX%�ؘ���n)f��r	U$���]nۊ�����㍇�\�ؼ6{6��C��.����sB�jPVm��X�,�4�6� 6�lY4de��1+	���ӗ��0ʔi#�l`dx��;���`��10`�X�ĺf��bR �	�8 ���RRV�@`
rH��:�w�����66W��l�<��{ꞎ{��p������Ox��|ַ���q�)vgϋ'�zc�@A�J�"*ZkU�$��J[Q�TG�j���G�VAu)D1��t
ژ�
Ӎ�a������2��O�ϣ�y{����׷~�W�����߽�Ч^��}�E���ϼ�;������������/���aǶ����# ��0r)��9&V�U"Kc�v)m-�	�Bva`l
�&�`c��{��-�a��U�@4��Zp��E[I�xSL�eD�s�Sg� �L���ڣ������1[o�6x��*�i�y������{�r!�ۗ^��!�U�"�@4)l�ZU)$&��� �P&TS�2!2&E��:j�iy�Y` 0l���ľ����^�-&�b"Ie�l�"@h4��*1�bE H��>��Ý%)Ѫ�S���R� Ё*�fX�Ȱ���;�s����~�w�O�����g|�_�;yn��F=6٦�P�.�
u$�Pb�L5�J�L(J���J�$P�+�Z�2�x,`c�bD1�C��0�m5WoC�m����W�+���z>�b�|q�=�����׽�`i�ٔ��*�if��@�\*܅�s`9�d0��cX%�,%,Q
 0�0���bS������(��!	���(ԩT��R��d,t����u�Dc��*cm�k[����Ooh�!�`����f�^{���U_�U?bf���?��?ު�!�RM4����il,��  ։V�ň�hLӂ1��!�r�������D�8��6�dSL�m����	���e���g������b���	� �\VQ��b	��1��ə�6�$�@2�QF���v`���cꡧ�G߳���9G����ȏ����������9#Q��)R�T�D�
��&��*%AU��/<�틗o�h��%�$H����mϖ��jۋ��om�-o�j F-c�4L��� ]9>�r��̫�a��S��Z��$����o�,	&�����dV�(�N�N�I�*Qj� ن'Z�Fc62�!Z� Fl�jj�w���Jv��J�� e��Ǿ||չ*�SL���x���6ئhOcج3�M���Y2��3bI뷾��_x�QK�`4.w��\�8A ̰����Uɐ�$Ӱ�*C �`  ��J���Ȇ�i�M�M�0������ �iF �A�*!���)	��-ƤUQ��@J�%�^<�����A����2D�S=���\��c��y�/�mkUK��U���.�ڕ��_���01v�21uVAaP9�/~��[��vB��2^����I[ʹ�}���G��7DRQC��L�6Gfm�6=G��`m��G�ɺ<���g�m��UI��TV�ן��������0��f
.Bb.0W�eb ��0�H�>���S"0�`�A�06؈��	U�ږ��%��=��q\eW��b����/���l@C�&6����f�MX�L��d�f��6oe &VFw��k��%�B�9)F`��鷘�E�TV�,���!� �I��Ј%��A���-6���!�Qٰ)�xæ@�j�@!XP]S*]��D �Pi&4F�RA�UA�DI$�1�ʈ@Qb��ɦ�=�S=�p���n��ս�)�6G�TU�2P)���?�ӷ��^��Ӗ�$UI��I�T�w�!�a�7��W~�^��̶}��k/kofce�Q�`&��dF�	��[�l�<��e���\�����&6�R�?��41`����D �,A�D0�@���*0d#{���&�[i�X����� �l��Zj�ZD�$RQ��F%�vڈ	P
PU�*�a<��1��6��ӌ6!U�=Ǜ=c�)fmj 6Zrj�����u�o==v�a��n�o�H�`Q	TU�F�1�L(!$,�(PF�J�HlKۘXbA4�̦M̂ ��J���Ad��J�W���HJ� �������ĔU�HHHu[l��^<���?/�Pfd�e�z�Ý�t
���_���loSf#�r�R��Q'+	%��ں.�Y���)Gt��w�:���{w� �d#Ct*���~�S�m��k?���6xse�2e�����V���/M��]���d��=��������z����lE4M5ʈ�j���0
�҅�Dbl4� �X
�A&��C� FoÛ1a[<�F�����ls�y�tm��P�˟g!z���|&TM<�RKEJuD@b��i�7���&6�kA�u-m6�h��m�V3+�ɏʠ��B��c��z��-m�f �K,$ZzJD9 �
FȪ&���J� ���2 �M�a�`S	F�M�Y! P�� bHA�$��V)GJ��(d��T"S!0��D [�M�D��>�߾��_([����ḓ��fn����}��|���~�7��;O��J+���)�`2L�*U�8��BCP ��J?�n��v�0��%f�����S�ME+�CƔ'(��l�3�Ѹy�M���d�=��\���{=�y����c�۪�]�
T2��N�M@�;W߭�XL��,�,����T��P�b��b��ښ� �����/���� VM�`H���o�L��*����R-���|_�d*6o�jT��](%�`B *ŢRG.WH�텟fJz�m�,af���nWN� Gf,����4�1����I ���9��DPJbZ��!I��-&��ؒ�a�a06S�%b�Y�F�1ecR�4%Ҩ�H�0��FU+	�cB��&6�� F�B�u���?�Pm�tR��cs����q������ŷ�z�۷^����H�_�����������1\ҥ�Q
3en�Z���~h�0d��"x3m�x?�^���
!�1��Ĕ�����`V��N��[o����4@�Ѻ���ｮ��.Wi)��]_��D)i+�f��
1��+bA(&a�bX��,1QT��i�� $ ���nWd����T�FJQ�>AZa^���KT�R�I��KuIlR�~����E5R����h�vCe�U�0������~��V9�����#S�dY��1#6$�N�J�0��	��hD��mal[�l��bz��W���:b��V�d������UK�(m]	!2	�(5de$�%F�1�M,o�B342�ڠ�E��ޫ�^�y�IU���
��'��z�G�y)@iI PPj)Ċ1�1��@�J��P�h[�Z^=f�M7e̪�ڨ:VWת���MU]��F�3�f&���L���2V�F�P����^��+L�r\�SԾsBU���ƌ7$U�X�HB���iڄ�f�PP��4��lU1#�Q�$�U�*��I ɪ����&�(r��rP-!`P�>sy+�)�l{m��� ]1�d*�2��R�(���Fc��VC�j¡�u9�K�֊���lEK�@e����cCK�a3`d�0�0>��_��کD��-@� l�յi
u�N;) "a�Ro��?��%!mK�#c��T�)+���
E ����r�yl�$���)���PW;a��N�` Q�GI���a��X�!?������O���ۖe�Pyc��evU��*%�:�UR&bQ�|��`�����{9dslB(�S��/��Rʵ��u��/4�� 6��(�D�FY��U��R�V`���F(��H� la�0D���(�ES;P�}�L,	�1{*�R�P�O����_�
Y�>B��ĴtJfI"y��ǶP9��`������b+S�)�l@��B�
6j��UJ��*a j9�Rb�1�F��T���� �F6�7���`S�@�
�D��7@��6K��Re�i��BW�SSEȮSb!�%f$!0�1�"0�L/.�����(Sy4e���k/;&�J�*,��Υ:P������d �#�\K U��(�����?�%`���=o����E]wSwu�Yǁ���*JU�hf׃jj�6�{�����R�T��;w���&H˝�/�;���([<hs0KBp�����	�F���NX���$��M3Ta�Q!�6H�EA��I�J,@1P��۪ֱ	�g��t��ե���T�*U���d��5�U�Զ4!�4�-PF
VR��A��tV*~ק���"AT@�
4 $!R�F��fVl"���،ئ�]��!��(�x�VH�e�e[�Q�5MlD@ RT�
�ɦP�@��`D,�  Ҕ�� P��,!#F�����eZA���D���*�ѥ�bK�)9J- *ɬH	��޶<o6[mT�����o�����J	��U�SSW銢U�D����dG�&Ya�(�֩.W�*�*��R.w��*�)=�1��Y�K�T��(Ե� �
�,!�N��*H����"�#�`h#S@�*v\��R<���^���C���?|�_���o�N�P�8�`�DYk4f�L)^%�mb!�B�K�4ªr��-Lc�U�*�����NA�(-!`Šb�b�$J��T	e� �6�L�bi[��D�HZl.&�l���[�f
�@T���2#��܄L�m0V%1������� @3�Ă@���
>�������2Ҫ��01h��ֺ�U:o>��t��u�����ŧ��r)U�* Y�Xm{�����@��\��uʨ�����B��R��Q����X�"�ɰ� �kSYI�t*�;�քU������N��\:�0jc ���`���*����TY�������׿���%RT dAEZ�1L0Vl�l�P���/?y�Ud v6�Kl�����6���o��Q W��kW�.�Jcb[�Ylśf�T�lj�؄���"X�"K�U* ���g_��ӣ2G��C� ��A)J�����`eOr�*�@��mP�����
��hQ�B��K�Z`CHQ�C6��T�N�m�b�"0b0u1e�f[% �L�L��x�}���� �Q*u��Mk�%��dJĸ��
\�Q�
��/_J	���{�6�m/�F��C�T[1(�o�Mm�l�X�5�lU�n���B�Hu��Cm;�m��*˲rJ�qJ�D% �b
�tU�"�K�lƣ\.��ile�X�AtTU�g�15�V�&"*a���H�h0�.}�����D�P�iƛ!�y�ӵKS�(��ꜾVP��xC��ޛ�D���L�f1Ւ���Z~����~���V�[z�%�J�eJsQTK QG`�8�o�%` �RN�0�!b5��٠��&
"$"�U�)���Ĉ�D$���& J@���v �� A �$& 6L�UL@#HG؈��(!�ٝP��
>xϷ|���7���\�Li{���x��l��%��U�3"2AK #!6�f�c��ˈT�w���R�)����-3�G:p)��Tf$���F(R��
��BW�:���J�\j���J�nbA��w?��&~Y�bb ����x�bf����PaI-�(K���"h��%�=`0����q^K�P,&�ʹ���r�4*���M�.�I.�vk�t�h�mc+ޘRk i1�%F`�`Lqǖ�ƴl*�?��Rd�RA�`14�1a� b,%��{���9H �L�a0b�W��$�Q�&#�jSb[*T�%UH�������2�Fu�� ���PS C�)h��u��ۯ���6���f�M� 0K>��m��~�W���{��2Y��X����V��Ґ�+��6�\ժ�*؜��i#��-�e����~��dYF�-FlB��*M��U;)\!˝�۶E����mW�u��=QG�R�T�Ү.w��X���m���ؔd���m���*s�1��l����Uk.  *X$b&@���26���k'��b�BLf��f�Q"D�\��U�Qg�%BE��g[��>v����mf+{�U�#&�Y�)��j0��RbD�X~�cQ0�m-�����F�!�H����� Ec����BA1��D�ĤA1�a�A�"�,!B"P	�.׮.����%(h�$(��p��� �$ �@Rm2��|���~}@�+8�R�N��h�=�G��G;��h��]?�~����~�7����Ͼ����y0��^ݻ���;w�u���qZ'�,c�K���穏LJ���DI\E�r9u��ɭ��>���%�Lb�4��M߾�S�C]F���
�CV�"D��;ZESU�����2�su�IDV]�ѻ�vv�R=q�I%�`eT��*���Q#���W_��ȇ��|���Jb�n3SV�V�aakF��v�1��"S�2�����m�f��4��uT��UMQ�lʘb�������U��*��W�|�@��ue��B[o��|����~�9�&�]6��0XA2��0`*&�f52���4#�c�7��ؔE @���HU2�E�6c %e#JSLZe[�l��*AC 1�D�JA as��k��K#�����h[?=�t6��@|����[�\!� ǲ�b�!�����l��^�~���?����w^�z�ח��v�����^.{�x^�����?��o��a�����w�r�#�D�@��:��k]ta$� o�`b*V!V�O����Ā����N����U\��CO�ÿ���Q��j��9�@&j�NlJ׎��W��Z}WO�.I����%�&���}���l̦��q��p/'�[ڌ�Pف1���p=����%���D"��0c�71Db�L� ET��L��.l6w���_e�V�@�^�TS�/W����2�w���&��[,���#SF�����(� CLU���Lo1�%�� ֈH(�Fӟ���9��xvȐ�w��;3��rFl�V�Ć�	lb�#��ӟ^�^"$ �H��T�(q*���$-�*@�c11���MwF�f]�``����G��x��#���G�/�����?tի+WC�`�􃯹�#C(SQU���U,[� ��0h-�5#���&�Ve�:fV�Q�
R�)��� ����z�����*;����.�L	c�L���iw��#���\���P�`UK[��_�xKm<�wI`�|16X�� &��E�0"	,�*fV3��B�M`,*�B��P�c1Ŭ�*#U��$Ժ:gӪmc1\*�F�m]C�*X�FM�ޮF-�fզ�96+o�J)�2Lo�,,B0Һ�%ƻތ�� i
�`J5����߿�_O�i��t�Tߩ��0mb��lu���l1`l��յ���G�_�Σ4Q`)R)�D��D�� �xF&���Ma1X�B�a�8��Ԭ����  6�}����v�|�W�8���T���m�m l$�
�� L���XU�Ƥ�b�M2ǄLe�8]R�T��/L]��/���G�הt�u�K�Ȥ�zsȲs��]�r9]��\�A��@cl�������bӖ����f�l�f1x��v��0�9|2T�"��(�f4ak����Ā t���*� E4H��cX��w]��T\���͖rI��di�X� 6�RlKef�mi�V1U$M��j#�h��>�����o��&I�蹟�C�E�*#"���J���^թW�Uw�<
W�ao�Um�0��e� *��b��G��(@�J���<4�RI��Dd�\  �5��M�&�Rn
�F��0,I��U�b�iz}���߫�ab�@�%� l%Oc����UB�Kh	cmK����hUI�F�J����~�u���p\��]�)EFG�*RU�`$�\�jB�I۬���|R�]]�<Z>?q�����()ԑd�*�m)��̴mk�Z�e3QSL�6kC�y�N�xbSM�)+ X�4W�Ao��cDS̡JuT�v�,L�Pa,���I����]��rU�<3[�-m�ֵI1����l�Q�%���}u=m�m������-� �%R@d������?{>��!L�����y�d�����Q��2'�{�^ի�{�w긧��q5�w;
��XleS��b�Ř��o>����!�JI�  7G��������B##6H `���)� #�� :0�j�XPV���1Ÿ4�Aeذ�I���"�!� ��`k �*ԵK��)6�l�mU��7
T�:2I�����*��˝�Bw���TwjW��.�t:=��a�c�)�:cZQ��<�Kv�U�������q�7����*DAE< ���lmm���,Ab7k�`,�3_���o����f��B�QSL��,6�2ƐD����C  �d��\��:�*��&a���-�r�s׽�|��r�B�y�����쏯���J�p)ۮ����s6�id��ӄ������0�6�?���5M$���,�T�tx�W��S��;�J���=|oؼ�e�b�b* @l�lc���χ�A���\J���&+QLU@��a�R10�D�)�(��V���.��{��fW�����R�ފ۰�Jw��%��RA �#�����Oݤ������;D���Ӗ����ר�&m���Ū�t,����)��&Ke�,r��D��Aܙ}]��el�G�VmT�=�(\ʏ��� ���IH�ZE2U1�MX�5�2�*f��]�����Ǜ�a��k�_��q~11b��X��fb�L�)+��Sհ ��T�/W�]61"02�Pu��Ww}�]��"Wь1m��-�U��j�5ʈKl���؄�@���B��no&`K��Kl�IiU��NIEG���z���tߩWݫ�U���[\]w�UJR��
��":����H�	W(%�Z �vՖ@�4�bB�,15*Ab��,�O���e�(6���*�	dbP����/W�!�������|_=��C� ���j
V
t6�����)���2[�bU�6�������l���^(q-u�b�me�3��u���ӹb���)b��S�J�C����ʿ���������>��A�ƙ�YX�j�mcH�,����	0�0&��,�/>���,�16�ʹel���`������~`(sH���nN��Ѡ����@�f5��Ynn$�H�˛�}f	�E�� m��F�X���Z7��ob�L���@ ����U�:��7Of��m6����V���00���^��}н�(�ݓ��uoU�:JF�������TG�H
�F52�J�j@Ո�H(�d�@e&T�2�*�����xl�)��?~��~�cʪ�!��J��7w�ͷ��c4(!� J�T��@#�w>{�ܒϮ�t�U!��0��l�ew��^{���/ޙD��2ޭ�lsκ-99[�լiT���Q#�RFK\HXЌ2���)��������O}�˞���d�إ&^R��F�x�1�1N��n�ha�ɔI�H�e�����6ͦ�(�c�a��!�z���1,�}��lL3��4 1���3��14b�W=}\�Yu ͒ȥq3�f��x����܈�av@% #a��ҘU(�fh��Ma*6#��0���s_���^͛1`�l�iC�����R�fyqu}������˱ٳު��J$@(ŔbDU�B@�HeIREH��8(�$I5��6LT(�TZ��(��@i� `���P�����fP&\h3��s������)!@ �XiJT*�L@����>�ܗ��VU���I1�U�u[���Aj�m�fSm�!gW[s��+J�P,%

�P4ƛ2Hc6k��iֺQ�lױFK�#�h��F@��J
�il�a,z��1�e�HLR�o���}�3�� �y��� P�6��MGC�40�>2@m/�V���UJ3�������9�h�m�h�6�`��PX�		�
�j-�e+��m�l]Ȕa2E������1o��O��&{l ���A �g���U���;���%�<���`� M#1(T$p�)�Dʐ�"�pHJi�F	1
! ��(���" �aĊ5�)Ii�[���M�a�7{a�K1s�(&�� �A%�RK��T*3������jm�g�l���oSي��>��M�3��U����U[���)I@��}�0�-�و����l5�|��uGֿ��c�ޯJ��vg��O�Z�����V�"�`�P��'23�iI��ֶ��c6�m'$F˾��@T�baA�  F�[�}������!i�m� ��*k���?/=��U��j�_�����������1�U�8ve���0�
d���a�5ֈ -b� Vc��7f�5�[�ǈe[�L�H�6C�~N���u|������?{V
0HJSƐ�M��D�j��`
j [H�Z�J����%&�(RF2���?z���,�(U� ��PcF�l��%�9�Ut�l�00��m�� 1[QLH ��bB�6$`�(���T�&! �j�-�_���/���h�l�u�o���V����p�i9#�m%VU'[�96���|��l6;jeo}6��O���������u���r�k�b��sX�5(��(c������a@+2i��l�46�Bc���\�� �1c��d��&�,b���)���������������X�i/=>��qZ��{������=�������}�i4ˑ��v�&�D�A4f�E����1��)h�l��2E�6��a�x�.����o��X�`9�Ɣͥ4�l*_.߹:�_�����~��۷`�XR�J�*C1%�"J��l �2�jeB��$[Y�HL��@i
��o����kF�0��w���R��1#P2(=��*��?����El��sx�\QFĘ��"%�4Ԧ���b*I�B�%��$��,AW���)��P�&n��XuŞ����1�Q�w�J�-����Ȧ�)�e���M����_�{7o�5�'w����sm�q�0+kg�R����������L�6bJmb5���C LV�)����/�8�
2��(clLF��`i p`	i����~���2`/`ä�a���یw畷��տ����w��x�7�a�T��>k90�i�ب>�o��U�]%�]�XѬ+G���D��V�`�d�f��l6�x�.z��&�8.0����r�G���Ư�7�ѷ3��?�(H(
�M T$s��ϔ�!az���~�F(1R)E���/�ׯ
������T` �0bD�!��T����w����Ͽ	`��*��K�{�=��&�ՔҖ0n0� FAH�b�FmC�I�V���U��Z��& AtSUg�~��~��>���u,;�Q�v+A���Ի��/6Ӧ44�r�K�6kxz{�=a��s�X�uX~����?��h��~���e��S��/~�=Oe$6�
��hiT۲sT�r�2F6�f+PuF��i�ċ����� ��_��� C����m���a���~�'?�L�f���Lih��2]�j[��+7�M)�cz�i��g���F ������oK�F���}���g_?�KS&5�iK�&m���JU�K��pLC����c�1o6�x��B�(�� �l�&��<�~�v�_��?�l���+L �R)B� A� 6I��u�����&aiJb&�1l[�1JX��h��X1�,������%�KЖ֕�=�[�&&I��w�\���1��)�.WMF �-Q�7�t+�l����$��H�CZ��O���^�~wǳ�Ӵ]K_9�U-n;���g�>K�h���>(�o�T<��7[��[�a����uZ�r����m�'?�9�n���[^�����(e:�Q��^��-�*LZƄ���T�H� X�4��N�(���G$FKl6�'%Y:
���O~��d�٤l*#`,�xY6Zlj��jQK�H�Y(s�m+v���O}���jJ�/�M�00�]6c���J�"w�S�����o���f��xwo�x��`� ��0*0��c\57m{���y��������^3[l�� RD �T�$P�)(&�i`l�P�+�
@�!F��$ x���T�H�� $Va�P���0Vm1�N2)$WWg�� ��P(*JĄ��*��TCHf�U�3��"���mi���Yؚ�jw�r�.9X���f�؂X��Z��)wj7^��Z{�=m�o�����d4bώW��ʥM���з|�7����f#`�Ikv����Ԁ��16��h]R
 ![IbB�x��+)`�6�c6���z�hLK��"j�ni���j�a��u�
۶>s���iV2 �T�bc�,�CM���S����`'��*��4��f��fL��1�D�95�Y�{��	����s9�+9n��O�x�f��&D�$�,�,� ER� ���F�9	�MK�ӡZ3�Bl�@@EHXb�TM�4��Ҍ�X(,��|l4���bT(������}���Ͽ
!�s`11dlF�B������`.�DK�	�`}��h������H6�Z�ۊ��Vu5������6��D������L�s�>;��y+���������ӳd.'b4��v������� \�c�9m�Fi�t���iH��-��L��?��(�U	�� � J$�d˖
X�BS"����:35/=9c�fl�z��Lck��X���V�%Z��*�gm��~m+)�����$3)T�:ҋ��RwU�KJ���f sc�l�l�Ǩ��e#��9�l똰%ͳ�٣��c��{��W����3o{��  ��� �7��x:I���b�r�E�Hm���,�L5��� ZKPY��D%���a�k(�����������l�E�΢�x�Lln��������~��_��B�t�Ks�X Q�be�6��5RYi\�UQ�B �Q[s�9�_�jvw�K�uSB34F�Ҩ�w��.$x�f�e������R!,���� �'�Uf��h��,��ι��i75���
��f�M�,�������o{ܥ:����U)�D��7��P�`s&�Z���&a��m��%��{�6Ӵ�*k+A�*�vSa4��n�f������%��ҐX��\0�2R)w�t]��R*
�wa�Y(c���d�G��/��&yl
d��I��m*��a��0�|d6��\��^���	����u��$��#$hx�����Je�VF��(R�D�,�I�� J٤Y� $a�FB�Hk�e�4P��VE�m�~��^��
p�q��'1��(b���w7�h�x�¢�$A,�X
�@�����BX}�r(D�-�ԍ�qtF2������A���--��	�΀�S��U.��u%�N���m4lIi����PMV��B�ԩɵs[��$�����1HA���
%T�j]�E@ 1W�.$r�\�%"esA�Rd4aH@e c�P��-�jx��n'�q����w�^�LN֠�a��ڍvk�EE�" �͈�.�܋z��{�{��� vѦ<�u����ҕO_1��/ �rs��*�۶��c�����ȝ�$D���$ 	��� �:!" �hb�BlU����5(E1���d(�0�)HK�J���L5�A��T��2*�+�	��ۓ\.�IWw���@R[�6E���P�V�"q6!P�:�D1!�l�Pr�S��K����7��@gyA���:��ٮ�Y�6SifA�n�$�L��+�Vݭ
�c��f��Z��Blk�5֚��Sۑ�M�v�N��$�+4аcȠDD��"��T�UJ�"	�EE���TWג  (�C
����b29-��fk�ں��1#Q�mK�]�խ\ i������k8MwlW�r)%E�Q)�J����S/���]Ww��2M��!���o�,��`��[s�5�c96�<޼Y�l��Q:�+�����0X*��(EA��	�� �F,@����*]e�aB�FEA���J@IE�A�(&�zq���j�[�����wT��PH�DG[Ba��eWX!۔��& u�(�"W%��|�*Kcv���i��sv��8m>�d�f��ݭqapu��0��ZRg���}WlKcNei����6o�k4�c��i��
#Yk�$��ζ�&-�
�J�Tv��VE��(�U$u8a�QDF(��4�Y T�ljk1�Ύ/6�"S�KZ������|�-�gi7_a*�a�[YF^x�������wʯ�H�ĂJTt\]�R�U�����̘a`c�BX��LƲ ]�r�Y\J*߼Dc�\]�dX�=�(�����$!�D��
%�JB �+�6+``� K��&�L*���@U����5@Y��?�l� *܉R]�.��"fai��%UGs�R�.%4Xn�y�Pw.T]��ڕ��jT4IL��v�x��s���Wg�(kT�!a�^��i��tB��ec
6���F�X�K+̕��nX�`@��N K�Ӏ@�	�0������J��r��ti�"FA�b���1*��"����9��3ɒ����4k	a�E��jWe��}��~��47b�^83v,wBt*5/?~^~����!Q �F��r���Q�0v%W�ؘ��FCu�U{���E��E}�y\�;�ǘ�2.m�U�F�*��	�DUR��RT�����DXZ���6c,4�RhXZl6� 
Rh�\�X!@�@lI�kMŬ��Ʒ?>��F�]%�.KԐa�X1b�EN�V��F�tH�UF���?����/���R�S����w�b��¦z߸�g�a��Tnu��e��5nw�VwW�W�l,Ũ,V6�Q�J;�ëz����'�1�뾻�iӼx��dV-�0rl���0�a��	 J
u0RM����t
o�F�PBU��%)r��8h�`���!i�	`�8v5���PK�&���-��%:v�\.�ru�T���?���X��*w9��]���������~����fc�n�;?�^?6xc�Q��KA6\U鲣��kW׾1곇�����&f�&ml�`A!��WG-U�%Es�!�4`	C�6��b`�BX��a^��	bT�4�4�J�j�V-0,�Z ��j�>�=R�rU�K�rA�Je��4�iD�"��	H\�"wJ�Nu������u����#�g���9K#��5c�ӫ/�.)�Sٲ��U��]��������쩘c��Y	9�^��ƍJL[��{y��d�-!Si�ɤ����jk�4�MݠF+#C(%B�T�J��AU@�N)���iH�t��RR1��0���[��DD,`44l^؄-ɬ���vdl�T�+ۇ��Lu�d��da�C����~����G���TQJW�Kw�:��x{�W���l���f�	<�؄�j�EJu���ܡ��s�Mc�FAXE%k�	��F��l11��$HR��r����R"�HA@4[AP��،*,������W�P��*#Bي�*
�2j���F!0���
9$zq��r���H뚕 ��d�����fR��XE6��9��Nu��.�Jkꔊ[�)65Noo-V���2:�v?��&�yW�hɶ:��������{�V�{4��`]�F-Xw��VL��� �hnP�{��]�1�lz��܌FL@k���X%����H� H�kD%UGȈ�BAR]�.QJĩ
D�)����R��c��XT�jIkw@'�4~������O��F�F�ς90��^|�K�Hu!�d)�S�;U�
��^��6��2xl0EHc��;����w*w�s���-�t�r�)�j�$I)6��U�@]�\JP�T�R���P� �����TcC��r�o�F$��.��q��%�##� �b��"�4f�k�B���8t�H`lH�%d	($Ŧb*B�
X �*$]�tݹS.�|Q_�vU�\�:�4��.S���6w9*�����������w�v�]ݶ%'��Mo}�3�1����%WmӞΌ��d�t� R�h,��,�Xә��]�c�ܶj��5���	�� ���Ȋ��)E
Y�:�TPR��kUdW"�R$W4Z+ж������K>��0����l�`f�LS�Y��.`��i���~�'?�Q緌�}�Z�v4�Ln"��K��M�i<61�cL�RQ������W?�����1��\0ل7��db�C� �u����M�5]V��*#@N�2հ���Ru-�@AfIQ�J	 U # ) 0
�F ��4�T��U#-���LE,@�Q�	�	�*��V��TJ�-&�:c�%m�"�L(j��IbJu)�l?y�O/_��UUW�Ju9ݥ>�z9��{����4��q����� �vگ���Q|��������>}hv�$��m�������M�:MIj1���Zli�t�ˈ���`�����im��"mk��U?�wʧ�_n[�A��H���!UT����K���#ժ�I]����ʪT"� .��UkE��b����s��X�� �͖����������թ�3Kl��[�=����������~����xl0�l�I�a��o��{��a�yf6�lꪰ�`�"
�X�s�d}����+GMn��wKP��m�kiD9X��]e��T
2"��D�2E�
%(� "� r �\!0J�
� ���H$1i�(b� V T�b�RP��J�UK�c�)[ͮ
&J.5�HL(D�
I�}�K��}��s�S.�\._G�U�AU�}\�J�y��IK���������o��U�����R���7|~�?�Q����U-UI"V��GX��ܥR�Ym ��d���de��]�b?��?�S������>�JUE���o��=A��Rb\;���"s%�Z�|W4�v�)I�@	AA���N�d���uԒ�@k1�������a����;^{��S�:cW-f��9ͽ���>�i���X�Ȥ��V�&d0��M��J���{7fc����?�7�t���-�TU�FG�r���U\(�0�|���^��٩����m�4��9\2�C"��r)�S�RG�,�*��R��*�(U�S��E��� ���)�(RR�� �-C�*E%HPe,ɪ�ruB(1���U�D�M� �Q�dU֑�]�r���t�DWŨ�\*���v�tm���^Ejv/5�c�O�������>�a���/�����5�	���Z��T�*(�D�X]6izs����\��2�ȞӦI�f�2$�0��|V1dctՏ��_T���!U�PT���P���.��7�����[FsH	��u���-I&�u��͵!͖�a�,����9��o��ϯ�������Y��({����Gjs��`Ӽy�@�I��U�a�xO{��g��n̝f�E�c�8F�Q�)�""+�4Ì�fӶ2)	+��K-�Ʒ��\�:��PU�*����\E�Z� �1` @
���)���k��	Ř�����*"P��:�;�*KL���+�ꐨ�K�
�t�j�\ҥ��DAG��Uեv�������E��Yb�ь%I�U��v�L@�϶�=�����n������n���:'[>��r��RibZ�V�@�i6�z�-Fa4/�ۺMQ�qw��Sb�5PZ�V�2�US�$	 D�NT�$D���B���� $����[zK�����V\�]��εU6K��ȲMk�F�e�����~�O��=��8i7��9��C�(+�e�{fRL3���S�D�Cվ��b�m=۬���<�t�w�.}ty>��#D6�(�|SR���{,��a6��iƈ��@cV�{>�/>��� �@�:1J�Q!eW�J�B�:B"��I�J(1�TT�j��BP@m�D��UH�긠�J@�J�����!�KU��(SQ]���r�\. Uu꜔|�]U��]w��J�t@e���0���Y��Z��4�u���f5!��:Z����m����j��V/k�W��B��>�u-���F�vb�YL#@�>�����`��"G��HU.�:P�g����k�����d4f�"뚊�H1��S�����=�yp'G1�z�N��;�%5`a+A�d�yFN���_|���Mww�Nw,�aWc�{L���Y�4x�B 6U�r!I�j��6f��UJ�Q�.��\.�� 1D���j�0��|�r�:��:���T�|����ˏ�OD�U �:	-��
��R�ri���*[U �F`$ ��!1 H�A
PQ�M��*�� �e�Dd��:$�b�I.G���"1U];�>��=�*�ʩI�H�H��}U�}U仺]��u���V]k��RZ���v"��o}]�Vиe,�����؉!hLm�V[�����"��
�U�ݦ',f�f��t��	����g�M�J�5�Nlծ:Fl�4�����U�K:ʥ��������}:ժ�JA��}�}U��m�P(�Ui���˥�Ewy��Z��=�����;o��V�m� ���2�M�aĀ:7�^.-�MlZ��YĴn����Gώe#�_b������e[x�%:�ե�c�K)���B�e &l��>}����C�0��6�ͥ�����qAخ��ҤUԤD�Ĩ�����
C-EF
 	 @ F�PѴT�*�)�!A��V*�U������*�'J���$��etR?�����*WYu!Tq�"������:w�I�yR?O���O/�=�����{��c�<����5v��]a��Y�������/>CېٹM�ĻKv?�j��4l$MX�h[���T��6I�<!���
����n @5�cH��vw��ҺJJUWw���_��ˈ*Uե�J)�&����0�0$u���(�:宻O�k������8���j&�������es:�#�Q,��!'�g�c�6Wszwe��m��>i3CB�1C��b� �1f�g[!oe˂(���KGIeLgpDYF��l�@�ʑ����kg����y���b�H�K��R�P��*UmRVe%�)�2ʠ�ib���,�N�0� d4�X;k�F�U["�Z��b)�$�$�(Q
J*!a�Q�
ݹvb�amjVTw⎭*�%�B\B��۝I���~{�ܓ|7�=����u����Uc{��/�t�Z��mr��s/+�zdv�}��o����ߴf��īh[nƍ)��Rj]Q��[ڬ}ZZ�hL�6Ls��� �"�Z��Y,�0ZҮJJQ�R�%q��D���A*ת��%�,@�J���[����������}���~��|{���a��b[bK�a�4�1g�h�c�l�ng�Gph��<�{7,`]��>���G�10Ș16mxc��`{lh#p�.+$�O}�o��)^Be1Z���3BY6�T��/�K&2M�HM,�1D��l@���R#SH�W�ʊ2�!���!�����g���>�e ���X�J�6b��V�"�%F�bPG�(��A�IQ.��ruT��+�BH)��j)�R)�R}�"��s��=ԝ��]�s�||OK�m���/}���v�pO�U^{�<��ю�|b���[�q����V쩭�[U 2j!�X�˒�y�U��4K2�
�tܪ�]�rHei���mp�$� *EU�՗O�r�D8%�A�D�\�,m咦*@lZ��uu���Z���~<|珿�ͭ[77}�������؀&15%���,���whwN��d�z�)iso 8bS�1d�Ĭ�A��I ������`AAd(,������ 
�M���$v6���f`A#� 	�*,Dɥ���e� A�b����@�b��}���o<]y�o�����%�@�Xhx���:��PAnH]JD9.��P�(Q���0{�Ġ�MUEu I��N�
���O�p�ԙ*WW򝞮}�=�g!f�j�U�Z�e��9ۊ���H�z��/;Z�nu�q5r�XnX�Z9[��l��,A0բ�Ӛ	��%`dօ�G��3i�8�6��b�hPK�O�R��Q�r�(@@RH)�T�2�!AH��t�.uo�uMc^���^�ƒ���7!m� c�̔!7c'�����vXv��?���_d��z�@��bc��CK!M��� �θ4�%�#^6@Tؼk<F�a�-#* l�U'66��b-+flҨ}#����2��J��QRQV)U����?~~�O�@ �I6��Y|�]竤k)h(JP�����:� A���T)���!"��RZxS@���Ju�%�T.%��rH���.��=Vwɥĝ�/]=�˥�EFJQ��7_��S�lW[�+{Ҏ����s/ޤϠq�%�h���и�h�P3��l�Z��h0�+#��^�m�rDu�;�c�vn����n�m�%qoS��A�
b4R(�L��$J	e ��C��-��B]���Ͼ��ｾ\U���*ˮ}׿�g���7|�>wז].ۀT�Ha��!����џ���QS1�@le���?~�G����_��ؖ�,�A%$��ؘe�DD)QIl���,ƌ�l�v�����T�=�G�4�\}m4�(T����/�>}���(W	"���]��ԵJ5
��w���`@��TFbBB�@K!�@P*` � ��T
CJ9h�ϠNI�.�˗;�U!�Y�x��b��*K吠K�/�|��|��>ewU�E�S.�nN�V�3���)�|v��7�gw���ՙ{����h1J��o�k����է�Q,�R`��?����o��Շ���FK��!t7�i��n�-6FKh�9^n��)
AD�QE��ҥ�x#EI)%�x(LJIY����RNթ��8�����/>��q�kײ�Dekca�%mc�lď��7}��5��"����)����Ͽ�z����Z;n-�8���]�x�������i.�E0L%����1ey�e �02�0*0#SX a�(�K,Lζ��jt�\�+�!(�bD���:hJ@�H3%H�5U40,,4 �H��06��@Mc! ��)�*�Ҡ���T.����J9�I��۬�ĀT��t��W�o��E�q��)suj��=��R}�I*�t�ļi�Ku������n�Emn���NhV���Zn�R#�^}���K���~��ߧ����*�P�2�>�E�4A	����iZ�IK�KM1�x���x/?~q���H�6�),�S)�DN�(M)�䀜b+Ƴ-0�D�jN�(	���q��n�3��y�{��w-̰�xz	�L��H�r��0#��,7"g�E������ן~�����Z�k\�1�&ƌ3���0�V(ʦ%Øǲ`�702��l0ư��1`����Ť�Z�ZS"Q�XV���̴�	RƪF�	�@�H!"M� `a��	�*��Q ISU��'���K\T:�S� 9�a{�2k��|#i�4(#�j��vT��:;]]�\HJ����*5٪�r9W�rIRD���j6MZ.��r��rU�rU�o����.�S��4��	>�P�Ɗmi����[-��CE�f���������v��A��C#�PP� ���"�M���b8~V��tv��Q��U�P�J�.�Ƹ�v����v�͸Kc+foh0����%�q��w9����?�;?맞�]m���b�K`���`k3H�������v�0��0x���$� ��&%�4�D ��)U�檏�����}�Q��t͂��E���#j�T�UҶ�M�D#5*Q�UQۤS
Pi�9�Q"� c "@,)�x��Ƿ�H�9��ݢ�js��U
u�����\��g���/�=�giٰl]FAY�w�u��r�z�t<Y��%*�q�"K��ή�{rO�i�5ކ:�/	�i��v�v)Y�����" I�Z*QTu��*���Ս�����	����Yg��/z���y���w�}Q{�ښ��È -�����g?�P� J�j�p���(G�,�;�N���Y�n�P�&�!"�1��v�v��׆���fzz 'z�,���(�����Ϊ������mg���K��e[�f��쉕K��締��ZB#�xl�X��j#@T5PY6�(@�t\Ї���_������?���#�PR���rA2#l8��xT�1��04FD\L9I�����{>S�Iq���JQ�P�)$  �`.{q�y�$*������j*�v��;"j����JU�J"NR���+?~� 8��������+pu�q�\}��ֹV�k_���_��jw���ժR�:�"�Jɝ��ʨJ�r�]g`��Ao�┶���,�r$15�<�rԪ�SG6T���^���uOz�SM�<���?�7�=o����{�@͊c��m/�����ˤ6����	�-����F)[1L������(�� B&��|g��U���!YhI��H���x�ۙ7��m�&L����H��&c`���Q�.QT�R.��u��6�/`��Lo�[Ә�U%�F0D/�
��<� �LURJ�(���rs�w��NWwTYR�"�����ȟ|G�e�5��)#F���a�)��Q� J�8(��J�#b(+���@�
 b.���y��Z�����%��Hw��*�(��\�I�J�`&!� 
 �:!��\pG.���v�t��旟��8�RD۔���V����RI�R��\���Q��/���UƬP"4J�� /oUWAT�ͺ����QK��{*ٖ{���0��������_���e�{
L���Ƅ��U�i��;�&61��u��#BQ��誤��k9eD��}����Q�3ⓤ�i�4�].k�f��ƌ5Lk	����2 Qԩ�ڱ�#��4{ٶj�İa��i6a�Ԝ��/����@`cD�lZ"E�QBB$bT��R2�ǥ�$�a+T�#�y��6AV�c�4SF*�V9f�*G#Q
@M�LE(�PhEY�V��\
EA!�Z��\�j�T�H��s@�V�h��bj�$A��=�������*E.�r%�n�$�Q_fT�i� h�ȥ�1&��嬪�b%�Y�R��Ծs�3�Σ�0��4!l[[[)uDhUT��EK�U0�c�LE�sWOi
����W�}�S�~�S�����?��:�m�m�q�&[�H�K�i��&
"HLR�؀�>z��� s�'B�r9pW|�q�d���2�����7-�j����dV6���»��l3EkV	�����׾M&�\p)��T������9ޟ���/�y��f{��4�QJ��V,�1J���sveK3U��m�6ƛ�!w��HQHTW�����}z���Q��R$��l� �
?y�qP�(Q.r&[,.7򒥌��*7��)���B�^\��C�(ru�H��(U Wrb$(�$VV�(K)�Ò�{�TR�[k�`�%��"i5�GL�*�]�D\�t�ۥ+��]��b��AɄ���:��l�#��]�V*V�]u�r�:w}����
��\�!E���p�d�*��IIA�"wZ(r���Z��������o~���������6�M�����fv�`�����0�m���P�(-��w�%�,&��eSBD6��qW�#"f�q��f��2H
�{Z��`����
�����F��}����z���f֕SzGo�6�kA�$����=��f���1.rtR@ ƥ�j�T��~�)�;�rD� �m��Y
�X(6�T�\��c�FVF��&�
J@S�Fʗ/��$��Z�H��^��)����޿~���pI�ן����*XR�4+9��2ՑE*�J��P�e�ds���)GҚ[��ژP�QdSPJ|�ZU�q�7' �BJ��Rw����%��\E]�xc%�ǲ0`�R��IE��P���ox����r���>mdvT�*r5�]��o��	�j�̆���@<�M��Q�� ��(�����X�
P-��N�t�#Y�6��(�,/�M��"�������`zW٠ A)G)V�1 �rBI�rVhA�&z�Ȧ�`�m��Hb�D�(�ݛ�w���M��W���Q.!���\P
.�J  �(����x��1JĴ�bl U��@e���[�����]�/���P� �
�����.)�բ��*���#�PR�]N�b�,�I��*(���[�l��%��T+��6W,�茣��Es�O��Jf�L=d8�J�{�Ѯ�T�MI�K����Ԋv,ń�6��L @���
U�H6H��Q� �9��2�ԥfNS)TaMV�Ev��v`:�l�ģ2����![vO��4#�٠)!�,Q��&�;w!+]jU� �Xe�bKR��G��alb��M��vU.q�l�@��@���
 iӫ@��fǶ��m���*��a�]fkk��X�A��A'�����҅R5�pD�re�`"��
,<��&�L�C"KX;���1b 1�drUZ�*Q$@+#U�.� D@�D@@␒ز���{�7�Zg���|ZC�\���en���$FB��4��2.�D%쒢�UR[3�Ml�R�&U�S��t@U۬ƲR!1.̄�#Li6��\.(�\Z��"6��*jA-m�H�(�D[m��-���j�];�:3w���BLq��&�I��H��j�i�d��M`���16x�Yj'U�e�8K4ΫE��jm�VAI�V�L*�1�d�(�J���P�K	9��
�@����ͧiJm�X[�+�0�l6le*�ق�w��S�;��i���h��KY$ԉB:�M�IДA�`L��bo.�@3�+U0�!	H��R�#��*(�Kܕ*��DP	c"b�BF���4m���XD���֪����Ȫ��R!�(R������estԵt�t� �&6#����q��R�d�.q\n�._��?��?z�y��$���������LPI�Lu)t���K�*��\�f��P,�}ٲ�i�ɜ�[Ƕ�Tl���Qn�B^>�j�)�h6 ��!���䆣PQ��e��Yd%�(&�jHҢ)������>|��\nBhS@'�Ju��-��0	U-���4�7Q  Fժ�6i�&`��K�lƖ��&�x,GׁR(U�* #J����}���ǟKB���ǆ�(HSJ\bvs�4��Ҕ�51��$̄�l� *��@�Q�Z��X%W�i�b)�bD�Jł��
�
�BE@T+�XD�� �#Pʪ�F6(�R��~����Ͽ��*
��h`	ZG�n"ţ��E�-���������񨧂kϛ�s9�WR�&  �/�rv�Ę�C�*�̅�6ꔪŤT���0d�����#������0�m�~n<y�OOl�ȶs��@AИf �T
B$@S�V#Q!)�e���#E�F�@��Ee��UL���xB�I��?���WE"�@��dI�Hj�H�U �
�i^=�7B�16x�'���*Ҁ
]��ruv)r����T%�
 &6�?���G�N��SY� ���O���m�r,�BX�Y@E�����D�*sL")�P�E������P�x�Q� ��b�J���i	)%-��
�D� �QJ`ʴH�Q��~���Q�������eKSU�#�"�
5j��vV��5��F��L���@H�h�;%�(_�]E�*�
ERCZ�e+4�N`�Ml,e�����(���̑q���O{�s�K���QX�) TbV�����ѩ­XƆ޴�td��������EM������fU�m����DD�$���	�~|�Se]Ғ*��J?s��]��Rua-U�=�1�1�F{�=1+�Y�R�ؔ@!�#0p���K�����@X4�ǳ$q��k�f�`L����������TKY��l%���j	��ȆebE".D�iUZ��t%�R�\��	���a��4�����\TH�Ғv%(wF�.)�R]�2 �
�6�T���vQ̖`2 ��V7��]SBV�"��(��Z+baUIz�Zd[�E�D�V23��hs�]qץ[���N��*�]ѱ�*�de��N�f���`��k�Y��{��O������V�H��&��U#M�-, ��,�V����M"��*@D�y$�wi���/��Hwl�`��(�RWw\N�:p �0�����(uբ�M��|~���K�U��r ����4���i��fc"`Z�D��X�@CS%�SJ)�b���2��2�#�)�H,lO[1�4{Z[0��ys��q�XL���l�Xp��Y�ڪXjK(��|U."W�KG*�4*U
/����J+&T�]*�$��"-�k�*��\�mQE%�r9t<��\�l#��++�&E+Y!`��m]�t�%c2!�*��U.w)AK�d�	Yd�@��$�R�ε;��wN���Rj�Bʷb)���WmiFX##k��L����������NC\���,g(��)0# �BTc3�F��$tP�~JdQ$�t�e������ʧ*��E�J�(U�J*"��VFI]��H�¥ܷ.~��(%%T���јbRlb���֘K \*� ���Z:.AWQ
�A��o����Q"����^S�iC�ӳ����)P��mOY���K�)x��V�oNh;�E��R���V����Bb�^\�q���J�R��T�) J8��~o�����J���h��R@�& �X�!��)W6b�	��Y���(hv୲F��UZ�BQ�I�FS�t���8R:+�B����HQ�\���4M�/w}u�A�"�DZj��E�J�2]iUf!lF��ƒf�l�����96�!�+�B�1Em�c��`�1�rD�X��U���T	2QeD��L�J)�U��4
B��G��o��^�*��Du�q��P��t�c?u�'��Bz�c���1lx�F#�IC'� j�������q�H)!Q����l H���K��&E4`��i��L�'@iQ�9�w3��P�,7�6��6%Hť�0�0LU���{>C dS�:tV�
Q�t<�9%Uru\;-XB��}IK�� �������@��/o����k�F�ژ�$���dd�[A���KY�R��*��U���԰�l�m�L|~�ʹԾd��T�ڥ:.}r��Q��(휚@��B�T��m���vܽm��u�j>��5��q4�:s�jS(6T �� �@�J�}��q�IU.�Jɲ�T�ΪV�,�@9��Q}�]��U���4�VA�ޖ��r�QK���
B�DZ�H����K7�����f3�6وl��|��}�c�3hJc)B��ɹ����TXN�`��Io�	 �Rl�
3���nf<6�c#h�2?c*��9��6�k�v�T].UXZ[�!G�� Pa�d�f]Js��U���\���
�TM�*["Ii�含
�"��%�B�F}y�[�lKk��F#�q{I�)�4a�em�P^D���rS�Z��	k�l���o_��5��D[�Ծ��Q�|S��ԗ�	*]T�P"3-ٖfZ���<iid�M3eY�js�%�,֌�H��|����D���4H!k��t�4�KE^dKN�8*RG�hSg�S�PI�ѳ�s���$
  0��	rl��Q��$E%]t%�m�6�¢0�b4<��㬒M�fi)C"\wK�ȇ��A0�1��bv�2[�&���1����ж���lj���4�+�\�{�lԡƈ���%�0=3�i�1�VMiJ I�H*�
�"�!HJ�*F��R��rZ�#���J�B!�2)�jNR�<����7ׯ�Ԟ�lR����>��?���S|��9�j�$+���H�B�S(U��)f���6��jձ�n�p�L�M�}����B9�֪��H-�l�m�NT�e鵍��ܺ9�*P�Y��Z#���}u�f���-f%L&�M�1K�����eI%��(A��wS#z>��b�0u�(��QT� ��%�"�ej]�j1�@�2aV4�%XKLF,�I���6P�T�u�T��WhL)%�NI�����	˃��D����+# ��1�1���HK�Υ߶|w�n;�f��VͰEo���1o�@�*�Ă��Q0�K@U[I ��vW�A��$�F�X)s)�r��T�V��ĮmW3��ڰ��Sv�&3p���kE�@�$Ej�i�PV��Ϊ.\�@C�5{,6cؘ@h�ͻ-@�� �8��. F�J��,������pPUPa�6ؤ�a�"k[(�X�:+����`eb����F��7ڄH�`����TÊ�%��R�)D]׮p�2��ʬ�*!%�d"@K��$P��Z�#"��U���`�J��m4mf���$)��QP,IXX�X��X�����gIQ�$M��ɯ_���{u`B Q��l#Fo� ��@<c�
�L`����h<�������r���Z�6�`la31�0d�gӀ�\�bS�D���������P��%Ҩ�@���gS�#WI+�*yS.�KRIXe.�d�e�6e��"��cmȚ�ܜ��j��-#1 eT�.��j� �2FMh �i�mؘ��(��(�L��1T��vU1Rҙ��g{9��R���p_K�%��^���է� ���ܦY'�ZMh��S1���l���� �BIE^="H�:$9Z��.U���ֵĈ�  WJ��L�&=�sA�^S]�r9�42LB�#�P ئBRY;i��V6���q�9��r�m*	�� ����i
� ؘƛ��xڰ��^amf�l
	#�K�x3�w��PY+6�S%.���a���ކ�cS���Ԑ(R������� �,�T����X1@���Q�r��G�$�L4%V��R�J�P"�Ɍ2bSSh��zFQޖBU���� S���EQ�!�B5�	$T��H��X{�7iz3���iH��Ր2�T�4��z9�"�(�Z�H�(O�[{��?_}��?��欍j��t'�Inl�JE�2lؓB��U�*f�cI�\.�d��v�SQC�u-g��ҙꖎ��ۊZj~��o�"*IAId�m����}����3�}�r��\�Ҕ�tP´�4�d*�`4Ul���I��$l.Q}ܭJ� N�b.#D ö�����v����c6�A� R0��xo0{�mLȥo���Qa���<�k���<�ئ����_~+��@ �$A
5�� ʆt�/�qյ�(��Z��r�q�IZ�-U%UE���F��eD�:d�6WojC	"jH��ծ�jPX���$�ał1��a@`����f�ͰM@l<,�R�%c�J�P)Ɋb#5��#&���_�}Dlj+`��mcj��t��Q�a3��L���S��	1���Q�I�
�t�$�pv���Ħ ����[R�De��F��T�u���]jJ9�[���7$J�����Kb�� 3b�u6���iH��U_.6E]]��q��!�;D	oFD�lٶ��o�<ƛ72c�`U@�Dle�6�-6����z9+G�Cr��f�5l�����@�-@ ����r�壔��
)�4%aT�B�u�꣨�B���VD@��j˱���I���ڢ�1�v���Tƕ���uW%���L%�� #[`�V
s��*�����z�	2�����$1�*��}8��FU*Ib$���6�����ۭ0@Ʋb&����:m&�xlm�k3�̶Ь�Ό�0�_.�ꡮTѨ :,�Bt\��!FD���O�ǣJV�H�غ� m+%��ĥtu�\�/1M��u�h"�f�j�c<�@0�j3�`�J˥T�]]AVEA���d[���f������X��m �)Xƶ�1��aI#�5��,&��Y�c�06g4�"!������@Q 2PE�*VEqչ\���Zg�DR��˩\"��:����F6��0��@6�h�R(0�t��n�%�d"���'��W�;����VC�l6��l�����a� MY�$JF�| ��dK A��lv��f6Z�Xqh�lJ��8�Pm�,��fӶ���o�=�TH[~�җw���\E[��X�Ց�Nv:+���"������x+Ī(�D��
!�:������|?��\:7�s�T��jU�8��f��bn�f6 IȆ��&?�g�*\��QJu��WaV�RA�c �A��-�`�QQ+�B"4�VȦD����~��sm6�9�b���%ؖ����X�a�!�h cl0yq����|?)T��޻�|"�K HԦh��$���U�0�V$���Gu�����u[�`�!S&c26�d�!�"~������KL�%����5�FS
ŀe�6Zm%������B�R5�1�1[&mb�VxZ&"0�HimC*(��F��P6զ�$��5�uc+�x	���1��P����Ƽ��$��԰�5_�1�	�|�㫳˰٘�$A*2�"EFZR���Rb�5���l�R �P�
��~�v7�T�:�tU���;��/JE�%1T���jTBL�5� y�|'SR��T߭:���"%P�$�	2�PcB0 H)���()�\<�����o[�moz���:2U;Ph���e�,Q�Y1�%�j�Vmk�(�գ��t�����=�M�R��.�f%-P�R��\�KI,����t��JZ�[M�T��MF�Dlb7e+��ӘYY�o��_�����Kj%����/=d���]�Z* *5A�d3��YV��'���O�s�����K|q���f��a������S+�L�����ڬPU�m0�ғ�n&6FVu�i�k�ջ��d�����<6���NZ��KRT0/W�d�Q��"���)��T� %�����iPD	��qM�TW�Ӯ�U��+���\>��T.�@PWq h�X.%լ���1f'�@E.�R]NQJ	��&Ul ��GϾ�[� ��ɰ)����O�&�F�!�i��T_���b��V-��.Y8�%!ɋ��� @�ml1Z�*>�+���ĒPJ9�T��������D�Ud����l}�r@.UӃ�VV�+  SF#�7�71C�G���`eP�<j���(u1�Lʪ+�1M�eQ��21m�G�j�L@4&h�o���	l�M�� N�֠X>����PUNɵ���A�ql2ͬ�Y2���5e��W/���4�`�B��
ÁBR)�wV}�,ʈ$�����H�UA �
`��O��GF�[���@:Qq
g�9��QN��:�S1��l�xtR`��\�"�1��&Hb�Qp�!G���PB[!@��HB# �=����S�aoMc��~���P� է�1wl66��qǽ�Y�֥�,6�*Hc���t�%Fz�0�|��T�U�� @P9.W�E�t)���]��*�XZ�j9B��^��Ƿ?[e��%�n%���a2[�̵	؊�60+�.#&��*��U���oǀs�25Q���֊ j �d���4�N���i�U���f�����IuT�A)���\f���0Z��R�Y*����Se�`�il��k՗�Q0i���S���W*mg9��DVE�)(I�Y�@������g�#}��d��J�]����TT��\����_�ﺹ�XW��0Zb��TH �@UQ&ö4l�BI�.5Jg8]T�(�4E`�ޠ`
���C64=����mWZ���D�	�b�����u|��:��&�* � 6��u4XU��A���4��)��"��K)wp�N����:�$E�r�)�R"b�3_|�g�i���r(��-AmB�j�e@ �P�C�BP���?��/���v6�"T;�E�L�	���f�@j3�46���%MT���
����|�՝�m�����0V�&I�ZZ��*k�ڳfl�	S2�%0�0&��N�յ/��,j PBR������@��V)�U��g��pH$Q �fQ]�L�>�<��(��k�������$���xӜA��Hud	0� �a=VĆj2P�B#���e� ��@"�D��i��.qа6�?��=�W�:FIRNߡ(���T���ӣ*�V"�(����\��R#s�Ai[Ֆ&��(��P�>��X��L�����\>�k_N��(GMQ��=�
P�ʙl��R����]�,��Nmaqv0Y�eۊ�P	aLTijJ�� �Dc<�a+��w�� ,k�&1P?���}�$A[rV,���BTI���S��[3W���������������5n_�k-�66Z+i3�:���4�������6Ǥ�Z������w���;}����"�#��(Q"J�2�U�@M"��.�o�d�m���6�&������J�^����T�#���6�.)��P�l�&���P11k�U�E��	�Je�T)T(ۊ�́��3J�`�rJ)"M�1{�e�U$._G�vH�N=��q�\�i'SF �ДĂ�-M	1)&��\Q¬�YZ %*5���@�S��"����%
#��|��j�U�U�8��"�f��1�(v�(0X�l���Ε�$$[��P�,��b�T�c�����O���i	�41-�-h�������ռ��\$�\�.��$Ъ�u�v��y���+����O�Y�/~���џ�o��]��!��w��T�cDAi���_O�����nw�S������(w�q��θ�('���G�@d�緤���%
%SFXl���	�:u|��S}ǁ���M�)�+�Ŗ�T��z��������6��
s��*`U��J��Ѫ)Z+�@AcrJ`@i��D��J*�)��Y��\��v��3�I���U�ZTKQ s1��"� �)�UTH �9V�D�������&�;�*����\�"J��uϖb�)r�4֍TYG]KK�*�ø��%��P_����[��FojV)5W8� �bݯ~��?��}*s�L4�J�g����~�WX+�Y�m�
���m�:X��Ĉ
L6լ� �.qOV��NU D�$�r�oy0o�p����X����>�ş�5�Q�)���H�  %��a��`�o��;���w��HH�D �!�3�Y�V�	
�T(�j�2eI5�f4[�;��^�g�ӣ���XS���)�/�r�.�������RZ�!�x��*Ta8E��ВDU���kA1h��Ը,刐��|}�ޮ2"�NE��� EM�TT���BnE#������t���7_�;��<���M�#�t��ʵ���;C��w�g�b�l�k�0$�ߟ��_��m�غXv�p^e��M�F�ˑf`ĐƔ��8]��wJm�lf�8�Ym��J`�y:c�9PJquJ����sG���%��A�I��J�M�cTTʝ{	������6�����`׭!�ۍac�Ō���x9���k�61@��lk�&�l6i��0��HDx>�|v�
*RV.�/��b 3���u���~��f(6@Ь�i"�P�Fck $:����>����}��]�!>4�_���?����;�3�d����V
����"`�@C�vE��\RA�B�XK��
R��{}�t��-�	�Y��J4�M�Q;�N&Ɣ��T���G�{����w~�{��������黗��>k`@/�wO��C��8Z��k-,��-��TK�-M`�-&��m]E�`�`�Lm��t�ٝ��k��JGs\F�H�s�{u'"0�R.(F���f}�l
�`c �Ry�UQ_����u��������J�%J�Ril�C!I*F�@aS��[Z��d
�r�i��ffu�j��IJ�9i4f-��VV�P�����V,M h��fl0Pػ���
���`�R.�4�,f��l(�嚂��~��-RF�9@2� ͤ��6��N	����~q���,]���m�MM����{o��U���c��l�"�D��XdSBU�UlҬD�R��ή��Ef� V@H�(0f������0�Q6�<Ƃ����4*6MVپ�~�9�CN�>���Q�>���/������{��ɷ?z߷?��w���Q7w.���֭�vrQ9�ڰ���0,-]����v�- 4b�b��
2kE����,�suV��$e�MչWw.g)�4�;0�(22����F� ���Pʅ�Ig�t�
�����!iI�$�a�3m0���EX��6 I�®.��h�4(3����]N�-+k!D��ٛo�YJ���V�Z[��ж�)ƌe����]LA*������>�H��V P	�且#
Pd[���V�!�A$Ԩ�V`��?{������`i�c6�(l�� ��3)�������������gn�羊V�ܯ?��o�;iG��\�M��Z� �8�BE*E);�X�� )���Y��N%a���Y�0`�]�k��/�o�&� fDӴ���9:]ǝ:G�_��� �}H�����o�_������7?�����O?�0�F݌�=��u-�F#��)�[�؊i1-Ȕ�.��Hqm�!F��P���
��leMA�[ם���2Sq��\f���6�tàm�P��Z��w�	E�h��%%Y�$ժ@fC[�IoVR ��J��l���V)� rM��;��CZ5�6����E��xU��Ir�ߪmm���Ąe�����-	U�:;��*��=�C"L�V ��k�^�R.1 ELCo F!��Q#S�H�`(���͙6ń�s�Al��6Y��HJ@ck�^��Tnp�w�7�����^i�eQ��R5���*��N RJ��$vi�:
b�����ۅ�xc�͛g?ױ�0l����c���:��7 �T�F�j�;����ҷ?�o�����׻����O�`�X�(�^|�'_(f��5�P[�3�֡�fw���ugKl�lǲ��k����˻m]L�0�Y_(@�((1��2�M��������A�͵�4b3L*��6`C�`TƝ�3�y�@u-�$�)�kUK*FH���d�Y�Mcd�hfU#�2��Mcf�I��؄4t9��&�r�wwzd1\�аΝi��l�4h3�J`�ǆ���Vծ:�
�rD � fcϧOn�8�&0MMRB0�	ń� d����?����R@�P٪��i��Y'�5G_������T�&��T�m�^��jg�Y�;��XeCaR) %	rdW
R)$�Z�,!��%�nۅ�x;���lK�6o���23���f�a��a���[ӈ�]>�A���}�ʬ���?�����w�nPM� Ь�����(�h$j-���v;3Ҷ
i��oXS6e��mUu��Q�\�r bs�O������C�UC��	�U}7��b��aim�3:S0��^GV6�е��ߟ�/�Lh����ܑ�*&�Ą)��JI!�[���N#�q�64�v�f�6%J.�1�p^.kAٲqw'��Vn�z���4k�	4a�`�����JI��\P���vC3F�� Ȃ"��	`�`2�F����%W�+Dg��`�FX�X��Il7m7G���y*"Z�No�m)hY�^^�W/�#f@�$�
�Q�RBU),B%�PY�]���SY,	#��l1�f6�;,<-HT`��)��f�5/�����=�����J����u����P� Ь�xu���Āq�4��b�Ѻ��ڊ�=�%Ɗ�,�F���楬��bsY+�!C^���S���s郥ö��2R:�`�(o��H�.p"u���|�.@*��\���P�
e�Y���B�$V�@  ؘYxS�&m �me]ZpڴԼ�c�m�Z�26MZ���;�h��flz�eh1-�	1FPi��jWQ��(ƀŀ���V]W�����)02MIz}��u��Q�H∰F�J���G$lƶciE�:��T�ns�4��|NOu�K�WcyY�T� S
`1�*KGA*'Q́� ��ٝlW��+� !�]ejL�.��]8";=YY��b���f9ڎ��mT-6��9=�o{������i�dX[��RfT��]7\w,��!�q�a1�M�j؆l��hbklk�>}������)N���:��fh���,�l
F��r�@P]XU.2��	� rR��S.��U*
lhs)2M쑆���Nhl�U��6&i'�(7Ɇ��c�|�)fɿ����}��_�3ʖ�kǲlK�Q�k�7c�X#�������%J216[�#C��D�)
�(�D bF(F����/���!�M"��i5f�\6�T�@!X�l��߭i�����F�ZF3L�;���2�5��!H$Q�\]RjUIU���
%$�� Xտ��x���=��  3�x�Ɗ�X0Iǩl;�A��(�0:�,�� ��6ќp[(��GS�-I1��'���dL5�-v�ɍ`�ƞI�d� �C�a�n6=���H�#$W�ڥ�E.e�6%���
Ը��B��S ے���:���ktuG2T%�\.��,	����\�.(J�D�VӖ�IPU[2�0��Qݐ_�����O)&�L!��1�G���_,�{����'�Z�6����74�b�P
�#�*��T��ҷ�����8ʧ!��Ԏ0�M�)�>��4C��&d@Ҽ��D0� K3�F���izzS�]�tS�t�l"�X[�L������U�0Q]�Z�$�vb�Y%$�B ���o�8�i�2L�Y�v��"#tT׎CLKN�;Q �m��]�aVS #F�hFbO���~�M��H3sڮ��B�f�Ͷ�˳MJG�>}�+��Ҕ�a3�I��E�W׎�M�j�Ҹl�RC�]����52۶.K�æ�*�+;��U_��� ��VLΨ�"
��H0�f�a� ����uS�b�!�H���Y�1#��x���m���n�|�G�o�����mWw`9�pd��$k�1��V@H���0����������BD Q}u\
$��@�(lS�d��P��,A`��"�B?���/ŲM�`��Ӧ\��.W1$�R���hʰd�������/�C��%!��2Ju'�J��
%��]C3S��6���]Tk�Ƌ��ί���"`i'Ծ��mؘXBkZA(
M�$�U ��8e�TL���hV�I63�Q��X�fv�d��uc�d�u�Mʶj�_�?��tc+�W���Q�O�|�8�H�
�Ԯ%5��d����/"յ"Si�z��
��Y꛱a����u��r)���
��ъR ��Qb�&h[���҆akm�m��Y�O�SP�T7�kIgf׷o��w���>��7��/�����x��_����2q�"�t{�ս�hC46xklh�Q J�B�@����T0t_�\		��XJ����Q��jSf��VM5�)S0�@��&��� ��E,5�F�ͲL�iJ�_����Ti�%d�)h"��%���شH� ��M0J(��ڧj	k��4�	� m1z5�mPV�ޘ�{�g��fc-���}u[ʚ���
���lc4)����ڂ��P5�hv}hF�|�,٦�u`\@�4�%:�B�AՀ�`���ɺ2�	F|��\Tq�[�T�̪2A\B(�UU#�#[�.g'�Q��1��|�ws�8�3SWW�՗OW�P�*��@�-BD��� ӬO�岭�l�x+:��hK�뎵PY�R�������ٿ��_����6S�i���܋���{�ޜc�X�	I#� #.F0PQ;Q�s�����`c�\%")H��M�XF#����1�f�4����~t��M�.ӞY���֔K����]��,4���=��9.GH�i�U�c-�R*%�� �����X� �Ҷc3��ܘ-�Ĩ�v��`[ �7a3��m�h.��v�L��i��sf�M��j�@�N6`"0�f#7厗�ȍI�3�;v��]1�`u��f�Qm��!�ӝq�A����tu��`,�dF�V)����.�NaA���5�;�XVҩպ�H�׺B�Z�DZHE��?�XU��T�&J�UaS��0�!-bL�ԤM	S��L��_�w=��v�VSM#�
��,�D��^����4�mL� J1�
0L��~�w���R� $P:��q��˩ "   JD ��H��c��0��l ��l��l�87``�rJQ�$��4��V���ܐ[/ �B`Z5g	pJ'��De�����16&��Ild���f�b�v�.�\�9p�]���vk�SV����n���N��M00U�53�$fӔ;�:�W6,���T�1Kw����;@V6 +�	y�Y�M������?iժ3���5Ͱ��������O�ܕ�����z���0������*�K�nQ��q��$
����7}󏿼=��J%��LI	M�f�Ĵ	�ִm-���fXsF۪%#�û�>Ͻ�Lt�bq�l�a�!1�hf٪)3xw�ˊ�A�	�.s ">�= �A4�e�������ab�(1��10!D`6���`4Y�2l# ��փU��bSZi�!M �iJh.2��4Q ��i"��`�lE/4e��P��EN�*%������``�!�a��	�E`f�a��}Xg(�\�wP��1bS}�����TuӠ��dl%�A��c�����Ǿ�3�і@g���Gm-]�/�j1��xI,��R�U�ѠQP�DU��u1{;,�YB����o��T�U�ܭS��5���z���������������ij�O��u�j飰1�YL�2����/�����~�5C%ऩ� L�T���xt��@L�B���DgR��fj�	kiMq_��Ԛ�e�֭�[c�c�k�]Ӛ�AȰT	�@sY�(�@����R.ǐ 1 &D0��1 F���Z����G��ζ$0�L�&�lΰG��m��������i�V"e�55����͡!~u���``����V ����	��%H�$e�@dbb!6f1F`� $	e���AaiԢ/{��}�˿�S�Y���cD�g�jC1�Y:���&T~�{?3���sLmV�l֚�Δז��K���S�]]f֗k*BBL��r)}&�d��u�E���M!��v��vU���d�WըH���2,���u��-�7��8�b�mNŐ�T��1k6aZIR��A1�"& ���%`bD[�L�!q,+M����r[��/��5�N�#g9oC�� 6�c��"�Ab�
QJ�EZL��#�G1�iz-A` ���4�dHm�Wo�?߮�b��&�6-m뚍 ؂�r��D�²�E+LD���Ϗ����2�V/cz��a�X0�۵�����>H-��KAC�
�-���H0�  ƀ P F2B�be�/z���囙�K(`XM�"ۘZ40���p�8�f*�N�ZN8Ll�&3��5��X�Z�]]ʦ3���\ �ʚ��ĩo\o���J�2��(��n9x�r䮚�Uo:t�qY�mu���,���J�gx�b�ݩ���c�`�,'��1�5�X	Z%�R]]]U-K#E��ޯ�G���D5-�	es(7c�d�!����[-Ɣ��=P��u�CK�lmkiAR�����R.Ab��4aL�x�Th��E0@lf4��II�$�)��~�������XLb�M�+�L	 !7Y4� m�~8?s�&l�3���`���h������D��$j�J�����*m�K`K$��}�_?}�1Ph�`1Lr-��bf�H9�:���h�)�YE0�T��`S7��h�VhPZ�5h��Z<1m��)���&����&t�ڢ�ew��k4gK׵�%Y����2���l���J+����I����m�ZuGSߍ.VsJ�U��TU0���)��Զj[6��9LnU�Ukۂ�)��j��K��������ޜ��2͓4٤�6x���Tj_
 	*d
F� ���Qb�!Si
0@I�o00,�m)�l+lX�(�*���
��1bb0�8�K��&$"e��mŸ��fI�dh1a�J���Y Bj�U�DDUP���[+��(�~�oh@@=�x����2d�Ml��V��* �F*TT�ױ5!Q�-(0VY���g���SVFKl�;{�]����P�%��j���2s�Dh���R�ŚF��R�e�6�Y(c%��8��Bg�RQ5�.�,`e�R�F٠Xq�kfY޺�P��"I�*ת����?�ܱI��`"�ڤU�� �.7�`Xe)V���g�X\^kɬmuzsf�n�,�,h�õf�aUr�j�T� �`LRP�H@fa0�f��"QE�\�{y�i�6b `	bi�(��K���c���s+���@F�h$��ѿ<ǬL;K��
�aYac)���4���)!#� 1G��Ġ�(�Ѫ�U�ŀ	ivb�v�UlǤ��06aLc�����5���d F�V�ņN���0@2Md&��-}ͩ9��#ݙNGo����7~��o����~xVi-�Om#�����R#T�q��`T6���������I���"�X8b;TdS��.��l�������'jR��RU!TN��G���T�� L`�	1$�(�s�6�ss��ƈ��bnk\��]����b똙t��&�Pǹ��PAd]��v	������ �T@�\"� �DD ���'���|) d`�@��f�	�F� `��l�k� (S����l$�4d� ��X ���X,kbl��{�"����",�J�$�}���8O4��PG����*�H���`<6�4ֈ �����4}��_���7l��T@��c��2&�dK����Ӹ9�֮�Ɓ�\����� ���?����4��J��,�!�"�H�����P����-K`�ŐfU�@�r)ggwV��^s�*!0�R�d�bɼ"ʂ�,�$��?]��V�R��BT��hIdjE�l��Q�Y��k��T�%lKsM!�x���=�zw��x�m�BLd[" u�p}�Q�ح�F��v���T
���> ��� Dʵ�&��1�0`�aV4 0�M�ad�T#)IUa�e�1"X�dNGP�L��e@+�W�~]��J�D �h�0�g�D�Te���0�	N�zl*��@	���7ff��0C�4M��A���?�A� �u0�t��`e��~��o��UfN��76Yb�I;6�X� r�-%�Xě( ��8�qumtLl2\�kSs�nʆa3nC��+���\�����y�g�{����1��&(f��(tͺQ������ajԨ��p`�!J�dSMRQ�%�.U�V�V,�D�K';�>SL5�js������Y�?���mϿxauڀY���+��|f9�����H�Z�	2!Q"�	l�$� b4"�ve�ĥ7#r�R)Y	c؈M�(F��-F�4% P�P�3���6a��4�PJ�%L���Ȣ��U��X�v[�c��F
"L
)�$M� m�R����2�)E�:�ef��`�TB�c�7�5l$d@#ds @����y�_� �V��M\�ʓo��*3%S:7��kv�>�5|�}}՛oVm���������G���/�����u�1�̇�_����'���|�lW_�jGжVyf�&�*K01�(�M��U-��gg״R���>���]w����c�X�M舁�+�3��e�l�fB�	��$�M�"��  utUq�:.!�x����Nd��)����u�|�{���ǣ�_�m�\k��lA֎dK����6˫}�o�(��J)鐀��  ��R}U0���� l�@d��Jɴ� 
J�&aH%Q�T�c�-�I�bj[�ClGq�/��	7G�llC��WK)�0�F��`	�9mª&v`h��\Y�����U�4fi(V� ���U�e�����v�a�(Ck�l�J���o����B�{t=��\���Rem�Y�dV�n&M�տ�|�{����?��/����_����� hb�H�I��ܛ��<]��k��v�Z��6B��l�fXl:���)תKM9+��:�;w���Ƶ����6<����]��%V�(0fY���������������ڴRE@
1�JI'�Z]��}�=�.U�l2�lR%v$���*���ܼ|�ŭ���4ؔ�,�i��V�͒�B�ю�"��:��*-PZB%@���R��M���&X�f�Ѡ'i�V��5�"����zۘmc��v(���U�˝#����Z�Rhc<�f�`�T"�ab���+X�o>~�3U�V���{�7�6C�ʆ��E�4־$�%����x P���� V/}�����2�>�M܄�g'�z�}O���Dj�,eەa��ڐ`�Y �5cw��E���e)��1HA�al3� ���#w*\j�8�}�n�w�/��[���ذ��ö��{��{s�.�M�@w��`�o�|Tc+{Z���ϟ;��JD_{���Ċ�Y�t�����Td?�5����R���ʵV�;�O�Cۺ����=c�5k��K���USK+[nF��ڭLs�c[bI]��}u-M[�f1  D	?��@IW��v�`s%���& )M4dU�"ak���4��6��%�5:�k�q��%B�D�b�M�i"H5	, % X&RE@���g����D�h�l<�%A�x`Ь	�����(��`��`��!2�� �jx�M^�̢�x��b��Ќ	�|}�hb��:�Z1��H�N���R��&[Z,h���"]��b�l
��:�F}�䢮J�m�J������jW���bexf�03i��e��6[m����q���H`tͲ�l����yh3퇇?�ZisT��^5�����0BE"����]��-�}Դ���Oם X�����g��7����5�ͺ���e����]�XZ$�5�%4vU�$�m֬!�
���=�c�D!q��@S;���K"��X%1
XS��l�i�f�0�,TFa�v�q�*怘�R.��i�Z�k0����!n�c�0c�$V�����K�`���_����Kʊ7��`�Ԗ)�T��F��L[�S6�$L0d!��|��96�����*�#BF�V�a@݋�z�� �0 ���kgn5<0��SۍĶV�8/٭��ת���F�<e2�`�-o.�cu7�ru�ю�٥�>Ы{u'|P��Fm+b5�j���M���؟�x�g�'�>\�:�[(c�ȶU�J��UE�A���DjMH*]��ZK�2��Iť\�!�s�3f�M@���~�=��Ds��[��}u8���)�6Մ�Ĩ0`��#m��3A�`���1B2��"r��QW��Ieg1��a#�j0[C�rЌ�V1��Y� �ҹ�ѮB H�RNW��K��ZrT�tV����et�Ij�D�>���`��P,*0�`���`�A~��߾�D����@H�D��^���������Ma�`j	�q��L�Lz��R�Vj�, S�Yki��>��ֹ��M�5�fEK�vjw�4��սF��jpD�'O�_�~f4�jS�q7@����:w��-��jdͬ�5�M����d����*���u߿��+��l}�2�g��������`��f4-���fT]��$$��a�r������|5���w�a��$���ݦ�ɦn[]͵j��L��$9+l�)�(�(�������-�(R$b��$3L��/oV%�t�r��z��ZUG�)��F� � �-�ƾ��{�����lSN�m�کV}�}@�J !߹\;[Ԫ�nbe�_���۟��%�x����CZڪ]� YY"2]P H��FlBL����� [���=�gI$�V���� KY��/�׷��F�d��Z+-()L6P7&T3��R�`#=��#3�3��h[ei�;ͦ`/�P[i�VXu�)�v���;-b�,J+�}��GSR�3�d��v���U�3⨍K���N�L�4kM�#,��֧l���f*�
߾%4�2z��k3ƔM��YM ! 
�r\�$�Y��l�"_u�Ý�]�v��
�.3��ZeS3�V�f��Jۭ [�,���ݪ�mW��r���_���`�-�as�	������>�2JD�RU��#�e�I��$H�0"I�4ax����`I*�-�p����c#��Uf u��l,���Ȁ2���O��	%�E�1V�a��"Ѷ+!0PA���
��,��[ڰ=�B 1�r�dj1c���gB6_L H%�����xu�QL��� ��Ύh"H3�hi��5�a���Mb�n�'�W7k�����l�Y��AUmė�RS?�;t��p���NlY�v�dh�LZ=̘:�������x�-4b{�B�֑���XLUD����,�rQ��*����?=�R���K���R�]�-$���Z��ꮚ��e���Y�vk-Q��\�y���2*%ՎjsHv��0PLE�zs��|��J��˥ԎR�\Ŋ#l�3�#@��i6���l��@9T[�/7��ڗr��Z(Z��So����i�����b�x �l� ��%�2 j�$c�lN���)B�i IVHm�Q@��ф�N(�#�1���Q�ؖ ���n��9n�mo�[��᛽���YȖ�fug��`��&��p�]}����n��=ft6���q}�8꧕J��V`���$(��نm�L�j.�qb?��M�LE F���n���چ�͘�uMW��)�R���T[���?;A������5Y'����L����4�T6��M��Yl�冣u�n��&CYE,I��R�K1M���w���!�RJ*%���J
�Ng�]J4�0��m�Y��1�%h��O��m�Р��U��L�.(��a���~\YȉM,JPfkk;�Td�Ϋ�	����ve�Rm���K�N  ����L��6I�c`����*A9�J��Z��'�|��o`��` @*�]�b4��N�#� �a��Y��Ms�$����}��_E�)S[Xۮ��]���l/��6N�1P�vՊ�N¬xuTm���tjU�#u-��,
e��@X��m366�IY��l7�t3FV�ZW�{�2d��D}�����t\u�]եU��4XEU)]�ݒk��R	�A۶ެ�b	��%.�N�#h�&�V�wR�mH�D�f����%�յ��*��1L�Q�3ڗK4Gu�\]H�\]��)���o�,	dЛA�,�2��gH�^������6Ų��}eu)��9ޏ�"w�Y��@�J 6�F����k
xy�J���M���S6T+Vjf���B	Td`�0��Y���)Ă�%ť�R.�)�vP��,��~&��X�	S�N,hv��rg���Sv�֗��O��ڝrd�J+E��\T�r"�j,�XiZ�Lj(,D��ݪ�+d�J����M�j��ty���r�;ե�"]�]�uMɪb��(�d�j�L"��l�Xź`�n�ɤ��8�$��*`T.��h��0��zo�{ rc��U�rW�]�*.eT�ɪ�TB�:�"����Jo�2-lɦlD�P!���͆6ل���7�rlª6f��G���H�]�MR)G�4d��g~�|��E�	eK$1�0��l��^#�!ٱZƝ)]���Z�����Q
.��e5����R
��06��ؘ��F��f��,K̈́W3�T�� �M`, ,(�$)���N'˥B�&���Ǆ* F��"AY�%$(Kq�����K�]rȠ��)[DJ�M�@F��g��ĬK$��d:N����8�J&) ?u-u�:q��s�i�ws�8��kK�L6*Zu6�'�m���تm����>��fh[wIXl�ϒ��V����Y�]�v$���vl1�h���2�	t���u�]�\ݕ�
*�R�MUՉl��zӌx�� S6*h��Q1�.r)1��i2̒^�v
l&�l�aǦ��]��ܕET�Qz6�%BsЈ ,�:{+la��6�D<[����U��������U���U��(%
Y���eW�\�Iղ� �6��ٯ^��#�d2
����ݗ_]�4F
������$"`��
(�P��LLc3PA1���(aB��S��Y�����)	�P�������[��9J�b�(m�Ԉ%h́��f(YĤ"�Ku�!�$ȠHnru'��r��CZߙ�.Ց���Π�(խu�2f��6���>������B"��Se�!լ�Te�T���ؕvu�6�5��Ml̶-f���fV�� %�Bw�r�Εo��?b��\Ng�d�ڊ7�1&3 L�Zt���,�Z)0J1g��ֶ-6i�*o����V��b�x��Vw�R}'V%�%��RJ�bʠ L,�@L�fm��)Ȁ1D����c�UwIADc
AY�8K��\��fZ4P-�i���P��҂i��FD�w_~+ İ�ǈ xq��q�ca)j'��B��$� ����1�(B�A $
�(M*� 8� "��Q�e �U�o���(�R���BP; 9��ZE ED��ʅ&��L�L�*]�UH�����:��5uG
%Q_�2T�i٦=�m���H�R���Ƴ�x��#���UW(�Ɍq�������uN6�Q�[���a`m�,�`��5dE�TGչ|����yV�ή��R�"���j���k-0ڬ�+R�����Q��Ҵm,�mP�loՒM,#S�̀)�bJ�J�\���QPd\�(Φ �ʔaZc0d�V�f2���� ئJQ�F\ �Ru$Ĕ�BUu�T'�lӌ�0�`L(��r\U�H���
1��D� �Dx�����r��F$QJ 1��0bbcH�$T�bb�|Gq:�%c]8K�ܷ�������Z�u�&$����!IPV(�p����"��U_��溺v�tl;m�Ѣ�ƭϮ��)�
��R��pW��U�t��2ݙ}W�Ѣ�jN�Oc���[�P)L����dm�u�ܩ�B	�K�9Bk������U����/f3S��zHӲmi��Ν;Ww�Ẻu�*V�DO{���
�j2��k�a�c �ՙE�@ `�L��-m�$!T,<hö�S)�|�r���ZIEm������͞��R�{e��4ӚjS�m#�])QՄ�ʖ����BBR��)��RI	���)��եV[��L )Afc҄�FE�_��3FH���E��U	P�_��ǐ�V6j��C	 L������e�&FD�!!w�`W9J��?[�u�� X F��T��(�%[�:���?���?:*��7Wu������*|v�K�R��H$��2w��w]����I�����BY{�m���تhe�{f�y�͛mP��i�m�͘��J�V��ĆI��C`3��ڼ����O^�c�*�Zx���TW�\��sW�V%:]���6����)o��jT�@������d�h�g�'��.٘"$m��� J)�%����TPB�]ꎣ�Zń�L����!�e���(ƴl���tTBG!J�i�tp��ZE��ԗkW��@��1��j��*B�j4WR@VL�
bh�²����M����!�1l�Q��*������h�t��)�46�������yS@(������{��Q� �	�1"�������C�B�d�^�.��,e��:���]}V�K�?N�Ƥ��Q��Z,kV6�(٥�)�����uQ��;]R��ч{sSE�՝n�O��Z��'�){�I*�d�w�a����U*�4�bm���f�����eM}	�[�q��Rbo�֞콘t�ĳ�P��\��.�Nq9�]W���]�G ���2���զLE�1��FlE�$iP-���d0o�H4���P%3�R�N��%�M�v�P\;UE�hY70l3 �Z�1�� �`r�B��� @
��r-@�B�U�R]�������aL��),B���B2	0e�R�ڮ��1D�*�X�M� lC@�R	3�0L�X�%f�F�NC��yS!޿|/o�鬎b
D�#�Q� ��_�P�A��j)�*�n��A S�ˏ0�U$��'3�^�M,RJ�e�i� (aE߼����қ.�\�%�=V�_���}���}��Z)�����FA�Y{�7ժl�y�{�[3Li�"I�u��-��+�mI���l�15׵K�l�L�v��naDrTuMR�Q1�ʗrJ"E@%�Ѽ�6���lK�n��9���k��?� 	�0��$M�0�ڈi�H�"�C��M����{��Ku�V�IZ�'6$r+�P<�&	�ؠlQ]JE J�'r|�"S(Iw��n�o|��?�7O��!"���Wq)%ѩ��*A��E")fі�(1�\�kSeA�f�40$e�(e��1�4lZ��,�D�I���L��� �ā;(��-m����A��%�bb�k�+ 2u����cR��6盟ۦu����lUVh�0F��p���׾|J�l]�.�<�}��/ e)P}U���*S��V��ٓ�{l�0�U	(QJ���U�DA�1��c+J�Z�Q����>;�~rݘ#F���|�)���ʊ�7����ɩ8�1�(ZEl�0c��-�������B�������`�h6m,�4�m�*bz��,�\pGJ� & zj�����]�w��Юԙ��^����T �VC�&0H��t� ��=�/?��}.�(DY))]�*��h��xL)������J�
I�dUE�%Z2�i�I
�x���o=% �� �b	#�+��8j_Qb-� C;�������+�M���B	)�bEZ0��A���ZG�%�X���Z�X�Q�V����*��.���|��MEʶR�h1��w}�1ݭ*�/i*��R�/w�ٻ�j�L!#D:U�Lm`O�=m�О̛1L i�
4��.�*KhA�ږf#��]���YUK�L�U�:E������W�JIU�*�_��_~ᣱ,3�Ä�a��6e��@*-�
6�L�m��U%��M�|����%K(��:#u�r��{�t�:�ܓ*%�6�i�(�c�u�jk�����)2 �g����ɝQ"�.)���iB�7�� �w��W�r�w�VEDi���8�r'FM�@A������g���㼏od&��]�}:D�
ɶC��gQ=���Ј��\BZQHH"����@���E+�RRd����~�K '�a+���(ʤ�S�*��&�%�cD�Z&���Q}�]��Y\_�Τ8�v��K����~�oo
�_~�/>�"��%�E��u���m�� `�T�¬JEЮ�	U0"�����Ͽ|�*aͺ΀�M��L�.��Zeє����UTmՉNuUK��~�_��/Nk�	�Qc�	�H�rzVҾs��wi	JZ�����7��4D�L4�t�XL}p}o��\�0�rG0�*��N�]��S�q���UuDb���%k��,Q8j�F	��2�>��G}	M �N���M�.jȰl�%��؄��^�>�]]]��0�RVJ��\�J%1�0�����}��Ϗ���_��i�i�� �$e��pIARҰ�M=;J4
���6 AY(�@Dp�g��D��T뗿a�e�2�@�&�Ȉ;��҈����9@�[P�T.�ru�V�/��;;%��.��Vh��/
�[���T�����A��c�A
b.��	�RR�L3�Ī/|���Q0r)�� ltqK�`��"ZQ���R�ac���Ͼ�k������0`���#v �cPW��W����*�fd��b�@m}%�6��T@�x~l���(T�HR�QgU����Ӯ:�9��=uuuT	[;%�P�S�%�i)C͠���]�9�h`ĝ��T*�4@��t5M�cL�a ��~����Q�\RH9 4A������	C��ꪤ@����O���_�]��O����\�:���� �X�oDES )i�qA�!J�h	2�F E�\�j���7���bڠZEv�D�0ۦMI_6ר|���B)�n_u:�c(�Rפ%%Ҧ\S�bV��N���Ul4�j�V�`�]ݮ��\�����yoo��� @#�U�+�����@Uue�76l�Ԑ�LRke������0f`E���
�R#�����~��
�,B�H��wn>?���4��Rlac��	eF ��A� \�ȗJ�R��*�!�Փ�>���|Χ�������[�����Z�V�M��L�Ǆt憮/cSF�T�"� %Q*!�C1������"��(H��� ��vJC�Mb�LeĬ���_6ո�nR��#u�L(`��1!e�]0�͕F3�M E�bBL ��������(KYd<�� �s� �z�0*�U߭�X���R�\���F�,Q2��ɠ�O��zu-�Ӥ���:R��Q��)��b��Ron1{��>r���e���4̀�r�D֤T!W��$�)F��La#�T���4 ��X[a�f*U��[�!�I�"�(UQJu	U����>9j-O/�!����m3Ӭ��0F6i�C"�M´�UI��l ՝(�.�]U����G�?�ӿ�?�eش��!.Ց���k���f��K��4@�R�
�*�4RC-Bt��D$T�&Б���*�K�DU�*�*���U�`����D�G�X���1�L�����T����2a�
#AI �K�}�\��&m#/5l%/?k͒�#��el��R��]n,�+P5G9elfEHUJ�*[i�����8�=B,WC���r��Z%�>VHEs]e��,tŨ1���y�Y:�Q-N[�JK�$6e�HKUT-�  @ F�Ĩ%1��m��j)A �R.Aõ��ťPQ��t=S=�~�[������hf�e��iP`L����4�*_]�(m;���rTY�K9�*��q(uuO�~����?���F����������MmK��4�a+V}�AE.��d���d�HU)3L2 Ag%�K)�.���RJx��}��$$i.�
����{�sO�2�dS0�\�$�1x�X$KcV&�H5����I.@Z.�*)�j$
�g q�rZ5�4ٴy0XMTm���lo�FDdW�p;]�y�5���B�eH�[u�D�ݐ�����L�r�vsW�:T��T)E�R�)�?��﷯�غ�l�2."	,�W?ߺ�`����V�%X���\l	�M�b2�.�5b��F�*�d&z�DK�Mk,U��������*uV��թ�JW��e�-?��~�-
�
m6���w��#�ؔ%B1Z�*��w�^����j I��������_�����/�m�~cc���$�ϯ/��5�f����%aU�flJ�tݹ�LRJ���(E��fDBQ�t
"�!$ru]�ܗ=�S0J�20�����o"�
�H�IQ�._݊X�(�f�&Mc��YZm�T��Y��ZںR%�8��$	B,�l
0e
�*B�4d%k��Z�umY���Ҽ���2�Ku�u�,�7mU9v5ӱ(��56�]���)|)嬒�����u��B� �*2��K���V�u߹6�0�>ͨX��b}�H���U���2��G-�]�lK��P�ь6�aw]a�Qg�\%��L2�mla�1�:�Fu:}h�����`�f5-%%��b�b[�eχ�Hۨ0b1��iL�������/���V)���RDZ�s�~�O���/��O����>b�Ms���%v .����1��ȝN���dYPD��*t-"���L(�*���)AD����Uu9%��K F���B�V��&I�Ģ\��\9�y���2K+���vH��D�Zj.!��Rb]�YeS�n(�h1�jyK���(��9�aZ�I2e���>]�8��k�0m�4*�8j��Z�����b9I��*�
��j���s���wuS��)U�Y�k*J�2��n�aVh�M�>z��~A%�t �L���`Lm+�B��U���� e��d�g��בHIJ�lm���&�*�Ŋ������u?r��C]�s�+5��a�I���ZC��L���1�f1�
b�
�Ф71��#%]R�E�ੁTW�޲���δ��Ƕ1���mWPG��8�%
������O^����]�n�\U%�8:�d���2��*i)
!
E�\���t�PJ�"cA(Ob!�ɥ*��골h�[x<�jc lҀ$2eHDu�Zg
Q�q�U�RD*�M�%�� �Ʋ�fo���E�YM�咽9^�l��P��>����%�-]��iޖ��,E�D*"��;⎺+.wV�Rt�T�����P��K�:jt?�����2R:��?��}��0�� S��vd\$#�%�
��f���$�MeT22������81S���Lۨ���W3��=��/�'�Ųl{m/�+'l]��)u�~�S?|��?�=t��P�K��J�����iOy)�^���i�YĶ��4a&��&m�4K
�"��ۨ[5(�ֶ
�Ćm��a��� �D�J;��1jf1������_d#q���=��㇎K�)w��JU�R2+�U&yЈHn�11��K$@�\��U\�HQJ�K)�L�TAS��]��ӟ^ި\��(0oL�6�7eCd��|����?�	� J�jW%ʅƌ�@LFS�	(&$���"�Ƽz#؃f��I%�Pm7���M���m��@�1j�g�8m�ZU�͗�����\�T!�k#����Om� Pw�:�?_�
�ys��[��f�)�4 1�
eɼaU�@ L&�MFr�4.��b��L�(�*��M����/��o��P�*��ic�������=_�� �T+It�6�>�������m�m��s�$b��m��6a��V�dIB��RLE�����ˑҦR���_߾��Di��5���Gm{��i�MV�bn
ƌ�أ�����r)߉�IIV���JMS� %�tf$ՁȐ�$WW��8�V��R�R.A�����
E�����)[� �� ��m��*R����b%������A����K�\�J����Z�Vok�~(����SA�\�%��bk�&����?���o�ܔZBr���9tM]���>8�NOk�K�h������s9�2*���\�Re[����l�*K!�*#�-��H�$���P�ʪ��4SY2f���&H�L����)�U��6l�>�^������j��X]/�~I������Ͼ����6-4�#`���z��Yzs�&�ڐ�*
H���P���L{��^�H��}�����f��O/��SJ*K��ږcc��q�ǵ��d�,(Q ���������K�)�Kv)]������Lϰ雏���폢�"U��R�r� ��J]�*�rW��\.M�.�����(UV%� �l ��1&<e��"��QNj���/WWQ�*����r���.wʝ/���\.e�!�j�e[����hw�K*�!�:jV�C�nŶ���YX����'�J�����[�����tQ�:.UL�K�u����s��:3��<�?����W�=���*tUJם*�@LX�V(*] 	dT�6='�T���U�kL�*"0�cf��#���0 �l�u�<MC12��IIC*�gU�������W~�����?��[�����ܚ�ƃ�u�J�2��FQRJ�TT�j):�r�F�-���.-͔�M������=`��l�0�\ZRB&F��d�x�u��r�S����"P+$�iK6�1؃�`�����lKGuI��B*Ge"
�F�r�.���r�\$
}�X����U�U�FFe�4� 6��9�����إT�'e;��OgiK@��CID�\}���w}�]����*ͮ�X��ʖ���MiE�&ߥŁ��R��)*��46���Š&�E4��0����o�N�V��buu�PW���|��Q� �)�E������]AQ���&C,TT���h���I��X��MjW�ն�a �71K�REf����5��@4��A��T)�V`�f�C�ku��?���{�h6ob	mO���&")�C� �j�Ju������]վ�
*[<[EUIc�4��o�����������+��-�b� 0HD��?����s�rb%�*���� ˃@�i�8���j�Q�R��	\���*W��U�U���%�P��hRf@�x��=�1�aB ���)��*�SIo���EJ w�;�|�w��]}��/��]�UA1�Zh��*�U�)��]YMb* ���X^�0uCc�Yf������ǔUER�\�%�c�5Nlb!�$��M�T��溗H��E�nƞ5#ɢ����`S2$1J�Z1.�M��q��a$lbK�5
0I��6�'ak##AZj��@�r������5�<�qgu�����k�������}��f6{���[k I�
TS�0i�%EuU�2 TbIbÔ�R��&b���Zn�Eo�6Wmb.�(�f #$J4�s�o�_^_��]iQ!���z�oMm����_0-���fL���
�U")(w��R��]*H�ʰ�A1�a$�q c��T��ן��_0A<`#U�\6�7�@�2�Kb:�OG����r����:�.wP���Y�L%�N�"鬃O%ɥ��V��x���f5{��q�������N��-�U�.�%�4��>�x�v�S��6��[]Vc���#��n��]U�ՇO��������꒮tk[�!Sh�K���I엟~?{�`�� ĸl��L�`��?��?W6����ujaFI �P�+� l#�0��-T�I���~������K�m��˶m!c��y��ifJw�5�VTJ�J�C"�,#�	C�3RR�؂���#6am��x�i��Y.�d M��(G�Ɣ�3�����wN�m��0���=ނo�?�߾L5L��� �A���� ,L,�#"���t.Y����TJQ�
�KI`4l�,�¼�=��M̈�T�4ok�A�* ��J9�����D�"��*I\ʡJ*�!!�R�������+���O�>��n�3:2��Duv0-�bo���[�1o�*�ҧ���X�U��T����?�w��J�%�mݬFU��6�Lla+ā��u��@�����^[1�nA�j�K��aeW �D�����s>�pF0�ZS1/��	F��� XzS��	$lb-	6�l�8�6�˾�~�u�>2{Ԗ+�6��>���S�=�ژʝR]�bb��ʢ�R*.�)[ДF1���������������d�0i#��Bb3b6	J�4��9̐;w.�9�k�j���L�|��^��E��\�Im���}r��W���.�Dg�\�D����N�%� Ij��'����_�rDbaU�R�-�)�0ՠP��m��r�)���
ԍ �廎#H��*��$v���R�&�O?����;w����۝;]GI]K풅tB;Tf�Ә�m�l����;�X\uΎ���A�$s�������`3�qz���d,H_�}�]��< љ�U��)���;#��b����N0P�+0P4ܱ�0�F�(�o�p),�a�ClU�` ĀM@!������rWU�҅-zk?�~���?6���X��6=�'{�����8X�ޜ�v�K��d	���R!��ޅ�=�#�fL��T�����מ�����4�F$h�l����}�x �7���R�@�"���W�A+�+���<�X��� B-c�e^ｿ}C H��DH�\��GAD��r�\��"R��ꀤ�ｾ)�1���)4[��M�Xm.	�Ġ�%]��P;]�RAS�\���ȁ��I�U��"U�"�ھt����LK���n���?�ÿ��7�nG��@�T�4f��xlh�� 6'/���:��o���b��3!�Ұa9�/��Z`Cb�=~?z��̐
��H���LQ*�+(еՅ�!�6�	�`V���\�h��KD`0L`��U0���d�(��r��˥S�J�m�x��x�5{x�f�6�}d�9�1x�y�S�s�SI� �iI И!Ƅ�fk<����ec<	,�`2D�s>�����c�1�h`$�����D�M0� $K J��^nm�7x+�0�!�C��R�@ 6i�$9��ˏ{u.QA�RJ	MQU��)̰��=�x�Q�T��iV(U3T��(T��w.�C�Đ��+�R�K J���4�z�5BQ;E �}�׷���w��]Ȫ�Rt65,����%엿�����uu���vB��H;՗��Nj-��W��������j�7UN�����
�����5�Y��F�a�*�+b�a�a����B]�a��Շ�%a$��&#d��$F��˥\;alټ��1o6&-Ƀ�7�m|�+���>����y�[c7�R.GJ�L���#�D+{��K�I�Dcs���4�_|��;��nX���H�b���y��?�(aF#7���ER��2;��5l*�� �i����V�64��	�� 0ETA����$:�f�$T��h��ǝ)p��ZV6P�4��*(�DP2E��%.��,�L�BhW�Q�|ʺN;���Y�8䠅\n�K������qL�,�J������k~�yd �ٳ��>�o���?���@&�s9��%FQZ�� �R[{y��U��xP3S�gJ�`�)���j�=E�,e�B!0�����꙲4(a���Vע����]7�
1SДͨ�b
JU����U�kW�:��i�h�=�͛1�wȐ��޶�Uħ����G3L�7��K]�г��l6��6��l��᧲	��S�Gc�8�
l����?��s��]]��?_9���{d$l� ���ɒf��0Cު��f`S�QM&6eJ 	��
b�P)Ձ�*�b S�͛ǘ ��%B��(���f�&��XX�ѬĒ�
�P��T�-T��	W��꒮�I�K	���R	)�ݤ[TP��V�K���T�l�wS	,�@�M�6���˺��ZX Vu�����8Cڬ��x+��j�Zm[�L��fI[�NPL�8�й77Y��Ѷ*#�2�h�8��-#��0�Zm�	�\�c�uF>?|����	��CRu"B)�S��Yhk/k�l�l�¦ib���<����<RF<<�Y}��
L�ic1o6[ĦƘ[Y"����&^6�y���������W8���Gū��K�8�M��X�m��RX��}�y�ɭ f۰�M�b*�$�PB�eT$#@2Nt)��RJ��t�\���]����(���rqUR)G�K`�&��%���(c0��Y�0�����D���ZJ"�V��H�p�������kT�k�(��t��:�@T&�6:U�Y��I�66h�>]�V���i�0`jUئ�(W��r�����@I�����A�QF�l���	�Ɯ��P(н}U���d���M�M޾� I��T�"�g�!w�k�E��b SQ9F)_]���$��l޼��}����x�����=���'b[2���T�0l�n�16#o�`��ͻ6@L�c�)��x��t�}��_�M<�ƌ�y�m���8�*I��q���i�D��<2m�M��L�B$�A�AD !�GH"*�)q��@���rHB�clKUS�Y$��� e[�X�X��x�Ʀl(e��2
�.b}1Ij9]��Ui��4���WU��.��)H�;U���+VŴ���bO�5mĦ�l*
P�M��He[׮��b��L�Lu;ծ~c��Fmʔ�0:e��RV�2��TMCNߩR��}~l̦i�PS�)�R�[��h�xVk]ô� V9m���[��r�s7�]�4�Vg�2o#��/����f�݆W��,�Y��Z4��6c�7�ǚzg7��P�db�Ik�M��} ������͛�y�ֶ-36�6��kf��b�
H�yY������)cl�k��4&�좮}AI��� ��	�� IBѢ%%�ZG<�f�i�1cp2�nnF�&�	3 a6���"��Ҧ��10�]QE�K�e (QDu�*WT��JY ��ͥTW_��r� Ww���tUE����1ް7�@ը��&��ck3a�b�B�Tյ)*��6ڡR��/a���6@A���[_��LJ:��VY)m4G�:��t@��S���t�"�A�V�rk`k礄F�k���%KKhQ��K�b��
���d�h`Sy#l���I͜L��|�\Vn��[ۚ�v+���w�;3bB�,� �!��X;���V[���e���63m���6[f�.<={k�Ic@�Li[z���$J�0]��R����7��L��*B�TY�� +Ph#�"	��ru��8� -�i�f�m1�a�95��&��4*� k���l%�h�BŚ͛���1�Z*%j'�������Go���+�QRT��J�4M���êr�Nu��Q��Ԫ���!�֭�4[�ai�(K��Y[����h�(Մ���wo�n�y�yX���E]��=����h�&1J[ŊN��U,$�J�F{�4m" [�l[�f�)�L6����l
����������/�$P��v�����U�rK6���v�m乌���}~�b��-DT�b;�K��n���yd��k7���v'�-*�����厗c�SL��2�Ӧٌ�b㭱2c�m���Ma����b!�4��
��#(&�I0�@�PRJ�T���X ���I}-��K'��BT� �f����>�=*�uܺ��tsB���	 �""(^��Rf�^\�۟�t�1�ٕ4I��Z�U���w�͐��(EQJU�E��
i��)Ju:$�j�CG�:KQ՗��N��eP1H��m)�0)����͘�,*�xw�1(6bKU���ǘh�%�g �aզ(gm�Y�n�N%,m����J����m��&6d��C6(�أ�aK�I�TԮ]~��?� �rM��̒�4f'Ĵ�ۦ񞭡���O�>9���n�·�[5G�Hʛll��ƽ-�<=�=^^k�Y},h����eTgr��a@:u�Ȇ�b�'f�f�Ix�iZKoP,�DEK�R[4FV�cL�R��ʥJ)�#� P�j�[O�g?A�U�tvU.W���H���%9RD��� �b������ô|;:u��u��D�A�Y���J̻f�v�X���~r��F�	*QU��2���`�!�*�*�\"�J��$j��\]ݷ���x�R]I	*@�vr�����N�}~��>P�Vac�j�dY0�2��TP#�[S�5#�)���S�N�26�X��V=:;e�B�.UM�y\M�&��vuUp � ��	��c0|v�7� ��=`J0 ������/�,VeV�\C�̊� H�f+�6���ن$�K�ض��2�'���.���6�0T���,`jt��È��Fn�76Ӡm�E���=����D�}	�kC��,�$�IL&�QN�%ݹ��*$@ &i"�?|�1bu)]w��\�9S�]%PMPI�2#˶sj*K��� �31ScV촠������O�Ҝ |I��M�����޿���0kBQ)�'KEk1�,P����8�$%�8"H.�*j]����}����J�J�\���\�ˡ-��jP��@Ҩk[�`
k�be�V���ƀ����֌i���Y{X1�I[ɝ���Y]#UsV%6W@
Y��։����'�l��q�?�c��͵��V�ѥ��u���߫�j��HX���&ͬ�
��,5�em���J�j)�����v�c'������}w����}9�g���-�6�V�p������t[ , ����bb p�6czc�`���V ���T����R��V�#ƠP��t$�.w��ٗ(%.PTY��{� �(%.UPlA�
�B%Mec5F�E"�ṋ3Ь�,�X�bF��?�K>��� ����O�7�l����6�2!&V��hLϪrV��U/.�����RR�*��r*�Ru���nM�BR�r��ªT	��j�F�R�`S�0�ԭ#�X�&������P	�ɪ�����ލ-�6%P���q�K[Jg��V��QH�bձ��tvFD��6x������c�flb�6�DG�_}��_��(S���k~�������0�!� �Fho7�3����@(�x�Z�$0Rc,ؔW˶~�2��c��l�`��z����<��P#���m���vM�M�Yb<mh̐�
��T�j�j�%Z� �S*�����Ke
��r9*U����(�L��p��RR���LRaF	`N���bc�D�ԝ�[HdR��ʨ�9F	`��cc3�������G�fa�����,���r�j��`�<)����{~ĨR(TU�R�RJ�9�\!-Z���MT��8 m�F�+ Z�"5i��*SeSPg\<:�bK]�:A�^j�L�LH��n�w�-�q�u�P�E`*k:ꚜ݉0a}v�i"Z���؎Gl��d�u���A �������b� �h,4+{�-�j=Z㍭�b�؆�j�z���v�C�X�xG���?��}9E3�u�-ii��"���9�NC���K,g�$*#�� &S`�5�h��B G)���KIIB�RU*�"����$i.X��w�r�$�vP ʄ	��"6�]]�`���]n�aR,�,/���{���J�c	� �B��f܄��?y��vZ` �eQ)���Pk	[�&�P��PM	$K�����R�V�T)��	�*wLÈ��J�e�M�3 .�B$HA� Q�dR��%t�6�g�BW��]KM:��פ�$�ؘ�.I��E]2���=ƣ]�ˀ@�uiR-�� �vQT�w�Y�A�Xe�TB�[4Kf�-y��f�1=�N-VaQk����òm%�M��ȮN?���'GF�ܔ�ʨ�J'�s 	���cW�_}���iEĀU� �7M(����
&�!�@ �)��� $v*r��A@��������
�R��U�i���l�xc�4n����Q@�XC��������R�b 7���j�M�xw͈EJJ,&[��@	��) e��D�%�����C)v�!@R`���C]U�]��Jl��Bc U�Gow�\���m�{Rm�0�I��
T�U��kA����T��V�ӵ��Ri��2�d�[l����tgٵ#J.��+mF� e�϶)n�1C�R�"��{����L#tm.߹븃�-h{�b2`%l�+hma�T�d[T^��5W�L��L���VV�6��Kd���`DւbǶd��8X��wv�����ǟ��3Mlj� a
6Au&DB�RU()-�޹���lJ	4�(M`�l�K��	�D)�PJ�����1�0a!&V���f�+���?��ߕBYIHc�VlͮKiަ0�LS�0�C����aYX�II+�� ��G����_�1!0�M�`�����Ȕv�Th�-={
��v�ÍBJj�Y�%蘬L5�\J�r-���P��H 	�j���nwQi�HӸl��pƃ�:�{���Z�����F"���5������ Z��AA�#����K�ʡ}u�v�^[kk�͖i�g�uJ{�~k��c˴�`[]w�(����vy���ec�I����.oYv�Z�@h�d;�,o���N���w���������V�D�bAC l.����&�%�$Q2��T���^�&�E�Ll T%���BI.	R�ӥ�|�ުT��Jb���a}�J2Cm����S��_��?�.�%٪�-iaI3�X;TCJ)�k�lR6E ��f��u)a@(4�촉�	d@s �bҤ�q�N�K#�hk3-�4�$��:�x[�`�@,�*�\}�T�P����J��ʪR�������%��B�pSmQ�.���8��]�륌��2��Q�X7o�{� ��	Y�ڂ���Hebv��˗R�E4�x1��z�{�3EbLl�� QC�ԪVl���eY^f�aA��J|eL���=�h�;h�֨��۪���nF+{��>��o�.`abi��aJ��P�VJ�*;�U\K%��@��!U9��Hډ�";��Au��}?��K9�:`p[�QF.�bo`�ٻ��j$����I�Gy�U4�0��]c�XL^�l,�(�ұ*"�*���N&�JG)�"����D����N�06��"R�(h̪�lV�!5�F��� vI��5��������R�T��r����ɡ6I�J�Q\;�.n=�p$�Էas�����/�l����(U ���-"td�vk LI��j_]�R_�k�d�mi
���mz���lm6O(���r�0FP��:jQk��`��b�e`AK��h1ǡ����v��$��e����vqق�i�3��x�Ʀ�Bp9�K���J�
]��B�!EL)�r)��&��/�0XVU��RED�K��W�������JYe���bٶd���$�Ks!
�v�Q<
�F�=�`���X��Y�� � <����R�Nq��rI%�|IAB���(C�� 0(�(�sL[�%HV�		(�L:f�(#�d�hO��f�v>R����������B�R;�JE�LuBe�B1���yW�r��Hw�:���Cwv�u��M�5���ǳ5X	��,֖EU0�� �x��:�Nw.g�յ�Z������ƴm|����^�Qk�x�yA�����K�b	�XS̶
3��[��L����Fc];���.11��k���/����2�}"f��F[���l&�\����*)U*�U!Q�%�
�d)w��QY����o���K���iP�����DT(F�8�L��U�V�6��`�(�Һ��Ɇ�b(+��㱤ŝ|��4P�6c,�� 9����]H�HRJR S0�تH0�(��BhL#� �(�Ќ@JYU�HF�
2!V�5�����ܒI6`?y�P+�Z�EW�/Q��RPqI,�S*U:nNg���yST7)���=���3��dL�Wv6)�̶�>]�L�hʘ�,<��H:M-ȯ>��x��t�]]�S�s* ��5��ç�o�����e��&���s�DAu�rĖ:��Ʋ-3I4g*��0����g�͞���r�n��vk����)�4�M�V׽�b���J�a0�]Ub%-�Hź��Z�� ��\��������g��_���R��4'U�Sv$P��>��mW�fF*l��-��7�[Mc޿������*�X#�bCʎ�f��3�4$^����XnT�lAaڄ�>�z܁�)iq�bE���6�JJY5��=��?�EcQѐ(MCB�*K�4VF���Q�%P%M�	2k.Lk��6�Yu�H�10����U/�uW��RFr %�	��N|G>�q�z������o��߽��Hg�٤��L��\c
̶�ղ1#S[C�Z����i�cHe2����.ݮ�\���rT�����������8��1�l��ОԢ����m*bklYI%�j��H�|Sb�fii�ṿ7[^����B|���e�r��oyyϽ������~�K�9�N���6,��%C�!��W�mQ!� JS�Q�hR����D�1�l%*
T@��/T�H�Ծ\YZڌ���/��6����ͻ.�1����K\��ˤY�,�L_,��Ve|�K�P��H[�IL!�����{�\%�TT������J
�"�ѯ}��7j<� Ӌ�}�$)�Qr��UU��@�T���rG.��:0�� &AQ�Ѩ�%H���4�*U*�*��嫶s-u(!VC�+[BhU��;�C1DUΞ|���?z���(;qY���_bC@ly�۲V��l�b)��6m�.���U@�s�ڵ��vu��mbX`�l���F3{m��Y�RBu�U�,#`[Iv#�vے�g��y�j�]�xؐ��}�9٥�a���	z�ɛ��5wi���U�C75�-$�*K�
���HP�VA(�BD��|�4���SF)'`�(
��Z�R���X��˩�L�m�1�]b�x��k< F�L�������+k[/k吘UÍ�)D��lB0P��/6<JP�$�H�
���
��$"���fW����x�WQ�b
cH�%a�U��:��Z�
](͕�FeV�
S��a�-i��H"�:]�#�
I�i�'lͪ`b�Q���*�r[��%Dzhj��h�Vc�{��7�j����]f��Q�cS�Q�P�.�k����t���[���՛��xhĴ�՝X#�85�[�Z�[���������dr������o�C֮�j)c�!a���:.ک����J��u�k���V�v7У�j#��*e�%�HIՒ�4B��H��)��"qH���@�J�I6YA%YuU�.��a�f�J0	B�ͮ㗦(s��`�.�aMM��3#��QK���#�[~���u��w#�1�xv�(#�XLl \{:G�H��H0I���������I
	 T�*ՕfJ-k�XB*@�HAT�J1�Va���*,�5��0�P�01�Ւ�JC��|�N60E�� ��(æ����s��)w�	iSVo�O��^�͞-c��ك��E
ɀ01�*j'�R;��w�.WTR��eٲL����*'1�T�4ƒl&��CfQ�����?{�~~���?�A�(,��c�����c����;?��O��I�d�J���U��m�-qۡ��"�յ��B#BRU�TAH�!���RB ���$@�I���c�]!���rA\:���fzL�626��cܔa�&[bKV��Z�ZV,���,�Ai}���9��W�`��[��������ӹ�A�(���������=��hBJ1(Tm�V��Q.�nd3M@R%�U#G��JZ
6��O^�&6A%�B+�v����������s��d�m�Ve�r��]m+���GT�ҹ�8�@�U�fc&�z�)o�j�]�lی�m2o���tfݴ�) �T�\*��^+߫�����2���F��*�xz�ԦKʗ�\�0L��o�R��[Zc�}��O'��iai�8� c,f�4�Ջ��y�Q����ܿ��^�/�ݿ�]Ow��܊A1Im�m*������BLR�LL*VU��^�: h��wEĀ��l��� V1
�D�:!P]Eа�K�Z��m�&bl.@�O��&`&��bM�k��e�XK_�ň�X@�f���I���S9�R
�@���T��H�IĂ�RHJvD�J+I��Z�ĬPD�j��G��^�Xi�M-IӦpY�hTV�]ݾ�x��|�N�:w�s� ����?�ۻ�����Q)�t�_K)[5�C�v]�$�5��d��&�U�ڄ�c5��-φm��2��65e��˥�K�s�n�k�)q�4SV���긼�)��IR�����/{���u��K�B����d�S�����#5�ff	`�w��������`e�h��\5K�2k*[bE֎�g��JP�%Ut��ʺ�$J�T�U=VN 		�M�R�` �=�K �U����Ra��-�ie�.p�����(�/n�_�;�,��\�'� j�k���K�V���!X��^a��~뛏n�Uv�]]�K��D�"@%.qTQb��,���(����T�$��@%i�@K{;�����V4Y1�BÄ�6���"��uݹS�.U�� ��ؠM��Ozw��P�\�U�0ر"&();�&?G.NA�}$^e,4�l�&����j6c+\2A�\@e4)+kw�/G�ĝ��U�8�% S�\^Y{��
Tүx�o�(>?𧻓���'.�m���fd�n��n�!���rd�fi��4�`��K~��|�e����������vY�Y@,v¶�;�~N�����U��"� BtU�Q��X�(�HU�:)Yu$
C�cZ�*[F� PU�B;������f ��
̰�Lg*km���k���M`$�2��+��X3��÷Ҫj�KJ)�Ô�$J�P$�&���(Wq��})h%T`U��ʰUH,�&�� @���*['IhUF��ħ/�/�cl��O=}�20a+�6{{G7��:�����BF�i�˹���l�)[�1blN�^gH�����h�3����\._��%u+W߭|Wa�Zـ�Mٔ�q���]��+��S�O����ٖ�27�T���x\��ǲ�%���J�e� ��T������_f���?ìUr�Y���*���^y���Dg�H�*J��
Q�+W~��'�����"��TJ`Y�U�%�r�*C �1X"Z�V�F&@E�&&��O}zo����O�+��,фم-�+f���2��oF��U��Z���>�T!*�(�"J�*�\�U\� ��P-��0W�Z] H��J]]���.M���i,�m^!,Es����쎤K�N-�4��[ԟ^�61m5��P�F�Pu���l���fE�@��n�pmz�	s��i�zsL���,AA�:�!
5D:�S�̤s����]e�r)յkQ�����h[M�;���߿{�RM㷪;� �"d���|�8,zv���������|�;�-^��*�4��f	�o�0�U%���¶8���)��!n���n�E���k1�]U���� U�6D����(�*jTP���!&�"!�l"�w.�� `�r�@B6X�ֶF``��ml@��c����� �7��vU�b���!15e�1�`����b֎�e��I:D��*!]�,�B��W��jm��0PD��D�B�R�t�����7�4��ƃ%�κƛiP5E��n�v���0��ضPJ'JS�M�H�H$�M�HT����h�į96&�x�f�7y�/^��l�X�K�u��<��:��-��]���.��؆I[�&?~�+����u�C���ۿ{�q@��M@��VL�,�Mi�/{��}����6@1���c"�fW���*s����5�-i�'��J�Ď7K��jUK$Q��F9�(�T�TT��,�\���U)c����s�d���%��c+�B���������Y�`�Zr��aڴRA`�b�HF�ٲ�z�.̩@��+���J��QU��WRQT%F�޻���4A��B��1��&�UWw�k��Ș�`Y��F�i i��tݬ��Pm�0�
�j��*i�fj�4+����Lb.�0%U%�A�*)w\�;ˍ���L`��c"�f��x�g˺-.Z�M.,ز�R[�Y��w��N����k�R՚+Ҍ%�@���=�����^���/�Ա�����6fe�nM3���=e��h-m3��Ҍ��L����u��M�͒�ݼ�X7(����$k�L�,'��QS��	��:ŵ*H�0%@�JZI]J'"���J``(�&Lj`ˁ1����ڌ��D`�ɶL2� [��	#Bi�	���W[�.� w!B��TN(�]������w���(��o?��?}W����Jl���Әm&%�.�%��d��f'.�6���V����D�	m*���6"��m�lmA�0D�bC]%�Ij�����:w�P�F�c�����H�[oo{��,J�"*(�j0*��>܇�p�����w�ˎ�i&�<��UX�&�?���������������~���^_���������0�hf!��,���T�Q�\n�H�S�M<be��}��n�f�1����ՇW�iӸ�;eG��M�1hہ�͢�3���z�����LT��ҩ�.!E��f�9�VNr��06@DT�P�ńTb�)��f�`��i�1��Xk��Ŧ5� ��%1cby��&�vg���?�'����[�|� \���~r�&��IjQ�.�����*!Bҏ���"C36�1Oo��1��P��	�j����x�r��DT��S�E�Q�ĪV�:����m��X�a[�h����4�� 1I�1�v\�<F��~'����Vj�mi���2�/~�3؎ls��H�H��r���nw}s}��B,��$ek
�l���i|���3[����пz��o�1ێe��i�U#�L�?�����Ƿ�W�`��e��emk6�`�u�P}:��nJl��==���[[�����`��cl�Z�mG��-Vը��(<?RDHHb��Q�)��5E�t�%TAu�`�)"$@�;���c4޽|_���,�� dc�	�,�`����-C�ѨT�����xjd[$	��}�~��˿�O��÷�3�N?�����������V�!Q*e�1Ɩ�6��e����$UZ��&l�m�-%{�w��j� :,9K���F���R���{ض�lmۚ�0o�޳��&���ѶULURi�5 �X��u�y)��+�i�Qy[�&�����hw�ք�)cΫL�]�r��J���Υ�6@�����"�V�4�{1���l��W~�/ޯ�ݟ�g�M6�Gڞc�&�Dm�_�����_��l��D���h8�L�7	oG3�,El�|��hTVl��}���ct3�P�!-̍�%A(Q I���@��}z�N�\.ǫ�#��,3������e�'�=��LQJ" �������Q&6f�f`�Y���-[k6ab��ڟ�g����r+��M�0Ɲ�rc��ޛ�l�k�����}�{�����Y�1�@e M�T��Af�+�Q���l�f�]Eko��4�MX4+Mm��m$���*.�r)�R��`��<�-l�<l[{��d����xkk�Vm�j������9����������F�!�3!?�j��rW�8]]]�v��K	W�ʢ�Nm���%���4�51F6T�x8{��[�;G����!���|��>.{�ʹ�L`+&�
�fӰ�&��������f��a�i�������Mc�vj�f��"b>Ԍ�Lh;m��0�,�.&�!u]k�d;�RN�*VE�T	��\��D�3ϧOo��Qn��
 c�^���QJč�\
�QLx��=�޹��c'J�ؤ��n!���ٌa�
�7�iͬll����~�?�����Y�:&ͮ�=�؛��}�_����s��l���'�ߝ��`� D0& *�"�X)���s��%�l����L��h3{c�dD�f�&�c�m�#2�{�&�l{�[���[{��V0�EӦ���_o���o'���K�-��k>���U���BY
F\�yӺ��Idu�V���v7�s�w�)E��k�j,
ݐ��4'&0536��C}��Cӂ=�Z���w{��m��7=eh�l
�u�A�֚D���di�b�c����3aF���pa�	�['�v刋��,��n��W��S[
�)+gg���R��RJ��0�N9
��K��\�K�\z�(�����G�N ���|}��X!��?����۞LEVkz�m���f`Al���̌)��l6�l�ی�-�@`i����ｿ�m�{�6����?���>h��L�Ѐ� P5�%�@X�PW��c @5.��b2��c����i�F?|�G?-������T��l�%[Z��r�2����46��R��X���L@�U��!��D���W��?�{���!YF��;ؚ�f@tlR߿_J���ҭ�Ν�"���T%j�`��f�����w���J�F^U�����ޫ1`[�!�I`ӄYs5�"D4 F��l�iKaE�-� ���m_?��X�17��۽"/?��/~Cbv�p[�����'&��4Z�J��3��D��K)�J]>�1D��u_~�B�x���V (��ӷ0�������8� c�1�bxl� 6��m�0��Tĥi��1x3�X62�$�^v���O������=�wǥ�����'�;2�Hb)"�%#�t"�p"K$h0FJ�6�#BJ�~��}�v9N*ej�$�` HYW Q��R�sG"���R4����[Ͽaދ67ˌP"e#�Ԧ	c�2k!e	��Z�֦�ꢆ�F�l T۶�n����9�J��*��c��v�r%ww�8��(%�FZPM�*a�7jO�Ǽ�w��\��ε�q�.�1ҤY"��A�4h���
 ����/W�L�Z ����%��2bIR)U	�J6��Y� l�� C l�ѦJ��D���,1,��e�ud�`k2�>?FV,�44�v��#�����Ơ������w~��Ha��j�ia�x��L�2Y%J�/~��������U�UfA�H���T��(Y� ̖��);���(C�ҠOo�OW�U���m�M�5��e X���R:5T�Z��tfWM��g��� �	���v�M`�T0�NI0-���JJ�Q[��.�#��N��ui�\su��۪U��U�{���cT%(&N�B6��Tb�l`���}���ܽ�˶���]ӌ�b�(��[�a&6+R�1��k�j��w�����ݟ�*:f�5i�[TGtS�FK
kF��1/�xC�v`Z�y��	�҆���f`���L�|�s���%!XI�� $�r��[ʑ�H&{�1����P��"�����ͷ�e������"�����BA�
!C)C��ZS(��fx�`B��U�-SrJ K�ĄP�ml(�5Ҋ�������݆u�R
���&��*�`F`*S��ʆ��MwjW,��6�9aC�>3�ބ�T���"&Pn]��)��2�P�K�V����$�\]�\����9���B+%��(ĀAZ@��Z2/��̓���5��e0`Q�� R �a�#�t-B����0��FR���V�UtS�cǤ*�6�=�ǋ�,E#�k7�f�������/3Ě��Xb��L���gzK���X`pm�y`"� K�H�0�*�I�ll�M1l"3A���Ml���}y6 )�H)�86���.&~�)Tۀ" ��ͧ����UE�Lm�2�F��E 5�a��M(V:�S�o���/��]6�jVi�t�w:���e֥yN?�$W����vB���(�hR��.�J��H.G�u�r���N���rtD��T�T�Q՝J�S�S���zV]Cչ�N�h�KU�D�� ��&(k�2Zؔ�x���ol�m���JU�BȄ�F̒l�b0�#�KhV� ���!];e���U�($-٠X���c��˱��_��ŚU��ȶ\��40�����-��q�k+sh�+�j�q�� �DT��-���b�60!��.M�9uT=�O�i16[��BI"��Fd�Я��A����T�������.[���傠�2CȖ�$��K��������?��3�&IUԺ:ݺ�`Id�6�m�)V�h�6£ԦT��J��T�UiU�%I�J0��h�r��zw߽���QB�������2U.��.�;�*����*��N��N�"%�#��$'B�=�36�czn����f�4�U�x2 ���{> ��������!��M�M-�ڝh@����$�RE�w�����T嬒쪔Ӧ�f���� �f��b0���D0�f`4@�fss�M���BֵZV�1�A5ld
n$��C�4i�	�b"�SL``�ٝ�k'�Ð*Q�Nؘ����8;��R,��$`TL�1��������?��AA�Vb{bD�&�m�R���~x;�DlSAR��܇;Qf# �`\�̺`2X�{kI��P�TmW��UAQ�.t*_���l
l�E��r��e?z���J��4wQ��*�\�r������S;u��\߹(�� )[��MYi+ Zl+̴�=l�L�f%ʠ 4��֛���J���Ϳ��ͳP��8�%�j�51L-i
pp9|���mu����rq:Ub��+ 8�x�v��,�v,0�f4Km�nz�τ�,UxyS����l�[��Ӓb6�q�A�)�)&��Rv�U��&@ЮN��6����HÊT���_�������C�0ɦe˛���F�}��O�"K\�X�0�Fd��t��L�F�a�3�S��1M��h����\��44
c���M�(���4%�*Q�ʪR���=ͬRmBU%%�E.����!G��J�S��Ҏ�����r�����r�	B����͝�*���+��ڌ����)�P�$��H���il0��4{/[�2uԨ/����1� FL!`4c[��N*Q����:ŉe����%�4l6�@�aR�<�x��3Qn�����a�� �+mg�&nFf{+&2Z֠Y�m�)M
L	�M&��� W��AH)E툸�ƀ	R�T(���~�]�,�7�挠��`�Qh,("T��u�Y�&�2�l:S&�0A�*��)��ʰQ�Mm*(n-l:`�h�j� c��Y%	]�*��PK��7�m�����B�rGL9��(�b �r�(����T_.���=P�����ʒBNX@4mBR������u���M��f�%�2bʺ��%H�b�%6l6�61&&�T!gV__�X{s����F1ǬU�F.u��T��;廭P]��W�&��V�W�"F��Z��͒^� g7r�~�o��=����3n���BsZ�F�c*϶#j�L�,Q5kWcl�0uHӧ?y�����9��B6� b���bel  %����(��@D*��g�?wP�$�`�V�$S�=
�T$�B��J`c`�L(0�Q�P�llZo�!��j��R#V�Q#` jS�``[�����T�
�Ša4��ҕ]���B�l�2f�I��J!�:Q��,���@��iU]ɵ_�N�R.�"�����J�4SF������q��Bl��V-(F��)�AU�ƬNmG��{���X_޿���(����6�ޜ@��BY�Ki����]i��>XU�DF۔Fo���M#q�2f�~���%^b����s���1�o�GϽ��j;Ri�)믽����/�v�Q[f��vc������$}yl@��R��M6l��!MSL������+��`9$� ��f�Zo�X��R�۟�Q�WFqA�!#�DA��$�CKrdufc &B�j'�$�Ƙ�!�%��Haj�\�%����zӉkoլl2�p_��(��R�B�Drܑ/�[�����h��n{kKS6	�st]�]�ܹk��Q.���)9�Νe�N�ZW��#D1I&�q�-�@���؛j��ئ�A	%kUňMRJU
�;�b��ЦɌ��^�me.�fK�ؤ9�,���J�Z�\}��wQm��ӳf�cL��&P�F���g�2������ ܳ=m�yX2����5��)������|����~~��vO69Xu�1{�@0*q � �jM<`��Ƽǣ�["!0ehq�i̮f�}|�aP���}��å��%���+K!Js�e
�E�8	�MR�SG�R�` 	���$0P� Xy�e�Aå��pѐ��}~��ׯ__�2P.l��b�҇�\Je%h��#�)�.�@I%u��V�	�Fަ�x|�;�R���D(%F������NdWQPe�%��J%Ǩ؈GL�io�l����ymL��mj��
��L�ʒԮ�)irE�K�Q�U�L�I`C�jS1X���V(���ם���%���6�L��O�M��KH�n�R@Kk�b�$�����u?<{��i�씅����)�V޿����=��{�ev�ali+�
�:ŗ�0�61Ą`�6<m"��*" <ϰ_��΋B�r����>�D��}p�t�A���HIJ�C�I"�j�'ť����Hj*516��e�&�%ۺ�6�� F5�TC׸V�b�mj0l�VuGnej��6I�V�:�ҵKW\RQ�u-M���z����PE�]#��u!F�D��;KH�U&$�H��BH) ���@ؒ7����cl���w���#!
�t-HiT��U\�Щ�JU]�QlwZ	��L��tl.dB�l�e�����;�;��`�mz��&5�r�,� �V��3
^^�����g,ہ��jd$�c��������f���](gY2*� J�q�4�#̛b0��aKZMb� �񖏟��%�(lo;`%�$ݮB�r��������ʞ�l��L)�Sm�e�U` V�`�eWT]]q�(��C�KH1i��f�4BX`��-[Mg\��]HfW,�2�V��+�`F�lES7��аUI0EW�.W���̥]�._U�(m!�ڬS���-)C�R�$;�" `%52�ۮ�!!UuP hɦ��Mڲ�MV�4|v�
!5�1ZQJV]DXJW�R���Ȍ��X��k8�4#FcԠ�u�w��r��U	��l��-�hZ�@B]�A�V�֬́fċ,˸O����nyp#a�Â�2X�%Ř1�?��������������x���J���S�\��.A�����ĘM��BI*%�=�{:4���2�f�l�1��A
U��ǵ;)N�K�(����R������4B=��Υ��P���5u�T��H0ƴ� ��ⷿ������\I #w��))%6��@QJ��,�LV�$)���]���
���
L7����Z���r9.�ҍ4������Q�l�F�c���,�"���4fV�U�)D���R��4�e*
��¶.*EFZu�RnÄ�nƥ�lMFNڱ,�$\���QMb���`k�[˶ejruP�(%#�n! �����em�����<�M���--`ʆ�݊Y�$z�a���eY^�ٮ�U�1�t)�/�h�&�f��4�&�����X,Kb@���Mz�m�ll;�D�t��T�Dq�/������9>�����JW���J"�&�"��L�+�\}g� PF*A�!� hl0bl���jS��5F#��2+2�K7��T_Z� #H�:U��\�|�����(�2��f�Ml+�V��>��/�6��D�TrHAU.wP]��a�b)dK�1��HXb<����m*�"lJ�REa�$*�XZe��L#f �b�0e��ll \�%�uA]�Ji[�8dZ�R��H�J�m�jf�6����y����N�����;Z�[�U�|f�T4��mٺ������TY�SQ�M��AYG��.(��lc�ݴ��ֱm�iZfӄ\��d��@\"�c�&�J�ZE���v�⨤�����O��)� -VA�.R�)Tf Dt�\Vr��UDԔMUA��I]PL`l�M,Ml��M�P�4��HF�*Ĉq)r��ε�3F� �(A%�t:��w}���Q�Hۨ��$H�r��r�\~R�`X�@�*G9�lb@I�M�	��c3 ��V�)b�&�Um��(6 -`��y�ٛ��EY�K`��0��2�l�����:�Y�l�Rʗ�kߑt�UV����-�"ZC���lҬ��U�hk�*k��ҋ��Es�>�l��}�X#XjK#AN��j6V�=ˎq-�&�l#i�T�DgW_�\Jl�`�`�iW��6�1��*b��$#�%.w�.�c(ɘ6��x�>�{\��\�_&����)eEIƩZd�`*�Q��s��eAʤ�i�  �R���n
F1�\B	�L6�a
��ۈ֡�
�rqSwʝ*MA�\0J,��R�U�R[�fm,�U9{�MN]��)w�W�(fsX�Eh�D�6������@	���ٸ������o�vÑj� �B�`lp���Hys���Z��R��ٰA��Hl kf�n��Zg@I j��U-�Щ��k��	L5i�^(��(�q�J�'��;6 X��xv�x}>��+[0[��W�!Fy{��A-�U)��V7�Q�*������)��O��0��ۂ͌��2L;ok�&ˈ��OGi�욂`�1�l6�O�>��~rb�᫥���E�Yף�
QؕԦAG��.{����ը:�O�@ �M��?��｠#��$�@J���u����D	�$l.�P�%�P�]�،�w���#0��2U��U�w���A��a �Q�
Ujw��N��bH)�Sm�
)bbc�oƖ2b�q��4���Mo�Οy��d0����S�v�yi��`SBi�\���3�����1+��z�e�f���Ғ)dU�ڔ�H%���_��O5J�@{jS��Rժ�a��*�b��fP֫��������ۀ�Tm{�M���"K�mC���X��>A�lj�.%.�01�fۖ���lj[���r�c�"!���m�3-��R5�Ac��1�e�c��6c_�¥J�"@qTB&2HMGO����t%w� *��?������P]����()�\]��M���\*v�	LQ���U�f�j&R��P�p�w��(�,�M�)�̤�/�S�-$�V����^S`
����%��%Ll��6�Tc �6m
�!:Ƙ�ese-�9ipgk�Ũپ}��yI���:�%
j4�6�̬�x@f[�1ð-�Ȫ�EP@�k̑��#ʵ�>?���:���U�:��T	*�H؊���vϒlѐ��q�i��i�#�[�b�ɲr�L��<��P%�1�͌��qH� ���<�j��wɦ 傱1F��52���Y Zc����g�A��S)]��TjJD�(T������%#鎨��tY�,��?x�w���L1PM,!�2��"U9}�C����T
!�H�0cX�]�� ԶjU��%�K�Yuɶ�$@TX�]}�%���lI��mAI��\��*�/.���Q6M�Msռi��1��F�ز]���M �v����c+�h�F��VkkZ�"�K������`��I.��Z*��-1U�����Κ�.k��6� Q)�f�(lWU�2��?������_.���Rɶ����4ʺ�yufTKi6�d���Ԍ�fKnk����͞�onK����2�kY�!!�j+B��r�)�5�Vɮ F�X�]��޼e����s�"0��P�D�*DcFc<od���Y��ۚ��������tD�jC )t�۪�U�o�����BEpu��b��qH�>�}ĐAX	�*[���U�"��;����L%�.S��j{#+v�6)� ��nW�-�ZIH��1�*sb�;�H���~�v�����*o���&QG��A����3 �W��y�����D4���
L����_�<���a��e��Wm�V5�*G����!�*g�J��2*��n���ao�%�-ۜiQR�;��!���H�JŤ�؜�q-E2Ƶ��\m��t��Re'c�E�++�f9�X�M1j���������� K���ͱ�*
�Y�FL@l�][��cs��b� �����Jd3ylƅ��,��o>|k�/���͇o�2%s���4�e4D�
�fʇ����*EQ�����S�M�(H1eԥ�JV���w���� +#�m�m駍�UlB&(����Z��"U�)��*MR%�]э2I}xK*$ݍb�-V����C��-l�e�ub�*Vf�V�e�V� h�f̰u�[2*��E�m�V/�fo�8�ʥ�gTJm�E3�V�m��zz �)(����qҾ5�#�
��*V.�hTR�BUd��m����*ձ���@ہ��1���UV�Y������7�Q '����-E�m�X-��c4��r6�80�kֆm�	�%ö�� �� �`�V��$R����`�ٛ�ǴR�Dз��L��[�,�	��%��RF�BPũ D�J Qq�\ԸH�b� �L �f��B��"]XU�޽xu~��nW�R�3+�me2��k6F�d$VA��\��V�E����^�lsZ�LT$��rUk��("�e����w����L��Y�R�Nl:��6�Zo�F��_֦��lW�	k��g��RӶ4���1����mh��m{��dF\u���5 adT�TG1T`�hc#���5�ԐI�E�Π5���+W�k�rח���{Ւ���Y��ck�b�l�E;��h�Lh[���iSŗ�n�
3r�׽�������[o(c�c�0ls�&
���/ߟ��Ɩ0Xz��ފ�Y�d�l�&���d_G���i�T�Dv`*�=�1Q��d�U|�ևo�2R$EUDI*HE)�L!%�H!�RFI�B�t�,�@�1��l �
�s���\���kDeK 1lbz6e�Ц��t�N)%�����M�Z)�j�Ίb)��������FG�ڛy������9�$�����!�a�6�V�����l�&LAL��{;�ʣWy�Ć*���l¸��\��aـ��֢mSS{�Z��[�}~�!߹��?��#C��H�U�4�*�X4 �aW��ٖH����F��]Kꣳ��W����+VE"@m*bVu���M�I���}H�]��2 �iƍ2Z��bW&�5��X�o�����v7�6ކ�> 669���j4�%�bO�i�M5`�k��F��<��)��5GBv���JD����r� S�_b�	��K������2D����w�"w�]�*�6w�M�DQCC���	i]�t�\.Ww�t	�I���bb�%m�Lǹ�n��T2*�FH��"&�l�������mޘ
!�E� u�Y�4j��_�����&6j�C5����*�Z6�/�dV�F�����vc����4�HS`�T�⼯�>�ߛs!U�$[�tPAlmad�J*Pb2b�:���Z�־�CR�Ώv������'���U�$�c�bFKM��'S��F���rZ��h���v��}��nǘ᝝٪`M�VB� ^��0ӊ6��>L��aS#�,��m�l�b��̬ �M�m�,�K5P�5I�\;�PT�嫫�9A�@@|E��E�V(�"E�\-QO�.���*��fe��EU�RTՐ"�J��h�J@*
�PDRT�s��@NE* �a2������N'�UL�$$XeK�JiF%̭�U�SJ�ڼ�.S(_P������1��ˬ$!�S��i*�0[�+2`#�����33����*�Ur�F�XIF��.��m*���p���&-Ȥ��LH�2u��ˍY ��UW�+��Uө5U��b�ذX��F�
ɦm3����$�n�X�k3;��f��Ԛ�bc�}�����^L�-��x3�����~8]�e��F˦o_�[ڶ�m � ���8���3&�J��S�Xe�Tv$J@U�rD�\.G(	��8�2) t)�B! A��XJe��*��v����eb� ���$��U1W!���R�|����#�R��\�`[1fiV![L]�R�@�ꄄb�
�BK�� ������&�VC�*�Z�ҵ�t�SP��Uc0h�+h�l[he&*���Y�d��PH�fӤb5jc޳�k����dK�3�%N��J����r���2ۼy`�N�21�M�IҚA�V����Z�6�k%]L�Z�*V��hc�"	mX!ؾHL$�l�������/E�w�5nS����{iY�M�W���X�"�%,+C�n>��1�����O��e��W��F?w�J;��:f[�����ͫ�L`���TJ����|�NW_}���3�K���TI*�E@��)�,�UY�d���Z��,՗@mBb֬R�D�ĨL�be!��sW�s���Zt��x���=����[!�|q������B`Y5�	%TaW��u��۶,L�U��^+Ԫ$H�R�*���P��Vcb���MĴ�	g+{X�ox�����i���4]Ӷx�"FF���^��l��[=����1ޖ6M,'��l�ڌ����R֊��@���C$����$�%���	b��RX�G���_���hV��3��X
%C��}��M)��̂:O��s7��|�vZ��6Җ��X��f�eV
?<q���w��YV�9sl�f�$4vg��61ތmmxo�;��$�H"�t�q*qT�#.Go|�IЊ�U�tM��Hʔ�P(�Q�2��$Q�޿���yO����!����L��6G)���%�����R�>��G����!�˛@F�ʂ�O�k���m���Z�Ai۴a,�]Ib��FVr�LEm��X%e{3��Ă��d*+��5B�?����}>YA���&�V�&s���®2��)lk,*3�����F��ʖQAb6�B��va�*	E�e9.�FqlSQ�Д���*��Q���7�����*Sr)���K�m��
�d��wއ8�v���0G[U^f�a��X�Mٟ�z�β�|�� �6�QeQ���kt�ذ'SL���W�o�HM��T�!Ǘ0�$�""B�B�N|ЅX�U��LSHQ�(U��
�6ND��K�N�s�s�PFB(��n@�f�2�d�VE)���*V��	�a��a�F�fֵi�� �r���:S)(�l�Ԕ�"�jIZX�n55��{� H�j��-�qiڲ�ضBKň�l�m)�I�mi�j4�6ڠ�Lgk���&W���6���`6�N0��@�ʑ@KS]�iHA�K�ְ�WYK����� ��.&H-eV<e� �ئ��*��R��u�����9Բ��
-���I#̚��b��Vm��lMj�u�>�"�孂�V����le�~�?�e/�~�-~>��/��>���f3�6�#`�[{�����U�yk���O�?��	@����X�R�A~�#GUE��p)��L�H2�t�,0Ԭ�q5����tp\V� �U�%�)[�&� iU���P�Dj��lb�v��a���,Ҷj���򈻍F���Y%�(,F��F�$5V��X�e��xګ5��7����՟d������Rmˤ�1K�h�I��Ɉvb�L�f��Je���2��j.�*j5����}��mI���H�Y�J2ʦHT�����&�CSK"�f{u�@B� 
����p����:6M�������lߩ�*.v�xq�3�-h�fp�i7�h�֊5�h��vz��HUb}�m�hx�� A�Fu풲ɴmo� �h��ȟ�'������/�G?~3�����ǲ��
��ʤ*
iW��$��"��]�jS��x��qJŢL�2�ꒊ1e�TV2SSD��R�\�j�FY��Q#P�i C]�:]JU�Pr!S��XPCb��MF�6�ɸ*�b�.UsPV&l�!Q*;�2o�V�Q�V�dƴ�ޫ����,a�a�m��;�Q-�IZ���U�`�����������Ԍ�V��ꚩ�r!��`dh��Xe(т�!��KT�?�����WP*��
�&�����3B&��0�5KSB0�-�*�����K*Y���P!�UnKy�7�2�kи�����z�NS#���k��h.�Q�*��/�W����J�i��&F ~�����y��1l�J�&�g~��������>�������w���o�������g�Y?���������SeP
���|�S����(��U9�T))�Z	&�b>�z���t�{q�#Be%]W�!�2��U�2P�L* aB���)e��`�a0�2���̆ٴ��%R�%�i�Q��ce�2��o���͉��`�,��	沬m]�BMA�V��6�)E�M#[a�0��]�;�W%K����e6��1�-�jr��js\N�fhds��º���C��F6A�i`�TP���&��W1�#�Jx)�J)@�.	�+��T	"��e�`�[�l���`���nI۪���mz��lW�6I�.�]%��J�B6������V�
���1k�<��lՁ�h=>�[sI�6Y�(�N�)۽��mo���_��������?����y��?�q����1�Y`���հ��l���i�ɥ� �U�
�荜�.�.0���&�(�ך���0R9�10��&�)M().G���Re*4:�B�$D����(�
��q��0�l̠%ފ�a�)ňJ�bbce��6���bi��5IjkcЬX��-&��gz�)LbBK&M�l�\]L�0S�T�|�k�|�23�f����&0�;��wL����j��`1E��e�SSe&]��ټE$��Y��:�&�l�&bM%7Ih�k:%u���H�
���D{82�ZnfiV��
!�B]��*�T�.�J�WI+]w���S]Y:TRl$W�L���`�Zf�k� ��!.3nf89��%��Lh���-�0�����O���x?�k�������6/���fEَ4�U��.~r He(sAP� �S5�"����}�# ���TL)����W�ΰ:���JQpBJ�_�ǙB��RL�z��4Ǌ2m����wS��Alm�$+e�E�h��a�d�im�`��6�,L;� j���2�T�����ͽ�VL�m��l���۞ddՈ���m 	Ԯ������~�F����`@̪M L͊�M�h�Q��5��Ŷ����ʢ765#S@�R���۶6c`��mJɘ�@QUQ�%�:Q�H%]�Rf���xU{Y�!`�qiVհ@�@�����yG�2P���/���1���K)����jM�V�JuE�V���lSfc6֦� �e��cT��v��Y/gVM鶖Fn^>�ǃ�~˙y�����ӿ܇��3���P3[ �f���ȊmU����H\��D �9����w����Ma�T>�#��9�!�c3.���T���K����@��)�J�l`�-���d+d���?��j2���K��B&�*���Ȱ���D)ms���ImX��%��������hV}9M��1� ������E�MEu�=F�T�ָ�U&@K�u��4�%� �8lʔa2iś�P6U[�EȰ�ְ}����G2͖@�4]���[��S�]]+Hv3�-��ƳBQ�T�d�R��˝;���Ԫ�: �8�e�&��#���w7_N���V��{�լ��Y<���%W_�bf��t��.���|u7����l��1���a�!m3���a
��`9��ͅi�vݙd�����V�X�֮m�?��m�#P�2LG��ѳ�H�mU�r�*.)���"&��\���d��"��+��]J#Ǯ�4�DD9$%$S�U"�B��l0F�̘L�eA6�ټ��ǖ��ʿ���fXڻ��_��������bɶ�&#�V�VAe��j!�fa57ݖ�����o�$�4��l�Q��Ԑ5~ڛ��z��h��*OP�HK�Đ���3��O݊u�bbHؐ��
)3��Vg�/�c�Ě�����A�e�6�mYc���hӰ'����<��h�$�
��r���i�*���.�b�J����m7�	��l�5�ͭ�fU�����f�7�#��i�5+m�����r�QM�Jմfު&0mƘ�l�2Tf�ج�Am��sR�[�az������?��~�'��m����z����� ��jOi(Ř�T�Tǥ�,�>	:AH���SmL� �RR%��7��/~������Ɣ�%$.�HL�2��dʄ��1l	c��0� �yo��`�mB={��һ�=ߐ�X4�4m�ӒȐw<[�����5��-�aK����V�hl��i�N�fe[�M��J:�m��F����]��M�aixd[����M�)��[i�$�%Ô�B�Y.�m�������lj�ن6�����M�Ě�fQ�R���ruR�@�R&)��������V}o�}d����H՛���(��`�����\]Jl5O㭵�u-%Z�\UUq�
j���Z�eڨ�$����V�	6�κ݆a�9ZF��-*�`-bw[;�����u~��o�<~���o�e�xs�Lqa
��چ�b�ֵ[Qe�, Q�W��������:��\��~�˿Q����j��|3".M�r9hA��$%��$6Ƃgm7@�Rff��d�o.�*���mP13�������|�+B$Vc�d?�����x����|��l�f����L�+�Mp��n#<�I���1`*QlW3� �Vٺ��Fo�㹲�Z�\�hF���X*/n���T&���~��jV��1���-aL	��@*g9+%�Ι"S����jMƸWo�n�{�6_N��-[4���,֮˥�)$�����\}u)�*����WW%ј�lkl,W\�D)_ +�
�����V��3���3C�4��%Z[,v,Ϭf�x����2ƳV�e�p,��A�ثh�j0̪UeU ��BQ���'�o�L.gg���T.)�����6�IK[�hJ�H�@�d�B�%��f��
2b��LeRj�f��{�5U�
W�"b�j���Wb��W(�	X�s�=��c�����m��&a�	�dǊ��ʸ�*�2�-~E�1)��KO��cö���>�w�c��0�`F�R�Q.%;iV`F��c�a�̾{ٗgC���H����4�d�`l�lښmԶ4��e6f��L*����cXE�J���PIu:�%R"DH�E#��a���b�bm1#�4���%�Ƀ�{*)C���JӖPU]�\Ua#!h-66�,Gu�\�RG��i��!�MM���O��/;���6�W�H�YN. K,o�x�نe�w�#�`�ɷ�6��(�J��1���Y����XB@��HT�˂t #����W���1�]�g��J+\TH9�/)�Ŵ��A�1����	?s�`�T��`���l`��F9�pQĶ�H�HC3%@�����Ř3���1l���r�DV&��1czl����mŪ��ITA�F���[���zl�n)#���%�IԪkG���4�ij�?<o:l�I<ZƔa�̀! �Č�֌6��6D�X5oͶ0�$Ϗ0e
�$��ڤR��̹��}���o�VVi��:�i(��jF=aJ�,�C���u?󳧋�TWQaE�iʢ�-��������(l�5��0�R��r9�v���������2?����O{�{�-�Ս�>�����?#�Ü�a�aK�[QTےaE�F�B%�����hTXTQE�)� ��ve
!�0�^�Rݩ��*Klvu#Ŧ��L[�	�(�@"�4b$#+��M����J)�f&�Ш�l&�iF�r��@�P�ʀlHK$��Z5��U��hPǬ�̫Λ����bk���xi��!�UC�Y�)e`��k�F�˗bk�� (a��ĝr���Fbs��VL�P#���XL�ؤِ��TÚm3�fzۊ�i���V�fͦ�H�JʪRi!�����T�d���LӜP{8�����L`���a��x=��	J��Y�B���v�W�jͯz=c�!T�ք!w��R]�?�x�����K�u�f�����?�-/m��_X�Īmi��lК9�f��ڐ����`b�m���"���]��n�g��b��J9JS��@�}s��A�1ͦE���wP��:u�j-�ZA�)��*��
@���X�0cf�̖e������*"�m,æ�յ(A��!�����Q`�Il��x��
��5��Ŗ֔�AZ�mK�6L��T����oAmҦs�Z*�Ҁ�ClUH��r�je?������Ul��i���ʔ�x��!K�nK6e���l�4&62)�eUR� F�X��|U%�"�*���Uɪ�KU*+L�S�/�D's���̚6�V��K�3A9�*&���RK^���χelӪh�Xf��c)G�N�[����xL��$�:��M�k��U٤qm˱%۵�"�X � ,l�9�M�`V,o�q'��^\�{^���6 TȎSd�J� G�����D����P�Q݋���;߭�.��1E�	��0ń$��2Y��������
�г��ε0(��j�.ƌ!�����AT6����4���,`���$+��T͊��.c(�����be(m�r	��jT��ږɆ�$�ꋭ�R.6���V})�@��jj���\�eG1ۑL&����e�,v�Y����f�6�*�`7Aʨhd�ɔT��%�HA	)��t������˅И#�leC4� �,�Y�2�S]H9T��EZ����H��$!����Ua�7��*$*T_Z}�KȘU�I�t����zY���_}���=��U��\ �P�Ng[��۬�`c�M
���e4��h��u�g�o��o�S�φ3�
PU %�b]�T�jaHj}A����VǒJ�g�;|���������A0
�)!UTM3�X'E�M�A�~����4�BCu�r�Vm� �O���DI 6ؐ�� �G��&k�J6��I4����Ԙrz���X�=����������~�ilL�IoS�/_eU���_{^�\R̬߿��o[�r�԰	#(�R�����Li@��{��;o�Zw�㴆7f�\&MHZ��jII��R������֩P� U.�H�pIu?���<ii�Zn���m�4ak�X�YUNՠ�T��"���I��Eu�DH�˙��VE,iU-�$]_;�M�T�*©�ٮ)�뵧��s��޶uKd�LmI,�ڱ�mb�4&�12! �f�Y�� VQД�X�Um_֡%���a%��d�[��x�ݵ�ܶ[u��4mjs�X9	�����Rmb�VV���kI�Q ����AS��������.�h�����	u�� �f�V����Hc����1�O��x�A���B��&ۤ�;�'�[3����@i��|��B?�?���Omg����i8�Ϫ�Ҫ/�Ԏd�U�Ve[Z� �b��$y�����1Ē��r��;W剶�V�43A6��a¦ʰ��0�J����$,����)�hՙ�BTIW�h�K2�v�Ml���=���3%� $!��
��\� ���UH�Pp*I�u}�DlJ�>}��uT%�3��t��Nj[j��fS�	��B>۔ ���6hdm���ib��w���o��ܻ��Z3k�3H

#���+A�*����XAC5��_�m pf�-1*�M�IeT|��QP �IZ��2B�L�ɀ�\�%����D0(�J$f@�
ƘP��1R]�ۏ���_NaԠ���lV+�w��1dI������5N]K+����A4��fc9׾�2�U�V��>���lw�kM��&SP#�Q̵ae���jY��MF�M�ͻ�j����`T�b�H��l�Q�T��`+JE�U��+S��rG��H 1ҚԆ�&��{���dL�=�e�H�T����Q�L#��@Ir�N��ku��ru���*��ud����?�;�g-��.6T�#�[Ŗ�8����>xʆ)+6��lP)��c�6�v�V�>?����u�d&P�@,1�5���X��W�?��,��� �#�f�alK��d�*�ͧ?>��H@VD%�2Wh�AmQ�k�#����ݖ�@��I���tb[�QJuտ��?���_Œ�U����?���O9�ާ�URBj�tFj?����Ehc9�WX�ll��RJ�h 1�KS,�&2��n?�2Ū�������U�>�çg����#i� �ڭ�6����Mv[Vkcy���3bmMφU��`ښ�B%�ĪY�A�9S_E#���*�@S�DJB#��5 I����I���L�0an�iڲ�����/���=Ʋ9�U�4ME<,�$�ʤN�|�UJ��U���>'����U!!� �������7=��װ�ld�f�t�+�i������|��\m�lS�d#���*���m��f����5^�^k�aJ�H�4���og'�
�A����) ��mv��;D���ƣU�&J�
ż�9��(D �P``M����r�r���X��H*ݡ�R��URQ.���oZs��;���ʞʞ�na��"k>�o0I<��lXA�E.Q.�+�* �0WAl�U�h�}W�_���~��GS�w�|9L��(�H  ��c���Y�j[�U�0&����0�[koȤ�5�7�+����/��/��D�T4 �$��¬��ݪKDq!��hR����l)x�`�M�1g��7#��}���������+�4�+")+Uf��jb���!U���:r�RA�|VzFc`0W0%J��x,k���l�s'붂Ӷ)F��G�g���G�l+��
��؊В�`��%�6�3��$"�@y�W%�l)��t?i��f���I�Z��lb64�Ґ-�� PՔ�lNS������YU��m��ib� hq�J�aql�	-��ʄn��miPI�����ri�U6�	s:�[�a���&s�`
Nr\Tu��Ҝr�)��Z8*�d������4|q���k��J�����
2u��F�Z�Fp� �&U��da�H���}Ŧג�[��M�m U�%�r{�$sȶ(tG֤IEU"���*ήjW�������U�i +L�S���ܶ��;����ŗC�`�ae�R���\�4�F%�T��n�s�"K
40҆5 
I�T��`FkI�w�L�;��in�diF��2gF����lMh,6�޸�܉��a[^������&��NŚ��j�JcZ��]׸���6��
�A(�����q_%P]Φ��
4ƛ�j���u��9sץo�D�r\e�V]].i����\%*!>}��@!S5�ݴ�$��F�������9Ж��%�DITN�D��qUP(�OO��li�U��R.�k�ʶ�(16�DԬT��V� "除ٲҤ�������^d��3�1�mc~7<m%��B�ʪ2���%	i��R�ʵR��J颔!�Jt��������w��w�!M��Zm���1����-�wS/4*���
��f+!A"�At7ץd��lݙ��@3"�H�4	�����tۙ4����v���t����iI�L�f���o_��6��˫W�	�Lզ��2#B6l��dE/.{��>��~~� Pb
�Z+;@�-��F����Mi��m10`��\H��DUR[PH��Jus��QP�5�T�q��u�t���keb�T-]B�����֭�i�Zچal�����SO�	+K&�BR�*Pa��+	h�"f-�l@����r0�咙��B�K�Pmb��[?Ӕ4�	֌�|9۪�KKy�7���7��V�����:(�TuU��J��R���ZTAD�A�~�뇭5��la�l��f�6�ak�Z���U@PR7�і1�d*���R}�#�V�kQe���2�:B ���c�R#7���6I�n�9��m���<2Y3����V�M��m@�ʰjoŋ�"[����ӳ�8���c �R*�b�(){s+l�GV	�%]mo>�F����f�	� $�jj1j(����wQ*	L�N +_.GQџ__��D�a38�;���U;Q[)�UZJ��2��Nd�UlKx�d����r3R(E�p������T�&�	�&����Y��
r��%KV��YH�4��>�W&S٦���m*�V���@����˿��7bތm[���F0����ئ��MBP��H���]�Ye.��QU��\���$�7��24h�-�`���aYv��$D�R%�R)�T.a���U#J���	��hb�͙�Y����	c��:�f���Ë�~ӓ����6�6�[m7�:���T�6�Q�7��
*T3S{0�4�)��S��&` #�H�N�T�)賍�!)`�iW��3���efJl�6���*�$ ���"�tui�R�����8�\2s�r�K��Q"ʵ�%�._B��]e�\��UU��jU&4An*�
lci��As�X����.��U+�J�R���6w�]UV��҅%��m#U9�ZedW�G�͵�4��B欸��T�A4P�ՙ��X��|�[���x��	�1`6[�c6ĩ9����T�ڥ�u��$�c��\�ܭ����'���LOw�WmKbd+1b,�in1S���b)�P����T�=�Ѵ�mrSU�u��$KAsE�V��[����LSW���eS0O���Ox��Lb��6k7�[�SKn^��g���l��`S�B6�6eA�@&��f�`�, "Z�
eW��F�M���M��h�#0=��X�T��PU��FE �TSn���\��W�eк�U9� Js�#��\>�*Q}�r��U�k�\%�4lQ�Y1�P( 4�f��nzkn���6}(�-i��F����\�	��9��"iU�R��gۖV�ڷjf0�d��SF`Ak[�� K�i-���L�����9D��2o�Ij UU�J�r�U�Z����r�tTU}��r�����n�u솱�,����lͽ5K������@\�PsEU���h5�_Mo��J9�,�\U�� o�c_>�
��&�-6��bh˹�Q6H�'�0ٲvj7Nm����l.��T8�i� ��6T�0Ak�@2��,�\I,I	ںT�*�X�0�jk3�b[��dd
�b��\傄��jVb�X�����G�@�`C��>�X�N��w��Τvץ
�=����5�x�?�J���J�c� m��0

�F�z�5�v#moZ˹�sQ���
Ӕ��"�(��V�J���N��Rl���-�&V�Mi45�j��İ�i�̽�&��I�f�*���,&`��-������{^������0�wG�����vWGuU].�v*�P!9U�64��i��Mh�4"X��Ś��ʖxggy��.��D�RX��چ6cT���M e&c�ڤi����ֶ.$T�%w�ت-@��.����v;���m��c:yP ��Y(R��Zl]F)QE�N�14�HEuRL��d�j�&1sA��*�ZP�401�k��.�"AEP��
�F\��R]�gj�%�#JO��v\%�}� %�Be4� #� &(��v�){�矿���N�c�
�*�
Lפ��&!S�⎫[�U���ifȶ��V@��b�b�̒11i���@q� ��#ٴfi��%DBo	K�l�ĮX����Ġ"�ժd�r�;r����JU����T4��U���l����aQ3�v�]l�`Ms1v�w[����T��K̔HLө`���I8%+�i�!Mo�@ ��J�ZrrG�Y�n$��R�����K+7o ��bp,�� ��`+�LbTLX��4���Ŋ��hu�qf�%F����P�(IB%I�0��*r���QJ��Z��j]}uMj%�]}T���bkN�˗�̚�nۊ'�f%\JĲ�4[��|����6���1����X�ko]�0�b!�MCi�����]�:R��v�L�Q��͛��bV�V��be�֒gưw��W����/��M�bh-�,&$c�|�T��ZB`��!��4X�t�N��.�.�ʪjS��6�J��B������	�0��h��A�	#�������&	u��f*�(���r>�(�y�[�m�Q�
�% �Mr<n��ձ�f�[���7�������ր�v�ɖ�f�]�Ėf1ֺȄ�u�f�X")D	@�(J�U*Q�$�c��
I�U@�\�׷�ڢ\aL`�f^��QU"AlW����/o#6*B���kW��h.%�<M�03���`kn����/_]0��'�j�d��u!�FTl9��je�uۇ[>xz��<M��9�5m��Fm�0QFXƤ�ԭ�tuI�`�6{� �V5M�������Lokm{�O�_��@��(���Ч�+Km�aɠ
BH@N�:R�:��q�6IJ�S��r1����PJ	R���m��X�Ѩ�;�2҈,˻�ޘBUI�Q��J�.�jE�j�fŜ��l1�jی1��/Y"ۈ�����l~�'��?������bdl�a�>~٫���;���&�i�l�D���Ȏ$�EJ(��*.G��$T�� UbF4��*ʡJi�'$D�v�:� %�
�j}��0�)*��*���<�m� ǥ�����O��-ʗ�,�&��#b+�_�����!�Jen0�@�Қ%2{Ynn����7��7�o��޺������\�p~��4&�)m%b�:W�X0UJ0��l[�9�fe�-��fO��7&DB�a����1���M�����o��i��Xb�
`J���˥��T]}ǩ�,���*%: UM�u�G_�/U�M���r/��ܠqd,�о���f'�yg�*WR��k�"G
	�TE(�m*Rj�6�<���v���Y�1*��Ҳ�(aC��U���*W=������% &�{���&������2�4�& �Q�˗RE��S�IUb�"Ppd1�y}>�gQ�LQ�*�jS3����˩�����ATK�r9$�(`a0�DA�Cp-�/�?�����8A�|��"��QH�I����{/OԪ!R�4�L,��j��M���Է/��������i"|>�H����^����	S xc��@
W%�ւX�B�� h�bal6d�mx�a6S
L5F��Z1 M��w����<?���@$)�P����s�|��ՑE@EP��RJ�
�	��^ngdU���dy鉃l1�M�H6�"Ӭ����Z�Y1Uթ���)�j�夡��r�����qS#T	����Ii�XC��`F���@�A�j�w��Ms/=��
Mm%M�!�2�|lK�2���J��"�1B����t�� U�@��@��BH��|��22q����&]�Y��7�RҁP�H.�h���Ml�jw}�;)�V�����blu�;WG�6�451$�}y$�&%�l�&�ڪf��k�
�������?��V��H }z�?�O.�
BIRd+�@i�c+ŘXՆ-Fl�l6����h��6�f�3�a��F5�1 0Ms cƦ��l��)H���!_];.$	P�r}�H��|uE�D��Ja0@���R)��L�X� S�-���3�ņ,�}�JV�K)WW׮@�X�����"b�P����B��"<�J��0�6:6���ܱ\�̀��������}��`���&P���mTDyc��)�M	�j'�H	PE�
c@�@DG���D"D2�2M�c�^��4:���,�Z1�&�BI�+�B#`�^f�(�t���Q+ml�h��b���,0w++$�* QQ!Y�T��Ɛ��`� )�����������A6��ʪ�*UY �����*H�MB̆e�Ĉ�b#&�²���c3�l#K��o���&cl~��������q��`�`�Hm"V�������#�;��QUT_�;�U����tz���$ԪRD�i��
jݜ�A�f�v�I#K5��B�V^^�RK׾|��J��BiQAj����
KeA�E�P��� 5���*�$ʦ0`P��g�tO�Q�*��f��M5�ЩM��Xa��-6b0��J�!E`9 b'ȑ�21P`BTu�k����Zǫ��iz��1ʖV����%V��O�ڟ�Ul5�*�ZuDe0�l�k���NiN01�em3�Tؖ؉�����2S!(���"���%�&��L��Aǵ��[�Ы�ʊ1�PS�����(AWRL3�у޺b 1k��!a� ���Ξ7?����������w,��~���>&i�x�@ ��(���K��,߁(_��OUV�ZU��ZuԪ/w._��ӿ~y� 4P��UGh�����|��yG&�v����ib��Z#�j��8�����XU(�T3���J�L��Pgx+&UڪQAZ��Qխ���� o� 풴�)ì1-gO�� Dٜ��,���I�ld� �7��jA�fF��B sv"	SY)խ���QJ�ǯ��:@��K�.P1��I�m�悔Q'�	t��O����40.U�K��Ud�����tZ? P�&�B���TҤ�0K3�d�j����V���b��)�M����R�����w����]����� f���Y׬�X}�6�ے4=?0���[[;�����}���Ɔ����Ǜ7�|N�,1���:95���z�>Պ��l�.��>?ڗ��D �3%jY "ey�eBIDQL������������ͯ~�㏿�M(j	]�H~����7��ki��6��61&�V�"�� lE�Hr���4ǨLS�̈���0�4���I%J�ZAu�5F���`�Um߬(0
Z��Լ��\��O�h'[Ll{�!���MGA�P	��Ȁ5�BF�Y+�۷��<���Z�qv�,�a��1X$( �@0Z���k-s@#!)j��&D�9U��BÄDAKY$�-0�#[E_����l+Cf�F�V̴)�f٪�P���j�-Ʈ����������.[0iBT�7�g1�[�tSڐbik����л`�6c���x�7c���l�A��:6��j�:�s���<S�k��n� }�/?4�&Д�9FX�QJA�6c3�r�E�e�<P�V�U|����FR-�V�\�)�R���o���|���Ц`̦����_�ћ�b�L�a��i@&�%cU�E#�9���F�`� �@�R�+�I�\N̶̺` ԬI@�r)рM��I���6�u�2�6�u�f1�9�Dh�Be��I�! ��a2��a��V��'���������2dX��a��������������͂�`�0��2��)(aa�1�� .��Bf�5uK���&[ZliH�l�-HLVƈ	�V�T�I�1����?�]�sa�� eT����g	l�gB⥍[,�$F�b�M��oz��������j#�	lBB���:��t���׵�y�ԣZ�`��<}<��Hy��lʲ,EpU[md��ڶ�����ҹ�Ql"���2����@��0���coN�]i�h0eK3��7g0S��4lbbk3&�T,�dm�b��KS M����L%9ʝN�*h�ru�8��9(Ya�0L���|���$���l���c�I�f���� F+C�����
�,*�4і��gD���)�)w�?���y[� kc����e[@I+��6˴���?���;^�~��լ �L�� Q]�l40��!r��*L1�ʵ��T0b��G_�&�Bf[� ��Zx��riE�4�tg��nl�a!S���@�4H,e��6
6T #�����{<���-��s��	��x��1�)Oo�p�L��h��=��<��<�ѥ�M^x����O�,%�L�"�,2�t�XD��~����`�m�vvX��s�A��TdB�jvLd�^��F�道aXIƌ�z����DHj�֍m[�74PX�ق��f��!�R� �E��RTߩ�f��v�D�A �Dz�"�����Қ�Rݰ7�o@�0�0	�iO[��zu�����t��1m�^^�׽��,�����]��rUc՚l�@4I%\� �`cm��bS�}q���{��w�������G�믿���Z*�_ݓ���mS�r9J��Ԙ��;O��'h�ͥ*SShщ�J�`4��ư�\e�0�ʨ�*[$vum�l��|T�������|�gBF��Ѭ� ����LiB����9�iX�L�!��f�yl0�6kӨƳ�����s��4e��G�>p�:��$���c�͸�q�#ᐈ�������?�)�
�z�ۯ-��/V���Z�YRօ �B�h���ξu�3��l���Y @�Y�:�
�V��� �d�Ԃ���%���,l,,���Zȥb�5��=�]��N ���6ߥ�j`�`�J�"�*�+���a���#f��,͸�01�"K������W���l�E��X�o0�/˰��tA2eR�m�SD!2�s�N�֝���>����?�����ϛ��o���������?�����[����ݵZMck�K�/�w��<yܘ�(�R����fk�~��?�ݧ�c�eS�� �ZTq�hԢ�M�l�,��ic����U��UPQb�hbc�ؖ$�"��ʲ�f�n�U?�6�4U����Fm��l\�z3���1�]�1�0�Icc����!�ᴇ�C��dk�AKy4���J e����0�B��l�*�ƨ�w�w���@�&��X7 ��4Q�g���a�k�"F؄���_�a/'B��#@�*@,��L�ؤ�Vb`zkkFc�*��OL03$�*m�9V�l66S��O���%Иx��HP!p��Eln�m����o��9Xh@f[�Ke��	cL0��������lzy�LTR�0+L�mQFD��)N�Bat���w& az����|��g�����������5��|���<���$	JXe�=�>�ŀl�R���Z�f��*J�fۦ2^�Ki�0#J�b�l���0[zFa+����$M��\���lum��`X��xCo6n�w��1`0���5��c�j㍵����{�NƗ����s/�������ӱ�1^�1���_��O��M�\�2�3��BE
 �b����z�|�%`�`�HP��&� ����.k�ʖ�{�7ǛhX���b�MQH����`��k_�,
����Td��lh�)�(!�f���4����"F�iz�M���WN� ��\k�˫R�r
�7����%��Vai�I2`�Qk����f@خ���4�'E`�M����%]pQ�.�쐁K� Y@4����|��?��3����7&�`���&�Ji�J��%b4Lc` ��H˵������~��K�m3&F�̪�����W�����/����&��U%P��
l5[��ԕ�Z��Z�`t#��Lh-�^T��L9/c4&6�e6�6cc6�w���waCom�i�e,���ׯ﹗×��������iY^6��]?���5�Z�F�(T��Kb8� J�W������ꏔ�U1)L���Ȱ�*�I#Ʋnm��d-�1!�i�
 �3M��0�������?>X �	@k�����f�f`e@�i�	a�ޖf 6 ���4Jn�2��*��]��.�d"$�f�%�� �����Ll�j��x���f��M���W0�1�2��QtPpq�8n�����j &Z�m�h�����c�<��N�7���1���a���~����V! �-��lƛ16�$�$���E@�f��6ͬ�-i��h�&addz����q[����9�f�'�\�	�ꆁBkiR&6e]�x	�8�!&��R�`��f3�ؖ�=޼K�mk�c��ZƲ�գ���#�վ2��]L�~�O�����,H

pPԚ��(�Y3���"j��,afDf%��d���b��X�%XSb�4�dĖ@�L�M�v@�V[���9�]�"-�f��m�m��
Vl�،m{�Lo� �[p�� bSKAB�WX������_�O����{�nJ/.��=����H+�֦b���`C3��f�)���|ɋ߁e��0m�^�nbȈґ+SY�D�
_.�U)�퉪AY�X�quc_�߼s���Q?��B���}�5����D*��ɆX�{2cC�C�l�N���dK�-=65$�,I��1X�˹)4IS&�ԭ��*U�*���E��ZZ�%i��jY0X�jش�(a.(�&�����b�AӢNh�w���=���c���G���s���E�	�O��wM4	#��A�(Y�Em���������Ȳf��۩	L��A=F��U��򦢴՚�������b� ��-����mT�a���N*2V2��xY�6��d��q	ڲ��oM��5d�樅�ЈZ�)����?����?�u���3�&�Z�I��r�Pd[������Wn?���IV+�LXM�D)�ʲi��h� Wǧ��q4�R�()R�ā�ud� @Ck���f�uo4c>���Z ��AI(1@2yq����L�-�������`����>~����\;`ll���kS[��f
(��;?���o�$������K�Qͺ:[�Zg�B�cI���eX�0G�Z�@�%"$K�-��f�Fh������s�u_�\�d�;ww��L��:���zy����-]b�yy,o-�Ej[Q{�xm��RX��C�,l�\K	l`�޼�6WcF�,ok�\�]��ƚm��ضI�2��cBX��ll��V�B�aL�f��b���%⢡v����ז�4�e�ak�CBL���mi8T����o~�͟��3Ŋ���9fR�Āu,!�W�+iFe@&�:�����d�"A������K)*��T�4mQF��!���i�%��֡5�D b9�jS�Ň�1��j��l����כ���uR���7,hc�bJ9X1�b��<!������������J�*�RE+��e��Xd,�C �&�A�p�w�������r�M�N@�/������c�X��r�Q��\.�,rþ�G�B�����s�K�eY�jc��>����'F(V�+QQl�˝�� �)���͢��F3��Mx�M��j�o�6�Fd.�U�d sÈ,<�)X
������eH�g#¦���;׮��a�u��46�)# � !�����P����̦1��öHG~�)s�A�UKS����9*FV�Rjc6�Ȳ���QJ��U0P`m�QԈj\f�	�6�f����%������ӏ��'C��h��#1 �)��L��,���7�٘B�,�:j�%͊m�P.U��bK�ǆ�b&1�FcH��X��زь��Һ�#�k�-+��X0K�i0"L��("G��=�#������U�U;��<�]��� �������]aVܔ��#��g�"J�,�yKH<���ZZ���N�[5�0B0��=��N4{
Ok�=�;`C�7�V��m��4[�LL0c�dٚb��[�ٌ4l��β$�
PlgX^a�X�KM����ڗ;�RBbf���6M��0�M����3U�Κa�3,���� �M Ғ�H��P�������l�m��LX�,�ʜ0 �m�0�e��QFVf	�aV�hl�,�q#7�q��$@4���BXհ.���\mѴ��A���iC�b갸B�!����\Ę��m���Q�U!�e{~3��xC	U7ZZ�W2���4��	L���#��c c̬DDTC�L��9z���y�/�m�����յzw������ؗ��̇�&�S�!ˋj��LQ�(������T_�I��x��l5d�1�O�DӴٌA�m٦I6a�[�V�M��0�&� &&j���ʀmR+lm,�j�:J��]��/n_�궰�g�ucfC�@Ejs'��)�M�.�����ccf�6��6�-6�Mb��1�6�t۬˪��x��&���
" �<37�0%����d�F%H:R�PIQr3��m3�!Lsܠ��Db�J!N�DUi2Qe���Z�]��a`b�Q��f�` � [��-`b�Q\�.ٌ���]f��B6&V)�M���B6r�1��h����07AcF(��n��Xv�8���?�����Aj�D4 }ɛ�닎�R�%KE^^��&EY���ZS�)�B]��Nm����Mx�2`e�Ҷ�l��lc�a�E�
���wY��`K`A0�����M6K���U��J�!����.�m<��0�!s��FAuo)�����n@�e�mc����g���w��	�M`�R�	 �՗��uy�d�� d[�v��P\B��Ȯ���y�YT�h�_)���"�X�,6i�� n�rl�$&n��.wW�T	*�
jI*�t)�&��coʔY�a�P� F~��_���MF�����ilҦl��<m|p��1@o�X $��0�0���K�� "�Q"P@cC�����JM�Q���U�}�����?��g�ǯ�[��ҝ4 ����z��QsD�@�e�@ĥ!*d*ԢdH�����u�- �{���/sm2m[[k�l5lflU�6il��6�P��@�f$�h8��-�I	1@��`�T(� ��f�T�О�e� ��([Ϫ�=.wUU9��f�l��a|��o� �,c4Q�D�	��FƘ�"[�0�H!����Z-B4Eelb�˃��2J|����$#�.V6�@��q4[��vj3R��ru�#�\.��(BZP��X��|i�m�	Ea�XLM���]�h,$o6f?����� cx��74�� �_]���c��b1� ��%"��=��b6��y�ӝ�����=�~���n?�{N��ó��w}��|�_���{~�g�E�������������o����oܻ{���wk.MW�նS�ZيGH��h ƥ��U�����B%;3"�c���1���[�?�C�͚��T1�Z�e��ƌ7j[zCۀ� �6�6UY�Z��@�ڂ4���,��,01�J�j5��R��2b\s�R��:����ʹ|I6��Ƙ�5�b	8,��QY+��, "2fV0غ���&����$tu��D�\�U��D&Sma��;U��-#�uL+� Z�"�� ���à�&��S�t�|���tJh.���R"� &U�t�5�-���*�ڄ���r�%��$Lh`���C5'DH��1�,V1���x��}��1�%@`�-b�������7&����J��_��������n֤N�^��/���}}ʟq��Ͼ�C���_������~?��?Lڱ ����Ti�V�xA�D!R��5�J�D�I@�R�-ol�e�T� �raC-lb�5{kL(�b�%�l�(M��&[jDV�R���Y�e0�645if���D(�l�5�ԗ�����֩D��E�	Q.W%w:�]Ꞿ��b�ǿ����Wl�V,�8��X�S9]@���Qf+c��j[��M[�J�*���(��Sj��d&Q�VT�I�����V�l�dO�Y���a��i��J���u����7~��M]��""�T	)�RN��0����kQ1j[b��
#�A;iXPef`l"I9������XB��Wׇ}�x-�*Vg�Mm�6u
HH�
�Xl66�%��Y��=������?���7~��?�����Ջ���7Ϭ��TFkd���n�I�t �J�E���DkWJ[�J���Fm{.[eOS��-��0���X��=2$Ѷi�V� ��l�h��ʆ�����i�F��&G$)�:	�T�,�&+5L�a��������bj�o^�~��aK&�n�B$.��A�K�
�t}��|%w�Y���������۶��]L�.6uw[�����A���_��H��L�����QӄI�����Ǘ˥*����JXB�\ QZ@�me`�M$���J(-C)ʵ���KE���~�zR��$�BD��H�v��4�陹ҐjV�Y��I�4׌j�4T �?����ANZ�*�(E$М��##@��4;�Z+�C#0r6�Қ��A�Mll�>������VJe�0����w����������&1hV��h[��jJ@q'QB���e�hMiS0�A�7-����c[��b˶%��O�6ʜh6a�VNZQE�  h����c��kZɢϏk%SW��F���VP��0-��f�D��dZB��[��8.��\R��)��\GW�~��}�g��J�6@4�J���d��J+-�e,e�~�7����j[B�c�H�U�J:Ng搵eQP�Yۑj�B7����((��ҳ�:  ��mY��˗#J-eT�b1	(�$r*�s�%�[6zV����2 i&ͶbAsmC�Q�ĤM`_�/�O�
R"\ �Y,��oZ��:�2�URT�RF�h����(l��f���������a�L0��b�0$�L���t7�N�D�ࢆuY�
��b��v�Qs����O��Z�ٴ�l���6���6�)�j�\RD�T�����,��)�R�7A�(�b__�f�*Exc6omD�A�����
&TP��H�D�U�q]u��?����?�O������۶���Y��Ҕ[ld�q���B%�B&�2X�*0 ��	�1�)�HQi(#RYs[B���J�Z�J�F�4��X2�Hr�FН�[�Z!��Z%�
�� ��r���G���U�4XK*�&f6biFQ(͒j.���6��T��!kIhm�Pmb�3�0��) ��H��ڨBK#6 ��(e �&�/i����_�`�4�(JD�15+"J9".!�P���"(�L�*z�l�}��'����{���g�&�Mψf��
��*bPT%�6�7&�d�"CV�#l�)M��m{�ւX1~��?n`�Y0��	hB�� �.r*�F*����+��7|7�o���cCf���!�Q6Ki�sA�D���RB3Bf�V�Q6��e�0�(��t_�K:ԤmR�T�l5�T�Z�QѤ��61�$ �Ґ+���+�<|�J�P�
I�TQ�$
��s�qZ�s��`d$�"��f����$P��l11�bB��m�6��� �y,/1�ؔӵF0VW*�L�U�%I��A�H�0J��D��x��
�1 F,v��U��2��!w��H��!���3�l@�Fj#TA��g��'G 1��1��HQEBa.�4ԛoa6��
+(�n�MI`�7@VXm[�MB� {�Y�=���! ���*�0ԪStH����-��7�|�ߋ��M��w�Tg����DKP�f�%���_�;�W��B�f�
6Lc2TT[d�J���s��rѐ�$m�J��QVpU�Rfi$�$2�X�`,���^~H7G#��0#VDU�\�K�
�����Ս0b�YHbͤa�ذ1�{���|E�6�؄lH��x���---�"�Z��ht��_���o���"��1����D�X+I6Ŵ��6��fD3�$��XK�@����$�YD@���.!Ǳ9T�F�ت
<0�ɶژV�&Z��!%`T� HȦ"0S*�i�flc�01L `e`���3æE������0�8"m�Y�x��m!��,�"JU`$Q������ll�b�:.���8]3%P#�d��A������x}~T3붰V5�b/�?/�?L�Б]ʥ�q��PQ������*Q��u��I3��֚E6�5���Mk�( �!����R�*W�k��R]�Ur���fa HlA�V�� 4+���������ś7���6��
�B0��~��j��iJP�DO96(ص��P!H�E�TQ�$�䠇���X�jX���ړZ�F���Z1ɀP�T��;��7g	!�D5�J��تm�v�T��*��Do�����Z�Aޤ�B�2$Q"��! U�1Mfm�6�m@��l�1���s_��W׬�)%j�4�J4fJ �Y�U[�J@�!`�cZ+`�6M���8e�p���C@Ɓ�VZ� PC���QfYJzu�W��fB�*IǂV�,���~�뿶�&RY�T߭4ac�J`�UۨJ6}�F	�R�,Uw].W�U�.�KT�R]+WY��e�6�65��2#�����*��}G�;>�ژ�[����I `PFZ�W����/�Sf�	�M�X�&m��(�.Qbc����mu$t elLk\���K &�%�0���&1�U(PE�D���z<��(He�JUP:�H83��l��FUU*�X�6	c�pHJ�JH�P��JC�(1����|l[�f�
�T�f�4�������!U+�RD����TE��P ��b�DF�9h�`FL�h�a�9�֩�&�1 J¦�v��6G �@2VT��Lc6�ay�P�� ��D����o��61ds�Qj[M� 1�$6(��� a9���6܊�
 T,QUKYU��;w��WG)������B�(#��XL�H.��;]2چ�
���l6�ي��0��@$	�v4K��z��4#0%^�A��:�r�bʦ`)�1=�QbK�K_ ��`
&�@,Y�`R�:H`%�x��,F	std��I����ƴ���PE�\�qUz�is���I�@��UZe�X�Y�$0l�,�{>ض6�HqdI3^a#�j���H3?����a*R���aF�K�	��L!ە���fo��;�klbu�Ms	K����IAmIE�E�@P�O�pf�iCIg�X��L��2j˨�L�x��5k��V�,HdaAn �@I������*%U�B�:��R���[��֊�1�aİ
�[E�(��hm�{�f3�Q�а�1�Uu\.W���V���=�F�ϔ�b$0bH��ʺ0`)4�M@ib�%�]6��� ����cd� ���Mi;A�X�%�J!Ş<O`"Q����P'��Ӷ���\U]]y�PG����66��$��*ɔI!�9ɤ��S&r`�l�1"Ŋ���i �`�i��l
�r*m�,d��%Y	b #��0%�e&�ڮ����`l��:�̶6��(4��l�э�bU:kF�ܧ$�S�F@ �i�#��;J� L�����JMmF����(8RĩVSԔgL;=�bh�����h������|C�IIT��H �H��t� $U%u���Z�`���M`�Ɇ�v��������=�l�1�1�"w���T.�>�	)��(�&�%�!aP D���G9Jͪh�iٜ)��Hہm#`$�1BL��/�FO��޿��D�th����G�H�%H��Y4��XIU�q�>�Pu���l�M��)!E]�Œ""�$e�L�!+��TP��l0XT�&$X�] �
���زmŘ0#�9��$DEbH:mmK�����1��\��a�@,��("E�W���"#E����F_�����������kE��tm�(B�j>�xX6EaK2`�D#�%�o��:2�Zb�R",��� ��Q�v�sb�U���i�b��Q��f�֮�[������|��l����qIqHt�K�!1S[D���F��_^����ȍ`S.����MUYra��P&�f�$7k�b��6X�1=yDX�7�NQ���M����o"�E�4
�H��~��}v��$G���թ��.'�LXޒz�Ic씫��3JHL��D�2��4�X�b+۴Qc��9 [b�BX��Eե �U)U��
x/o���c)�4��XK0�"�M��Z�[�X��O��]`۲�m0 �P��a0vrr(e j�e mM�"R��)G��02��,�n.�)�S+b>s�V��`TX�  A^|�ӧ[��(W��
D")��~{�!&dsl�e�r����r+��ڈM3PF`S�Ͳ�e{3�{>-3�a�)��@�R %
"��@���������!�)�@ �U�/o}z,` ��%��MG�V�Y2�Z�ِ�j[EtLײr�� ���-�b��޿��sʨ,�J��U��_-H�:"(Q�t���^�J�$�VU���kJ��*�x�xsȥ���S��L�
 5R4�HHA��"0�ȴK���3��)��J��d!�i������%)KO�#�8B��c�T|�����aײ��lc��lBI�p*wl0�q�P5��/{�۴�H��j&�:t���2X�R" �-[��!������&Ȕ�(6����s�������4Q�R�
B���'�شXz�Yu��������c3��&���цm�m6A�0P@)i)���(W��(�Q� KSb��}���m"�D���`�`)�%�26a�`BY��d����a/3d�Ħ$Ӛ	Hc$�1��>�=:�y�\�~����_�E��	úcE��9�"��D�C��T������Ϳ���5��xn�Ǜm��\�(�TPR�H@�oMI` �ԈM@)>?bb[VL��� �\�\.�R�u0�͞����!�&����j��D�b�ت�J2}��h��ϖl�ؔ16��V�;�QI3.NU�@����.ڔ"Ѭh�E��J��a�L M�M6�qA*��|�ˌق,��6�u�t�\���ʌj��&]�B�jHyˆw���Go�[�	 ��6��m��6��U �4 ���_|z�K"՜R��]J�D9� ��|�|���b.!clJ@c�O�0�6E��f�ɀ6�!�)� 	  4�T�2�����_�X!B)�7���N�������L���i60�� J9U��#�_�N��/�fl6o����̲RH)Հ
�.�P��RT%JAU�����׳�#KҊJ��RZa*S�.��I��qE��-���	" U�� TA���� B�P ,"�ˌD���մ������'���an���Ӈ��:S��&tV2����p�P�K)aV�FI#Fb�(:#�l��c(ȂC�+I֒lҐ S�em%2d�b#�
D�H�/bb(��`S�����{>��fo᷽y�f7�-��7�1��Oo9�J��xЬ8��E*�2��@�;�;�r	��20$L)�&ސ�5�l��ӻ;=���۰����e �oƘPP0��%���Lz�(��WA>x}��^�r1�I�1�0j�⛿�����{5�J�Z�R���G���������l�^�bR�^*���ҋ��B���xZY�#��DAB$�rJ `Q�t�܇����N��/��)Q)�P��%����
�����3�/ p�N��?��g�<����Տ�'.��D�
�R���.���V�c���H���. ),6Ơ��%ZR�bE)"�B��%êp`�:@EJG�R��R0d�܁��
�{9�]f�˼������f�Mk�٘�s����c�UQHxsQR��$ %�K��.�H�0b"�1�����d�`������b�mכ��އ=���A�b�16M�	6l&` �B[�����tU��� ��`���쏾���t%L����+�>���?�k��#O��l��w��(�dň�HB��ݦ�N*e���N�VnS0e���d�����$L1Rj�"*�.�)]Ww��S��������8�� �u
����*+HHaL#��K���2�0�ܴn>�;�����MZ��#����CG�bT�S�U�t9�B%^$c�@�a��K�e��钺E'$5Dd��9Y�e�� @P*(R�� A���C��e�7�c�e��l�،Ƕ=?�ނdT�htt�P�R��!r\�S}7)U�aP���J����jI�7����c�y={OgL��f���ᣫ���@6�V�1�XKC��Y���ػ��K)���������W���7�X�	���"�ن��w�ּk6�ؔ��!$����}v'!DF5)%��%���EAc2�E+)M����js%�*#��}�t��]]��rr����-������� �B��9	�����(a�R�@c�L�ca:u���C=�g�gX��;ܟ������+g	(�RKw$�����\�5��MsL�0e��YE�@0�ɐ��8݉$QXy*�(��Y����H\PF���^ϫ��KS
��ز��L3��O��G��ma�0�1e�1�
P�Dd����+�����;��;r�$�	 �I����yC%��xl�ilz���غF�؊g&��>�|  �g4ds6��|�;�S��8p@�#?���_�i6BXK��1�DIY�6�K��2��l�ٖ��*J�,K� ^�!�)Q����(QT���i"���x���4���j����������p�SE�\]z9|�Z�	��w.�7��/?J�� ���}rs	c�H����X𤁍����Zwj�C=���������������m/??��?O��r�J�JUť8���]��Ng�l2��I���� ��S� wE܉"J-S B�V�l5��,(��*�KA�*"��[��z��R����M�V��([3ތ��G11(ED6ѬԸ�ˢ�R�����Jg���R����1�@s$:�D�V����x���f����1�)#C�������)�`�Xc�����}���>���g�--��PY�7�[�l�V�om.��zW��5۰A��YVl�H�J%H���!EG�ta�����1��&�BRi����h���_��������uՔ�t�[�@ ��ޟ�߫�Z�6F1�aB�h��W"kIZ H0��4w�����s�w������zr���+
��8J��NG��.��T_���$�%``�p�c#��Ly�m1mvQ���pJ��dS��$���(�EP�0F�Y�."��.���W\�E��K5�hC##J�ʦبh4�W����kTBRD���QQ�(	���!RJ	bM�Q��� @���1��f3���	ab	iV*�b´i	�uaW2 F1�N����Ƈ�p������>������}}�(%��\y��G��l5�)�j6�^�x�	!�|%/��^^<=2�(�*I���F�TFAi�!P"bR5��*��r���������y_�P�U8�H�T����+XS-�`,��(eid�J���F^��4�6Xb���D6�ʹZM���o�҃��)Wu�Tt)J
.�R⢮�8r�;]w��87�M0�#F��� ���a��ft�n�R���k�)Bp�,"b����/wF�U\:r�З��P�J�B2�m��x,��#�K��+l�6JPP��E��m�� m��U���b*"� H��1d�R0�1S��5���! a?��,RJ�J�В����橞��Ыz\ݫ�^]��������}��{c_���7|�o���}�����;��z�;�N����N�(��`���!T3Sm�����	lk���r)�,��PeO'���Ҡ2�@�t6
 
V61ڴ��B��\���J͈��*��i�f|y����~�?%c�	��B�*U �!��
W!Flb`P+$u�!X�@  e��D)�������ߪ֝zj�յS���!��\�r�z��=չ�K)� X�X6�M40���Mc�;w�G�U"+'�O, �
FEޤE�	�%��"�tJ\���F��ܑ*m0m�k3�6�lʈ�1` <��)�{�� a�RJ��&m�i0hY61m0�A��*�&"��0�����m�vj ,i�-̒��ؒپ�0W������-V���|�|Oo��6o���K��������n��/�����w{�|>��_��{�ўG;z=�����fFQP	�l�ޖc�A5l0j�k��A���S��6ȐJ������=S�(C�TuQF� � j�2if�iɤ�t�E�eI� ���h��x��H����NI	I�@� %� 
���0p 33�i����VdZ��=��UQ].���)�Q�]w�{��]wJg��0��c4!"a"�lb�������N��3J,{������)����YVq�1�R�)��%}'J�)q��#�;rl���_~��g��� �|3� �i��m�lyluٔ��U��R[�A��h)Ķ2�ƈi+ � b 
����f'	`j��c+K��YeB	����IkA�&)[{���j��Y��������}����������G�������*�\�V��@͚9�X	�隱�--�\leEʥ���M����>�no�W_����"C*,a�$�*#	`��xL�q0� �H+��a�`l��1f��a�\j_������J��J���D��9�XĢ1J`�4@�f�^�h�e%ֺ�G��������?���>ܮ�@������Z��8�|��;�;�vŶjo� �b`���`�@Le����j������߅#
�Vk�e�Q`B���J�;����&:�2��Zo�����ڌ7~�齾�%�Y166e`��dլeL�M @yD�@���@0@o K�����@��xo�$fx]=��%�`� �K�Ej`���I���ƌ�xZ;��3!�ӯ����>����RJĐ c���Y �\�{�M�Z�i+�!��#%��AQ#DOg�^�� bH�*�$b�i�ր�ZU	5�lQ�@�G7��l�f�elf��ru�r��TJ�R�*)E�Q$�5���xSf�Y�*[31[&��nn��+���z\��3�!Ͻo��v�0B�(���.���S]�RD:]�F5o]{��kl�De@��	Lqg����,��ǧ~��?iWGAR�jG�`#�,�θ�t��wuaŔb[!S�[�7x3
z}?6�i�lh<�01&TY�JX
b�&� .#��U�Ȣ�h0����R6Ƙ�c�k�Ɔ�=� ���XeL��]J�%ia@�!��[�����^�,0�*�y�܎�)BNl����� �����)f"�4WYSI6 �(C�
U�����|�{tiKt���D*3JI�2�R������[�<f�mm��XC��k�{�^ϐ-$�ةja@��~�럞OR�E�:dC��0���a}�[Y-��r�r����{�m��c����<� ��R�DI��"rU�(S6���}̈fj0���(#+Ɩ�]G�CB	���8E�I���!VU
�]��d+d�����WgY�:�j��LA�)�&{K6e`lcL��)* 	#2:#�PFF5L�,l�1������1bĀ�M�ތ��Pgi�7 i,�0&�ʜ0Q����&�i�a���O�## �����%���@�Z۪(Q�b6! ��B���r��rU(�#N�D�
I���[J�N�Q�JԿ��}���
b���T%�*�I���do6����Ml.�����~/7��l�B
bx�%�@��g7'		��c��AH���[��T�����ؽ�{���w�����S_�{؃�KF�d�.R:��KG�#��b�f
&���U��1em��B�G:�c�L9&huY^bmDe�R
��*od�x=S��zR��mh��b l��U��a���`��@����dsYFI�a����ƴ�L,6���h��sb`�!���U�N�ƘZ����O;m
5E5�a?�yz,�_��_���.�10pA����H�p'/�Q	�l��2MS�r�������G �����F-�"J8�N�D		�U�DK[�	B9��G��%i�#E�26I��_�SϿ��B�Pj]qu��Vub4���N6+�+lZ����٫��d4f� c)՗s�(s�aP̆)M�$�$�<������As_��◙7۶ $�:�R:�)U����TDL��!3Gm `���2�L�q�1�TRR�NQJITY ül�&�� aP��d���T����mk��������6�r�B�d�ZLcl�T�R�J�@+
�ő�B����1��B�4A"l0�D	b[c�iۡ�00b�)�e�%Lc5f���V����/:����=�Pե
!	PI�unG)1K�7�
i�;��Џ~��W�0�~��O_9�����R�D��%���r���Җ��J�TC�p�J
Ҧ�K����V	�&LBUHUNC�:�$4��&L�I*UR@�����ao(�c�ʑ��w/?�o�����\"  �78L B+�ۣ�ް7�;� ��{��2jU�g鬔(T,�V���ؔ�b�M%�$Q� G� ��V-Cz�M�� Sހb��"FP:*�R��͆�������K�&Kl?|���S�A�Bd
QdIE��IA��JJ�J��j@Rێ7���D���1�r��J�����2EB`�!0�ن�2hHJ��q�r�"R�XS�)��N���V�a����Aa'����Q6��(���4eTW]�P��@ա"�T�RSvU$)U쇿��-P���B�
L[���BH�T#���ؚ%PQGy{��mu���(QT�����_�ٯ���>�Â��p.wJ�d �1��h��κG{���q��<�1�ԒE9RpD�k�Ȉ� ebA�Xi�0��Զb����������[�rQS��$\F`�0�<�Eҙ< ���c��Ơ�ab����Bz�=J*W��lȈ+�TuIA�)�"(J�N�`��B��l=6&�H��ؖ�g�0���F�b0 BXL+�'�������l0��S ������_��洨rHQ)�spU@x�� *�]�
E#�&�@ux�����Z��D'��P �(���Ġ ��MDET�J:h2fe���;ۈ��Ɗ��0�&#$�h	JI *EA 0������/^K*�D�,lEH��I�= ��;^^zDCGf�Q�;��ܩ��co�<`�	&��(���XM��V��{��u����2n�Tئ-`�x� deõT�P5���w�-o��)�w�ʮ���@���Ìe���{s��ؠ<���@�id@�bC����\��g_����"#(ʋ)H�\TU���©����\�l@mC�)��Hl`�����=�i����|t�|J��F�+���@l������7�!Q ��_�BE�e�rg������i���#l T. �B�$� ĔҔ(q�]�CJ\	�F8E-����e�G	i8pTQVA����\h��m��~� l�Q+��D�%F ������%�(T@��)�(0�J�EF�l�� �;��#K�&Ʈ��e�&&z�I6�,e�V���<�Dme~�˿3f�<@��&�y�������"R+W$�t�θDG�J%	�u�F�`l0���T�6��΀����w�%QJGQz�(%E�2.��;KY\w��]�UQ�qgHU���{����\��Q.q)�`�)[��Ɗ�b�$3���D1XHj0�����,1SID��؄c����?�񷑊���SNu��*���Kve;IJ��r���i�غ$b �P��Q�"�ruu�Δ�"Q$�8��G(�U�K�ZE$s*R*,1	b¶7o�����t�!P�P��FhE����[L/��  "C@%�F-�T!�X@d�B ���9n"��R#�p2�m�؃�m�i%`5�*�B	AX�Ȩf�j�� c���mo��O��o}��:��;S@t�j�Z�"�"G��K(%�lum��M����_�8�H��c����"6[0X �����9FJH�Xz>ת��"X�((�"ŉ��\�N%�J�T�:r��V�r)���H���-,c�, �:# � �Щ��ؔ	I���ŏ�#$��Y�>�}*��R"ʐ�9I�FJ���Y�*��t�T9����$Pw�T�A�l�L]����ҵDU(� �c
�.�r:��j����B� E�d��
�z������qc��	�  xc�VU��%P�#�������|�Fak$�]i{h��1�JD �+A)0"o�"˰U!�Aly`3 lʾ����H��(g�IS��S׈��XXd�K�x�,���]T	�4Y�XMlbl�`�c�XJ���ȥ�I.�1�%�(#DP����8�]��/EI��R��:
��
�\���*u����a�LL�� �XL��Ċ��aM�j���Ͳ�%d!�`��}���w����T�!�TQ�Z�ib0a���!@lIT�t9䐸�Y��ٔ��e��jd�Ĕ��)E!iD��"�P*M���I	C����Ic��ӄ%C҂]�H)HV�] �TJ�P1*
d1M��������7R��h՞5Č[��GL�-m
# #�js��T*A��jU�f�mj�(Ԇ&6�XFD��7"GP
ʪ�
]B:K��<ޔ�i1Jx�P
]$ݒ�K?�����k���epDě0B���C�K�� �js
�H)WR+��[)ݭ��Q]��'_�R`�ׯ{>7c�S��
�����	�b�,���@)��xV�#�Y5X������;����U�A���Z1$EI)JU��Y�11����D1���\}9�R�T�������KG����������Bm�R��F"�B��ZET�A� �h�=)��EIK���aV��\��]TX�H	i�b������������>�����M)%"RSnn>��mFs��bOLF@�2�DT�Zeʸ�ԅ�("�("jV�B�]���`j��s�)&6a����|�"J�4Eg"IE�#��+y#B@�Ut6���:��o5��7�c �C$v�%�R�Q����8�@�B�Ȃ��E:��RA���(�T�r��Ш��UD��la�`�i[+71(EE����c��
0�������SH �r�\�9��pT�+ۥ%�(H��������#J�*�Oe�K$ # �P�T�X2
>� �I)%D��KG�T�5:���"2�TNwT)KR!��	�4b�L�5����U��F����rW�B�T�@��@T�������Hu4��T�i��tiB0����)��4G�l���lC�[�(UU�J��8�,(�Yp�E�	�jk��2 �˦ �AH�����ǧUaQEvZ�\�;R^�R�̱$��A	� �u
����GA]$I�K4c�FFG`�	����"2d���ܩJ)�2��4��hWP�|��T�� �ilh`STRؔr�vA)�*Js�O���b�v�f�Ξ�
�v�r����߿x븺v��L�q��vb��L�����E�_�r��JsT	��"1eT%	U�H����l*��$P�E�*VJJ���ZE�@Y%��Ұ�&L,Ni3)����I�2$d��T �b�R�D�l6�_3�H�*�*����O�ַ�c	s�h��rآi3MF�l�������3�?J��T�E_IgYPp���jYm�����5"���Q�:VwJ���~��G�8���h;"�T�-M�����D�%��Ps1�! ((��R.i`�f(`�&E�D����TD�Tn� ƶf(#!�ʾs��.QUQN���2�&5ծ�L�R�.	�U��)�L��IK��bix:ӬP���|���t��P��r�+���kO���QF%��D�*'�RX�%0p �H��V�T���D��
��)�B�mա�I5W&quv��T&H@TL�0v�R�d��U)�RV�E�+F��� E	��L4�2��NQ�����{>��ǭk�aM�l��2�=�1���\������*�E�+)�t�J1E|���󣲪�	y+��2�F �(�c���#wq,�$��gQ�J��e�²(�7o�(#���(0�8"#J����H�(�Q� $*�$�@˂����������XL��V��H��H6vuG�*�\Un�JAЄ�$% F�E���	������ VE��@�;�/��ZBvU����Ӿ����#��i���,P�L"���JS6!��rCB	�(��jS�"�(��B)�t��rcL(QN����Xe�R}i���T���$P�$ ����K�2�0Zz�r����]媰�9��v�d��	 m�mWπ������r��Nq��%8ʐ����|��(Ef�&�����ڐ@�Ο�͇7�8�u�D�EJAJ��՚�dw����T��e#�偭�8�.9��,�Q�B0 I��� &���B�bʪZ�ʀ���	�<amC��jZ��M,� ��t�թ���6f�R�QaX�ʖ0d3��a."T�0�fo�%-�$ ����@Q��Q0 u
�1�Fb� (�JJRP� ���\159�(.T�˩DP$�B�j0$�����"UUw�t!�4���r���:�J���� �V�Q��X�R�R.)�1`i"L���J���,`�gG���z�U/=nՌ��" �]E:�K*�tU���N��r� j[[�-d��)�X ���~Зxs�_�M��օ�R-�ME��PK�TxTG�.!�b
T��W�eKЅPWV)MY.%0� �5�0ƌ!�Xe@A(@R5���hL!,T���Y����}�Qw��Q�� &��d'D5��N`<���B	"���Ɔ�`�X�����]R� 0QS�����1-�1*-U��U7��9���۟O��ĂR�!E8��6(�RG�����&�+�!���c�ժI"�R(*B�
��RR��R�H|�p׷�z�!8�j}H20&#�%�IU`a�JW�m�9z��^z�
&7�=}����������
͵�RD��Z�,���"r��jQ��Po�d#�Tl��P�k�X �'|��������?�������B���`%3��RC��+Y( �QwR�PF �;��2ՠ3�9�%L��1�,��bb�)���B���R
Ҩf�2XTH�X������R�J�tJ�"s���� ��`X��恁�a� A��h6!�aH��ruI�
(
��X�#L�0% �1���Plb٤�J��\�<�'���S���P�VĊ�$�j;��)ݍRv�4(��4V���[�
�JaU�b�J��P.i
22 _���k��	`z ��T�D�O&$�7�	P�8�'�d�[��'����� �ҥDJ��T]RJ��Y�HeETd�i���F��!-�u`�z<����#��;}r���~�7������G�+_��o=���=���+VI��J[ZX�IԆ*��He ��w�[��Ĕ c��x�^ �FQ�F� y*�7�"奤2Q��V�F���(B*�HQ����Aq9]�S�(c�@aUb�U�Ԙf�f�Vak�}���;�l�Y<6i����$�r�@I,	4RbQ� ��\:�8=0l*x�S.�&$"� H5(GJJҵFLpI�GWhSF��\h��X�&���"Q�x���%���e�A�(��"J`D���BUJ�ZR
�
�4�_{���t�-���'�W��V��ٳ�ֵhΦ戨@Y*ҵ�y��T��d��{�����?8��%�0��.�����6m6�	������?�c���/������ǵn����z�t��:Bi+Q+�݄ʢ$K��Q��ˎ�t:֗-, *W��	T!ͳ�lOo���*&�����>*��@0VE*CĔ	� �ƀ�J)U�㒮ե��[I�\�Ī�cC�v_}��cLx`��Q��V��\���ʨv�` bb0�cb��E�H�Kـ��m(�@�1Q���@R��Td���m�J�Q�8V�� �y<���.����}u�Z��w���+)�	H�>y���X%A�
�����(�1N-�,H����@���'�M�@�)��ël�����:�n���E�~��/��E�#BJ)AR�������^�>d��a��ۯ�f��MS�'�>�?��O��Wzs�?�S����FD�
����ڔd�,	2S�:�*bS�xq�j6V�HQp�,怊Q�Ȍ�ʹ�BA����=�?��aB�t6�&L���(!��$�	��Q��DU\ꪣ:�R)d�׮�&�*A���f�xf�Y�Ѵ�P��Ncc�� ���R].R��P���)��ň	l F�TN����J���61
0(��TB��F��j!���+�Kʦ�XW:N��6W�
�j��*,��}߿���c������=���R�����u�׻盤�)�X���ܺ4� @lUeAw(jl�0P6�N�l��W{� h��~����O��̀4q�P��J�����P�<*��O/�꼚� #Ǝ�1l��i۴���/�jo��]-�Q�e	dUD�@�"�ġ�@���N�2�Zj͆)�\f�U3jdJg��i6�mO�Vg��@]dٔw.����ڟ���	o6��H1�"��$�&LC Z��(tU:�T�������ۿ��6�����S�*3�Z��-� F��ɣR����8�T�%�,�������]0J��bb��cB
"TT)� A��MaL6�X���� U���{z����u�H�H��;�:�(��2�v�{˶��E6Y���sR6�ƶ�o~��M�=��f��JX�����\��ۄ1�-&%$O�T���T��U��KRۛG�@�*7`A�$Q�n�X��ղ,eHb�< .�HHQ�(�)�#�HG��/}闿~��Y�\�4`d����	l(
Fm��hd���H(��J�
���y���ү��	�.QDf�(��R._b��_����?���m0=�x�ٌM�!�*�$�1�P
��Su�����w/?�����n�� �E;e���Xx+�ߒ��71�ƴIK[�CUJ�
ե\��.)�ݗ_���S@�(�c�F3S��3J�N�.]]Qբj�jT_d�ʄ �"��)�"�z<��6�t�.�鈊�)7�@�kS�6�>Xm��a1U��RflS�n�- ��&�%�,��F�UWu�^��DLC��1�5"H��E�Tu��+F��.aU)j���mU#�Z�LP��j�%�!�����/��EQ�D���D*�Jg�bKD�I"nO���"��6�@�Z �����~��y�KĲ9�k��li���������?��4Z*K%�1�Ǜe���D�t	������@�K������/���ƀ�c �L�Y�]M)��-b�P��R*���?�ۛ[��H �İ���3��͘�,�c,4۔��A�4�L�SvU�NTٕ	��Ju���}�C�S &X�r�;������B_�*�Vl�,Q` �q����f��T*K�sK���P�PKY5�B��=X�u�{ +��@(���IC�3�������eq�o^9"}) $�H���R-JZ"��*X�J�"]Y#\B������,j!M��BY�J�g�Qb��� ��!�):�R
Q1N����7;����&�b�ͥʢX����W���৏����ƼA���0�0ٞˀ��ώ���5՚���l���}G�E�#A(#!�KQ�����-'�����K��J�T6iA2ie�����Z�c\�B��%k<��[�U�%`�[GR��Q.�SIl ����xl�f33�i�Y�P���Q:����������0��}�/>4_a,E�I��B�f��N�T��T�"�SAY�,��8Lb+��<����'YX��?|��{�y#�K���go)4Ֆm].�2*(���e��u.MJ���O%��HZPr��v�@�L�eSB9���v�QD�Bo�Q��B�|�٧��6�� X�4p�B$�⚢����(��L��� �R�=��?VYŢʒc&��j����m���A��c�H�/�p5	�B��y�	��@h�Q�B8�"1����*USwJD)q)M�,��B�)B˖��\a���Z�f���fڐ��"i�1�f�V1�@�>Hm,��JӢ���?���D���?�g����`ðU��j�
��!%�;�N�;O;�o�����_|������2bb�ӷ}�:�(�{���;��t:��T�ui���������,Q��������]m���σ�U�D��� ��hZe���@R��M�T�V]��=\]	*��S���R��)�&�u�Q� (��U����+KQ�D��H ��Sw�% "�4�$��J��W���Bj��[ �2�2��L�f�p2��\�lIl6ն/�d3o �'RL9����Ɣ��$�$�.�Y�u��f,@\f��\6���E�DHT�UP¹��RH*Hi`+���TeTH�ø޵�k��l��FF��f�1�M�(�(Q&��l�O�U�\���P�K0�@xl�cLJ�*AEP��t���S��w�z���;JE�b.~���G��PZ�&BZ�o��)NYDUU�����C�)��� ��`pa�	��$�r<Jl�\�J�������_N��h-*	�B��[/��Rw�1$����i��1��10����L�%�K�VTRA!Ge�w��لR�7���������,�@*Y!I��T�p�gwb+���R�%jq1��F =�t�!�N9Z5b �Pfd�l�lބ��H����F6ْ&�*�],m4+��Oo6¦(��e�7�1dA���R���W��U&��$a�ټ�7��ͮ7��9� �1��`r���_�wmf���06�9�V�v뭭�1j2��
��+U���x<�H�!LZ"�c#[A� $e�J��U�{�Wݫ�Wݫ���K�d���*W���:���Q�D0�]�D�Jʨt�#JDD(Q�U!�-�n3e[z�[,��ֵ�M�)mx�{��~��D��`��w��UD�U)�v�]�}���k���HU�2M����S�e+�!C�H�NT:PA �Z��ղ�!���e#˖Y&�(CJQ��lH
��iIL 9�¥�)s[L�r �-h�M�*�=�!1L�c��T��6e��&�Pl�3ɖk[m�:�=6���QaTd�}�侯Nج�D���%weGTg�b�51b�i��`���O�����O�i�0c
Z�9�����wgm3�4[�2�wg=CX�T����#f&�0T�+�Ri�A;��ȔP�)ũS'���{��y��:
h��W	2)�bږ
h`�|']�YB(w.!.AY���rT#��6��Jےق��j�Y�Ԙ2��A���U�:�r�図Z��֭T՝�D�{YK}z9�\��#�QF)�����L����iL$#�T�B�)֪P�HTi�����JQ�D�����eb�
'u�W�������Z�S)����l�$qDC�P�)��*�h�i[l1 �lb�H�e;��T��dq������V,�L������Ѽ�a� 6�������ޜS6��XW�U9*I	��Ub4%&(���/�������@��x��%�V���lno�l��Y6 l�w���F�jMA��	����'��(�Q��MШ	���@1�6	�
'��WO^u�ꩺ���1lآY
LPI�j)U�u�&�rg���"�[��IPEK�ڛ�_�~����� �mj[%-m�>fU�ܡ���{JUUi���\��k=߼��|��6��ﺔ(	D����W�$����2!esq�"O�]D�(**S"�[��V�Ъ;H��LːYC$��D�>���f�&a�]��#I\L�� IB�Q�N�ri1b����V�l�7�9�	G]F��t9ҪMb.�;�
�#��c��zj�Fp\D�� FoN��S�G<P�u��,����\PT 
Vr�\�����t�Kse#ec=�
`��zw�Ɩ�]�&�ls�ތ���fTm];�Ml��i������U�B,��`�f �8�N�Sǽ���������>�/�;���b�^�[��dF#�* ���:��__�?e�$1J:���>�Le��(D�[��Vb��~Cm��,���e�l��-�:GuU�ڗ�5�V��t�TU�!jL�U�;I�QQ�(�¶�限�� �JX�uM�HM������Y~�dTd�E�L��#��R��"AH	�]Y�QUa��)dY�%e<�m�7�l f�mf ��TN�U+�-�q6��J�*����h�{K3���C�����x�� d�̙B�����x�f�\6$PJ�����!��SGT_�-�c���$���4o�1���Löl��& C06�e�e��bf ֨m��P��Ji��l��($   �:T��S����¯���參m��w�m1����O���w%I���������q�q�W_~}u�N����PY��`�fk�0meFlK�fWn���1��'w�@E]EP��`b����˝r��N�*E���b�V��
ɀ �5Lg%i@�,Բ,�Ͳ3$$
���(b�֚�TY�4U$*Ew��(�]r�H(� ��f(�ږf�� c������9B�l[�����w��4t�k�J;	bS���[K���Q���Q�]f�)�1X���� J		�5��!�xS��P��{>����0a����L��p
36�kc6o��o��i�a
d���� @l
*�U[5#*�ZLP��$�$؜ B� $%`�YU:O����?���?�?�U�ίzr�ֱW+��&���
}�ү���kVEW�qDH( E�䬼~���N9I�
��*c�4lm�!x�b
G��S� :w.�:�"�RV$c�H�(H��G�Js	)՗K�Ɔ<T`��*�
�FT�4Y�]�ȂBb�R�e���&�ZB��U�9>QAH�KX�
Q�Z$J(�l���3�	�͔Mlb,���N�P_�~�KMXU� �]L�cF�H�ڐ+�f(���ȣȀȉ��F9HM!H��MbR{��cSdS��e�\.F1cI�xl�c׆�l���AX�Q(lW,|��}��=��l� 6��������_~��C���TI�"�N�`##B�1*��D�*�J�>�����_��'��o����a�bb
�T]ͩ�\��B�:�������WYҙL����,Z��*[0�!S[eu,�Q��?vu�\.�hՉ)P0H2��1"�*��.�;��R%����lƐ��W/]��撙 X����q'�2��`�f�H5� #������R:�������'7FUD	�"Q��A�B6���6ٰ��a[�����g�_�j���o��[eS���ʦm���mm�V�/b ���m�i#�*>���A ��� T�SJ��)�QE@�4Qm�	3V�ӗ怱�]4���m1m��&� �`
 O���X����U$&<��8��! A�&PD�d�������۪R�d���.ۻ�y�ecA��(!���5����)�щ�t���ҵ����IЊ$�b���Q5��@,+��1uF�ͦｐ
�R�#S%(Y��V�B��F1�*�
�����2ބ�*V�ZJ�`��ʨu��~�������x��+���bdYɒ�UE�dŔ
*�;N�"��.}r� ��IѥI�����`�-��`Ā�����țC�唕�*�eS�e�ɒ��.[��2���65�B��AH��ET���,]�@HG1Ew��X"DHAH��1��%̄quG�����Ɗ�16i�lcƴU�A��ؗ�����*0 +H�&����*�(�!)��T�%�+��x��ؑ�i3{۱w^�FmbT Ju*�wP꒢#�'����n�%N�:N|�]�Bj�e�r*�*�ֈ�-�F�Q�LF\Sgk=�0=и�Zu��H6��Mo&X��	a�aD�4�L��U ��a���W�R�,A*,%�#��n�{s�R$�;{ �ĩY` �B2�*�̡�	�J�����I��8�-MHb�Bm�1�1���Tg	��]Q2�Ȳ�֘2MP �CvmÊ�b�K�")�e��(�c M��r\���R�Ԑ� (� e�$41 1�`�Mobfm���6��C`J��mi�))�Q&�j�JjE�T�HK�)&�M	 FB1�bB�� ��~���+���m{�m�	5\�T��K,!>��FUq*�t��(�J)�{��Ag8�dۚ�MIm4������x�db��R.�36�Z-�<��FM�B�%@�(%S��*�F80B�6QG;Mkr�Y�!�)q�8����+g�HV��$%Ud�	�V	��p������j;�(��X�I�	����b�U{3��]��.t
֒Q�
2emc�ɗ������\,����}��/��P#�H�O�ޜ�"t�\.%�Q�$���B� ĺ6��$�  ވ�8�6����Dc�� �j�CK� - F%�b���T�B����@��)����4��Q���b�ֶ�]m��ƻ�F ;�~��񶪪rV]ʗR�D�JK(;h�E��*X3c�qel~������_a����d�&� U)q�ݴ@+mmmI���,��cN	cڴ�%A��nj�@�@(Q[���P.+�@���AEȝ2w�Z�rH²HX
�(Q�j�I�*�T����$R��HW��f#i&e�b
1�F�� Ġs�0D~TfԴ��0MXR����b�&���-������&��`(r)�z^JgD�r�#�ɭ?|��
`*�s}��Wh�� ��"RPL`(���=��	�"=6�֚-[�[�a �@H�E�PR`��u�5f���N� Xe #$Ab`�!���?Oo��lm�����`�K�:���S�{~���J�TJ)���"+#���e���"�d	��aNұ�es���+IE���j�m�ĆV��)F0�`��y3�&C+&cȲd����#J JU�*	���B��B��Ԡ��_i�
�I8�a��R��Q��ZD��P�Z��)H��*m�Q:R�N����悂-0{�*�r�Pf��:"�&3l���TK0�h[��I�е�͞V�qJU]TDqʝr��u�R%�П�K�&��R��`!�~*#J�x~lB��������Y�g[��O~�M6���:�`�	�2�+Z0Ƙ@�m�h*IjV�P"  0|���q���~�[��1f���e�M$QU�)A�[��n��ΪcU.G���B
I�*#���B$$%a��bw�{��)b�|2J�t-��P�e�61C��)툧U�n�CF$�S�E"��U}�K0�@J`�^(�v$�q�JZAHD�� �C�����t6YQY�5���kJV(P�^\{��T5Sl
��RU1�V��Қ9���i��M�յ���[��맢v�)-��<�Ƙ]F�%3k�F�c3��6K��[k��
��2�*EхruU��)��#��# A�o @TTB �����y�4xOo���z�/��HU U�#�1"-FZB!sS�Lْ`eb�MA���uAl
�Q$
F��yX�n6�-s,���9"�� ����r�|�	�M��B$�%Vꅭ(
&Hӹ�M���҆(\+��4��*(���}�r-6�H"&XDEJ%� �T�RU�
��{q���	���V�HV���T�͗{uG�����%É�)%{z j4�@�HQlu�L2Rʔ�3��RAʔ�\)�EAdjI��&mK��\�P�h�Z$�(�5fy	�2m+c�b�64��ɒ它bk��ҵ�Q]P�+��K�� ��  �@ CZ��*�%M	/g@dHl�̀����)$J$�5UT%��I��`"j���BL�E*��Ȉ
0�l�6'�5U��S��b*v�]�ܹL���Z���������GY� �6򖼶5�Y�(�2]�6�@\"+�F�M��� �E���-�)M 2��,1��F%}¨H�.)���x� �,%ij$*g]ʫו,��D�sY!P �U+��f[Ռ�j��8�l!m��%�%Q&*�2q-A m��Ԁ�M��&m+�!�([�:�UJ����g1?�n��c#��``#��1��0!�m)%��)es�\!}�kwT\V�R�����%h���~����Oň&�@�"b% �pm�ZVes(X%E1�*Qp)�S) Tv	�$ ��$�Xɘ��,A�(H`������N�,�`FL� �4���B ���JRȒ)J���ޒ����J�z��,k[g*�E�=;�;0XT�uŝ�r��cSS2Ms�BʴLc��֘��T��XؚL���

Ju)W_����
Qo�ǪTDk�֔���([!/�
Y�jY����)+��(R��Hא��25R6RJg�U(�F��)�a�2$֡�%����T6�d��Z[�nP���j��m�l��-h���S�H���e�Kug�#��@�d.�2�3esA����(UH��/E"�ܑ �+ �C5Fo�̬yk6����bPU�\��1P� Y]
�� 	ib��
�����ެ1��gĠ�>~����=���!V�"W���o]GT��0��Ħ��*#�]a�+R���eYVJƖ�,�y�M-)D٬����26�H��U�w�װAaE�4Ҥ]�DD�{�clz̆�x&fcZ�R�#!KD9�đ�˥*Qby5!%j�
v�Y��2d�
Q�Ȑ(�,��֢��*�^[Ո��R%��P��%A1�p�&H�C�b��1e�1��-�Q-�UBn��	�fY��,om���������Ƙi�y�<�PU�L�*P���(Q!��(H�
$
%5��QJH�����1��1&���=6��H�B9�#�:����""���  ����I�Uc#�m���\����y�~��h�
��ˈ��u�w�=�3w?��w%��]R@Љ�\.��Ĳm-�Wj��O����_m���-����«*\M`�l��±��]��t��ڧ]a��)a��J��;��T���@d$�J��(�����"*r\��͍�,�Q"4!$*yY6X�Ȃ�Q�
�E��1�,
��r&U*��� �H
�r��01R��p�CG9P98� �ĢbA�&�*�����55�lBF3�jߙ��Nm�^es�7+���l�G��`Y:wԙ,��`)SM$�GU��)�� �u�V%"H!�P*�Tc��&al䍚l-k�?�����JO#(���!�	`T�
U�U]ѥ|u���$(eDf`3�@V!2��0UVmjq�H�H��n�w�=��,* N��N�m��F���~������7����ʶZd�E`7hK��"�4�>�:�N��b[��r�ӢJ���d�����AD�!)����rU�գH�䕠@`��w��l�,))�L@��ʦ�b��V����Ƞ# ��F����Ѫ8KJ���Cg��*���m%�|y���k*����(f꽽��G�7ճ[e�Ű��f[i�l��T\��,ӗ�
���%2"
Sh��.!H�!��rH��ja��i������c�~�& �$t�P�TQS��5UZg#T����럿�#�[���*�����`!S��!VZGԨ� ѕRL�2��V� �:J9�,��j���,بe���Z{%D�6C�m��m�Bq.E���n��������������[*�,ζނ�!�~tI������xqPJS6)�"!-9�����HY��N	k�K�h��j������qQW�T��Hg*�%$��Z���"��TD�R6(�"I����
�* K�Y���-t��$��	�\��dI�c�aO�ٌ��5��A�6#o��lb���{��LGY:#]FUѩPS���>�×�o�@�ͧ�����I@,��˅��� ��T�Z�"�*���!�]�YL��l�l�` )�*(	º� �J�@��=Ξ�R�B%���l@5\h��
�E?�����o1�� E��TKR]����x# H�T.i��Z#-"EV����,ˆ)Y�J[����m�Xmhw��NM]#����[ַ�ٮ1�Fj3C��J�w��)0�1V$�	�JF�E�usi-��BS����a�H#N�U//��_�%c!�²���YRR�T )P��H�U�j�TQm�$�D���l�h� -E�����\�b]�khao�����˶��5��#W,����m՞��7�A��~�K����FdLho����ڛ��g?�Q�h��T+W���ʐ����U	�ґX������5X�͛1W@�p��T��DJDEP@ (	E.G���J*�4�L��&�Q�\o�Lh��7��?��~�ۓvi"Ҷ��O�$�l*<���>���L�2���%yq�y�0�M�lb�T/���!T"B�r�c��ꖥ�T�zZ2�V�6��0�Z)q޿��ۚs	� � LT(U�����E�T�j� �`�e�E������ϝrGB	�HƊ4�Y^�5��tI�*'F�*������y$U[���P�)ml1�K��*v��Yl�B)�]I����3m۞�iȆVC���Za�o}�w?����[��e�R�ե��(�*�e(X*ÄUb����\�����ڥj:B$���t�H��``̪�-f[%����P��HEZ������׈*�K$�(&T�I�C�9��Tq-T���4���?|OG�M`)�4;�k�W%� ���j� ƛ1p�!W�tA)��}��˛s ��w�-$Y[�ݔ��1�/2*�dSkI�[T�B�VJ��{i���`�4b��Z�P�b�.?9��9�Ӈ� L�1�"�f �L�jɒ��+YK8�L,JdB��]�N'�#$!ꙩ�Ŭ�*&�� jRE�R�hoϬ�)��E�j�����!���q_��a�X�*K3�&Ð���+V]����{<�=l�F۬d��&Gc[�ej?��Kˬܑ �.K��5Ql i����2!�X+��TAe9:Wh%Q!CUP(�XT.��Ơ[z��l  �""U4�u}�z�r%Q���bQE*AHCP$`.х,�d#���3�i�� ��L��d����\LƸ|GN�R�����>,��=��SV{ ��/�?޳Rv����'?�T�%���Ц������Q�*D)CT6h[�6j{ky�%-Rsvu/7/7�Ju'�|)��x�ױ&Sal��F؄ml�4�."���w�5ZHFA�
Q����q��XSh�YVC�0��5|WV�*9*����Fѡd��H�0Uz:���b�0ͬZ�ZC��V�j'���ٴ7�k�F��j[m����m��2��@_��z��2TD\E�2�NC�]����-tVTw�!bPQ���� puU�*.��%�8�D1cl211s�"�7% �8�(V�v�ځT���5P���-iv!rE�1a<4@"@��aĪ]�U�4�\�HH%����_s�O2�Yެ޼Y�?f�jWv�������Mu�N��b�h{���_��lD�ڶ.�Huf�,cf�㘐Rj�
�sO.?�j]~�$W�"�_� 3�H54eY[˃$$��	YAy�roN�k**$pD����߉�#R/2dY6�LF�J�Թ�T��Qe�`:��j�Ql%�*D"��[�*�IK3��3ʜt�Kژ�{�yc�CYM!U�ioր�X������mm[ީ�.���H���ڣ�YP�A���))&Ti�:S������:j�յ��\�S��ؔ�lL�-dAd �%�@��Pi*$e�ш*�rDTUv�Τ��E���)�� �& #HKK�\���TQ�a�Y �:"�A0B]��j�y��[T'��ΧK'u��4�
�`��f�^��gKJ�N��Wcl�6e&��PW,U��Du}'ʗ�r�˃���
�
aCT�SI����c1!��愪�G\	)8����t��D�q��jC���.�ܻ{�x�~Fɚ2��SGJ��Ip&)��Մ��6E�^�@�ʦM�qF�0L�v���+����.s�L���g�[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://outjf1p6ape4"
path="res://.godot/imported/Blue_Nebula_08-512x512.png-be40ccdfdcb54196ab7f70e4ddc321b5.ctex"
metadata={
"vram_texture": false
}
 ��1q�5�6BC�#yRSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    normal 	   distance    script 	   _bundled       Script    res://WorldBounds.gd ��������
   Texture2D !   res://Blue_Nebula_08-512x512.png 1W�B�9   Script    res://MouseController.gd ��������   PackedScene    res://ball.tscn VK�_�Q   #   local://WorldBoundaryShape2D_tllo8 �      #   local://WorldBoundaryShape2D_5i2e7 �      #   local://WorldBoundaryShape2D_n0et3 �      #   local://WorldBoundaryShape2D_wsjye -         local://PackedScene_d5ne1 R         WorldBoundaryShape2D       
         �?         WorldBoundaryShape2D       
     �?             WorldBoundaryShape2D       
     ��             WorldBoundaryShape2D             PackedScene          	         names "      	   GameRoom    Node2D    WorldBounds    script    StaticBody2D    Background    unique_name_in_owner    texture_repeat    texture 	   centered    region_enabled    region_rect 	   Sprite2D 
   TopBorder 	   position    shape    CollisionShape2D    LeftBorder    RightBorder    BottomBorder    MouseController    ball_scene    	   variants                                                          �D  "D
     D              
         �C         
     �D  �C         
     D  "D                                 node_count             nodes     b   ��������       ����                      ����                           ����                     	      
                             ����                                      ����                  	                    ����            
                          ����                                       ����                         conn_count              conns               node_paths              editable_instances              version             RSRCϡGST2   �   �     �����                � �               ���)TUUU� I�$I�  &!UUUU� I    &!UUUU�z�       &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�zX      &!UUUU� O9    &!UUUU� I�$O'  &!UUUU        ���)UUU� I�$I�  &!UUUU�!@    F!&!UUU�       �1&!U5	 �       �1g!   �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g!p   �       �1&!U\` � �   F!&!UUUT� I�$N�'  &!UUUU� �p   &!UUUU�       �1&!%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!TXp@� X8��G)&!��U�zP     &!UUUU�       �1g!  �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g)@�� �x � @  &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �:�1UUU�       WD2UU5�       WD2U  �       WD2k@  �       �:�1UUUT�         �1UUUU�         �1UUUU�       �:�1UUU�       WD2� �       WD2U�  �       WD2UUX��       �:�1UUUT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�       WD2T\Pp�         �1UUUU�         �1UUUU�       WD25�         wDUUUU�         wDUUUU�         wDUUUU�       WD2PPPP�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%%%�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@   �       WD+:U   �       WD+:U   �       WD2   �         wDUUUU�         wDUUUU�         wDUUUU�       WD2PPXX�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2555	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2\\\`�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       6D2UU��       WD2]�  �       WD2UUX��       m:�1UUU�       WD2�% �       wDD   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       wDD@   �       WD2WX@ �       �:�1UUUT�       WD2UU%�       WD2u�  �       6D2UUWT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       m:�1UUU�       WD2 �         wDUUUU�         wDUUUU�       WL�:   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WDm:�   �         wDUUUU�         wDUUUU�       WD2P@� �       �:�1UUUT�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TXp`�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD25�U�       wDD   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       wDD   @�       WD2P\VU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@pPT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ��xLUUU�       ���TU% �       ���u   �       ���TW`  �       ���TUUW\�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       ���TUU�5�       ���T�	  �       ���}   �       ���TUX� �       ��xLUUUT�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T%�       ��IJ �`P�       Y�IJ\UUU�       ��IJ�UU�       ���Sp@���         wDUUUU�         wDUUUU�       ���TU�	�       ���TUWP`�         wDUUUU�         wDUUUU�       ��T	C�       ��IJpVUU�       8�IJ5UUU�       ��IJ �       ���TTXPp�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T	�       ��IJX\\X�         BUUUU�         BUUUU�       ��IJ�����         wDUUUU�         wDUUUU�       ���T�       ���T@@@@�         wDUUUU�         wDUUUU�       ��IJBBBB�         BUUUU�         BUUUU�       ��IJ%555�       ���T```p�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�       ���T%U�       ��IJPp� �       ׽IJUUU\�       ��IJUU��       ��nS�����         wDUUUU�         wDUUUU�       ���T�       ���T@@@@�         wDUUUU�         wDUUUU�       ���SC	5�       ��IJUUVp�       ��)JUUU5�       ��IJ �       ���TPXTW�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�       ���T%UU�       ���T  �U�       ���T `WU�       9uxLTUUU�         wDUUUU�         wDUUUU�       ���T	��       ���T@@pW�         wDUUUU�         wDUUUU�       9mwLUUU�       ���T 	�U�       ���T  �U�       ���T�XUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       ��KB��       ��8uU  �       ���TU   �       ���TU�  �       ���TU_� �         wDUUUU�         wDUUUU�         wDUUUU�       \��LUUU�       ϘTUUU �       ϘTUUU �       ϘTUUU �       ϘTUUU �       |��LUUUT�         wDUUUU�         wDUUUU�         wDUUUU�       ���TU� �       ���TU*  �       ���TU   �       ��8uU  ��       ��KBVTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�       xLwDUUU�       ��xLUUU�       �ƘLUUU�       ��z} �       �LwDUUUT�         wDUUUU�         wDUUUU�       ���T%�       ���T  �\�       ���T  �U�       ���T  �U�       ���T  *5�       ���TXPPP�         wDUUUU�         wDUUUU�       wLwDUUUU�       ����@@@�       �ƘL�UUU�       ��xL�UUU�       xLwDTUUU�       WD2TTTT�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       7D2���         wDUUUU�         wDUUUU�         wDUUUU�       ���T�       ���TUU  �       ���TUU� �       ���TUU� �       ���T �       ���TTTTV�         wDUUUU�         wDUUUU�       ���T��       ���TPp` �       ���TUU� �       ���TUU* �       ���TUU  �       ���T@@@@�         wDUUUU�         wDUUUU�         wDUUUU�       6D2TTVW�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       L:�1UUU�       WD2 �         wDUUUU�         wDUUUU�       ���TUUU�       ���T �UU�       ���T �UU�       ���T  UU�       ���T  UU�       \�xLTWUU�         wDUUUU�         wDUUUU�       �xL�UU�       ���T  UU�       ���T  UU�       ���T �UU�       ���T UU�       ���T`UUU�         wDUUUU�         wDUUUU�       WD2 �@p�       +:�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2%�UU�       WD:  	�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2  �p�       WD2XVUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       D25UUU�       WD2 %U�       WDQ;   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD1;   `�       WD2 �XU�       �C
2\UUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       RC
25UUU�       WD2 -UU�       WD2  -U�       WD,:   ��       WL�C   -�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WL�C   x�       WD+:   _�       WD2  xU�       WD2 xUU�       RC
2\UUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�         &!UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       
2�1UUU�       �:�1
UUU�       �:�1UUU�       �:�1�UUU�       �:�1�UUU�       
2�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         &!UUUU�z 0    &!UUUU�       �1g!  �         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g) ��@�x  ` 
   &!UUUU� 1�  &!UUUU�       �1&!%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!@pXT�  (��%G)&!��� ɑ�I�$  &!UUUU�   �F!&!UUU�       �1&! 	5U�       �1g)   )�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1g)   h�       �1&! `\U�    
4F!&!TUUU� x�$I�$  &!UUUU        ���)UUUT� ���I�$  &!UUUU�  0 ���G)&!UU]�x    �N  &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�         &!UUUU�x    �5  &!UUUU�   `��$G)&!UUu�� p�$I�$  &!UUUU        ���)UUU� I��	�RF!TUUU��     �1&!UU-�       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �       �1&!UU  �P    �1&!UUx�� I�$`8�RF!UUU�P   �1&!�5%�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU� �  �1&!V\XP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �C
2UUU%�       WD2UU� �       +:�1UUUT�       :�1UUU�       WD2UUs �       �C
2UUUX�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       WD2�         wDUUUU�       WD2VT� �       WD2�* �         wDUUUU�       WD2@@@@�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       �:�1UUU�       WD2UU_��       WD2UU�%�       WD2	  �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2`@  �       WD2UUWX�       WD2UU��       �:�1UUUT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       WD2	�         wDUUUU�       WD�C   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD�Cp   �         wDUUUU�       WD2\P`@�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       WD25��         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD2@P\V�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ��,S�C�       ��IJ� �U�       ���TUWTZ�       ��TUUU�       ���TUUUT�       ���TU���       ��IJ �U�       ��S�����         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ��IJbcC�       ��)JUUU�       גTQQXT�       ���T5555�       ���T\\\\�       ϓL��%�       ��)JUUU��       ��IJ�����         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       1C�1�         wDUUUU�       ^ߘT5UUU�       ���T�UUU�       �TwDTUUU�       ���T5�UU�       ���T\VUU�       �TwDUUU�       ���TUUU�       ~�T\UUU�         wDUUUU�       QC�1TTTT�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       ��
:���       ���T� UU�       ���T_ %�       xLwDUUUT�       ���TUU�       ���TU� ��       ���TU� ��       ���TUUTT�         wDUUUU�       ���T� �X�       ���T� UU�       Ք
:TTWW�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�       ;�1�UU�       WD�:   �       ���T%5�U�       ���TU 
U�       ���T* U�       \�xLTVWU�       ;�xL��U�       ���TT� U�       ���TU �U�       ���TXXVU�       WD�:   @�       �:�1TVUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�       WD2	%�U�       WD+:   �         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�         wDUUUU�       WD:   p�       WD2`XWU�         �1UUUU�         �1UUUU�       �1&!PPPP�       �1&!�         �1UUUU�         �1UUUU�         �1UUUU�       m:�1UUU�       WD2�UU�       WD2 
UU�       WD2  UU�       WD2  UU�       WD2 �UU�       WD2�WUU�       m:�1TUUU�         �1UUUU�         �1UUUU�         �1UUUU�       �1&!PPPP�    �1&!%5��         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�         �1UUUU�  @ 
 �1&!PX\V� 1�I�$�RF!UUUT�    �
�1&!-UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�       �1&!  UU�     5�1&!�xUU� �&N�$�RF!UUU� 	   �1&!V5�       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   �       �1&!U   � `   �1&!�\p@�       �1&!�         �1UUUU�       WD2U�55�       WD2URp �       WD2U� �       WD2UW\\�         �1UUUU�       �1&!@@@@�       �1&!�       WD2U��       WD25	  �         wDUUUU�         wDUUUU�       WD2\`  �       WD2U[@��       �1&!@@@@�       �1&!�       WD2	�       ]��R��R�       |��LUUU��       |��LUUU�       ]��R�����       WD2@`pp�       �1&!@@@@�       �1&!�       WD2�       [�IJ\R��       �ƘL�U�       �ΘL��VU�       [�IJ5����       WD2pppp�       �1&!@@@@�       �1&!�       ��+B����       ^ߘTXQ���       �ΘL�	sZ�       �ΘL_`ͥ�       ^ߘT%EK_�       ��+Bp___�       �1&!@@@@�       �1&!�       D2UUU�       WD2 �U�       WD2   U�       WD2   U�       WD2 �^U�       �C2TUUU�       �1&!@@@@�  @ ��1&!5V�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�       �1&!   U�   ��&�1&!@p\��D     �1F!��       7D�)UUu��       7D�)UU]B�D�@   �1F!_@���       7D�)�%%5�       ��m:�����       ��m:z��
�       7D�)WXX\�       ���1����       ;��J$�,��       ;��J�8��       ���1VVTV�D   �:G!)��U�       7D�) �UU�       7D�) zUU�C    (�:g)hjjU��     �l�1U�-	��     �l�1U_x`��     Y}�1-	�U��      Y}�1x`^U��   �t�1UA�}�       C�:U   �         �BUUUUD��X���qd��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bteneltln1r22"
path.s3tc="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.s3tc.ctex"
metadata={
"imported_formats": ["s3tc_bptc"],
"vram_texture": true
}
 1�extends Node2D

const BALL_SIZE: int = 10

@export var ball_scene: PackedScene;

@onready var viewport = get_viewport()

var dragging := false
var drag_start: Vector2
var drag_end: Vector2

func _input(event):
	if event.is_action_pressed("player_create_ball"):
		drag_start = viewport.get_mouse_position()
		dragging = true
	elif event.is_action_released("player_create_ball"):
		drag_end = viewport.get_mouse_position()
		dragging = false
		create_ball()

func create_ball():
	var ball = ball_scene.instantiate()
	ball.position = drag_start
	ball.size = ball_size() / 10
	ball.direction = drag_start.angle_to_point(drag_end)
	get_parent().add_child(ball)

func _process(delta):
	queue_redraw()
	if dragging: 
		drag_end = viewport.get_mouse_position()

func ball_size():
	return clampi(drag_start.distance_to(drag_end) / 15, 1, 10) * 10

func _draw():
	if dragging:
		draw_line(drag_start, drag_end, Color.WHITE)
		draw_arc(drag_start, ball_size(), 0, TAU + 1, 64, Color.WHITE)
�r�#-�k�?�RSRC                    SystemFont            ��������                                                  resource_local_to_scene    resource_name    font_names    font_italic    font_weight    font_stretch    antialiasing    generate_mipmaps    allow_system_fallback    force_autohinter    hinting    subpixel_positioning #   multichannel_signed_distance_field    msdf_pixel_range 
   msdf_size    oversampling 
   fallbacks    script           local://SystemFont_1pd1t �         SystemFont          �        RSRC�extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_shape_entered.connect(on_collision)
	set_axis_velocity(Vector2(-400,-400))


func on_collision(body_rid: RID, 
				  body: Node,
				  body_shape_index: int,
				  local_shape_index: int):
	
	pass
�N��t���t���6��extends StaticBody2D

@onready var top := %TopBorder
@onready var left := %LeftBorder
@onready var right := %RightBorder
@onready var bottom := %BottomBorder
@onready var background := %Background
@onready var viewport := get_viewport()

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport.size_changed.connect(on_viewport_size_changed)
	recalculate_borders()

func on_viewport_size_changed():
	recalculate_borders()

func recalculate_borders():
	var view = viewport.get_visible_rect()
	background.set_region_rect(Rect2(view.position, view.size))
	top.position.x = view.position.x + (view.size.x / 2)
	top.position.y = view.position.y
	left.position.x = view.position.x
	left.position.y = view.position.y + (view.size.y / 2)
	right.position.x = view.position.x + view.size.x
	right.position.y = view.position.y + (view.size.y / 2)
	bottom.position.x = view.position.x + (view.size.x / 2)
	bottom.position.y = view.position.y + view.size.y
 
�����,� M�|w[remap]

path="res://.godot/exported/133200997/export-a29d5d0e6346c53fac340b6edd16221e-ball.res"
:l������Ջ!e�[remap]

path="res://.godot/exported/133200997/export-f46c71a9b7f0892a5bf2bd9cf0943875-ball.scn"
A�����B�� �[remap]

path="res://.godot/exported/133200997/export-79e4528e86b81c004fd427dc362ba82b-game_room.scn"
a^-�~0��[remap]

path="res://.godot/exported/133200997/export-fff17282759ef4fb3eae077216de873f-default_font.res"
��I��Q�list=Array[Dictionary]([{
"base": &"RigidBody2D",
"class": &"Ball",
"icon": "",
"language": &"GDScript",
"path": "res://ball.gd"
}])
��i���NbT<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
��\o��n�}f   ���В}�J   res://ball.tresVK�_�Q   res://ball.tscn^q�n�_   res://game_room.tscn��SOK�3   res://icon.svg�9l�x�   res://PurplyBlueSky.png1W�B�9    res://Blue_Nebula_08-512x512.png¡m����|   res://default_font.tres�,e��ں9L�ECFG
      application/config/name         Bouncing Ball Game     application/run/main_scene         res://game_room.tscn   application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg     dotnet/project/assembly_name         Bouncing Ball Game     input/player_create_ball�              events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask           position              global_position               factor       �?   button_index         canceled          pressed           double_click          script            deadzone      ?   physics/2d/default_linear_damp          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility>   rendering/textures/default_filters/anisotropic_filtering_level          Z�F�}_*�T�^