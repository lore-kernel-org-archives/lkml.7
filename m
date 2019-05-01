Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6850EC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369B220835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556740064;
	bh=M9q29ivICQvhytoN0yZ/w+zXvW/YwhoaeKp03M5D/Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PS5Ju4AVQ0euFpa2PDQBRf20TTKZGeVhen/x4OUMYbIVsGr/rGlmoJItvxsXJcBRX
	 y/Eq0DSUAmYVyT9Qjs72oc+DhUHqOcAtoj+uKvAHqWhYxBeIOXnEJe93kBV07mE8oi
	 J6eK5+gQ0X4lm2aO+fzMMfk2akexoF1qKZyz/vo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEATrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:47:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46181 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEATrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:47:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id d62so8756590oib.13;
        Wed, 01 May 2019 12:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/rP/lNM5/74azub9ypQhSMTgulpgACEtFJzuhj9hr+M=;
        b=Qyq1OL9kOTn8eke03orYkJ6A9loqmUsJ00LFy63aB8v7aV+icYssVeQu6cefVZkQje
         +I80bcC7162mjIbWuV+nTSzNws1QhqC9e+N9FF28vGGAG8a1+T9CwGD9aWcA/KtDSWdQ
         mzrMJq8z3Qxv5tCE3UL46TE9utvtwVZmqGRvilaxtYcaGFnmm107Xb36LSDxJc3GFb11
         PWEKPa3iaaOh/UJZ22yH8r/W1sVgRmm62ggF0kR1qXsAPLxjsD8YaOWPinXhb1L1enJ2
         L1eQ2PPXcW1zHbAxfSpHxIzzSVYF9uD3haQVtq18yt9TqEwIb7PE5f5hKuWXVEUp/AlA
         R+Pw==
X-Gm-Message-State: APjAAAVNvEUvQhNzxGccS9g8gmKI+VrXJiPhCA+SP8lIyYXRXeFy2vdl
        9/1onv0XRWxqG5zp5wKo7A==
X-Google-Smtp-Source: APXvYqzKu2OdM8V4p7AhuWx35gRXw+/3vWvjzzWmgsp3fZyd5zjaR7rA2ALyP2DVqY8d/wCbpqyDOA==
X-Received: by 2002:a05:6808:cd:: with SMTP id t13mr22306oic.66.1556740060253;
        Wed, 01 May 2019 12:47:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s124sm16982906oia.24.2019.05.01.12.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 12:47:39 -0700 (PDT)
Date:   Wed, 1 May 2019 14:47:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V3 01/12] dt-bindings: xilinx-sdfec: Add SDFEC binding
Message-ID: <20190501194738.GA1441@bogus>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-2-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556402706-176271-2-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 11:04:55PM +0100, Dragan Cvetic wrote:
> Add the Soft Decision Forward Error Correction (SDFEC) Engine
> bindings which is available for the Zynq UltraScale+ RFSoC
> FPGA's.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt       | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> new file mode 100644
> index 0000000..425b6a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
> @@ -0,0 +1,58 @@
> +* Xilinx SDFEC(16nm) IP *
> +
> +The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
> +which provides high-throughput LDPC and Turbo Code implementations.
> +The LDPC decode & encode functionality is capable of covering a range of
> +customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
> +principally covers codes used by LTE. The FEC Engine offers significant
> +power and area savings versus implementations done in the FPGA fabric.
> +
> +
> +Required properties:
> +- compatible: Must be "xlnx,sd-fec-1.1"
> +- clock-names : List of input clock names from the following:
> +    - "core_clk", Main processing clock for processing core (required)
> +    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
> +    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
> +    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
> +    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
> +    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
> +    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
> +    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
> +- clocks : Clock phandles (see clock_bindings.txt for details).
> +- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
> +  location and length.
> +- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
> +  being used.
> +- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
> +  driven with a fixed value and is not present on the device, a value of 1
> +  configures the DIN_WORDS to be block based, while a value of 2 configures the
> +  DIN_WORDS input to be supplied for each AXI transaction.
> +- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
> +  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> +  of "4x128b".

Perhaps append with '-bits' and make the values 0, 128, 256, 512.

> +- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interface is
> +  driven with a fixed value and is not present on the device, a value of 1
> +  configures the DOUT_WORDS to be block based, while a value of 2 configures the
> +  DOUT_WORDS input to be supplied for each AXI transaction.
> +- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of 1
> +  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
> +  of "4x128b".

Same here.

> +Optional properties:
> +- interrupts: should contain SDFEC interrupt number

The interrupt may not be wired?

> +
> +Example
> +---------------------------------------
> +	sd_fec_0: sd-fec@a0040000 {
> +		compatible = "xlnx,sd-fec-1.1";
> +		clock-names = "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_status_aclk","m_axis_dout_aclk";
> +		clocks = <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>, <&misc_clk_1>;
> +		reg = <0x0 0xa0040000 0x0 0x40000>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 89 4>;
> +		xlnx,sdfec-code = "ldpc";
> +		xlnx,sdfec-din-words = <0>;
> +		xlnx,sdfec-din-width = <2>;
> +		xlnx,sdfec-dout-words = <0>;
> +		xlnx,sdfec-dout-width = <1>;
> +	};
> -- 
> 2.7.4
> 
