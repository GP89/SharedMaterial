// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/Shader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_XCutoff ("XCutoff", float) = 0
	}
	SubShader {
		Tags {
			"RenderType"="Transparent"
//			"DisableBatching"="True"
		}
		LOD 200

		Pass {
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			struct appdata {
				float4 vertex : POSITION;			
			};
			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 col : COLOR;
			};

			uniform fixed4 _Color;
			uniform float _XCutoff;

			v2f vert(appdata v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				float4 meshOrigin = mul(unity_ObjectToWorld, float4(0, 0, 0, 1));

				if (meshOrigin.x < _XCutoff)
					o.col = fixed4(_Color.rgb, 1);
				else
					o.col = fixed4(_Color.rgb, 0.2);
				return o;
			};

			fixed4 frag(v2f i) : SV_Target {
				return i.col;
			};

			ENDCG
		}
	}
	FallBack "Diffuse"
}
