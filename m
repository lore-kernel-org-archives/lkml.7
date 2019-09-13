Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B32C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D126E207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfIMIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:22:32 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:42712 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbfIMIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:22:32 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9F65825AEB1;
        Fri, 13 Sep 2019 18:22:29 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 971F2940513; Fri, 13 Sep 2019 10:22:27 +0200 (CEST)
Date:   Fri, 13 Sep 2019 10:22:27 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: dts: renesas: r8a77980: Remove r8a77970 DU
 compatible
Message-ID: <20190913082227.wkgmvf7jd2npludy@verge.net.au>
References: <20190912103734.1879-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912103734.1879-1-kieran.bingham+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 11:37:34AM +0100, Kieran Bingham wrote:
> The r8a77970 was added with an compatible string for a differnet device
> rather than adding the correct compatible to the driver.
> 
> Remove the unnecessary compatible which is for a different platform.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> Please note, this patch should not be integrated until the renesas,du-r8a77980
> compatible string makes it into the DU [0].
> 
> [0] https://lore.kernel.org/linux-renesas-soc/a9cc2193-0a18-0490-c273-c64bd70992f5@ideasonboard.com/T/#t
> 
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> index 042f4089e546..c6195377d181 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -1487,8 +1487,7 @@
>  		};
>  
>  		du: display@feb00000 {
> -			compatible = "renesas,du-r8a77980",
> -				     "renesas,du-r8a77970";
> +			compatible = "renesas,du-r8a77980";
>  			reg = <0 0xfeb00000 0 0x80000>;
>  			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&cpg CPG_MOD 724>;
> -- 
> 2.20.1
> 
