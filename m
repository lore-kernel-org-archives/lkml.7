Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61586C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C0B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfHTHPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:15:01 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55273 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:15:00 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3F0882000B;
        Tue, 20 Aug 2019 07:14:57 +0000 (UTC)
Date:   Tue, 20 Aug 2019 09:14:56 +0200
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
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: mailbox: Add a sunxi message box
 binding
Message-ID: <20190820071456.if5lyb4t3em77svl@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jk5ejfcyipdkxe5r"
Content-Disposition: inline
In-Reply-To: <20190820032311.6506-4-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jk5ejfcyipdkxe5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 19, 2019 at 10:23:04PM -0500, Samuel Holland wrote:
> This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
> SoCs. Add a device tree binding for it.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../mailbox/allwinner,sunxi-msgbox.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml

So we merged a bunch of schemas already, with the convention that the
name was the first compatible to use that binding.

That would be allwinner,sun6i-a31-msgbox.yaml in that case

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jk5ejfcyipdkxe5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVud8AAKCRDj7w1vZxhR
xdirAQCaQ0lRnlxqjU04uoAPvuDTZAOgibH6NkIR0aV0cXn85QD9FbgRFHJ+ms7S
qNfztvFj0c/efoycrt7+A62tP64/7Q4=
=Hklu
-----END PGP SIGNATURE-----

--jk5ejfcyipdkxe5r--
