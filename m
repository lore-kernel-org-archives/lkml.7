Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D972054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552406690;
	bh=Q/fIDY9FyBRREBJPvrPeX+hIyuQfQhyLoGrBK0bqzdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0Xd38oYbcYSsCE5F1z4kgOd8Sy6Lc4SygUgcJ8h6OTITsywHd4NNrSVa27xJSzvly
	 ssEmMcQY68owU5BZny4glF5hkAzcJClW+qD0AtUt56OYsTpuRAC/auI2impgR+F+9W
	 4jR7TdG1Kv5BI5XyLQUDAPEABQVK+3n0i/8hf6Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCLQEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:04:49 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38673 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfCLQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:04:48 -0400
Received: by mail-ot1-f65.google.com with SMTP id m1so2965553otf.5;
        Tue, 12 Mar 2019 09:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1U77x4dBnfLm15KIoly1ARxvisexMqp9b6NfCc0Y8n4=;
        b=Q1gDf40tfINA8lmHGXt+NkdIhblgTgB+w8QS4G+6hM1oDUkT5Ok/zBKxQLSwri13yH
         m+o07f1mIzrqAXSDV1IoeaQJbQwFMmqQ9v5W8fv12LdwjaAKF+Xn5nfaCgGaaxGoW1px
         9dUS3pUrmIr6ANTUHyMKKbudVIgXA52+n/GvMWD+qBzoEalvMZR1oH9o1V5+K8Gd26rw
         EjHwyNv3jQyNZE71OnqyJjaqvC3zC8P/1ojkK8Ph2zENN3oVu+FV4M0zeJbAmp0ZSPFj
         M+FkHrEd5xWxTEwy879Z45IhOgri69+l1Z48JaoswSa+lKEhjejPa4OrOdcE9aYoKpBh
         jrKw==
X-Gm-Message-State: APjAAAUyphgzZ7vQh7oezBk6LhIFUk31ARqgriWrXjKaZf1FsxYO9vl4
        sBOR4D4+ZYbwwOzQ4lgUNQ==
X-Google-Smtp-Source: APXvYqzXCP3SFTff0FlnB0ah0ik91HhUWHUcn6d4MmzYFhEAHLQ0t+s1xJDZ6eAgES/HyJb1VokyDg==
X-Received: by 2002:a9d:76c5:: with SMTP id p5mr22929627otl.283.1552406687301;
        Tue, 12 Mar 2019 09:04:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u5sm3561632otb.62.2019.03.12.09.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:04:46 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:04:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/5] Documentation: dt: edac: Add Stratix10 Peripheral
 bindings
Message-ID: <20190312160445.GA8802@bogus>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551288445-22335-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:27:22AM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add peripheral bindings for Stratix10 EDAC to capture
> the differences between the ARM64 and ARM32 architecture.

What's the difference? Sounds like 2 different chips, so Stratix10 or 
s10 is not specific enough perhaps.

> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 No change
> ---
>  .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> index a0ac50e15912..a0fa80c53d2a 100644
> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> @@ -258,6 +258,49 @@ Required Properties:
>  - compatible : Should be "altr,sdram-edac-s10"
>  - interrupts : Should be single bit error interrupt.
>  
> +On-Chip RAM ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-ocram-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent OCRAM node.
> +- interrupts      : Should be single bit error interrupt.
> +
> +Ethernet FIFO ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-eth-mac-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent Ethernet node.
> +- interrupts      : Should be single bit error interrupt.
> +
> +NAND FIFO ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-nand-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent NAND node.
> +- interrupts      : Should be single bit error interrupt.
> +
> +DMA FIFO ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-dma-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent DMA node.
> +- interrupts      : Should be single bit error interrupt.
> +
> +USB FIFO ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-usb-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent USB node.
> +- interrupts      : Should be single bit error interrupt.
> +
> +SDMMC FIFO ECC
> +Required Properties:
> +- compatible      : Should be "altr,socfpga-s10-sdmmc-ecc"
> +- reg             : Address and size for ECC block registers.
> +- altr,ecc-parent : phandle to parent SD/MMC node.
> +- interrupts      : Should be single bit error interrupt for port A
> +		    and then single bit error interrupt for port B.
> +
>  Example:
>  
>  	eccmgr {
> @@ -274,4 +317,67 @@ Example:
>  			compatible = "altr,sdram-edac-s10";
>  			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
>  		};
> +
> +		ocram-ecc@ff8cc000 {
> +			compatible = "altr,socfpga-s10-ocram-ecc";
> +			reg = <ff8cc000 0x100>;
> +			altr,ecc-parent = <&ocram>;
> +			interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		emac0-rx-ecc@ff8c0000 {
> +			compatible = "altr,socfpga-s10-eth-mac-ecc";
> +			reg = <0xff8c0000 0x100>;
> +			altr,ecc-parent = <&gmac0>;
> +			interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		emac0-tx-ecc@ff8c0400 {
> +			compatible = "altr,socfpga-s10-eth-mac-ecc";
> +			reg = <0xff8c0400 0x100>;
> +			altr,ecc-parent = <&gmac0>;
> +			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>'
> +		};
> +
> +		nand-buf-ecc@ff8c8000 {
> +			compatible = "altr,socfpga-s10-nand-ecc";
> +			reg = <0xff8c8000 0x100>;
> +			altr,ecc-parent = <&nand>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		nand-rd-ecc@ff8c8400 {
> +			compatible = "altr,socfpga-s10-nand-ecc";
> +			reg = <0xff8c8400 0x100>;
> +			altr,ecc-parent = <&nand>;
> +			interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		nand-wr-ecc@ff8c8800 {
> +			compatible = "altr,socfpga-s10-nand-ecc";
> +			reg = <0xff8c8800 0x100>;
> +			altr,ecc-parent = <&nand>;
> +			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		dma-ecc@ff8c9000 {
> +			compatible = "altr,socfpga-s10-dma-ecc";
> +			reg = <0xff8c9000 0x100>;
> +			altr,ecc-parent = <&pdma>;
> +			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		usb0-ecc@ff8c4000 {
> +			compatible = "altr,socfpga-s10-usb-ecc";
> +			reg = <0xff8c4000 0x100>;
> +			altr,ecc-parent = <&usb0>;
> +			interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		sdmmc-ecc@ff8c8c00 {
> +			compatible = "altr,socfpga-s10-sdmmc-ecc";
> +			reg = <0xff8c8c00 0x100>;
> +			altr,ecc-parent = <&mmc>;
> +			interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
> +				     <15 IRQ_TYPE_LEVEL_HIGH>;
> +		};
>  	};
> -- 
> 2.7.4
> 
