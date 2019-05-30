Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FEDC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535025DD2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cpAOSfyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfE3Qxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 12:53:30 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42064 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfE3Qxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 12:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G0I2VaOxTquFi5Bd18+xCgo/6GrYaQ0PNfS3fZjdKAw=; b=cpAOSfyqMpN0nX5VaEaBtO8LQZ
        xdYN38EEh3X2QeGUi2C2fbTXAenMFUxW+pzJxxXGo6TraAneV6wPqtHxUm6w/qqY0ke/0GeExjUx7
        4lIjv18JJMhbyr2MiKEl7IHwCiYT3I2V8qeC/V17lEII7u56RHWT17Gz5bzTnBgPUBMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hWOIi-0008GL-61; Thu, 30 May 2019 18:53:12 +0200
Date:   Thu, 30 May 2019 18:53:12 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexander Filippov <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add YADRO VESNIN BMC
Message-ID: <20190530165312.GH18059@lunn.ch>
References: <20190530143933.25414-1-a.filippov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530143933.25414-1-a.filippov@yadro.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 05:39:33PM +0300, Alexander Filippov wrote:
> VESNIN is an OpenPower machine with an Aspeed 2400 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 234 ++++++++++++++++++++
>  2 files changed, 235 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 834cce80d1b8..811e9312cf22 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1259,6 +1259,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-microsoft-olympus.dtb \
>  	aspeed-bmc-opp-lanyang.dtb \
>  	aspeed-bmc-opp-palmetto.dtb \
> +	aspeed-bmc-opp-vesnin.dtb \
>  	aspeed-bmc-opp-romulus.dtb \
>  	aspeed-bmc-opp-swift.dtb \
>  	aspeed-bmc-opp-witherspoon.dtb \

Hi Alexander

These appear to be in alphabetic order, so it should be added before
witherspoon.

	Andrew
