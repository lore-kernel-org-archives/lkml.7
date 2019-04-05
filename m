Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18526C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E1821852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfDEPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45205 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:03 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7FC606000C;
        Fri,  5 Apr 2019 15:11:00 +0000 (UTC)
Date:   Fri, 5 Apr 2019 17:11:00 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 5/5] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
Message-ID: <20190405151100.jjjg55z7sg35ijxw@flea>
References: <20190405122446.2101-1-peron.clem@gmail.com>
 <20190405122446.2101-5-peron.clem@gmail.com>
 <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vydzdtbzehqip32c"
Content-Disposition: inline
In-Reply-To: <CAJiuCcfbnR+Jfj8Je_4HwgycCBEe92sx6zqwqgXpeiMe2jKL-Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vydzdtbzehqip32c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 02:53:35PM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>
> Adding this r_pio regulators make a new error in the bootlog :
>
> [    0.346843] sun50i-h6-r-pinctrl 7022000.pinctrl: Couldn't get bank
> PL regulator
> [    0.346853] sun50i-h6-r-pinctrl 7022000.pinctrl: request() failed for =
pin 352
> [    0.346862] sun50i-h6-r-pinctrl 7022000.pinctrl: pin-352
> (7081400.i2c) status -517
> [    0.346871] sun50i-h6-r-pinctrl 7022000.pinctrl: could not request
> pin 352 (PL0) from group PL0  on device 7022000.pinctrl
> [    0.346878] mv64xxx_i2c 7081400.i2c: Error applying setting,
> reverse things back
>
> PL0 and PL1 are SCK/SDA for the PMIC :(

How was this DT tested then?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vydzdtbzehqip32c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKdwBAAKCRDj7w1vZxhR
xRckAP4wZ46tgKZYKDJhYKIgcd4LHvEUq6BNr/w1FqxiVL6TswEA6p6RUzr55f9c
tpfmanzizb77MMjF9zA6P9bPohY6EgM=
=3hKq
-----END PGP SIGNATURE-----

--vydzdtbzehqip32c--
