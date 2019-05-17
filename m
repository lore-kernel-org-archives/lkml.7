Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22806C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD04204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfEQKMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:12:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:37968 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfEQKMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:12:48 -0400
X-Greylist: delayed 7493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 06:12:47 EDT
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A559B3A3615;
        Fri, 17 May 2019 07:27:50 +0000 (UTC)
X-Originating-IP: 80.215.154.25
Received: from localhost (unknown [80.215.154.25])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4AABB2000F;
        Fri, 17 May 2019 07:27:39 +0000 (UTC)
Date:   Fri, 17 May 2019 09:27:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] arm64: DTS: allwinner: a64: enable ANX6345 bridge on
 Teres-I
Message-ID: <20190517072738.deohh5fly4jxms7k@flea>
References: <20190514155911.6C0AC68B05@newverein.lst.de>
 <20190514160241.9EAC768C7B@newverein.lst.de>
 <CA+E=qVfuKBzWK7dpM_eabjU8mLdzOw3zCnYk6Tc1oXdavH7CNA@mail.gmail.com>
 <20190515093141.41016b11@blackhole.lan>
 <CA+E=qVf6K_0T0x2Hsfp6EDqM-ok6xiAzeZPvp6SRg0yt010pKA@mail.gmail.com>
 <20190516154820.GA10431@lst.de>
 <CA+E=qVe5NkAvHXPvVc7iTbZn5sKeoRm0166zPW_s83c2gk7B+g@mail.gmail.com>
 <20190516164859.GB10431@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f4mha6snzgf75knu"
Content-Disposition: inline
In-Reply-To: <20190516164859.GB10431@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f4mha6snzgf75knu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 06:48:59PM +0200, Torsten Duwe wrote:
> On Thu, May 16, 2019 at 09:06:41AM -0700, Vasily Khoruzhick wrote:
> >
> > Driver can talk to the panel over AUX channel only after t1+t3, t1 is
> > up to 10ms, t3 is up to 200ms.
>
> This is after power-on. The boot loader needs to deal with this.

The bootloader can deal with it, but the kernel will also need to. The
bootloader might not be doing this because it's not been updated, the
regulator might have been disabled between the time the kernel was
started and the time the bridge driver probes, etc.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f4mha6snzgf75knu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5iagAKCRDj7w1vZxhR
xSOTAQCltYqEUg7d+BcEgl5RN6diNU5EHsL/qXA4yAy1FZI9NwD/epfnmdGcVWie
o0KQWW6HOXO96Su1afZmNzHrEtQffwQ=
=zj1P
-----END PGP SIGNATURE-----

--f4mha6snzgf75knu--
