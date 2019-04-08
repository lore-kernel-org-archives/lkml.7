Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF80C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C714820855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDHLx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:53:57 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:22045 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfDHLx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:53:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549954800"; 
   d="scan'208";a="26949593"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 08 Apr 2019 04:53:56 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Mon, 8 Apr 2019
 04:53:55 -0700
Date:   Mon, 8 Apr 2019 13:53:33 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] ARM: dts: sama5d{2,4}: use SPDX-License-Identifier
Message-ID: <20190408115333.v5ik53qx4wxq4rgi@M43218.corp.atmel.com>
Mail-Followup-To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190403205219.26098-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190403205219.26098-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:52:16PM +0200, Alexandre Belloni wrote:
> External E-Mail
> 
> 
> The X11 license text [1] is explicitly for the X Consortium and has a
> couple of extra clauses. The MIT license text [2] is actually what the
> current DT files claim.
> 
> [1] https://spdx.org/licenses/X11.html
> [2] https://spdx.org/licenses/MIT.html
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to at91-dt.

Thanks

> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 39 +---------------------------------
>  arch/arm/boot/dts/sama5d4.dtsi | 39 +---------------------------------
>  2 files changed, 2 insertions(+), 76 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index d159ee42ef29..26ae6b34e329 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1,46 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * sama5d2.dtsi - Device Tree Include file for SAMA5D2 family SoC
>   *
>   *  Copyright (C) 2015 Atmel,
>   *                2015 Ludovic Desroches <ludovic.desroches@atmel.com>
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
>  
>  #include <dt-bindings/dma/at91.h>
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 6c1e41f94549..6ab27a7b388d 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -1,46 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * sama5d4.dtsi - Device Tree Include file for SAMA5D4 family SoC
>   *
>   *  Copyright (C) 2014 Atmel,
>   *                2014 Nicolas Ferre <nicolas.ferre@atmel.com>
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
>  
>  #include <dt-bindings/clock/at91.h>
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
