Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A0FC742D2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795772089C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563120800;
	bh=6mzIaXCVd2Suq63Kfrh4nwfSHOSzsx2csQwxz2Vm51g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PO6iHhJY1sCTOhnaIiuluYdKe4AUnscNlNTCsuhChfnUSGI5uhniinVdn4KxZ8bKI
	 c1taELHM8gY2YSbhG5HTiOb2O2JeCK/cD409GPhkpTthftLXbFr5oAt636C/vul2oT
	 VAR9MrQfGPIStpIFEXn95ReCpgBihN9/0t5HREbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfGNQNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 12:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfGNQNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 12:13:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0EF205F4;
        Sun, 14 Jul 2019 16:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563120798;
        bh=6mzIaXCVd2Suq63Kfrh4nwfSHOSzsx2csQwxz2Vm51g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1F2MgzaqnRI76BsCuiJVNGDb2ty0OrJ0yHX+MPGYLkxHAzhJl8ZABS4hI0pLpVGwv
         xTfLoB+6CoVn5WlCpdf9+SGA5MsePgNHs4AqWnvBVOyIUiKtAV4B7zX7ARzEWc+LKX
         9+C33CsAYxdj76tiQVovtN9QXczS8nZ9ak42rLvs=
Date:   Sun, 14 Jul 2019 17:13:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: stm32: add syscfg to ADC on
 stm32mp157c
Message-ID: <20190714171310.1816afe3@archlinux>
In-Reply-To: <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
References: <1562148496-26789-1-git-send-email-fabrice.gasnier@st.com>
        <1562148496-26789-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 12:08:16 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> On stm32mp157c, the ADC inputs are multiplexed with analog switches which
> have reduced performances when their supply is below 2.7V (vdda by
> default).
> Add syscfg registers that can be used on stm32mp157c, to get full ADC
> analog performances.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I've applied the patches using this on the assumption this will go via
the usual SoC route.

Thanks,

Jonathan

> ---
>  arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
> index 2dd5162..b9a5b58 100644
> --- a/arch/arm/boot/dts/stm32mp157c.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157c.dtsi
> @@ -862,6 +862,7 @@
>  			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
>  			clock-names = "bus", "adc";
>  			interrupt-controller;
> +			st,syscfg = <&syscfg>;
>  			#interrupt-cells = <1>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;

