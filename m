Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FDC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17631205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731614AbfETIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:52:50 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:44920 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfETIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:52:49 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id ED9383A6B9B;
        Mon, 20 May 2019 08:10:05 +0000 (UTC)
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5533010000C;
        Mon, 20 May 2019 08:09:42 +0000 (UTC)
Date:   Mon, 20 May 2019 10:09:42 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Torsten Duwe <duwe@lst.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: DTS: allwinner: a64: Enable audio on
 Teres-I
Message-ID: <20190520080942.s27zv6yfv2zo5tc3@flea>
References: <20190516154943.239E668B05@newverein.lst.de>
 <20190516155139.E6EE568C65@newverein.lst.de>
 <CAGb2v64xKk1r1iqSVm5pVvHVkyQ175MUFB7JPUkvQX9ecOZDDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4whjn4knj7qddsth"
Content-Disposition: inline
In-Reply-To: <CAGb2v64xKk1r1iqSVm5pVvHVkyQ175MUFB7JPUkvQX9ecOZDDQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4whjn4knj7qddsth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 03:56:13PM +0800, Chen-Yu Tsai wrote:
> On Thu, May 16, 2019 at 11:52 PM Torsten Duwe <duwe@lst.de> wrote:
> >
> > From: Harald Geyer <harald@ccbib.org>
> >
> > The TERES-I has internal speakers (left, right), internal microphone
> > and a headset combo jack (headphones + mic), "CTIA" (android) pinout.
> >
> > The headphone and mic detect lines of the A64 are connected properly,
> > but AFAIK currently unsupported by the driver.
> >
> > Signed-off-by: Harald Geyer <harald@ccbib.org>
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> Looks good to me.
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4whjn4knj7qddsth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOJgxgAKCRDj7w1vZxhR
xbSXAP926FlqO6XCiMyZJenTVBmpT/A0W2UCps/VqpRJuj0aagD/exOJs05ag5un
BMT9ii0aqMgO8x6CqBc2f5EQ6uIRagg=
=Md6e
-----END PGP SIGNATURE-----

--4whjn4knj7qddsth--
