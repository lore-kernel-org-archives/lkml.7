Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E8C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCB52087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEPJxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:53:05 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:47143 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:53:05 -0400
Received: from localhost (unknown [80.215.244.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7D2D9240003;
        Thu, 16 May 2019 09:52:59 +0000 (UTC)
Date:   Thu, 16 May 2019 11:11:05 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v10 0/2] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
Message-ID: <20190516091105.er6oeyrnompwik3j@flea>
References: <20190512184128.13720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ce3qofktjm47bfnn"
Content-Disposition: inline
In-Reply-To: <20190512184128.13720-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ce3qofktjm47bfnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2019 at 12:11:25AM +0530, Jagan Teki wrote:
> This is v10 for the previous series[1] and few pathes are dropped
> as part of this series since it would require separate rework same
> will send in separately or another series.

APplied both, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ce3qofktjm47bfnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0pKQAKCRDj7w1vZxhR
xUFPAP9qQEmAom0RveVfdjeyYEidWvLU6MUme3eTHox9GhsoXQD6Aio7WpCJH0Hs
BM+RV1KwgBuakfuaClq/zq0ivu9hZgw=
=wdAl
-----END PGP SIGNATURE-----

--ce3qofktjm47bfnn--
