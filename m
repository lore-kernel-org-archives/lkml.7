Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0CDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94CD214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDDHct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:32:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49299 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:32:48 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4AB3D1C000F;
        Thu,  4 Apr 2019 07:32:46 +0000 (UTC)
Date:   Thu, 4 Apr 2019 09:32:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: sunxi-ng: H6 related clock fixes
Message-ID: <20190404073245.ql7qnind4oxmp6t3@flea>
References: <20190403151404.26542-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qot2ytx7br4g6d22"
Content-Disposition: inline
In-Reply-To: <20190403151404.26542-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qot2ytx7br4g6d22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 05:14:02PM +0200, Jernej Skrabec wrote:
> During linux-next testing on Allwinner H6, I found several issues with
> clock driver. This patch series fixes them.
>
> Patch 1 allows video and vpu related clocks to set parent rate.
> Patch 2 adds a comment with short explanation why zero width check is
> needed.

Applied both, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qot2ytx7br4g6d22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKWzHQAKCRDj7w1vZxhR
xSHhAQCwC5Cv8J55Jo4wFRF8Dw5qW46cNd89HthqB7KqgAadAwD8C7YeoAXhzkls
1kpw8ccV1gD2k/TaWWh2Nm//UrhSQQ0=
=Je6v
-----END PGP SIGNATURE-----

--qot2ytx7br4g6d22--
