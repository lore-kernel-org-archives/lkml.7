Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D477C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439B218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575277624;
	bh=4FwCVeTFST03BvCT/H0DDIcWMagOt/dsTOUkJbFiFQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YpZW4LqVUK4D5DDKxT3JJa7wavd1RIM0EoMk6HLOmW2U+9mP8QtOyd7YLEPtK2MxX
	 STGarKGwvWUzsBjFervZEGZ4NPddajiiT7flDDciEdV2aC6JH/zUBuv3f5ZOU+nuub
	 2J/G2yU6IhVOZ9KO5ceyuofAloxFvHcslFT49gMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfLBJHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbfLBJHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:07:02 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3BB215E5;
        Mon,  2 Dec 2019 09:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575277622;
        bh=4FwCVeTFST03BvCT/H0DDIcWMagOt/dsTOUkJbFiFQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3niqJ6LgVjMjZJgBXuJuJvs4aU8Yf+rWtnMVpeB0LCnzL3bhq7E3yaEaS2R4o3Z1
         c60QB3Bk0k8Di1ubbriqyxwgEDRu5Z82QZzCqRZAonWEQr3fFfaC35qygcBCvOT5l+
         hJVpQcl+j7QiLOglT5l+fuORciTH99zV7DKNApbU=
Date:   Mon, 2 Dec 2019 17:06:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v17 10/19] ARM: dts: imx6dl-yapp4: Add reg property to
 the lp5562 channel node
Message-ID: <20191202090645.GI9767@dragon>
References: <20191114133023.32185-1-dmurphy@ti.com>
 <20191114133023.32185-11-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114133023.32185-11-dmurphy@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 07:30:14AM -0600, Dan Murphy wrote:
> Add the reg property to each channel node.  This update is
> to accomodate the multicolor framework.  In addition to the
> accomodation this allows the LEDs to be placed on any channel
> and allow designs to skip channels as opposed to requiring
> sequential order.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Shawn Guo <shawnguo@kernel.org>
> CC: Sascha Hauer <s.hauer@pengutronix.de>
> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
> CC: Fabio Estevam <festevam@gmail.com>
> CC: NXP Linux Team <linux-imx@nxp.com>
> ---
>  arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> index e8d800fec637..efc466ed1fea 100644
> --- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> +++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
> @@ -257,29 +257,35 @@
>  		reg = <0x30>;
>  		clock-mode = /bits/ 8 <1>;
>  		status = "disabled";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
> -		chan0 {
> +		chan@0 {

Again, why do not we rename it to led@0 as you update the bindings in
the last patch in the series?

Shawn

>  			chan-name = "R";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> +			reg = <0>;
>  		};
>  
> -		chan1 {
> +		chan@1 {
>  			chan-name = "G";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> +			reg = <1>;
>  		};
>  
> -		chan2 {
> +		chan@2 {
>  			chan-name = "B";
>  			led-cur = /bits/ 8 <0x20>;
>  			max-cur = /bits/ 8 <0x60>;
> +			reg = <2>;
>  		};
>  
> -		chan3 {
> +		chan@3 {
>  			chan-name = "W";
>  			led-cur = /bits/ 8 <0x0>;
>  			max-cur = /bits/ 8 <0x0>;
> +			reg = <3>;
>  		};
>  	};
>  
> -- 
> 2.22.0.214.g8dca754b1e
> 
