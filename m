Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99637CA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787ED2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfJaOZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:25:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38372 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728153AbfJaOZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:25:06 -0400
Received: from dhcp-64-28.ens-lyon.fr ([140.77.64.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQBNk-0005pO-8a; Thu, 31 Oct 2019 15:25:00 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Rework voltage supplies for regulators on rk3399-roc-pc
Date:   Thu, 31 Oct 2019 15:24:59 +0100
Message-ID: <2490751.hSll4LLrj9@phil>
In-Reply-To: <22b56700-3c9e-0f60-cd74-7ff24d4f1a23@fivetechno.de>
References: <22b56700-3c9e-0f60-cd74-7ff24d4f1a23@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Oktober 2019, 14:30:06 CET schrieb Markus Reichl:
> Correct the voltage supplies according to the board schematics
> ROC-3399-PC-V10-A-20180804.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 30 ++++++++++---------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> index e06e4163605b..def8bca7d158 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> @@ -142,7 +142,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> -		vin-supply = <&vcc_sys>;
> +		vin-supply = <&dc_12v>;
>  	};
>  
>  	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
> @@ -190,7 +190,7 @@
>  		regulator-boot-on;
>  		regulator-min-microvolt = <800000>;
>  		regulator-max-microvolt = <1400000>;
> -		vin-supply = <&vcc_sys>;
> +		vin-supply = <&vcc3v3_sys>;
>  	};
>  
>  	/* on roc-rk3399-mezzanine board */

This seems to be some change from somewhere else.
In any case I adapted that to the current dts and applied
the patch for 5.5. Please double-check though.

Thanks
Heiko



