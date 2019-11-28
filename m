Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD556C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD57E21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574962929;
	bh=9XOdisxYU3SrPU4GTgh1Xcg39OSoWI0brVkbHYt0uCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tWXDKXVqjkGPjl/QeCw/V3qPIuoleBBRuJwAth2ZqPFzc3/KhI1P/NjKlpIuF5VFF
	 K471WlNBHqpgtd/FuIleYrJcm4uExI2x+DDvGAfBBnXgmgeJ18NFMRxm3vNrTOIx8c
	 MV43BmXaXO2zu+bApWFHHNWlH5iOv7SoalpucMZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfK1RmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfK1RmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:42:08 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4E1215F1;
        Thu, 28 Nov 2019 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574962927;
        bh=9XOdisxYU3SrPU4GTgh1Xcg39OSoWI0brVkbHYt0uCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rotXDPKjiszwD1t/stqextUsMNyUQ83V1CEk4KFIbCIv9yGz52CBNmEPznFrB6iTx
         R7nBRy0p81KEFn2yEdit0Epi7qofVxZ7Uu3FmsKMQviNneFnRF6NT1oRz63HB8Qz2a
         u+p80433ZXTW47e8sBsLcTqlkyMcRqXxMkkqnWDA=
Date:   Thu, 28 Nov 2019 18:42:04 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Convert to new-style SPDX license
 identifiers
Message-ID: <20191128174204.tbr5ldilkadw42gc@gilmour.lan>
References: <20191123132435.22093-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191123132435.22093-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clement,

Sorry for the pretty slow answer

On Sat, Nov 23, 2019 at 02:24:35PM +0100, Cl=E9ment P=E9ron wrote:
> Move the SPDX-License-Identifier lines to the top and drop the
> license splat.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>
> Hi,
>
> This the same logic that what has be done on Amlogic.
>
> Commit: ARM64: dts: amlogic: Convert to new-style SPDX license identifiers
> https://lore.kernel.org/patchwork/patch/890455/

So there's a bunch of different things that should be addressed in
separate patches here I believe.

>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +----------------
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +----------------
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +----------------
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +----------------
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +----------------
>  .../dts/allwinner/sun50i-a64-pine64-lts.dts   |  3 +-
>  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +----------------
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +----------------
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  1 -
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 42 +------------------
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 42 +------------------
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  3 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +----------------
>  .../sun50i-h5-bananapi-m2-plus-v1.2.dts       |  4 +-
>  .../allwinner/sun50i-h5-bananapi-m2-plus.dts  |  4 +-
>  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +----------------
>  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +----------------
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +----------------
>  .../allwinner/sun50i-h5-orangepi-prime.dts    | 42 +------------------
>  .../sun50i-h5-orangepi-zero-plus.dts          |  3 +-
>  .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +----------------
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +----------------
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  2 +-
>  .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  2 +-
>  .../allwinner/sun50i-h6-orangepi-lite2.dts    |  2 +-
>  .../allwinner/sun50i-h6-orangepi-one-plus.dts |  2 +-
>  .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  2 +-
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  2 +-
>  .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  2 +-
>  30 files changed, 33 insertions(+), 634 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/=
dts/allwinner/axp803.dtsi
> index f0349ef4bfdd..f4f2c70fde5c 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright 2017 Icenowy Zheng <icenowy@aosc.xyz>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */

So this is the first, obvious, one that you talk about in your commit
log. While the license says that it's X11, SPDX reports that it's now
MIT, can you clarify this?

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> index 72d6961dc312..2ca36580436c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> @@ -1,6 +1,5 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> - *
>   * Copyright (c) 2018 ARM Ltd.
>   */

This is another kind of changes though. The SPDX identifier is there,
but under the wrong format and you're fixing it.

That being said, I'm not a super fan of mixing the two comment styles
for two lines.

What about using only // style comments for the header?

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.=
2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> index 2e2b14c0ae75..a61d58c4db24 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -// Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
> +/*
> + * Copyright (C) 2018 Chen-Yu Tsai <wens@csie.org>
> + */

Here you change the comment style. And based on the comment above that
wouldn't be necessary.

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index f335f7482a73..84b7e9936300 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2019 Cl=E9ment P=E9ron <peron.clem@gmail.com>
>   */

And I'm not sure what this one (and the next) is?

Thanks!
Maxime
