Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF87C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E84628012
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfFCMOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:14:04 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53789 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfFCMOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:14:03 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 970BC60004;
        Mon,  3 Jun 2019 12:13:45 +0000 (UTC)
Date:   Mon, 3 Jun 2019 14:13:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     paul.kocialkowski@bootlin.com, wens@csie.org, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] media: cedrus: Remove dst_bufs from context
Message-ID: <20190603121345.5uh4xquo64fopqnn@flea>
References: <20190530211516.1891-1-jernej.skrabec@siol.net>
 <20190530211516.1891-5-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hwwfrxwoaemzsp3p"
Content-Disposition: inline
In-Reply-To: <20190530211516.1891-5-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hwwfrxwoaemzsp3p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2019 at 11:15:13PM +0200, Jernej Skrabec wrote:
> This array is just duplicated capture buffer queue. Remove it and adjust
> code to look into capture buffer queue instead.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hwwfrxwoaemzsp3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPUO+QAKCRDj7w1vZxhR
xY1uAP9hH5O7WjfeV/BXsKPStm23IM1ZX1gwoL+bHz6M1yQBjwD+NvJ/2aWqWf8f
R+ArhaQDIa5EhvE33GmymyMWU6/RpQc=
=Hu9G
-----END PGP SIGNATURE-----

--hwwfrxwoaemzsp3p--
