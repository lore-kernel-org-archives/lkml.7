Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF273C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A423B20726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575970728;
	bh=x8aJSKAR2dIcqW/3ygcQgBy7sFiK4/Pal+Rxa3TK9bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2hESVlrDTnh+tDJtRlYLbmZhMpKZP9fzrsLs9PH9UnbWQwAIeEFtzAg13R2WIWjQ2
	 xGNGa+E51Rs76hrGXrORGaRmUE3xGKJqnXdRN+OOoX1BYwxVKxuyQTjcqz1Jlf3hbo
	 XMcVRpLHQ2QsKwknuyXL/awInJjjkW2vo5LQm2x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJJis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfLJJir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:38:47 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C8420663;
        Tue, 10 Dec 2019 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575970726;
        bh=x8aJSKAR2dIcqW/3ygcQgBy7sFiK4/Pal+Rxa3TK9bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G2wZbUfdFX5wnoE/mSAwvP5ItTCOw02h6V/j2Gvd9/c8HLEU97Tsgd2+g7rQjFO2G
         JalyFsWwXq63jgAWnCu23skt6W7K1HVeyXNiBWfQ7jkmrMfjq82r7XnlWn4mZiMCuA
         Cy5tHjk+7PtkNt/w35f+OckD5so4qhG66KVaBaBo=
Date:   Tue, 10 Dec 2019 10:38:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: Convert license to SPDX
 identifier
Message-ID: <20191210093843.qoypomttr4b7kbep@gilmour.lan>
References: <20191209182024.20509-1-peron.clem@gmail.com>
 <20191209182024.20509-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191209182024.20509-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cl=E9ment,

On Mon, Dec 09, 2019 at 07:20:23PM +0100, Cl=E9ment P=E9ron wrote:
> Use a shorter SPDX identifier instead of pasting the
> whole license.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/axp803.dtsi     | 39 +------------------
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +------------------
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +------------------
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +------------------
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +------------------
>  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +------------------
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +------------------
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 39 +------------------
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 39 +------------------
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +------------------
>  .../allwinner/sun50i-h5-nanopi-neo-plus2.dts  | 39 +------------------
>  .../dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 39 +------------------
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 39 +------------------
>  .../allwinner/sun50i-h5-orangepi-prime.dts    | 39 +------------------
>  .../sun50i-h5-orangepi-zero-plus2.dts         | 39 +------------------
>  arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 39 +------------------
>  16 files changed, 16 insertions(+), 608 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi b/arch/arm64/boot/=
dts/allwinner/axp803.dtsi
> index f0349ef4bfdd..0e13e75132ac 100644
> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
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

Thanks for sending a new iteration of this. I had a look at the
licenses texts associated to the SPDX tag in the LICENSES folder, and
it turns out that the tag we should be using for that text is
MIT. While we mention X11 in the header, the text associated to the
X11 license isn't the one we have in our headers.

I guess we should make very clear in the commit log that even though
the tag now reports MIT, this maps to the same license text and is not
therefore a license change.

Thanks!
Maxime
