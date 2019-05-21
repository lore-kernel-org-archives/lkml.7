Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF2FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BCE21773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558426068;
	bh=cXDVFSlb57fPfk0PC+Emw8wXNYseTi94AoTHkoGNkfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DoCkp08Oc6fSwjqNsDag4cfiE2mJUn0IQR+fhu9fuZMVQ5bLQ0X6vlZ3dlXTF9zmX
	 webrhyi4gjvHUPdJB2PMQkolkZIV1zEMvTVyb8K41S4nGJiT/San37D1NdJ6/skaO/
	 INNpWM5MoAXNFDpFsPBo6pkxYYgyglyQxBCqBgjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfEUIHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEUIHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:07:46 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7C42173E;
        Tue, 21 May 2019 08:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558426065;
        bh=cXDVFSlb57fPfk0PC+Emw8wXNYseTi94AoTHkoGNkfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DXoQ94HdhRBUrmRldOQZnx18GE/O5x95W8s7rh/tU6K00RhOK1mt14ZuKqYUZNDTv
         tw5Z1Wd/A67dDXLDogh4dq+2jJ4ahWN1cbX/dLOS+p+3mBEXZSeYvp+8mTyny6P7i3
         QXEAmDMA/B7WRwhtQ18Kw2kwHC0++6GQ4/wFjKP8=
Date:   Tue, 21 May 2019 16:06:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add gpio alias
Message-ID: <20190521080647.GB15856@dragon>
References: <1557804533-18194-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557804533-18194-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 03:33:56AM +0000, Anson Huang wrote:
> Add i.MX8MQ GPIO alias for kernel GPIO driver usage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 6d635ba..df33672 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -30,6 +30,11 @@
>  		spi0 = &ecspi1;
>  		spi1 = &ecspi2;
>  		spi2 = &ecspi3;
> +		gpio0 = &gpio1;

Please keep the list alphabetically sorted.

Shawn

> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		gpio3 = &gpio4;
> +		gpio4 = &gpio5;
>  	};
>  
>  	ckil: clock-ckil {
> -- 
> 2.7.4
> 
