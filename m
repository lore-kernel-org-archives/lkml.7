Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840A8C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4112084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfDCHyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:54:23 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:39287 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:54:22 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E257610000F;
        Wed,  3 Apr 2019 07:54:19 +0000 (UTC)
Date:   Wed, 3 Apr 2019 09:54:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: sunxi-ng: h6: Preset hdmi-cec clock parent
Message-ID: <20190403075419.h2vvfiyzvq6xa2zs@flea>
References: <20190402210623.14988-1-jernej.skrabec@siol.net>
 <20190402210623.14988-3-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zyc6rapvptieglms"
Content-Disposition: inline
In-Reply-To: <20190402210623.14988-3-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zyc6rapvptieglms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 11:06:22PM +0200, Jernej Skrabec wrote:
> H6 manual and BSP clock driver both states that hdmi-cec clock has two
> possible parents, osc32k and pll-periph0-2x with 36621 predivider.
> Because pll-periph0-2x is always 1.2 GHz, both parents give same
> hdmi-cec rate - 32768 Hz, which is exactly the rate needed for HDMI CEC
> controller to operate correctly.
>
> However, for some reason, HDMI CEC controller doesn't work if default
> parent (osc32k) is used. BSP HDMI driver also always use pll-periph0-2x
> as hdmi-cec clock parent.
>
> In order to solve the issue, preset hdmi-cec clock parent to
> pll-periph0-2x.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zyc6rapvptieglms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKRmqwAKCRDj7w1vZxhR
xdm1AP9q79xxI5qd+mqALxTOHhyUITejVi0RD2++HTuCCfl+twEAp0HN7gcion4t
qxqa7GnCZirrn51qfwHoLWwcdB/1QgI=
=0VJJ
-----END PGP SIGNATURE-----

--zyc6rapvptieglms--
