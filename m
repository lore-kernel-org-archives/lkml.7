Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86039C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF320709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573764759;
	bh=NlVCjRxMkRqk5Azo+j3vk2a1KwSTuX1tB1bWS296FVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Stkg1VmmVfORyZny//Y5qEbJHaoacLQpJsbCVa1DaQy4CV9GGBVHiC2cEcL+sb9aJ
	 mjyXavEQc0yctyB0j5HDJVM6h1JfscMHUeurAAP4YEn3nGJxxgFjJ6Q+zw245oJTyu
	 V4y/QEQkPPDh8rI9PuI+6AXuAiPu3Jh9VGYpblc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNUwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:52:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35225 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNUwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:52:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id n16so6613113oig.2;
        Thu, 14 Nov 2019 12:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zBojHFMIp4w0kfIAZN5FF9FT2LN0lcrYZ7vKt4cgOQY=;
        b=jKBtUTAP17znvpSOLteir2XU7aeHo7hX+Tf6UB8yA1ieOW47IgU2bQXeSmjSWYl9eF
         cVCqm2kMkBATph8eBU/j71wrNeFJLjWCS9HTgF5SXbUBLl3Z+U4xCM4rC+kvFqSJUe4o
         7ibia8vv8gTZX15soKdRn8R+5RvE3V2lDHjfqKTVLtl5/79vPQnEqjkEJnLLlbpKSoed
         b2w2v/PYdF+cBx9j5uwtrO+7YaWDGtiy9Z3WBiL9lKDp2GP2YThHyEIpHaWl+d+Mmmy8
         sdx04BVI4wqev4l4icfhYP8x89RypNcEQjg2WZZE86WVZ4vPAs2LSJaHxmh6q4r2AbKK
         hccA==
X-Gm-Message-State: APjAAAXKQ26AVESsqZP/LLq+e/oKKNRL6VlgHaCEk4O4r51eg0cBmZtn
        YBYM4DjuiJVI9pcOQ1snNQ==
X-Google-Smtp-Source: APXvYqzoEL7iaxuPU86ILWpIVI0usyAt1tZvU65HgsoA+C35lNKYQKh1PZsxYles7K9mQ1D66Sksxg==
X-Received: by 2002:aca:d6d7:: with SMTP id n206mr5211559oig.147.1573764756782;
        Thu, 14 Nov 2019 12:52:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 4sm2190881otc.77.2019.11.14.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:52:36 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:52:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: Convert sprd-uart to
 json-schema
Message-ID: <20191114205235.GA16668@bogus>
References: <20191111090230.3402-1-chunyan.zhang@unisoc.com>
 <20191111090230.3402-3-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111090230.3402-3-chunyan.zhang@unisoc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:02:27PM +0800, Chunyan Zhang wrote:
> 
> Convert the sprd-uart binding to DT schema using json-schema.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/serial/sprd-uart.txt  | 32 ---------
>  .../devicetree/bindings/serial/sprd-uart.yaml | 69 +++++++++++++++++++
>  2 files changed, 69 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> deleted file mode 100644
> index 9607dc616205..000000000000
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* Spreadtrum serial UART
> -
> -Required properties:
> -- compatible: must be one of:
> -  * "sprd,sc9836-uart"
> -  * "sprd,sc9860-uart", "sprd,sc9836-uart"
> -
> -- reg: offset and length of the register set for the device
> -- interrupts: exactly one interrupt specifier
> -- clock-names: Should contain following entries:
> -  "enable" for UART module enable clock,
> -  "uart" for UART clock,
> -  "source" for UART source (parent) clock.
> -- clocks: Should contain a clock specifier for each entry in clock-names.
> -  UART clock and source clock are optional properties, but enable clock
> -  is required.
> -
> -Optional properties:
> -- dma-names: Should contain "rx" for receive and "tx" for transmit channels.
> -- dmas: A list of dma specifiers, one for each entry in dma-names.
> -
> -Example:
> -	uart0: serial@0 {
> -		compatible = "sprd,sc9860-uart",
> -			     "sprd,sc9836-uart";
> -		reg = <0x0 0x100>;
> -		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> -		dma-names = "rx", "tx";
> -		dmas = <&ap_dma 19>, <&ap_dma 20>;
> -		clock-names = "enable", "uart", "source";
> -		clocks = <&clk_ap_apb_gates 9>, <&clk_uart0>, <&ext_26m>;
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> new file mode 100644
> index 000000000000..0cc4668a9b9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please. If you are okay with that on both patches, I can 
fix them and apply patches 1-4.

Rob
