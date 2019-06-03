Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5109C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 954D027C95
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfFCNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:49:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48875 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfFCNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:49:16 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6670A1BF205;
        Mon,  3 Jun 2019 13:49:08 +0000 (UTC)
Date:   Mon, 3 Jun 2019 15:49:07 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v10 09/11] drm/sun4i: sun6i_mipi_dsi: Add VCC-DSI
 regulator support
Message-ID: <20190603134907.lh5rdpucbrzrsdps@flea>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
 <20190520090318.27570-10-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2trpzmkxqvxmxm5n"
Content-Disposition: inline
In-Reply-To: <20190520090318.27570-10-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2trpzmkxqvxmxm5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 02:33:16PM +0530, Jagan Teki wrote:
> Allwinner MIPI DSI controllers are supplied with SoC
> DSI power rails via VCC-DSI pin.
>
> Add support for this supply pin by adding voltage
> regulator handling code to MIPI DSI driver.
>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

This creates a lot of warnings at boot time on my board this is
missing vcc-dsi-supply.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2trpzmkxqvxmxm5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPUlUwAKCRDj7w1vZxhR
xSZ5AP43IgKaIr/p5/Gjo6oF9Ue3I+oWwJZbLyNFgh2oN9mw1QEA6PQIqgMXkKM4
cIW0qgxT/pqGVx3/w7T2Q9HObKfCpgI=
=aqhG
-----END PGP SIGNATURE-----

--2trpzmkxqvxmxm5n--
