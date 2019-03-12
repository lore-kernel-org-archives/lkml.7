Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3012A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552406465;
	bh=mxJciyXA1AfTEpQ82UzCG1J4ms0+hg9x48dWB2S2sz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H8Rk/qrc/gSvvZEC530YO2c5JARSHaFfQDaJYxcmSGXF3Gwq93TyPCH9hT/x83s2F
	 VCYjF0Mb1v1BZ6uBbdDP6Domdp8yCnqqBT/gBZY2jEamEVyhnPe/RreKkVXEIafhrY
	 97h7cdVqrL1sGZAvpX18XJCwDSH31szVbHZ3g7cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCLQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:01:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33898 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCLQBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:01:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id g16so2531751oib.1;
        Tue, 12 Mar 2019 09:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWfZSCPlNb0cDt1470GW9Ucs5VWxAtv3nEi3YLnM5RQ=;
        b=e+GAQcX6mwRcVdVs6yj8spn5fIZE1kfjmANRLZDJ78mjKUiPZl/7vL6xDQDZLTQeLJ
         M4uVZY+J2UnuQwdcnIB7yqoc9AjMAJnmcSohAieswA9iGeilRrpO83AOXCKMkgVdafip
         sjfe5+fC171NU/CHFyTmEnmcDnGeVvGdSGL5lxBPgvMw9ujkj4oYOp8b/+yrQcea/HyO
         2X24f6kE/htpYERZ5RMzzv1Vbmj/lfG1ZJbPvdOX1SmCfwZqMGztZUgq2O9hFi06YLjr
         t/A3n1653lGWnv9SvTf21tPKeIP43DIJjTIuOuWNREqAZ2G6jz7E+QwrD0RHNjZCWD0U
         K1lg==
X-Gm-Message-State: APjAAAV9dVDWBo+cVsDo0KsBTXnvR7Cs1yPrq1C9T1GvjDL8kLY6Ypeo
        0uX/xlVTrJ8Up/evrw7DKg==
X-Google-Smtp-Source: APXvYqyGCqHidiUK6Na3V7DUf0II+6pLCmesAsGPFk5RCkcGKeFKaYkmB/q2wneKt1mDaLYbuKMwcw==
X-Received: by 2002:aca:c78f:: with SMTP id x137mr1980360oif.124.1552406462545;
        Tue, 12 Mar 2019 09:01:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j15sm3667328oih.23.2019.03.12.09.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 09:01:00 -0700 (PDT)
Date:   Tue, 12 Mar 2019 11:00:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] Documentation: dt: edac: Fix Stratix10 IRQ bindings
Message-ID: <20190312160057.GA31306@bogus>
References: <1551288445-22335-1-git-send-email-thor.thayer@linux.intel.com>
 <1551288445-22335-2-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551288445-22335-2-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:27:21AM -0600, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Fix Stratix10 ECC bindings to specify only the single
> bit error. On Stratix10 double bit errors are handled
> as SErrors instead of interrupts.
> Indicate the differences between the ARM64 and ARM32
> EDAC architecture in the bindings.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2 No change
> ---
>  .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 23 +++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> index 5626560a6cfd..a0ac50e15912 100644
> --- a/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> +++ b/Documentation/devicetree/bindings/edac/socfpga-eccmgr.txt
> @@ -236,33 +236,42 @@ Stratix10 SoCFPGA ECC Manager
>  The Stratix10 SoC ECC Manager handles the IRQs for each peripheral
>  in a shared register similar to the Arria10. However, ECC requires
>  access to registers that can only be read from Secure Monitor with
> -SMC calls. Therefore the device tree is slightly different.
> +SMC calls. Therefore the device tree is slightly different. Note that
> +only 1 interrupt is sent because the double bit errors are treated as
> +SErrors instead of IRQ.
>  
>  Required Properties:
>  - compatible : Should be "altr,socfpga-s10-ecc-manager"
> -- interrupts : Should be single bit error interrupt, then double bit error
> -	interrupt.
> +- altr,sysgr-syscon : phandle to Stratix10 System Manager Block
> +	              containing the ECC manager registers.

Seems this was already in use, but why not just make this node a child 
of the System Manager Block and remove this phandle?

> +- interrupts : Should be single bit error interrupt.
>  - interrupt-controller : boolean indicator that ECC Manager is an interrupt controller
>  - #interrupt-cells : must be set to 2.
> +- #address-cells: must be 1
> +- #size-cells: must be 1
> +- ranges : standard definition, should translate from local addresses
>  
>  Subcomponents:
>  
>  SDRAM ECC
>  Required Properties:
>  - compatible : Should be "altr,sdram-edac-s10"
> -- interrupts : Should be single bit error interrupt, then double bit error
> -	interrupt, in this order.
> +- interrupts : Should be single bit error interrupt.
>  
>  Example:
>  
>  	eccmgr {
>  		compatible = "altr,socfpga-s10-ecc-manager";
> -		interrupts = <0 15 4>, <0 95 4>;
> +		altr,sysmgr-syscon = <&sysmgr>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		interrupts = <0 15 4>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> +		ranges;
>  
>  		sdramedac {
>  			compatible = "altr,sdram-edac-s10";
> -			interrupts = <16 4>, <48 4>;
> +			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  	};
> -- 
> 2.7.4
> 
