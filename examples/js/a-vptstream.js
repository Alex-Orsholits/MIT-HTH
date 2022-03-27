AFRAME.registerComponent('vptstream', {
  init: function() {
    this.vptstream = new VPTStream();

    this.el.setObject3D('vptstream', this.vptstream);

    var params = {};

    params.renderMode = 'ortho';
    params.textureSize = { w:640, h:360 };
    params.meta = {
            "depthFocalLength" : {
                    "x" : 639.294,
                    "y" : 639.294
            },
            "depthImageSize" : {
                    "x" : 640,
                    "y" : 360
            },
            "depthPrincipalPoint" : {
                    "x" : 331.706,
                    "y" : 236.211
            }        
    };

    this.vptstream.updateParameters(params);
    this.vptstream.scale.set(-16.0/9.0,1.0, -1.0);
  },
});

