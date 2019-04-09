Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C59EC282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE620651
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDIH5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:57:15 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33275 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIH5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:57:14 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D36E610001B;
        Tue,  9 Apr 2019 07:57:09 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:57:09 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH 1/6] clk: sunxi-ng: a83t: Add pll-video0 as parent of
 csi-mclk
Message-ID: <20190409075709.mdh62rdpiqmcfjmc@flea>
References: <20190408165744.11672-1-wens@kernel.org>
 <20190408165744.11672-2-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljfwd3xjzjevfhm6"
Content-Disposition: inline
In-Reply-To: <20190408165744.11672-2-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ljfwd3xjzjevfhm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 09, 2019 at 12:57:39AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Allwinner's BSP for the A83T lists pll-video0 as the first parent to
> csi-mclk with index 0. This parent is not listed in the datasheet, but
> actually works, and makes more sense considering the index is the
> default value out of reset.
>
> Add pll-video0 as a parent to csi-mclk with index 0.
>
> Fixes: 05359be1176b ("clk: sunxi-ng: Add driver for A83T CCU")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ljfwd3xjzjevfhm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxQVQAKCRDj7w1vZxhR
xW9UAP9bCO7liBbWiegGWBL/zx+00RNayMeVqwJyb5qxd4gVYQD+O39nkEH/FRKA
iV3T3zEzgmfYwY3zYDTskH6Zyg6Kzgg=
=URzt
-----END PGP SIGNATURE-----

--ljfwd3xjzjevfhm6--
