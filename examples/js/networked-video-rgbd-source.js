/* global AFRAME, NAF, THREE */
AFRAME.registerComponent('networked-video-rgbd-source', {

  schema: {
    streamName: { default: 'video' },
  },

  dependencies: ['material'],

  init: function () {
    this.stream = null;

    this._setMediaStream = this._setMediaStream.bind(this);

    NAF.utils.getNetworkedEntity(this.el).then((networkedEl) => {
      const ownerId = networkedEl.components.networked.data.owner;

      if (ownerId) {
        NAF.connection.adapter.getMediaStream(ownerId, this.data.streamName)
          .then(this._setMediaStream)
          .catch((e) => NAF.log.error(`Error getting media stream for ${ownerId}`, e));
      } else {
        // Correctly configured local entity, perhaps do something here for enabling debug audio loopback
      }
    });
  },

  _setMediaStream(newStream) {

    if(newStream != this.stream) {
      if (this.stream) {
        this._clearMediaStream();
      }

      if (newStream) {
        const vpt = this.el.getObject3D('vptstream');
        vpt.setMediaStream(newStream);
      }

      this.stream = newStream;
    }
  },

  _clearMediaStream() {
    this.stream = null;
  },

  remove: function() {
      this._clearMediaStream();
  },
});
