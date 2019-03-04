Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE3120842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 01:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551662559;
	bh=Zf+JwxpBZVGZZ7tciG6zYafkXpodmMMifsu5N0TiU84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1I9Kg9mHBMn/gbresjKgEO8lBmKbAW/T359r46fYLSsHUN/iZhA5iH7bPMEYaNZmJ
	 AkU5GpS34pBSTLJQxaW+orV9nrOmFDd+mEgHTkNF5Ti04jpRl7RPVtpzuoKWe8Bxwk
	 vc1EnO9FltmU8NfuxdkEZzO0J128Y1MDXy8Duoeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCDBWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 20:22:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfCDBWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 20:22:37 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8353E20818;
        Mon,  4 Mar 2019 01:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551662557;
        bh=Zf+JwxpBZVGZZ7tciG6zYafkXpodmMMifsu5N0TiU84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D5H3/M5G8ujUyhE0t0uD4n6pj7JL4AOhQwm4v3xkEIHd/ankeT5CjOVC3WlfD+Oh5
         +nNNt3/hcnUG87jCjXyRgpgcvz9kyGpOLL19dKu5jnzipxXCrQl2XvG3ykmRLEIuq2
         tcqo6chhiy/xccUCvGwlxzBHwyQi+7Kak6CDKnNM=
Date:   Mon, 4 Mar 2019 09:21:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Y.b. Lu" <yangbo.lu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ls1021aqds: enable esdhc controller
Message-ID: <20190304012131.GS26041@dragon>
References: <20190226084121.41499-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226084121.41499-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:40:22AM +0000, Yinbo Zhu wrote:
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> 
> This patch is to enable esdhc controller in ls1021aqds
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Changed the subject prefix to 'ARM: dts: ls1021a-qds: ...' and applied
the patch.

Shawn

> ---
> Change in v2:
> 		Add patch code after &enet2 to keep them sort alphabetically.
> 
>  arch/arm/boot/dts/ls1021a-qds.dts |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index dac61e7..ae26f8b 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -160,6 +160,10 @@
>  	status = "okay";
>  };
>  
> +&esdhc {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
