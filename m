Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E39C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584D220857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDIHyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:54:17 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55819 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDIHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:54:16 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1E2801C0008;
        Tue,  9 Apr 2019 07:54:12 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:54:12 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/6] dt-bindings: vendor-prefixes: add AZW
Message-ID: <20190409075412.zgwysgxy7ul3naut@flea>
References: <20190408152755.17405-1-peron.clem@gmail.com>
 <20190408152755.17405-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hlppgnemfbfukzcl"
Content-Disposition: inline
In-Reply-To: <20190408152755.17405-3-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hlppgnemfbfukzcl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:27:51PM +0200, Cl=E9ment P=E9ron wrote:
> Shenzhen AZW Technology Co. Ltd. is a manufacturer specialized in Android
> smart TV boxes, Intel mini PCs and home cloud TV boxes with NAS.
>
> Add the vendor prefix for AZW.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hlppgnemfbfukzcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKxPpAAKCRDj7w1vZxhR
xRxuAP9u8cxGxCGDABZ/l73QHO5o5IQuvztvtrhHFi4c1Z7sNgD+MX+PabulAl2c
/KBx54BLXBs9GOwq/pKa1F6Zp+Jpxgg=
=lGHZ
-----END PGP SIGNATURE-----

--hlppgnemfbfukzcl--
