Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B652AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E30920842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551664182;
	bh=zRo6OZVs2iaEmQkB/4mwvw7u1FMqfZRQgoiE5VVlvv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oj7RXyVdEcFsloGL1AThmLoN+v/gD0Oa/FHqW/rMQnqMQPmW2OfQ/00w8wWRZ+vXK
	 IauJ7ThQPkQToByNKI87AHJ8UMBNUxMzlmRZbUQ5bgeq5IlQrZDbJll6uYcBmfAeQB
	 Etjlis1uGjACJC8gWPno0n8l5iDuRA7CCA8UVN9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDBtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:49:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfCDBtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:49:40 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C608A20835;
        Mon,  4 Mar 2019 01:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551664180;
        bh=zRo6OZVs2iaEmQkB/4mwvw7u1FMqfZRQgoiE5VVlvv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+gSSXFi5R5Q9EXHyD3ScWTcQHUtohbA5fxjKcGiLX3X7p0yXcbapXdpvw+6XYL+/
         50hXHKvxQyxocn7cbfwJ3BxloIivkymaNSgbPBthdNUIPIwotleHRr3oiRrMfocbkx
         OjhlWsoruKg6FC7PbN+dP305Ssegg8pWmI054EiE=
Date:   Mon, 4 Mar 2019 09:48:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alison Wang <alison.wang@nxp.com>
Cc:     leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ls1028a: add pmu dt nodes
Message-ID: <20190304014838.GV26041@dragon>
References: <20190227015752.18342-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227015752.18342-1-alison.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:57:52AM +0800, Alison Wang wrote:
> This patch adds pmu dt nodes for LS1028A.
> 
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index a8cf92a..36ef9c5 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -89,6 +89,11 @@
>  					  IRQ_TYPE_LEVEL_LOW)>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,armv8-pmuv3";

Shouldn't we use "arm,cortex-a72-pmu" as compatible for better?

Shawn

> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	gic: interrupt-controller@6000000 {
>  		compatible= "arm,gic-v3";
>  		#address-cells = <2>;
> -- 
> 1.7.1
> 
