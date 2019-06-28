Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F801C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CE92086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ubYJwhBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfF1Onb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:43:31 -0400
Received: from node.akkea.ca ([192.155.83.177]:50288 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1Onb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:43:31 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 403B34E204B; Fri, 28 Jun 2019 14:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561733011; bh=vL6EoMdz85KeCXb25zgF163ifKwysc+oVzgF2OUUHn0=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=ubYJwhBx0LVLah3yR7dGCU86T3sBjzjPcEihX0mJAf3otSYyjuwTwlQsH1hZwb3Ey
         r9LwKQ8HRfgyVvsPdWu1BxJx1na498IxAXRUu5gcJtZiXwCKE85IeBkf3qdp5LCwA6
         cQPBCTwGG/F7J1S4z5KizNo4L88/jqRp46Gv6kJo=
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mq-librem5: Enable MIPI D-PHY
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 28 Jun 2019 08:43:31 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d9a2076bd4231398bd131483db8b05a7e5d56d8b.1561451144.git.agx@sigxcpu.org>
References: <cover.1561451144.git.agx@sigxcpu.org>
 <d9a2076bd4231398bd131483db8b05a7e5d56d8b.1561451144.git.agx@sigxcpu.org>
Message-ID: <b533e051f4f9b89fed8917954d328c7c@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25 02:27, Guido Günther wrote:
> This enables the Mixel MIPI D-PHY on the Librem 5 devkit
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Acked-by: Angus Ainslie (Purism) <angus@akkea.ca>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 93b3830e5406..83c965773a29 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -174,6 +174,10 @@
>  	assigned-clock-rates = <786432000>, <722534400>;
>  };
> 
> +&dphy {
> +	status = "okay";
> +};
> +
>  &fec1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_fec1>;

