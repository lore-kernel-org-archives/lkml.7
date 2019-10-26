Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A3DCA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2650B21D81
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 08:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572077557;
	bh=uLrgR5dduFiKpCf2zS/LUfYO4qdcUR5sKFqtU9Ua3Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yGY6eAF/FZTcQZ1swjWLbFdl0A+AQE4F844cN6JRU7FKzIQUxMzqd0X0SLMgRNIV5
	 0PFI2blw2lCzBfGdxf6VPy/u6jtrKmc6vSxVXLfh3o6pV6ENxtRR3cfBdKAnoe5fJY
	 ojUFvwKY8HnzA/HrP8gzh2Odx16zLOsrVKMUVp74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfJZIMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 04:12:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfJZIMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 04:12:35 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBD6214DA;
        Sat, 26 Oct 2019 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572077555;
        bh=uLrgR5dduFiKpCf2zS/LUfYO4qdcUR5sKFqtU9Ua3Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRieEcbL9aSAvlkBKLiSjJvhvYjxTr7M/1F5X6n/1gwJb+4tm0rqZjlUNkmpTYBzR
         FSfVZf99PGNvd9h8CuatnG7fM6hyTPAc7Ab4mtZ1aUCi/aDRCTrxz7Up34ZLFBifko
         asjSu+zFgko2TZlDVN1OZjhZ57/BCAurusF6BDVs=
Date:   Sat, 26 Oct 2019 16:12:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx: add devicetree for Kobo Clara HD
Message-ID: <20191026081214.GB14401@dragon>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-4-andreas@kemnade.info>
 <20191025134621.GN3208@dragon>
 <20191025200743.48455cc9@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025200743.48455cc9@aktux>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:07:43PM +0200, Andreas Kemnade wrote:
> Hi,
> 
> On Fri, 25 Oct 2019 21:46:24 +0800
> Shawn Guo <shawnguo@kernel.org> wrote:
> 
> [...]
> > > +
> > > +		pinctrl_wifi_reset: wifi_reset_grp {
> > > +			fsl,pins = <
> > > +				MX6SLL_PAD_SD2_DATA7__GPIO5_IO00	0x10059		/* WIFI_RST */
> > > +			>;
> > > +		};
> > > +
> > > +		pinctrl_wifi_power: wifi_power_grp {  
> > 
> > I guess you can have one pinctrl node to include both reset and power
> > pins?  Also, to be consistent with other pinctrl nodes on naming, the
> > node name should probably be wifigrp.
> > 
> well, the problems they are used in different nodes, so I cannot do
> that:
> 
>        reg_wifi: regulator-wifi {
>                 compatible = "regulator-fixed";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_wifi_power>;
>                 regulator-name = "SD3_SPWR";
>                 regulator-min-microvolt = <3000000>;
>                 regulator-max-microvolt = <3000000>;
>                 gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
>                 enable-active-high;
>         };
> 
>         wifi_pwrseq: wifi_pwrseq {
>                 compatible = "mmc-pwrseq-simple";
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&pinctrl_wifi_reset>;
>                 post-power-on-delay-ms = <20>;
>                 reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
>         };

Ah, yes, it makes more sense.  I missed that.

Shawn

> 
> So having them combined breaks the mux where you use it rule.
> I got in earlier mails:
> 
> > > +	wifi_pwrseq: wifi_pwrseq {
> > > +		compatible = "mmc-pwrseq-simple";
> > > +		post-power-on-delay-ms = <20>;
> > > +		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;  
> 
> > Can you add a pinctrl-entry here please? The general rule is to mux
> > things where you use it
> [...]
> > > +			compatible = "regulator-fixed";
> > > +			regulator-name = "SD3_SPWR";
> > > +			regulator-min-microvolt = <3000000>;
> > > +			regulator-max-microvolt = <3000000>;
> > > +
> > > +			gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;  
> 
> > Please add a pinctrl here to mux this gpio.
> 
> Regards,
> Andreas
