Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3004C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822C023A45
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfHTI1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:27:55 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44141 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:27:55 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 19956240009;
        Tue, 20 Aug 2019 08:27:51 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:27:51 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 04/10] mailbox: sunxi-msgbox: Add a new mailbox driver
Message-ID: <20190820082751.nfn76nlgl3ivphff@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gkmhex6scyynmxz2"
Content-Disposition: inline
In-Reply-To: <20190820032311.6506-5-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gkmhex6scyynmxz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 19, 2019 at 10:23:05PM -0500, Samuel Holland wrote:
> Allwinner sun8i, sun9i, and sun50i SoCs contain a hardware message box
> used for communication between the ARM CPUs and the ARISC management
> coprocessor. The hardware contains 8 unidirectional 4-message FIFOs.
>
> Add a driver for it, so it can be used for SCPI or other communication
> protocols.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  drivers/mailbox/Kconfig        |  10 +
>  drivers/mailbox/Makefile       |   2 +
>  drivers/mailbox/sunxi-msgbox.c | 323 +++++++++++++++++++++++++++++++++
>  3 files changed, 335 insertions(+)
>  create mode 100644 drivers/mailbox/sunxi-msgbox.c

It's pretty much the same remark than for the name of the binding
file, but sunxi in itself is pretty confusing, it covers a range of
SoCs going from armv5 to armv8, some with a single CPU and some with
more, and some with an OpenRISC core and some without.

It would be less confusing (albeit not perfect) to use sun6i there,
the family that IP was first introduced in.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gkmhex6scyynmxz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVuvBwAKCRDj7w1vZxhR
xV7WAQCXdOhK3aygWsBU1Ob0okTJbPWhSiAl4T7XZhHH/36ZiQEA6pZ/KLw9KS1c
2kVKRLeNf7nMSDrNt/PPkrb11elNcgA=
=KJoz
-----END PGP SIGNATURE-----

--gkmhex6scyynmxz2--
