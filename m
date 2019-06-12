Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4410EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D88C20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfFMPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:15:20 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57299 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732226AbfFMNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:25:54 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1CBDAE0008;
        Thu, 13 Jun 2019 13:25:40 +0000 (UTC)
Date:   Wed, 12 Jun 2019 17:20:22 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Torsten Duwe <duwe@lst.de>, Harald Geyer <harald@ccbib.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190612152022.c3cfhp4cauhzhfyr@flea>
References: <20190604122150.29D6468B05@newverein.lst.de>
 <20190604122308.98D4868B20@newverein.lst.de>
 <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
 <20190605101317.GA9345@lst.de>
 <20190605120237.ekmytfxcwbjaqy3x@flea>
 <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
 <20190607062802.m5wslx3imiqooq5a@flea>
 <CGME20190607094103epcas1p4babbb11ec050974a62f2af79bc64d752@epcas1p4.samsung.com>
 <20190607094030.GA12373@lst.de>
 <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kbzg5qkkfku6tqsr"
Content-Disposition: inline
In-Reply-To: <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbzg5qkkfku6tqsr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2019 at 12:00:21PM +0200, Andrzej Hajda wrote:
> On 07.06.2019 11:40, Torsten Duwe wrote:
> > On Fri, Jun 07, 2019 at 08:28:02AM +0200, Maxime Ripard wrote:
> >> On Thu, Jun 06, 2019 at 03:59:27PM +0200, Harald Geyer wrote:
> >>> If think valid compatible properties would be:
> >>> compatible =3D "innolux,n116bge", "simple-panel";
> >>> compatible =3D "edp-connector", "simple-panel";
> >> A connector isn't a panel.
> >>
> >>> compatible =3D "innolux,n116bge", "edp-connector", "simple-panel";
> >> And the innolux,n116bge is certainly not a connector either.
> >>
> >>> compatible =3D "edp-connector", "innolux,n116bge", "simple-panel";
> >>>
> >>> I can't make up my mind which one I prefere. However neither of these
> >>> variants requires actually implmenting an edp-connector driver.
> >> No-one asked to do an edp-connector driver. You should use it in your
> >> DT, but if you want to have some code in your driver that parses the
> >> DT directly, I'm totally fine with that.
> > I must admit I fail to understand what that extra node would be good fo=
r.
> > Logically, the eDP far side is connected to the well-known n116bge.
> > Inside the laptop case it might as well be a flat ribbon cable or
> > soldered directly.
> > In good intention, that's all I wanted to express in the DT. I don't
> > know whether the relevant mechanical dimensions of the panel and the
> > connector are standardised, so whether one could in theory assemble it
> > with a different panel than the one it came with.
> >
> > OTOH, as I checked during the discussion with anarsoul, the panel's
> > supply voltage is permanently connected to the main 3.3V rail.
> > We already agreed that the eDP output port must not neccessarily be
> > specified, this setup is a good example why: because the panel is
> > always powered, the anx6345 can always pull valid EDID data from it
> > so at this stage there's no need for any OS driver to reach beyond
> > the bridge. IIRC even the backlight got switched off for the blank
> > screen without.
> >
> > All I wanted to say is that "there's usually an n116bge behind it";
> > but this is mostly redundant.
> >
> > So, shall we just drop the output port specification (along with the
> > panel node) in order to get one step further?
>
> I am not sure if I understand whole discussion here, but I also do not
> understand whole edp-connector thing.

The context is this one:
https://patchwork.freedesktop.org/patch/257352/?series=3D51182&rev=3D1
https://patchwork.freedesktop.org/patch/283012/?series=3D56163&rev=3D1
https://patchwork.freedesktop.org/patch/286468/?series=3D56776&rev=3D2

TL;DR: This bridge is being used on ARM laptops that can come with
different eDP panels. Some of these panels require a regulator to be
enabled for the panel to work, and this is obviously something that
should be in the DT.

However, we can't really describe the panel itself, since the vendor
uses several of them and just relies on the eDP bus to do its job at
retrieving the EDIDs. A generic panel isn't really working either
since that would mean having a generic behaviour for all the panels
connected to that bus, which isn't there either.

The connector allows to expose this nicely.

> According to VESA[1] eDP is "Internal display interface" - there is no
> external connector for eDP, the way it is connected is integrator's
> decision, but it is fixed - ie end user do not plug/unplug it.

I'm not sure if you mean DRM or DT connector here though. In DRM,
we're doing this all the time for panels. I'm literaly typing this
=66rom a laptop that has a screen with an eDP connector.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kbzg5qkkfku6tqsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQEYNgAKCRDj7w1vZxhR
xagZAP9+AZ8uzanMLNIT15MfMeCtszC85MU2JHwDCbzueao68wD/WPbzy8s2BkPf
pRPeI1xiny1h0ObfHZ8o1OdpRlKPHQg=
=nu8d
-----END PGP SIGNATURE-----

--kbzg5qkkfku6tqsr--
