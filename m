Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE248ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C042067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 05:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571203541;
	bh=CpGwGpjKAHqQTYg4UEjE/y+LBALFEvwCQFezYmpRHmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=azZB4ge8R5FIHhkF4XKbp4mglH029rV2UBr0dZYSDuEq9r/+LUwNZach3R47HVv4r
	 RvS2sgiwuUI3QcYe9knJQMqxdWGZYlOAGGtZ2ZxnRbIEebpKbHV37dxKTiwTWdDElj
	 iVZn/Y8WOfeLezzLDrHbrJWaTf2HCge/+0tSD00Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbfJPFZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 01:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfJPFZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:25:40 -0400
Received: from localhost (unknown [171.76.123.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D786C2067D;
        Wed, 16 Oct 2019 05:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571203539;
        bh=CpGwGpjKAHqQTYg4UEjE/y+LBALFEvwCQFezYmpRHmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdquSlDc2kLy//rFgmAZqpUHPrBi3e8qwVeDKI6ASf/dfL486KtD3J3qGdFeYvgdp
         yhJlWc3/oV2Ful+EVx8LMUIXTLPKAboBauaJManjt3qxzKuXvsmVg8CgBmrnIIMIGE
         0f3nMgJt1e0cV0SbQm79bPAwck/U3KFcitPDRaE4=
Date:   Wed, 16 Oct 2019 10:55:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH 2/2] arm64: dts: sc7180: Add minimal dts/dtsi files for
 SC7180 soc
Message-ID: <20191016052535.GC2654@vkoul-mobl>
References: <20191015103358.17550-1-rnayak@codeaurora.org>
 <20191015103358.17550-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015103358.17550-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-10-19, 16:03, Rajendra Nayak wrote:

> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	clocks {

Can we have these sorted alphabetically please

> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			clock-frequency = <38400000>;
> +			clock-output-names = "xo_board";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32764>;
> +			clock-output-names = "sleep_clk";
> +			#clock-cells = <0>;
> +		};
> +
> +		bi_tcxo: bi_tcxo {

why is this a clock defined here? Isnt this gcc clock?

-- 
~Vinod
