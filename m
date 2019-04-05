Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D232D21872
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfDEJCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:02:40 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:36685 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfDEJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:02:40 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 72C541BF20F;
        Fri,  5 Apr 2019 09:02:37 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:02:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: h6: Add watchdog node
Message-ID: <20190405090236.e7vnyjzxmzfke3d6@flea>
References: <20190404135736.8491-1-peron.clem@gmail.com>
 <20190404135736.8491-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i56aap7rd27nepk5"
Content-Disposition: inline
In-Reply-To: <20190404135736.8491-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i56aap7rd27nepk5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 03:57:36PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 has a watchog compatible with A31.
>
> Declare it in the device tree.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Applied both, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--i56aap7rd27nepk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcZrAAKCRDj7w1vZxhR
xR3gAQCY34vjcxADWfQ5Z+C5SPwkNCFOKEOyZ3eDzZ06nzHLqgD/cSvE0x/VcobX
Et3afjWV59FzQcZonl7nzBDoAnQc6AM=
=Ryow
-----END PGP SIGNATURE-----

--i56aap7rd27nepk5--
