Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C836FC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CB3217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfDEIoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:44:30 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:47121 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfDEIoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:44:30 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4FC9F20002;
        Fri,  5 Apr 2019 08:44:26 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:44:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     airlied@linux.ie, daniel@ffwll.ch, wens@csie.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: DW HDMI: Lower max. supported rate for H6
Message-ID: <20190405084425.4sngy4gj76xogcuw@flea>
References: <20190324190609.32721-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m5sooy2nv6a3cvie"
Content-Disposition: inline
In-Reply-To: <20190324190609.32721-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m5sooy2nv6a3cvie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 24, 2019 at 08:06:09PM +0100, Jernej Skrabec wrote:
> Currently resolutions with pixel clock higher than 340 MHz don't work
> with H6 HDMI controller. They just produce a blank screen.
>
> Limit maximum pixel clock rate to 340 MHz until scrambling is supported.
>
> Cc: stable@vger.kernel.org # 5.0
> Fixes: 40bb9d3147b2 ("drm/sun4i: Add support for H6 DW HDMI controller")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!

(And sorry for the delay)

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m5sooy2nv6a3cvie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcVaQAKCRDj7w1vZxhR
xQqCAP9TJaJUMU3+xc3UHB2Ral4XWe4x+9Q4+A5FgalHfmqqWAD/YEoqpyw8eK2A
qcFKlOFJJqQn2sDexwFMNr+5w50M4gU=
=V1h4
-----END PGP SIGNATURE-----

--m5sooy2nv6a3cvie--
