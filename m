Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCCC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD5921773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553776306;
	bh=Ji8JYbWFowMaTNuL2GSoDtJ512goMzV1R54gT6ymYHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jqbtmv3Ddh5MOdloN87yNxD0VsLnhuAwAB2hhdKd14z171Ju0013JS9VANcruIR1P
	 9cJSSklty/e9ThmolnZsDRsQWiJJCr8ikxjf5+Eg1AO/+Ts8iV88R7XIZOtABeblbd
	 FdoenwYiLrO9AJnzTp9T/zCx6Bh78HtgsidSn0RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Mbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:31:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37734 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Mbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:31:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id v84so15612168oif.4;
        Thu, 28 Mar 2019 05:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jN8VQLeLdPeuegt50wtXSE6gSv0rp96DGEtnOqgjROQ=;
        b=O7OobHuI54p3Lkqh3KZfHXhGJ7tegSegCEgA96BODPbWZmpW92jG0rP6ImeFS/8ATa
         K5HII8yBQ1bmXh8Lk76rLfFcF4ErnUwkrbNygb6FKxh+/IX/nloB6un95QExGVpTw2wd
         DSL/MwmZhHolEPzjbV7f1P+pZRGlbgrNmaB+aQxUGy/gNCrH9FriEb2mM+RIuj0JU1B5
         eBx7NyFAsXBVAJgyexoGvoI2yViEucXuodPOKMPoJ9myl3V+hlT1Bo7YzVZnAIjTshxF
         jGi1k3zgcn9vP8PZ5pqkB2N5cyct77IEBcJTcG24TcAlXFALgWRcdgpIlR48q94dFbnM
         JVSg==
X-Gm-Message-State: APjAAAXBD9loNPWt+3t87Pi8sMQRFh3j2dPtZG5w82DZVjE/dzelyxyN
        Zpun0Qy/VGROD5Av7UwUfQ==
X-Google-Smtp-Source: APXvYqyGb73TxAyiiyfso7eXaTYs1Imz4/C4sgsy0qfl0SOsjFtTIr6P+sC9Z9dMA28VUj6FmnfEcg==
X-Received: by 2002:aca:ef82:: with SMTP id n124mr18264730oih.177.1553776303770;
        Thu, 28 Mar 2019 05:31:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o16sm6788665ota.15.2019.03.28.05.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 05:31:42 -0700 (PDT)
Date:   Thu, 28 Mar 2019 07:31:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding documentation for TI
 syscon gate clock
Message-ID: <20190328123142.GA6229@bogus>
References: <20190312090518.28666-1-vigneshr@ti.com>
 <20190312090518.28666-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312090518.28666-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 02:35:17PM +0530, Vignesh Raghavendra wrote:
> Add dt bindings for TI syscon gate clock.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../bindings/clock/ti,syscon-gate-clock.txt   | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
> new file mode 100644
> index 000000000000..f2bc4281ddba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,syscon-gate-clock.txt
> @@ -0,0 +1,35 @@
> +TI syscon gate clock
> +
> +The gate clock node must be provided inside a system controller node.
> +
> +Required:
> +- comaptible: Must be "ti,syscon-gate-clock"
> +- reg: Offset of register that controls the clock within syscon regmap
> +- ti,clock-bit-idx: bit index that control gate/ungating of clock
> +- clocks: phandle to the clock parent
> +- #clock-cells: must be <0>
> +
> +Example:
> +	ctrlmmr_epwm_ctrl: syscon@104140{
> +		compatible = "syscon", "simple-bus";

Can't be both of these...

> +		reg = <0x0 0x104140 0x0 0x18>;
> +		ranges = <0x0 0x0 0x104140>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ehrpwm0_tbclk: clk@0 {
> +			compatible = "ti,syscon-gate-clock";
> +			reg = <0x0>;
> +			#clock-cells = <0>;
> +			clocks = <&k3_clks 40 0>;
> +			ti,clock-bit-idx = <0>;

This would imply you have multiple nodes at one address which is 
discouraged.

> +		};

We generally don't describe clocks as 1 clock per node. Give the parent 
a specific compatible and make it a clock provider.

> +
> +		ehrpwm1_tbclk: clk@4 {
> +			compatible = "ti,syscon-gate-clock";
> +			reg = <0x4>;
> +			#clock-cells = <0>;
> +			clocks = <&k3_clks 41 0>;
> +			ti,clock-bit-idx = <0>;
> +		};
> +	};
> -- 
> 2.21.0
> 
