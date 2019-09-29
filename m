Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D66C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E980D21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfI2Vcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:32:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45956 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbfI2Vcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:32:31 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iEgnj-0001dK-PT; Sun, 29 Sep 2019 23:32:19 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Rename roc-pc with libretech notation
Date:   Sun, 29 Sep 2019 23:32:18 +0200
Message-ID: <4177305.6QI6aNXrAv@phil>
In-Reply-To: <20190919052822.10403-5-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com> <20190919052822.10403-5-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Donnerstag, 19. September 2019, 07:28:20 CEST schrieb Jagan Teki:
> Though the ROC-PC is manufactured by firefly, it is co-designed
> by libretch like other Libretech computer boards from allwinner,
> amlogic does.
> 
> So, it is always meaningful to keep maintain those vendors who
> are part of design participation so-that the linux mainline
> code will expose outside world who are the makers of such
> hardware prototypes.
> 
> So, rename the existing rk3399-roc-pc.dts with libretch notation,
> rk3399-libretech-roc-rk3399-pc.dts
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile                           | 2 +-
>  .../{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts}   | 0

Somewhat "randomly" renaming files for "exposure" of the maker isn't the
way to go. Especially as the file name itself is merely a handle and not
meant for fame. The board filename should mainly enable developers to
hopefully the correct board file to use/change - and "rk3399-roc-pc"
is sufficiently unique to do that.

Similar to how the NanoPi boards do that.

And renames not only loose the history of changes but also in this case
the file is in the kernel since july 2018 - more than a year, so this might
actually affect the workflow of someone.

So I'd really expect an actual technical reason for a rename.

Heiko


>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/arm64/boot/dts/rockchip/{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts} (100%)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 1f18a9392d15..73c10ddb4300 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -21,12 +21,12 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-captain.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-khadas-edge-v.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-leez-p710.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-libretech-roc-rk3399-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> -dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock-pi-4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rock960.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
> similarity index 100%
> rename from arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> rename to arch/arm64/boot/dts/rockchip/rk3399-libretech-roc-rk3399-pc.dts
> 




