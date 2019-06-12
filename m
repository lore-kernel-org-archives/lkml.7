Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C83C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E00E20449
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfFMPPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:15:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47179 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732230AbfFMN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:26:03 -0400
X-Originating-IP: 90.88.159.246
Received: from localhost (aaubervilliers-681-1-40-246.w90-88.abo.wanadoo.fr [90.88.159.246])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B10E040003;
        Thu, 13 Jun 2019 13:25:51 +0000 (UTC)
Date:   Wed, 12 Jun 2019 17:34:23 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Harald Geyer <harald@ccbib.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
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
Message-ID: <20190612153423.jjcxsturjip3pn56@flea>
References: <20190604122150.29D6468B05@newverein.lst.de>
 <20190604122308.98D4868B20@newverein.lst.de>
 <CA+E=qVckHLqRngsfK=AcvstrD0ymEfRkYyhS_kBtZ3YWdE3L=g@mail.gmail.com>
 <20190605101317.GA9345@lst.de>
 <20190605120237.ekmytfxcwbjaqy3x@flea>
 <E1hYsvP-0000PY-Pz@stardust.g4.wien.funkfeuer.at>
 <20190607062802.m5wslx3imiqooq5a@flea>
 <20190607094030.GA12373@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l4e2w5m2mlsciqb7"
Content-Disposition: inline
In-Reply-To: <20190607094030.GA12373@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l4e2w5m2mlsciqb7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2019 at 11:40:30AM +0200, Torsten Duwe wrote:
> On Fri, Jun 07, 2019 at 08:28:02AM +0200, Maxime Ripard wrote:
> > On Thu, Jun 06, 2019 at 03:59:27PM +0200, Harald Geyer wrote:
> > >
> > > If think valid compatible properties would be:
> > > compatible = "innolux,n116bge", "simple-panel";
> > > compatible = "edp-connector", "simple-panel";
> >
> > A connector isn't a panel.
> >
> > > compatible = "innolux,n116bge", "edp-connector", "simple-panel";
> >
> > And the innolux,n116bge is certainly not a connector either.
> >
> > > compatible = "edp-connector", "innolux,n116bge", "simple-panel";
> > >
> > > I can't make up my mind which one I prefere. However neither of these
> > > variants requires actually implmenting an edp-connector driver.
> >
> > No-one asked to do an edp-connector driver. You should use it in your
> > DT, but if you want to have some code in your driver that parses the
> > DT directly, I'm totally fine with that.
>
> I must admit I fail to understand what that extra node would be good for.
> Logically, the eDP far side is connected to the well-known n116bge.
> Inside the laptop case it might as well be a flat ribbon cable or
> soldered directly.
> In good intention, that's all I wanted to express in the DT. I don't
> know whether the relevant mechanical dimensions of the panel and the
> connector are standardised, so whether one could in theory assemble it
> with a different panel than the one it came with.

Because the panel that comes with the Teres-I is always the
same. However, that's not true for all the devices out there using the
bridge, starting with the pinebook.

> OTOH, as I checked during the discussion with anarsoul, the panel's
> supply voltage is permanently connected to the main 3.3V rail.

Again, that may be the case on the Teres-I, but not necessarily on
other boards.

> We already agreed that the eDP output port must not neccessarily be
> specified, this setup is a good example why: because the panel is
> always powered, the anx6345 can always pull valid EDID data from it
> so at this stage there's no need for any OS driver to reach beyond
> the bridge. IIRC even the backlight got switched off for the blank
> screen without.

That's not really the outcome of the discussion we had here though:
https://patchwork.freedesktop.org/patch/305035/

> All I wanted to say is that "there's usually an n116bge behind it";
> but this is mostly redundant.
>
> So, shall we just drop the output port specification (along with the
> panel node) in order to get one step further?

Depending on the outcome of the discussion above, yes or no :)

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--l4e2w5m2mlsciqb7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQEbfwAKCRDj7w1vZxhR
xXboAP9taP8cVAug0AmgG1n+5b7orZtPN+yeWqkQV/4rx6fcdgD3Tma8ZrLudyMc
SNeQDRS8FMpPCWr42VcLCNdIMRk6CA==
=j/Ze
-----END PGP SIGNATURE-----

--l4e2w5m2mlsciqb7--
