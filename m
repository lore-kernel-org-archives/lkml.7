Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B13F2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDKP5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:57:55 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55109 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDKP5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:57:55 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0A81E20012;
        Thu, 11 Apr 2019 15:57:49 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:57:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg 
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jens Kuske <jenskuske@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH RESEND v7 1/2] media: uapi: Add H264 low-level decoder
 API compound controls.
Message-ID: <20190411155749.crdpidehjxa6edya@flea>
References: <cover.bfe197a82766125bea21dd26fd3de85893a921ac.1554380738.git-series.maxime.ripard@bootlin.com>
 <7cd913545cfc80fa9999839c62c4bf7b354a7904.1554380738.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5ASMJL2_ovNeFOhCh2JoD86KMtV5XO+7OgM37ckxrxmfA@mail.gmail.com>
 <CAGb2v642__AF3iHO+d9FKazJ4=uRAQSfxAN_uCUWagH6Jz2twQ@mail.gmail.com>
 <c3ed6d00bf5642b1524ef4973f2db7ba6759fb6d.camel@collabora.com>
 <20190405151552.biesirbs35uivk7d@flea>
 <05078223a4098c96f6260f77e9ef2a01b966daa6.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gy5eppcjekdsrhyc"
Content-Disposition: inline
In-Reply-To: <05078223a4098c96f6260f77e9ef2a01b966daa6.camel@collabora.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gy5eppcjekdsrhyc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 05, 2019 at 12:27:48PM -0400, Nicolas Dufresne wrote:
> Le vendredi 05 avril 2019 =E0 17:15 +0200, Maxime Ripard a =E9crit :
> > Hi Nicolas,
> >
> > On Thu, Apr 04, 2019 at 11:41:13AM -0400, Nicolas Dufresne wrote:
> > > > > > +    * - __u16
> > > > > > +      - ``pic_width_in_mbs_minus1``
> > > > > > +      -
> > > > > > +    * - __u16
> > > > > > +      - ``pic_height_in_map_units_minus1``
> > > > > > +      -
> > > > >
> > > > > We recently had some reflection with Alex that this is redundant =
with
> > > > > the width and height in the OUTPUT format. It may also apply to s=
ome
> > > > > other fields in these structs. I feel like they should be removed=
 and
> > > > > passed via corresponding generic V4L2 properties - format, select=
ion,
> > > > > etc.
> > > > >
> > > > > The same problem is also present in the MPEG2 controls. In fact, =
there
> > > > > was a patch already which used some fields from the controls to
> > > > > calculate the destination buffer strides, rather than bytesperlin=
e in
> > > > > the format.
> > > > >
> > > > > Since we're in staging, it could be done with a follow-up patch, =
though.
> > > >
> > > > Just my two cents. I played with some codecs a while back. IIRC some
> > > > specify a "codec" size in addition to the actual picture size, like
> > > > when the encoder does padding to fit the requirements of the codec
> > > > (spec). Is this needed anywhere?
> > >
> > > With state-less encoders, the headers, which contains the crop
> > > information is created by userspace and for state less decoder, the
> > > headers that contains this information is parsed by userspace. So I
> > > believe that in theory, the accelerator does not strictly need to be
> > > aware of the cropped dimensions.
> > >
> > > Another thing, is that there is not guarantied matches between e.g.
> > > depth of the chrome/luma and the final image buffers. Some hardware m=
ay
> > > have bandwidth limitation or internal converter and could possibly
> > > decode 10bit data into 8bit buffers.
> > >
> > > A third reason why I would not try and encode this header information
> > > is that there can be multiple PPS/SPS at the same time, and I think
> > > it's confusing if the relevant information to differentiate them is
> > > removed.
> >
> > Sorry if that sounds a bit dumb, but it's not really clear to me if
> > you're arguing for the removal of the data as Tomasz suggests, or if
> > you want to keep them.
> >
> > The first paragrah seems to advocate for the former, but the two
> > others for the latter.
>
> I think the data should stay. As I said, there can be multiple SPS/PPS,
> while there is only one format. That being said, how does SPS/PPS
> activation works ? How do you tell the driver about all the SPS/PPS and
> which one is being activated ?

The current way of dealing with this is that the _SLICE_PARAMS control
actually takes an array of SPS's. And same thing for PPS.

There's no difference between activated and deactivated ones
though. What is the use case for this?

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gy5eppcjekdsrhyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK9j/QAKCRDj7w1vZxhR
xaYGAQCsc7VzPLi6Wez6KKZYGFulznMkEwVKTW7odXkXkgtCIwEAmJwWZjLVEXE4
EQyZH/dg/cuLi5H6A+QpU9SjLypRswE=
=TYHB
-----END PGP SIGNATURE-----

--gy5eppcjekdsrhyc--
