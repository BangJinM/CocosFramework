uniform sampler2D  textures;
varying vec2 v_texCoord;

void main()
{
    gl_FragColor = texture2D(textures, v_texCoord);
}