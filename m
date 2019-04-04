Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C3020882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfDDPlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:41:22 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59252 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfDDPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:41:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 331C82829CB
Message-ID: <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Chen-Yu Tsai <wens@csie.org>, Tomasz Figa <tfiga@chromium.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg "
         "Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Date:   Thu, 04 Apr 2019 11:41:13 -0400
In-Reply-To: <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
         <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
         <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
         <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-EqS/XowiKo2BFjcAriJF"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EqS/XowiKo2BFjcAriJF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 04 avril 2019 =C3=A0 22:42 +0800, Chen-Yu Tsai a =C3=A9crit :
> On Thu, Apr 4, 2019 at 8:54 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > Hi,
> >=20
> > On Thu, Apr 4, 2019 at 9:26 PM Maxime Ripard <maxime.ripard@bootlin.com=
> wrote:
> > > From: Pawel Osciak <posciak@chromium.org>
> > >=20
> > > Stateless video codecs will require both the H264 metadata and slices=
 in
> > > order to be able to decode frames.
> > >=20
> > > This introduces the definitions for a new pixel format for H264 slice=
s that
> > > have been parsed, as well as the structures used to pass the metadata=
 from
> > > the userspace to the kernel.
> > >=20
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Co-developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >  Documentation/media/uapi/v4l/biblio.rst            |   9 +-
> > >  Documentation/media/uapi/v4l/ext-ctrls-codec.rst   | 569 +++++++++++=
+++-
> > >  Documentation/media/uapi/v4l/pixfmt-compressed.rst |  19 +-
> > >  Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |  30 +-
> > >  Documentation/media/videodev2.h.rst.exceptions     |   5 +-
> > >  drivers/media/v4l2-core/v4l2-ctrls.c               |  42 +-
> > >  drivers/media/v4l2-core/v4l2-ioctl.c               |   1 +-
> > >  include/media/h264-ctrls.h                         | 192 +++++-
> > >  include/media/v4l2-ctrls.h                         |  13 +-
> > >  include/uapi/linux/videodev2.h                     |   1 +-
> > >  10 files changed, 880 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/media/h264-ctrls.h
> > >=20
> > > diff --git a/Documentation/media/uapi/v4l/biblio.rst b/Documentation/=
media/uapi/v4l/biblio.rst
> > > index ec33768c055e..8f4eb8823d82 100644
> > > --- a/Documentation/media/uapi/v4l/biblio.rst
> > > +++ b/Documentation/media/uapi/v4l/biblio.rst
> > > @@ -122,6 +122,15 @@ ITU BT.1119
> > >=20
> > >  :author:    International Telecommunication Union (http://www.itu.ch=
)
> > >=20
> > > +.. _h264:
> > > +
> > > +ITU-T Rec. H.264 Specification (04/2017 Edition)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +
> > > +:title:     ITU-T Recommendation H.264 "Advanced Video Coding for Ge=
neric Audiovisual Services"
> > > +
> > > +:author:    International Telecommunication Union (http://www.itu.ch=
)
> > > +
> > >  .. _jfif:
> > >=20
> > >  JFIF
> > > diff --git a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst b/Docum=
entation/media/uapi/v4l/ext-ctrls-codec.rst
> > > index 67a122339c0e..1285bfec7d3d 100644
> > > --- a/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > > +++ b/Documentation/media/uapi/v4l/ext-ctrls-codec.rst
> > > @@ -1371,6 +1371,575 @@ enum v4l2_mpeg_video_h264_hierarchical_coding=
_type -
> > >        - Layer number
> > >=20
> > >=20
> > > +.. _v4l2-mpeg-h264:
> > > +
> > > +``V4L2_CID_MPEG_VIDEO_H264_SPS (struct)``
> > > +    Specifies the sequence parameter set (as extracted from the
> > > +    bitstream) for the associated H264 slice data. This includes the
> > > +    necessary parameters for configuring a stateless hardware decodi=
ng
> > > +    pipeline for H264. The bitstream parameters are defined accordin=
g
> > > +    to :ref:`h264`, section 7.4.2.1.1 "Sequence Parameter Set Data
> > > +    Semantics". For further documentation, refer to the above
> > > +    specification, unless there is an explicit comment stating
> > > +    otherwise.
> > > +
> > > +    .. note::
> > > +
> > > +       This compound control is not yet part of the public kernel AP=
I and
> > > +       it is expected to change.
> > > +
> > > +.. c:type:: v4l2_ctrl_h264_sps
> > > +
> > > +.. cssclass:: longtable
> > > +
> > > +.. flat-table:: struct v4l2_ctrl_h264_sps
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +    :widths:       1 1 2
> > > +
> > > +    * - __u8
> > > +      - ``profile_idc``
> > > +      -
> > > +    * - __u8
> > > +      - ``constraint_set_flags``
> > > +      - See :ref:`Sequence Parameter Set Constraints Set Flags <h264=
_sps_constraints_set_flags>`
> > > +    * - __u8
> > > +      - ``level_idc``
> > > +      -
> > > +    * - __u8
> > > +      - ``seq_parameter_set_id``
> > > +      -
> > > +    * - __u8
> > > +      - ``chroma_format_idc``
> > > +      -
> > > +    * - __u8
> > > +      - ``bit_depth_luma_minus8``
> > > +      -
> > > +    * - __u8
> > > +      - ``bit_depth_chroma_minus8``
> > > +      -
> > > +    * - __u8
> > > +      - ``log2_max_frame_num_minus4``
> > > +      -
> > > +    * - __u8
> > > +      - ``pic_order_cnt_type``
> > > +      -
> > > +    * - __u8
> > > +      - ``log2_max_pic_order_cnt_lsb_minus4``
> > > +      -
> > > +    * - __u8
> > > +      - ``max_num_ref_frames``
> > > +      -
> > > +    * - __u8
> > > +      - ``num_ref_frames_in_pic_order_cnt_cycle``
> > > +      -
> > > +    * - __s32
> > > +      - ``offset_for_ref_frame[255]``
> > > +      -
> > > +    * - __s32
> > > +      - ``offset_for_non_ref_pic``
> > > +      -
> > > +    * - __s32
> > > +      - ``offset_for_top_to_bottom_field``
> > > +      -
> > > +    * - __u16
> > > +      - ``pic_width_in_mbs_minus1``
> > > +      -
> > > +    * - __u16
> > > +      - ``pic_height_in_map_units_minus1``
> > > +      -
> >=20
> > We recently had some reflection with Alex that this is redundant with
> > the width and height in the OUTPUT format. It may also apply to some
> > other fields in these structs. I feel like they should be removed and
> > passed via corresponding generic V4L2 properties - format, selection,
> > etc.
> >=20
> > The same problem is also present in the MPEG2 controls. In fact, there
> > was a patch already which used some fields from the controls to
> > calculate the destination buffer strides, rather than bytesperline in
> > the format.
> >=20
> > Since we're in staging, it could be done with a follow-up patch, though=
.
>=20
> Just my two cents. I played with some codecs a while back. IIRC some
> specify a "codec" size in addition to the actual picture size, like
> when the encoder does padding to fit the requirements of the codec
> (spec). Is this needed anywhere?

With state-less encoders, the headers, which contains the crop
information is created by userspace and for state less decoder, the
headers that contains this information is parsed by userspace. So I
believe that in theory, the accelerator does not strictly need to be
aware of the cropped dimensions.

Another thing, is that there is not guarantied matches between e.g.
depth of the chrome/luma and the final image buffers. Some hardware may
have bandwidth limitation or internal converter and could possibly
decode 10bit data into 8bit buffers.

A third reason why I would not try and encode this header information
is that there can be multiple PPS/SPS at the same time, and I think
it's confusing if the relevant information to differentiate them is
removed.

>=20
> ChenYu

--=-EqS/XowiKo2BFjcAriJF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXKYlmQAKCRBxUwItrAao
HBJjAJsEDtvSyNdSWrop+wtbnudBTcO4nwCff1+96wdh0zfxE95853qCW1Bkk30=
=PVEP
-----END PGP SIGNATURE-----

--=-EqS/XowiKo2BFjcAriJF--

