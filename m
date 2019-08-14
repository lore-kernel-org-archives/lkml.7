Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F69CC0650F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D29C208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565763442;
	bh=h2Zmuq1LzTEeDVfRxuk635BAG8HwjEFsXKfbcLtx4qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tmT3Iu5u1Rp5xaOzM6a/ctAbOB6B8rTFOI8es+skCco1uyrOfRvu+Lof19UDqNNh1
	 00XianvkcE53irwA/q/ne21ydO82IyvjFLI2muYWA8NwHpv7fLnWRUuSU7VvtW0TRk
	 92FXFR0L0yAw93huvnyOgQmayoo4z0F2HeT0NHF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfHNGRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 02:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:17:20 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CCBF208C2;
        Wed, 14 Aug 2019 06:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565763439;
        bh=h2Zmuq1LzTEeDVfRxuk635BAG8HwjEFsXKfbcLtx4qA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjIf6IYYK3XD0qhY4dWTgaz08i4vPb0oCS7yDb8DUiQXXCKW4u27PtNeMAmi6DS0Q
         /1FvUfCfsn/mKzfRCXWUxzuwMnT06sCQUHrRnDNWWqtqQ0qPkLewBL4ZGTicqJxdUA
         oOmBqSgqlTYbHiwF95rB3yxemzEn/TQ7B7jzHmlA=
Date:   Wed, 14 Aug 2019 08:17:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: Add mdio bus sub-node to GMAC
Message-ID: <20190814061717.54uuat3cypxjucfq@flea>
References: <20190814042208.9646-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ca47qifq3uyu2lgr"
Content-Disposition: inline
In-Reply-To: <20190814042208.9646-1-wens@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ca47qifq3uyu2lgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 12:22:08PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> The DWMAC binding never supported having the Ethernet PHY node as a
> direct child to the controller, nor did it support the "phy" property
> as a way to specify which Ethernet PHY to use. What seemed to work
> was simply the implementation ignoring the "phy" property and instead
> probing all addresses on the MDIO bus and using the first available
> one.
>
> The recent switch from "phy" to "phy-handle" breaks the assumptions
> of the implementation, and does not match what the binding requires.
> The binding requires that if an MDIO bus is described, it shall be
> a sub-node with the "snps,dwmac-mdio" compatible string.
>
> Add a device node for the MDIO bus, and move the Ethernet PHY node
> under it. Also fix up the #address-cells and #size-cells properties
> where needed.
>
> Fixes: de332de26d19 ("ARM: dts: sunxi: Switch from phy to phy-handle")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ca47qifq3uyu2lgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVOnbQAKCRDj7w1vZxhR
xdDUAQCnpVdT3KpOHMNy0ph4E404oIUBtZ6WuuLwZ9M2kNjwgQEAlByupn0xScxl
omeoaNbOWFWe22TFHJ0najT2LdaC2Q0=
=LPlq
-----END PGP SIGNATURE-----

--ca47qifq3uyu2lgr--
