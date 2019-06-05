Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9854DC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317B206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfFELtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:49:53 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44755 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfFELtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:49:53 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 80F091BF203;
        Wed,  5 Jun 2019 11:49:48 +0000 (UTC)
Date:   Wed, 5 Jun 2019 13:49:48 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clk: sunxi-ng: sun50i-h6-r: Fix incorrect W1 clock
 gate register
Message-ID: <20190605114948.a4m7g5zwdr23qgth@flea>
References: <20190604154036.23211-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4kypn3dccdwbnuyz"
Content-Disposition: inline
In-Reply-To: <20190604154036.23211-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4kypn3dccdwbnuyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 04, 2019 at 05:40:36PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> The current code defines W1 clock gate to be at 0x1cc, overlaying it
> with the IR gate.
>
> Clock gate for r-apb1-w1 is at 0x1ec. This fixes issues with IR receiver
> causing interrupt floods on H6 (because interrupt flags can't be cleared,
> due to IR module's bus being disabled).
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Fixes: b7c7b05065aa77ae ("clk: sunxi-ng: add support for H6 PRCM CCU")

Applied, thanks

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4kypn3dccdwbnuyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPesXAAKCRDj7w1vZxhR
xS0aAQDbqtubHM34CsRCm1ZafQXbbm/Co2Y9BfB0fqhizBC8EgD/ZVKxdfqHoRKr
cdCJa+8u/cSpVJrFqhwWKTQ01004pwA=
=OHOD
-----END PGP SIGNATURE-----

--4kypn3dccdwbnuyz--
