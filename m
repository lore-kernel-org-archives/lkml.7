Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EB4C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FD8215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300977;
	bh=kpTNuRYCk4/MMIP5zsVxzA3Jsb92H4wI/aZ9O1ah6CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d97o293ocj+DcmeX6NlnISFMkea2WxyrwW/gHiENH+O8qLMWomnhTIoDFucCFJe6o
	 tXi7ScYq4xs672G+BYQhvLsCQvjA0xhygpj1ya2oZxrvoqgfrYBdO0FKkcWIMLig0L
	 YNVm89qucp+7F22VnQW4mOg5hHITC58PctYNQsBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAFI4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgAFI4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:56:16 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D55420848;
        Mon,  6 Jan 2020 08:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300975;
        bh=kpTNuRYCk4/MMIP5zsVxzA3Jsb92H4wI/aZ9O1ah6CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sC1b4Pa8E10HnPtzFhJ0HR0m4DD2dXzD4mV0T3hAdPMy2isKO4ODDPj3N1qr0c9Pf
         iMNr5g1sSbA5IToBZJV456FiODXa7ch4p0swlbkiu+mXKT1O2/SXrD4d6Spz1Ol0+Y
         4JPUwFq/QYR0ztb7n+OL4hlt8E3VwEbzqAE8VMz0=
Date:   Mon, 6 Jan 2020 09:56:13 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH v2] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
Message-ID: <20200106085613.mxe33t7eklj3aeld@gilmour.lan>
References: <20200106003849.16666-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ksh7fmfwlzp3ppfl"
Content-Disposition: inline
In-Reply-To: <20200106003849.16666-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ksh7fmfwlzp3ppfl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 12:38:49AM +0000, Andre Przywara wrote:
> The Allwinner R40 SoC contains four SPI controllers, using the newer
> sun6i design (but at the legacy addresses).
> The controller seems to be fully compatible to the A64 one, so no driver
> changes are necessary.
> The first three controllers can be used on two sets of pins, but SPI3 is
> only routed to one set on Port A.
> Only the pin groups for SPI0 on PortC and SPI1 on PortI are added here,
> because those seem to be the only one exposed on the Bananapi boards.
>
> Tested by connecting a SPI flash to a Bananapi M2 Berry SPI0 and SPI1
> header pins.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied, thanks!
Maxime

--ksh7fmfwlzp3ppfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL2LQAKCRDj7w1vZxhR
xUb2AQC2t/o+wqWssFdYyX0elfDe2VwGXNbIb/BBf2YIjDGiQAEAnTOKxl6zFx6j
7yOxHtFLtYN6hk+SoNjDYuHQ3s/s+Ak=
=b/td
-----END PGP SIGNATURE-----

--ksh7fmfwlzp3ppfl--
