Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CFC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18AE206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 09:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfJHJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 05:43:39 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:46227 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbfJHJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 05:43:37 -0400
Received: from localhost (91.red-2-139-156.staticip.rima-tde.net [2.139.156.91])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 66C12100006;
        Tue,  8 Oct 2019 09:43:34 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Walter Schweizer <ws.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Walter Schweizer <ws.kernel@gmail.com>
Subject: Re: [PATCH] ARM: dts: kirkwood: synology: Fix rs5c372 RTC entry
In-Reply-To: <20190928105344.6788-1-ws.kernel@gmail.com>
References: <20190928105344.6788-1-ws.kernel@gmail.com>
Date:   Tue, 08 Oct 2019 11:43:33 +0200
Message-ID: <87lftvtvwa.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walter,

> In the rtc-rs5c372.c driver the compatible entry has been renamed
> from rs5c372 to rs5c372a. Most dts files have been adapted.
> This patch completes the change.
>
> Signed-off-by: Walter Schweizer <ws.kernel@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/kirkwood-synology.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
> index c97ed29a0a0b..217bd374e52b 100644
> --- a/arch/arm/boot/dts/kirkwood-synology.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
> @@ -244,7 +244,7 @@
>  
>  			rs5c372: rs5c372@32 {
>  				status = "disabled";
> -				compatible = "ricoh,rs5c372";
> +				compatible = "ricoh,rs5c372a";
>  				reg = <0x32>;
>  			};
>  
> -- 
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
