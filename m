Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D671C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C50C20675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbfDPLyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:54:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50028 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfDPLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:54:13 -0400
Received: from skullcanyon (unknown [IPv6:2002:c0de:c115:0:481e:e17e:2f68:43f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0499A281D52;
        Tue, 16 Apr 2019 12:54:07 +0100 (BST)
Message-ID: <d38e20350cb0ec73b7f295bf08cc22807804ad9c.camel@collabora.com>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
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
Date:   Tue, 16 Apr 2019 07:54:03 -0400
In-Reply-To: <CAAFQd5Cz-N-7YdwVbtF9yX3LgDtG0yqD0sw6w9r47_m086=b-A@mail.gmail.com>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
         <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
         <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
         <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
         <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
         <20190405151552.biesirbs35uivk7d@flea>
         <05078223a4098c96f6260f77e9ef2a01b966daa6.camel@collabora.com>
         <20190411155749.crdpidehjxa6edya@flea>
         <CAAFQd5Cz-N-7YdwVbtF9yX3LgDtG0yqD0sw6w9r47_m086=b-A@mail.gmail.com>
Organization: Collabora
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-H6h/eLDKF45bATKuH42m"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H6h/eLDKF45bATKuH42m
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 16 avril 2019 =C3=A0 16:16 +0900, Tomasz Figa a =C3=A9crit :
> On Fri, Apr 12, 2019 at 12:57 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >=20
> > On Fri, Apr 05, 2019 at 12:27:48PM -0400, Nicolas Dufresne wrote:
> > > Le vendredi 05 avril 2019 =C3=A0 17:15 +0200, Maxime Ripard a =C3=A9c=
rit :
> > > > Hi Nicolas,
> > > >=20
> > > > On Thu, Apr 04, 2019 at 11:41:13AM -0400, Nicolas Dufresne wrote:
> > > > > > > > +    * - __u16
> > > > > > > > +      - ``pic_width_in_mbs_minus1``
> > > > > > > > +      -
> > > > > > > > +    * - __u16
> > > > > > > > +      - ``pic_height_in_map_units_minus1``
> > > > > > > > +      -
> > > > > > >=20
> > > > > > > We recently had some reflection with Alex that this is redund=
ant with
> > > > > > > the width and height in the OUTPUT format. It may also apply =
to some
> > > > > > > other fields in these structs. I feel like they should be rem=
oved and
> > > > > > > passed via corresponding generic V4L2 properties - format, se=
lection,
> > > > > > > etc.
> > > > > > >=20
> > > > > > > The same problem is also present in the MPEG2 controls. In fa=
ct, there
> > > > > > > was a patch already which used some fields from the controls =
to
> > > > > > > calculate the destination buffer strides, rather than bytespe=
rline in
> > > > > > > the format.
> > > > > > >=20
> > > > > > > Since we're in staging, it could be done with a follow-up pat=
ch, though.
> > > > > >=20
> > > > > > Just my two cents. I played with some codecs a while back. IIRC=
 some
> > > > > > specify a "codec" size in addition to the actual picture size, =
like
> > > > > > when the encoder does padding to fit the requirements of the co=
dec
> > > > > > (spec). Is this needed anywhere?
> > > > >=20
> > > > > With state-less encoders, the headers, which contains the crop
> > > > > information is created by userspace and for state less decoder, t=
he
> > > > > headers that contains this information is parsed by userspace. So=
 I
> > > > > believe that in theory, the accelerator does not strictly need to=
 be
> > > > > aware of the cropped dimensions.
> > > > >=20
> > > > > Another thing, is that there is not guarantied matches between e.=
g.
> > > > > depth of the chrome/luma and the final image buffers. Some hardwa=
re may
> > > > > have bandwidth limitation or internal converter and could possibl=
y
> > > > > decode 10bit data into 8bit buffers.
> > > > >=20
> > > > > A third reason why I would not try and encode this header informa=
tion
> > > > > is that there can be multiple PPS/SPS at the same time, and I thi=
nk
> > > > > it's confusing if the relevant information to differentiate them =
is
> > > > > removed.
> > > >=20
> > > > Sorry if that sounds a bit dumb, but it's not really clear to me if
> > > > you're arguing for the removal of the data as Tomasz suggests, or i=
f
> > > > you want to keep them.
> > > >=20
> > > > The first paragrah seems to advocate for the former, but the two
> > > > others for the latter.
> > >=20
> > > I think the data should stay. As I said, there can be multiple SPS/PP=
S,
> > > while there is only one format. That being said, how does SPS/PPS
> > > activation works ? How do you tell the driver about all the SPS/PPS a=
nd
> > > which one is being activated ?
> >=20
> > The current way of dealing with this is that the _SLICE_PARAMS control
> > actually takes an array of SPS's. And same thing for PPS.
> >=20
> > There's no difference between activated and deactivated ones
> > though. What is the use case for this?
>=20
> Uhm, there is only one format, but so there is only one active
> SPS/PPS, isn't it?

Yes, and the active one can only change on frame boundary.

> An alternative would be to just make the OUTPUT format a function of
> the currently set controls, so that it would always match the active
> PPS/SPS, without the ability for the application to change it.
>=20
> I just want to avoid the case when the OUTPUT format can be set
> randomly to something different than in the stream and also drivers
> reading randomly the format-related information sometimes from the
> controls and sometimes from the format state.

Understood.

>=20
> Best regards,
> Tomasz

--=-H6h/eLDKF45bATKuH42m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXLXCWwAKCRBxUwItrAao
HEwGAKC9vzS05UNWnMStFON4Z1xXPRm6oACeJm2bqgyFqXpZCkdiFXN29ux7DW8=
=ac8L
-----END PGP SIGNATURE-----

--=-H6h/eLDKF45bATKuH42m--

