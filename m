Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B29CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B27208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572231361;
	bh=pb7IZTBRfkZVHAvZFuM2aHVe4OKL4bsoUZk1vFFsMic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dyrly8yMy8MWXlIcHdID5ECRV4aDM71vzMzCinbaxM+SZDkF1TXSIuqoVwcfZiru4
	 RbJ8btF7aHVKusjoo08SYtaPQuI0HkM20bBSXobMHv0tTNrf9J6lpwGgcu7qS4f5wY
	 hdkSpdDrOD1llDRZD/r3NpQp7ftu+wTjwETWXvVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfJ1Czp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfJ1Czo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:55:44 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE302208C0;
        Mon, 28 Oct 2019 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572231344;
        bh=pb7IZTBRfkZVHAvZFuM2aHVe4OKL4bsoUZk1vFFsMic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeCp2KyO5HGNqs9LV5rCeAyHiDVHPizLKOXUYKZe9JMJNk5mejLTdbN1VT7KA+enL
         nhFzRcexYUTqhoWNkmTETEes2aYa30k0oqjUzSXaNlImzHcJ79rLq8+3kmv1+p2Jsk
         W9kfk5YiU0pAilyIEU7Qh9qOBeP9BnukZvoZ/wWg=
Date:   Mon, 28 Oct 2019 10:55:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v13 10/18] ARM: dts: imx6dl-yapp4: Add reg property to
 the lp5562 channel node
Message-ID: <20191028025524.GF16985@dragon>
References: <20191016155954.29044-1-dmurphy@ti.com>
 <20191016155954.29044-11-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016155954.29044-11-dmurphy@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:59:46AM -0500, Dan Murphy wrote:
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

Patch #18 updates bindings example to use led as node name.  Maybe we
should do the same here?

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
