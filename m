Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD76C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF9B2183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014498;
	bh=pcHHa3o+CByJzVJrATlOv3lUPlCjMjgE5k0d9h8lKvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B9cOGLqJQctfo1r7PVvnLcsS8gkdmgGrX+JaMpUBSkIytH13CBoc3hd7yPolcbMqF
	 XFlpKgpyEozKh443eMw59KJdhyNUHa4/dWkd5Dug9Vpbb+I2aOQPYaN2qMmFGtNcsz
	 9cBGjetiwDPerIgLMhrIv8DbuRqfV7BPvR+iq78E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfCaGlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43968 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfCaGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id m10so2925646plt.10;
        Sat, 30 Mar 2019 23:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrmxwv21i7rt7ROgEeilOGd2Mpbqnp4HuFs65A3bhlk=;
        b=YkAKaNItLqE9QuoDWrlL4MhAX/E4A57vLV+tl44S+b0D36Yd+USlx61TkyvEp+Mtsj
         4pxY75bBey3ncCtIHPYVcyBLG6io9/ffXyf4qP0UrLvz5wB15Q4SdrW0tCthTIEquNXX
         mgCDJg2yiCSZs68eVqNR8quX2oeU1xtmRPwwQvCJ9LxALu3NOBs1Uyqi4zeDaS32ytEa
         D9LaXtGrtliFv+SaYi8Ys9Xqys1HwcmAW/HPbCFrJ7+yBNncjicw4j8VEK+QYyVMx9kl
         r4RHi+c2PaXiGBVWuBnKJId3rXfoQks30WO7owdMZdWPkYQXiLxQDS0ZKcR3LFhOPkLP
         G2hg==
X-Gm-Message-State: APjAAAV4pj4E6kUruV7BPRGkZQA2c2pysw87gC6nyw9vdFgd5aGYijxm
        5mctmj7EBQTGr9z8qqwQ8PGUR72Nxw==
X-Google-Smtp-Source: APXvYqwJDo8IkJGyU71xeLhyC9JIRmfOaEBxGh9mKSwJkpxcPM1KhWBn5p7L6Z9XenA3ltPnvxLIvA==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr59274243ple.107.1554014493296;
        Sat, 30 Mar 2019 23:41:33 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id z189sm9204870pfb.146.2019.03.30.23.41.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:32 -0700 (PDT)
Date:   Sun, 31 Mar 2019 01:41:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: bus: add ASR8751C APB/AXI bindings
Message-ID: <20190331011030.GA24804@bogus>
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-3-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-3-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-3-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:23PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add binding documentation for ASR8751C AXI/APB bus that are used
> to interface with peripherals. AXI/APB bus follow standard AXI/APB
> protocols.
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  Documentation/devicetree/bindings/bus/asr,bus.txt | 42 +++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/asr,bus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/asr,bus.txt b/Documentation/devicetree/bindings/bus/asr,bus.txt
> new file mode 100644
> index 0000000..cbb1b6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/asr,bus.txt
> @@ -0,0 +1,42 @@
> +* ASR AXI/APB Simple Bus
> +
> +This file documents core properties in ASR AXI and APB bus.
> +
> +The ASR8751C SoC has APB and AXI buses for cores to access its
> +controllers, suchas i2c, sdh, rtc, clock, power management registers

s/suchas/such as/

> +etc. Most ASR SoCs share the common architecture for buses.
> +Generally APB and AXI bus have a source clock and power control, and
> +clock rate can be changed and power can be shutdown in low power mode.

Then where are the clocks?

> +
> +Required properties for AXI bus:
> +- compatible: should be "asr,axi-bus", "simple-bus".
> +- #address-cells: could be 1, or 2
> +- #size-cells: could be 1, or 2
> +- reg: iomem address of AXI bus registers
> +- ranges: register ranges
> +
> +Example:
> +	axi@d4200000 {	/* AXI */
> +		compatible = "asr,axi-bus", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0 0xd4200000 0 0x00200000>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +	};
> +
> +Required properties for APB bus:
> +- compatible: should be "asr,apb-bus", "simple-bus".
> +- #address-cells: could be 1, or 2
> +- #size-cells: could be 1, or 2
> +- reg: iomem address of APB bus registers
> +- ranges: register ranges
> +
> +Example:
> +	apb@d4000000 {	/* APB */
> +		compatible = "asr,apb-bus", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0 0xd4000000 0 0x00200000>;
> +		ranges = <0 0 0 0xffffffff>;
> +	};
> -- 
> 2.7.4
> 

