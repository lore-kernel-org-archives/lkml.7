Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DCEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5CE20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfDIHzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:55:00 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46375 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:55:00 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 531331C0012;
        Tue,  9 Apr 2019 07:54:57 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:54:56 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 3/6] arm64: dts: allwinner: h6: Introduce Beelink GS1
 board
Message-ID: <20190409075456.3nnxjycrb43ngqlt@flea>
References: <20190408152755.17405-1-peron.clem@gmail.com>
 <20190408152755.17405-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3vfle6nyotxje3bd"
Content-Disposition: inline
In-Reply-To: <20190408152755.17405-4-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3vfle6nyotxje3bd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:27:52PM +0200, Cl=E9ment P=E9ron wrote:
> Beelink GS1 is an Allwinner H6 based TV box,
> which support:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 2GB LPDDR3 RAM
> - AXP805 PMIC
> - 1Gbps GMAC via RTL8211E
> - FN-Link 6222B-SRB Wifi/BT
> - 1x USB 2.0 Host and 1x USB 3.0 Host
> - HDMI port
> - S/PDIF Tx
> - IR receiver
> - 5V/2A DC power supply
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3vfle6nyotxje3bd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxP0AAKCRDj7w1vZxhR
xfd0AP9h7c4tuoUPJwyFRo07J0Tp5gh7bH2WuAf1bmY7P2rxTQD+JbqfAXImZzjc
si9fXW5bD1fVOIdyV6o3+WVvwDGEswQ=
=eRJr
-----END PGP SIGNATURE-----

--3vfle6nyotxje3bd--
