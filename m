Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0523C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC6B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfCAO7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:59:33 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52167 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfCAO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:59:32 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6B1221BF205;
        Fri,  1 Mar 2019 14:59:22 +0000 (UTC)
Date:   Fri, 1 Mar 2019 15:59:21 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/3] drm/sun4i: DE2/DE3 improvements
Message-ID: <20190301145921.ryjofwp57pjp2g4n@flea>
References: <20190228200329.11128-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o67vu2kehd2mya23"
Content-Disposition: inline
In-Reply-To: <20190228200329.11128-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o67vu2kehd2mya23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 09:03:26PM +0100, Jernej Skrabec wrote:
> DE2 and DE3 VI channels support coarse scaling to overcome VI scaler
> limitations. That is especially useful for downscaling big planes, for
> example 4K to 1080p.
>=20
> Following patches were tested on H3 and A64 with 4K video playback on
> 1080p monitor. Without them, picture was mangled.

Applied all three, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o67vu2kehd2mya23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHlIyQAKCRDj7w1vZxhR
xYG+AP9iLLcbwXEwM8zyrIWZ5tcWSKUgSoyzfkbEhkRHC2N9LgEAxZRs9QHcItao
X92rxXy9o8yEn/c3kX6K2V9JTPnQwAQ=
=YUrS
-----END PGP SIGNATURE-----

--o67vu2kehd2mya23--
