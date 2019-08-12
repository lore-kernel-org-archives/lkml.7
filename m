Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54917C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB3C206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfHLIOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:14:50 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43401 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfHLIOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:14:50 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 6446E20011;
        Mon, 12 Aug 2019 08:14:46 +0000 (UTC)
Date:   Mon, 12 Aug 2019 10:14:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH v8 0/4] Add support for Orange Pi 3
Message-ID: <20190812081445.kfsbikfrt3pmsh6d@flea>
References: <20190806155744.10263-1-megous@megous.com>
 <2218280.0sI6yjypBf@jernej-laptop>
 <CAGb2v67JVG2rhOdUwBmfsO0+RYb4DNOPmUo=Q_UhL3N+niLiEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wnuh5gs25vfqywb6"
Content-Disposition: inline
In-Reply-To: <CAGb2v67JVG2rhOdUwBmfsO0+RYb4DNOPmUo=Q_UhL3N+niLiEg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wnuh5gs25vfqywb6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2019 at 03:54:03PM +0800, Chen-Yu Tsai wrote:
> On Mon, Aug 12, 2019 at 3:45 PM Jernej =C5=A0krabec <jernej.skrabec@gmail=
=2Ecom> wrote:
> >
> > Dne torek, 06. avgust 2019 ob 17:57:39 CEST je megous@megous.com napisa=
l(a):
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > This series implements support for Xunlong Orange Pi 3 board. There
> > > are only a few patches remaining.
> > >
> > > - ethernet support - just a DT change (patch 1)
> > > - HDMI support (patches 2-4)
> > >
> > > For some people, ethernet doesn't work after reboot because u-boot do=
esn't
> > > support AXP805 PMIC, and will not turn off the etherent PHY regulator=
s.
> > > So the regulator controlled by gpio will be shut down, but the other =
one
> > > controlled by the AXP PMIC will not.
> > >
> > > This is a problem only when running with a builtin driver. This needs
> > > to be fixed in u-boot.
> > >
> > >
> > > Please take a look.
> >
> > Is there anything missing? It would be nice to get this in 5.4. There i=
s a lot
> > of H6 boards which needs DDC bus enable mechanism (part of H6 reference
> > design), including Beelink GS1 which already has HDMI node in mainline =
kernel
> > DT, but due to disabled DDC lines works only with 1024x768 (fallback
> > resolution in DRM core).
>
> I have a few minor comments about patch 1.
>
> I think the HDMI bits are good, but I don't have maintainership / commit
> permissions for drm-misc, so I'll have to wait until someone applies patc=
hes
> 2 and 3 before I apply patch 4.

I've applied 2,3 and 4

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wnuh5gs25vfqywb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVEf9QAKCRDj7w1vZxhR
xXlgAP9MFKL3iPUwZUiy1/l5hoQrktuJFTIedDN9ko3r/H6TDAD/RZg3u4WBh6O3
tteR/L/slzyHzMHsyD72abKseY8/IQE=
=i2m2
-----END PGP SIGNATURE-----

--wnuh5gs25vfqywb6--
