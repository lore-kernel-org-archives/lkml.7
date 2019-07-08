Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB87BC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D0A20673
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 03:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HvKdj5RY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfGHDLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 23:11:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39618 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfGHDLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 23:11:53 -0400
Received: from pendragon.ideasonboard.com (unknown [210.160.37.25])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3595DCC;
        Mon,  8 Jul 2019 05:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1562555511;
        bh=8gc1GRiNm08PRWGt9s/RcUqTuZs4EATDUk92EjTIlcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvKdj5RYahTvfPfFy2ezx/60bHwdmV+2ZVYzRWT/UererVRPzYXGK6SbVQdYqoFUG
         R5AlWdE/XFociu1LDvfAbVoO435efmELaJ8MvCIg4hscFOduZLP4WXYzPn5g0OJdVt
         vQECeAnBz5AH6LjXY50J4BSz7UtJLurU0KcwW7EE=
Date:   Mon, 8 Jul 2019 06:11:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/19] arm64: renesas: Update 'vsps' property
Message-ID: <20190708031121.GA5046@pendragon.ideasonboard.com>
References: <20190706140746.29132-1-jacopo+renesas@jmondi.org>
 <20190706140746.29132-4-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190706140746.29132-4-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Sat, Jul 06, 2019 at 04:07:30PM +0200, Jacopo Mondi wrote:
> Update the 'vsps' property in the R-Car Gen3 SoC device tree files to
> match what's in in the documentation example.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 2 +-
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 2 +-
>  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 2 +-
>  arch/arm64/boot/dts/renesas/r8a77990.dtsi | 2 +-
>  arch/arm64/boot/dts/renesas/r8a77995.dtsi | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> index 3f86db199dbf..e643f9d3c102 100644
> --- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
> @@ -1807,7 +1807,7 @@
>  			clocks = <&cpg CPG_MOD 724>,
>  				 <&cpg CPG_MOD 723>;
>  			clock-names = "du.0", "du.1";
> -			vsps = <&vspd0 0 &vspd1 0>;
> +			vsps = <&vspd0 0>, <&vspd1 0>;
>  			status = "disabled";
>  
>  			ports {
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 097538cc4b1f..432f4036a8a8 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -3098,7 +3098,7 @@
>  				 <&cpg CPG_MOD 722>,
>  				 <&cpg CPG_MOD 721>;
>  			clock-names = "du.0", "du.1", "du.2", "du.3";
> -			vsps = <&vspd0 0 &vspd1 0 &vspd2 0 &vspd0 1>;
> +			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd2 0>, <&vspd0 1>;
>  			status = "disabled";
>  
>  			ports {
> diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> index 2554b1742dbf..b701aeb4f438 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> @@ -2456,7 +2456,7 @@
>  			clock-names = "du.0", "du.1", "du.3";
>  			status = "disabled";
>  
> -			vsps = <&vspd0 0 &vspd1 0 &vspd0 1>;
> +			vsps = <&vspd0 0>, <&vspd1 0>, <&vspd0 1>;
>  
>  			ports {
>  				#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> index 56cb566ffa09..79db5441b7e7 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
> @@ -1764,7 +1764,7 @@
>  			clocks = <&cpg CPG_MOD 724>,
>  				 <&cpg CPG_MOD 723>;
>  			clock-names = "du.0", "du.1";
> -			vsps = <&vspd0 0 &vspd1 0>;
> +			vsps = <&vspd0 0>, <&vspd1 0>;
>  			status = "disabled";
>  
>  			ports {
> diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> index 5bf3af246e14..49a11b4f55bd 100644
> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -1001,7 +1001,7 @@
>  			clocks = <&cpg CPG_MOD 724>,
>  				 <&cpg CPG_MOD 723>;
>  			clock-names = "du.0", "du.1";
> -			vsps = <&vspd0 0 &vspd1 0>;
> +			vsps = <&vspd0 0>, <&vspd1 0>;
>  			status = "disabled";
>  
>  			ports {

-- 
Regards,

Laurent Pinchart
