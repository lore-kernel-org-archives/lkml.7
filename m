Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432DEC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145A72146F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 02:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558320956;
	bh=8BpeCF0fdOm1m1OcdQX6KdbUacYxfjUW3ylkXKDorQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qtqZOtBfRYgTc5MIHdVeuVJOBcgh3PiHMSRYTsrTsQEtJ5mtK9A7pSIm2L2AfMlV1
	 2WfxdCbo0T3RZyEHib/uhldnkuwL8RlPdsOYQINHYs+6jGrRwquW10tUCohew2Ap5n
	 u87HWhaTC1alXatj9g8grVSir1BNBbnKOamDAvcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfETCzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 22:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfETCzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 22:55:55 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C5B20644;
        Mon, 20 May 2019 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558320954;
        bh=8BpeCF0fdOm1m1OcdQX6KdbUacYxfjUW3ylkXKDorQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPWGhUPy/QNIJfz+MQNLhTPf2Xi6QEnDYnO1LG5uDwtCI6eJlayPJHKHCqZRqCX83
         1dM/GYtVl1kpyAym/jCfwPUQ9YVe1qVyQ4jbc7w+UHqEjbcf87QN/rKapRwHAuv93z
         AdUJ8zheqpZLoVxWKilv03EMhnsvTzph71EcyuVs=
Date:   Mon, 20 May 2019 10:55:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: nxp: frwy-ls1046a: add support for
 micron nor flash
Message-ID: <20190520025502.GK15856@dragon>
References: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
 <20190510130207.14330-4-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510130207.14330-4-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 01:00:24PM +0000, Pramod Kumar wrote:
> add micron nor flash support for ls1046a frwy board.
> 
> Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>

Prefix 'arm64: dts: frwy-ls1046a: ...' would be good enough.

> ---
>  .../boot/dts/freescale/fsl-ls1046a-frwy.dts     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> index de0d19c02944..890f07122dd0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> @@ -113,6 +113,23 @@
>  
>  };
>  
> +

Unnecessary newline.

Shawn

> +&qspi {
> +	num-cs = <1>;
> +	bus-num = <0>;
> +	status = "okay";
> +
> +	qflash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +	};
> +};
> +
>  #include "fsl-ls1046-post.dtsi"
>  
>  &fman0 {
> -- 
> 2.17.1
> 
