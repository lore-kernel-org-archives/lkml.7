Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE773206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 00:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556757866;
	bh=0kvEehdZmuc+bu4QOBHPY2M6l5uSQWk0FLsRPgEP6eA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y67ZlMJPr/lC4AarJpLT5666FxLJvGoUuTAm7aq20EpHQRoxXOQXKVK7KzBs7f7aj
	 xF+Zmbded9rvAoFJAsghxTVtoRaLtrWgbBAHzUJyEpDmyZp1bDpdp37Ktg7AVJKUmp
	 Vt101FevudUxdO8kg0lrMtsDuZDQL2gjHXiSlqmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfEBAoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 20:44:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43356 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfEBAoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 20:44:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id e108so544242ote.10;
        Wed, 01 May 2019 17:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30i3NYFXZ2MZXCMdrcpDy35fMw++eVjOrCNwvTj72Jk=;
        b=aw3a6Jy5zZzWF5SFbky7qdEOXhYSl1hH+krebh7x2ps5oT6rdWaQihrec4GmM17ocy
         uQMbuSMFxUmlrH7JmeHA/SwwG0XvopXmxa6tJFzk11+38PK0rDS/6FebXMgP6zje1xu9
         kp1ZFaWwS7ioSuL57r7Oyua2m2cu+qfkX3W+qbKYGBbI2CrB9aqbvDkPhVYZt2fTrO+m
         PWwmnnO2LoZoyTVk41SkdbyQjsInpB/g/utVjGhWcXBpY6wXq1ACoQ44pGA3bg8gzR2t
         LbsuraHv0AU1c/+SVK9ojmKLfEs5nSljklSUDlin+6X/bjDRYLzXAvi9Q7RAzmVPq4hq
         OpWQ==
X-Gm-Message-State: APjAAAUgDPdQE/RRXsbuxf3VJqYMV7hBG+djuGBSIIEsc/gK+/Wi8a4W
        rW6oyi8IRqf5jz8SDvwmBg==
X-Google-Smtp-Source: APXvYqx8Ov1Fb55uUfnOb+oD0w26UNXy56gd36CsDtsPofrXsJIpTWqmCCZ9VDjI3X/t5n36L29Sow==
X-Received: by 2002:a9d:4701:: with SMTP id a1mr578732otf.235.1556757864153;
        Wed, 01 May 2019 17:44:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm12129109oti.45.2019.05.01.17.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 17:44:23 -0700 (PDT)
Date:   Wed, 1 May 2019 19:44:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Takao Orito <orito.takao@socionext.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masami.hiramatsu@linaro.org,
        jaswinder.singh@linaro.org, sugaya.taichi@socionext.com,
        kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Message-ID: <20190502004422.GA2242@bogus>
References: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:06:32AM +0900, Takao Orito wrote:

Needs a commit msg.

> Signed-off-by: Takao Orito <orito.takao@socionext.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> new file mode 100644
> index 0000000..7008462
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> @@ -0,0 +1,35 @@
> +* SOCIONEXT SDHCI controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci_milbeaut driver.
> +
> +Required properties:
> +- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
> +- clocks: Must contain an entry for each entry in clock-names. It is a
> +  list of phandles and clock-specifier pairs.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain the following two entries:
> +	"iface" - clock used for sdhci interface
> +	"core"  - core clock for sdhci controller
> +
> +Optional properties:
> +- vqmmc-supply: phandle to the regulator device tree node, mentioned
> +  as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> +  requires the CMD_DAT_DELAY control to be enabled.
> +- sni,mmc-power-gpio: set property indicating that power on or off needs
> +  control of gpios.
> +
> +Example:
> +	sdhci3: mmc@1b010000 {
> +		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +		reg = <0x1b010000 0x10000>;
> +		interrupts = <0 265 0x4>;
> +		voltage-ranges = <3300 3300>;
> +		bus-width = <4>;
> +		clocks = <&clk 7>, <&ahb_clk>;
> +		clock-names = "core", "iface";
> +		cap-sdio-irq;
> +		sni,mmc-power-gpio = <&pinctrl 53 GPIO_ACTIVE_HIGH>;
> +			fujitsu,cmd-dat-delay-select;

Whitespace problem.

> +	};
> -- 
> 1.9.1
> 
> 
