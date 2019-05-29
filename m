Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF73C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB2D21019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE2HY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:24:27 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52793 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2HY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:24:26 -0400
X-Originating-IP: 90.88.147.134
Received: from localhost (aaubervilliers-681-1-27-134.w90-88.abo.wanadoo.fr [90.88.147.134])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 375D31C000C;
        Wed, 29 May 2019 07:24:24 +0000 (UTC)
Date:   Wed, 29 May 2019 09:24:23 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [RESEND PATCH] ARM: dts: sun7i: olimex-lime2:
 Enable ac and power supplies
Message-ID: <20190529072423.5wg5lejgy3ece77i@flea>
References: <20190528063544.17408-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqgbfzxuw6hkna6w"
Content-Disposition: inline
In-Reply-To: <20190528063544.17408-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqgbfzxuw6hkna6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 09:35:44AM +0300, Priit Laes wrote:
> Lime2 has battery connector so enable these supplies.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--bqgbfzxuw6hkna6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXO4zpwAKCRDj7w1vZxhR
xYGHAQCFpruzYdm052STiAsBGpDwgCbHAlK1s6j7Dla6ESbgYAEAglb2c7bgVX0p
vF9PXHhhe2aWbVr7yMHMmmiU53akGwY=
=88nu
-----END PGP SIGNATURE-----

--bqgbfzxuw6hkna6w--
