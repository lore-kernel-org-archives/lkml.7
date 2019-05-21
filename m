Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3026521783
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558426201;
	bh=/004y5rsgjqXUQAztnJ6E7c2FQLI5fNa1XatRR1RBJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVLuKt04+PqX5nh4H8el2NuCzeD3NwJgj3iSC1DrrdZiYNg4Rj7/F+NmDTcNGvXzk
	 obQEEauYKPTW6+9iBOIl26qF5m6jCjuu5uf6Lq2Fd0owwzQuDFq9LNtE8FceA/mzW2
	 5PLGltxUnsFNwFl45K3cJbvICPQhtZfw7W564O0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfEUIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:10:00 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AE0121773;
        Tue, 21 May 2019 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558426199;
        bh=/004y5rsgjqXUQAztnJ6E7c2FQLI5fNa1XatRR1RBJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxt3kyP+2/0jOC5auPLGolZjJwNUYFnVqo8URgLmXqKLDdgVhmY+QfZjeNNl0XxHe
         Zpu0RScCf2gxmWEwnOoSdsAiS5q7wjdz/CMomlSBpsbFA7ZsuRVZcwhotSgBnGCVKc
         4uH4rYcfD4GNrtql+4Hh/IXt0fxznh2x7NfGHuts=
Date:   Tue, 21 May 2019 16:09:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: Add gpio alias
Message-ID: <20190521080900.GC15856@dragon>
References: <1557809536-749-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557809536-749-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 04:57:17AM +0000, Anson Huang wrote:
> Add i.MX8QXP GPIO alias for kernel GPIO driver usage.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index b17c22e..923705e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -22,6 +22,14 @@
>  		mmc2 = &usdhc3;
>  		serial0 = &adma_lpuart0;
>  		mu1 = &lsio_mu1;
> +		gpio0 = &lsio_gpio0;

Okay, it's already out of alphabetical order, but let's not make it
worse.

Shawn

> +		gpio1 = &lsio_gpio1;
> +		gpio2 = &lsio_gpio2;
> +		gpio3 = &lsio_gpio3;
> +		gpio4 = &lsio_gpio4;
> +		gpio5 = &lsio_gpio5;
> +		gpio6 = &lsio_gpio6;
> +		gpio7 = &lsio_gpio7;
>  	};
>  
>  	cpus {
> -- 
> 2.7.4
> 
