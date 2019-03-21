Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B7BC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F9218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfCUJBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:01:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47755 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfCUJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:01:24 -0400
Received: from localhost (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E6987100011;
        Thu, 21 Mar 2019 09:01:20 +0000 (UTC)
Date:   Thu, 21 Mar 2019 10:01:19 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a64: Rename hpvcc-supply to
 cpvdd-supply
Message-ID: <20190321090119.5h7migh5wkn6yswx@flea>
References: <20190213070457.26049-1-wens@csie.org>
 <20190213070457.26049-3-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n64t5b7k22uirwh2"
Content-Disposition: inline
In-Reply-To: <20190213070457.26049-3-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n64t5b7k22uirwh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 13, 2019 at 03:04:57PM +0800, Chen-Yu Tsai wrote:
> The A64 datasheet lists the supply rail for the headphone amp's charge
> pump as "CPVDD". cpvdd-supply is the name of the property for this power
> rail specified in the device tree bindings. "HPVCC" was the name used in
> the A33 datasheet for the same function.
>
> Rename the supply so it matches the datasheet and bindings.
>
> Fixes: c56689e6f2fb ("arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec")
> Fixes: 6de8e717848f ("arm64: dts: allwinner: a64: enable sound on Pinebook")
> Fixes: 498c21f233ed ("arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n64t5b7k22uirwh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJNS3wAKCRDj7w1vZxhR
xd4BAQC3OfWiNhqIT3mNFcGAP6K5qKIFrd2+8d/6TXKKc5HX9wEA6XM3z4VSgj0t
Ydn+HXBIkiBB56H8BTR1DrBQHANk/wU=
=7C23
-----END PGP SIGNATURE-----

--n64t5b7k22uirwh2--
