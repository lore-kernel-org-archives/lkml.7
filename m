Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DF92085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfCAOrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:47:08 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35623 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbfCAOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:47:08 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 33857E0002;
        Fri,  1 Mar 2019 14:47:03 +0000 (UTC)
Date:   Fri, 1 Mar 2019 15:47:03 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 00/10] Allwinner sunxi message box support
Message-ID: <20190301144703.kyqyajysfsdvg3td@flea>
References: <20190301052947.32032-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghobjd6npcdkzhom"
Content-Disposition: inline
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ghobjd6npcdkzhom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Feb 28, 2019 at 11:29:37PM -0600, Samuel Holland wrote:
> This series adds support for the "hardware message box" in sun8i, sun9i,
> and sun50i SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the ARISC CPU, or to use the mailbox to forward NMIs that the
> firmware picks up from R_INTC.
>=20
> Changes from v1:
>   - Marked message box clocks as critical instead of hacks in the driver
>   - 8 unidirectional channels instead of 4 bidirectional pairs
>   - Use per-SoC compatible strings and an A31 fallback compatible
>   - Dropped the mailbox framework patch
>   - Include DT patches for SoCs that document the message box
>
> Samuel Holland (10):
>   clk: sunxi-ng: sun8i: Mark the msgbox clock as critical
>   clk: sunxi-ng: sun9i: Mark the msgbox clock as critical
>   clk: sunxi-ng: sun50i: Mark the msgbox clock as critical
>   dt-bindings: mailbox: Add a sunxi message box binding
>   mailbox: sunxi-msgbox: Add a new mailbox driver
>   ARM: dts: sunxi: a80: Add msgbox node
>   ARM: dts: sunxi: a83t: Add msgbox node
>   ARM: dts: sunxi: h3/h5: Add msgbox node
>   arm64: dts: allwinner: a64: Add msgbox node
>   arm64: dts: allwinner: h6: Add msgbox node

It looks good to me but a few things:

  - There's no reason to split the first three patches, so they should
    all be merged

  - You might consider using a YAML schemas for your DT bindings
    documentation. That will bring a more formal descriptiion and DT
    validation.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ghobjd6npcdkzhom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHlF5wAKCRDj7w1vZxhR
xSZNAQDg4A34dO9psJhWuKf/Wp3ytO0V7HBWnLGd7ABC26v6KQD/b/+fngiCFXHC
iEpvES4rw5pW+xkjiTfH1/ANXt3brQQ=
=nWPd
-----END PGP SIGNATURE-----

--ghobjd6npcdkzhom--
