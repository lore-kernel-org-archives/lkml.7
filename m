Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4AC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257E92073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfDQKSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:18:01 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33761 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:18:01 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 107A5FF803;
        Wed, 17 Apr 2019 10:17:57 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:17:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ARM: dts: sun8i: r40: bananapi-m2-ultra: Tie GMAC
 regulators to the PIO
Message-ID: <20190417101757.traviffiulwnzr6x@flea>
References: <1555492863-88860-1-git-send-email-pgreco@centosproject.org>
 <1555492863-88860-2-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdmpm7svpq5cq27l"
Content-Disposition: inline
In-Reply-To: <1555492863-88860-2-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdmpm7svpq5cq27l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Apr 17, 2019 at 06:20:56AM -0300, Pablo Greco wrote:
> When the GMAC support was added to the bananapi-m2-ultra, regulators
> weren't tied to the pinctrl. Fix that.
>
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index c488aaa..3da3598 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -201,6 +201,8 @@
>  &pio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&clk_out_a_pin>;
> +	vcc-pa-supply = <&reg_aldo2>;

You should list all the regulators that are needed for all the pin
banks to operate properly, not just PA

> +	vcc-gmac-phy-supply = <&reg_dc1sw>;

I'm not sure what that is supposed to do?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fdmpm7svpq5cq27l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLb9VQAKCRDj7w1vZxhR
xf8xAP9/tBCV3pqWsdx40Wbj9v3n+77u5fjcUOjSXXpFHqRjvgD/V7U+fC3LiZK5
hhmuRwxUo1vmChUUFEH6SV+U/YsaHwg=
=DIQ/
-----END PGP SIGNATURE-----

--fdmpm7svpq5cq27l--
