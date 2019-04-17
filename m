Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14EC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A1E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfDQKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:19:51 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:46387 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:19:50 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0DAFFFF805;
        Wed, 17 Apr 2019 10:19:47 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:19:47 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ARM: dts: sun8i: v40: bananapi-m2-berry: Enable
 GMAC ethernet controller
Message-ID: <20190417101947.xzper4dbxo4c7vyj@flea>
References: <1555492863-88860-1-git-send-email-pgreco@centosproject.org>
 <1555492863-88860-4-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j4bmablfkqbqicv6"
Content-Disposition: inline
In-Reply-To: <1555492863-88860-4-git-send-email-pgreco@centosproject.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j4bmablfkqbqicv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 06:20:58AM -0300, Pablo Greco wrote:
>  &pio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&clk_out_a_pin>;
> +	vcc-pa-supply = <&reg_aldo2>;
> +	vcc-gmac-phy-supply = <&reg_dc1sw>;
> +};

The PIO banks regulators addition should be in a separate
patch. Otherwise, the comments I made on patch 1 still apply.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--j4bmablfkqbqicv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLb9wwAKCRDj7w1vZxhR
xaIHAQDQ/ONMmRBC3c1zkHKtMQeae6A7lSkoskRooLq9UrKeKwD9GNGkDKlP+iQi
rK6MT7q85A8Yo1+/zc25lhZuwhAfUgk=
=sYtA
-----END PGP SIGNATURE-----

--j4bmablfkqbqicv6--
