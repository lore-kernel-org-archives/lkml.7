Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E05C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A1E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFQLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:45:17 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:51187 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfFQLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:45:17 -0400
X-Originating-IP: 90.88.23.150
Received: from localhost (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 569CD4000D;
        Mon, 17 Jun 2019 11:45:04 +0000 (UTC)
Date:   Mon, 17 Jun 2019 13:45:03 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register clock gates in probe
Message-ID: <20190617114503.pclqsf6bo3ih47nt@flea>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xp6yljizo7kvgkxb"
Content-Disposition: inline
In-Reply-To: <20190614164324.9427-6-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xp6yljizo7kvgkxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> TCON TOP have clock gates for TV0, TV1, dsi and right
> now these are register during bind call.
>
> Of which, dsi clock gate would required during DPHY probe
> but same can miss to get since tcon top is not bound at
> that time.
>
> To solve, this circular dependency move the clock gate
> registration from bind to probe so-that DPHY can get the
> dsi gate clock on time.

It's not really clear to me what the circular dependency is?

if you have a chain that is:

tcon-top +-> DSI
         +-> D-PHY

There's no loop, right?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xp6yljizo7kvgkxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQd9PwAKCRDj7w1vZxhR
xQVoAP9ttJDwkjwRPMkOwKzqZRD7nZXrcU8a7rson89BVm0nsgEA4p4DLpSvch57
JKorQlZPylei2HZiG2eUjBHTxqK0tAo=
=b7B3
-----END PGP SIGNATURE-----

--xp6yljizo7kvgkxb--
