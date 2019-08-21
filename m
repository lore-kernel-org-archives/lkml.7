Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1932C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23DC22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfHUMHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:07:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56273 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHUMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:07:47 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BE9C9E0004;
        Wed, 21 Aug 2019 12:07:43 +0000 (UTC)
Date:   Wed, 21 Aug 2019 14:07:43 +0200
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
Message-ID: <20190821120743.hihurpkjancgacs6@flea>
References: <20190820032311.6506-1-samuel@sholland.org>
 <20190820032311.6506-4-samuel@sholland.org>
 <20190820071456.if5lyb4t3em77svl@flea>
 <8947f4d1-3bb4-11b8-b114-5016339514b8@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yj7riia4gph2tfyk"
Content-Disposition: inline
In-Reply-To: <8947f4d1-3bb4-11b8-b114-5016339514b8@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yj7riia4gph2tfyk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 08:04:26AM -0500, Samuel Holland wrote:
> On 8/20/19 2:14 AM, Maxime Ripard wrote:
> > Hi,
> >
> > On Mon, Aug 19, 2019 at 10:23:04PM -0500, Samuel Holland wrote:
> >> This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
> >> SoCs. Add a device tree binding for it.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../mailbox/allwinner,sunxi-msgbox.yaml       | 79 +++++++++++++++++++
> >>  1 file changed, 79 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
> >
> > So we merged a bunch of schemas already, with the convention that the
> > name was the first compatible to use that binding.
> >
> > That would be allwinner,sun6i-a31-msgbox.yaml in that case
>
> Okay, I'll rename the binding and driver (and Kconfig symbol?).

Yep, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yj7riia4gph2tfyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV00DwAKCRDj7w1vZxhR
xR3QAP4uQpZfAOxXPnBEZQVDzwkMpjeJHL0oHyLSa2q695BzKQEA+XYUt7uuVPcp
6l8M8wf6Q1kamKS9IXXV4732b0h59Ao=
=rNyV
-----END PGP SIGNATURE-----

--yj7riia4gph2tfyk--
