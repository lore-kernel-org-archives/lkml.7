Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B905C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483C721881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCN2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:28:44 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48817 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:28:43 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5F228100015;
        Wed,  3 Jul 2019 13:28:39 +0000 (UTC)
Date:   Wed, 3 Jul 2019 15:28:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 01/25] arm64: dts: allwinner: Switch A64 dts(i) to use
 SPDX identifier
Message-ID: <20190703132838.nhewz5wzsijl65s5@flea>
References: <20190703124609.21435-1-jagan@amarulasolutions.com>
 <20190703124609.21435-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ai23iijsoaamk652"
Content-Disposition: inline
In-Reply-To: <20190703124609.21435-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ai23iijsoaamk652
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2019 at 06:15:45PM +0530, Jagan Teki wrote:
> Adopt the SPDX license identifier headers to ease license
> compliance management on Allwinner A64 dts(i) files.
>
> While the text specifies "of the GPL or the X11 license"
> but the actual license text matches the MIT license as
> specified at [0]
>
> [0] https://spdx.org/licenses/MIT.html
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +------------------
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +------------------
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +------------------
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +------------------
>  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +------------------
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +------------------
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 39 +------------------
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 39 +------------------
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +------------------
>  9 files changed, 9 insertions(+), 342 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 208373efee49..efdd84c362b0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)

You say that this is a GPL2 only license

>  /*
>   * Copyright (c) 2016 ARM Ltd.
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This library is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.

While this is GPL2 or later.

Also, I'm not sure why we need 25 patches to do that. Can't you just
send one (there's no even need to separate arm and arm64, since we
will do only a single PR from now as opposed to what we were doing
before).

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ai23iijsoaamk652
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXRythgAKCRDj7w1vZxhR
xZUpAQCUowhwV64YaNa72m5XwoQd0CDApNJEPfLdaY1WQi3yBwEAlNG7pyZFSYLA
mm/nwHBZk3qbI6FkIAe7oqcMDaVNvQA=
=pMuf
-----END PGP SIGNATURE-----

--ai23iijsoaamk652--
