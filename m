Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49134C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151482183F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014501;
	bh=S3iwlw+f7aQap6TYWLtp8ipTZUVLbhNVYpsYOkOkKI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yPVmuw8JbqRqx2fHXoXpo+V7mIIATllUdq28s/0XGy+FU9qE/Q9IVb1la2uAM93/e
	 FiWXAiG249DEF2pyFGUE2wuY/9Ta718SxtkIvcI4mbcUg9dMTh+pC6Q8Vv9ssem3DJ
	 ZJI6BeqNGLNPyjy63x58x6HFKyGGgrDuGTedPBfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbfCaGlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37007 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731218AbfCaGlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id q6so2934495pll.4;
        Sat, 30 Mar 2019 23:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=bU4MgfG1WWHlRRgA/0eLpVSHSCS8LTESu+fxUu1mbCQ=;
        b=UEhU6Q4Jz322z/RXW+R9OJ1km3tIWWut+e4Ev+eoSYT/pmrEvc1p6OmDgCIHHTGgJF
         AmGh19DPu4bxC0ffMchiQodU6GEX1iuLLwWWY/sr4GnCjHFTsuTMiF8I5A3vTnhZTppa
         NNOYrRxusW8shZhNPyjpQTN9nigUQVBsJqPyo/Dqu7II1MnBBnJ4fD0FKh9q/cODyN/C
         YQqRF2A7MSK6Jf7D00fIGneq+Ula+lapnzyNLlvwMZ228ZzWCTmAxksenPDcxrehbExK
         dZrQf8yT0POoLL5CEtoWWOgAtXRtBBZJRe9NgnjsM4g0q3qxfVk1rXvaptjgS8CQXKoD
         nDTg==
X-Gm-Message-State: APjAAAX/MSo1VqE+iB2nOTRABYUNpio2VkRNki8g4/46B6OZRzTDShrS
        Fgq4F8nkeycXEesmAzPUnSFYboEBBg==
X-Google-Smtp-Source: APXvYqwHnGx47HrYtQWau4kLqTvuh/LGWMCG1pB6GZZx6eeCVpIh5ol2bQJrkn4US84yI5rKHR+c/A==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9mr56367056plk.223.1554014496386;
        Sat, 30 Mar 2019 23:41:36 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id p81sm11941053pfi.186.2019.03.30.23.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:35 -0700 (PDT)
Message-ID: <5ca0611f.1c69fb81.662b9.c6a0@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     qiaozhou <qiaozhou@asrmicro.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: clocks: add ASR8751C bindings
References: <1553349688-1946-1-git-send-email-qiaozhou@asrmicro.com>
 <1553349688-1946-4-git-send-email-qiaozhou@asrmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553349688-1946-4-git-send-email-qiaozhou@asrmicro.com>
X-Mutt-References: <1553349688-1946-4-git-send-email-qiaozhou@asrmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 10:01:24PM +0800, qiaozhou wrote:
> From: Qiao Zhou <qiaozhou@asrmicro.com>
> 
> Add binding documentation for ASR8751C clocks, which are general gating
> fixed rate and fixed ratio clocks derived from system PLL, external
> oscillator. These clocks control registers are distributed on different
> sub-controller-unit on SoCs, like APMU, MPMU, CIU etc.
> 
> Signed-off-by: qiaozhou <qiaozhou@asrmicro.com>
> ---
>  .../devicetree/bindings/clock/asr,clock.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/asr,clock.txt

Patch 5 can be combined with this one. It is part of the binding.

> 
> diff --git a/Documentation/devicetree/bindings/clock/asr,clock.txt b/Documentation/devicetree/bindings/clock/asr,clock.txt
> new file mode 100644
> index 0000000..93082a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/asr,clock.txt
> @@ -0,0 +1,31 @@
> +* Clock Controller of ASR8751C SoCs
> +
> +clock subsystem generates and supplies clock to various controllers within the
> +ASR8751C SoC.
> +
> +Required Properties:
> +
> +- compatible: should be "asr,8751c-clock"
> +
> +- reg: iomem address and length of the clock subsystem. There are 7 places in
> +  SOC has clock control logic: "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu",
> +  "ddrc".

You should probably have a node for each of these blocks if they are 
separate blocks. DT nodes should match h/w blocks.

> +- reg-names: register names of each sub control logic.
> +- interrupts : Should be the interrupt number

However, how do all the blocks have a single interrupt unless it's a 
shared interrupt.

> +- #clock-cells: should be 1.

Clock controllers need some input clocks to have any output clocks.

> +
> +Example:
> +
> +	soc_clocks: clocks@d4050000{
> +		compatible = "asr,8751c-clock";
> +		reg = <0x0 0xd4050000 0x0 0x209c>,
> +		      <0x0 0xd4282800 0x0 0x400>,
> +		      <0x0 0xd4015000 0x0 0x1000>,
> +		      <0x0 0xd4090000 0x0 0x1000>,
> +		      <0x0 0xd4282c00 0x0 0x400>,
> +		      <0x0 0xd8440000 0x0 0x98>,
> +		      <0x0 0xd4200000 0x0 0x4280>;
> +		reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc";
> +		interrupts = <0 96 IRQ_TYPE_LEVEL_HIGH>;
> +		#clock-cells = <1>;
> +	};
> -- 
> 2.7.4
> 

