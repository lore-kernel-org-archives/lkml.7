Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EFC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE77120857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDIHzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:55:43 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39879 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:55:42 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id EF6D61C000D;
        Tue,  9 Apr 2019 07:55:39 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:55:39 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 4/6] dt-bindings: arm: sunxi: Add Beelink GS1 board
Message-ID: <20190409075539.td5c6utktqsnxknn@flea>
References: <20190408152755.17405-1-peron.clem@gmail.com>
 <20190408152755.17405-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4f3icf7t5cp44c7g"
Content-Disposition: inline
In-Reply-To: <20190408152755.17405-5-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4f3icf7t5cp44c7g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:27:53PM +0200, Cl=E9ment P=E9ron wrote:
> Beelink GS1 device-tree has been introduced.
>
> Add it to the sunxi yaml documentation.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4f3icf7t5cp44c7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxP+wAKCRDj7w1vZxhR
xSjEAQC3jlcFMiZqldSMXOIrZnldWbM/6HnVF5qag2xWn1QshAD0Dfkn82KRQI1j
xKaFdy6AWx+BTI3RFM+n0GfoWMsiCA==
=Zesj
-----END PGP SIGNATURE-----

--4f3icf7t5cp44c7g--
