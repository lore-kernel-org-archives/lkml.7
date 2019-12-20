Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF755C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818262467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g2ShrcW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfLTLlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:41:55 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49560 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:41:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKBfOh9010342;
        Fri, 20 Dec 2019 05:41:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576842084;
        bh=w9s9i7Ww44rCNohjRaPm+5Se46XEGbZcF1GgQsc7m0Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=g2ShrcW3zsqpojqXbe9w2gE0RKYmB8+5O8Je41uReBbDOIVzuoSWzMKcrN8RZ33IS
         cFc+7H6gpdoA0RevVYJhRaAtfq/ESB7qdIAgAqBHwxyIaIkGlAASHYYvdyZzES6Jrw
         BV0ibljWPVgc2xfBtkCCg9IlytbXqrnmUDxNRTyY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBKBfOpe007487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Dec 2019 05:41:24 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 05:41:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 05:41:23 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKBfJ6t015527;
        Fri, 20 Dec 2019 05:41:20 -0600
Subject: Re: [PATCH V3 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <fugang.duan@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linux-imx@nxp.com>, <kernel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576827431-31942-2-git-send-email-qiangqing.zhang@nxp.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <0cecd3af-8bca-c0d3-1312-925624c63dbf@ti.com>
Date:   Fri, 20 Dec 2019 17:10:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1576827431-31942-2-git-send-email-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/19 1:07 PM, Joakim Zhang wrote:
> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
> for i.MX8 family SoCs.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> new file mode 100644
> index 000000000000..3ebe9cac5f20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
> @@ -0,0 +1,36 @@
> +Freescale INTMUX interrupt multiplexer
> +
> +Required properties:
> +
> +- compatible: Should be:
> +   - "fsl,imx-intmux"
> +- reg: Physical base address and size of registers.
> +- interrupts: Should contain the parent interrupt lines (up to 8) used to
> +  multiplex the input interrupts.
> +- clocks: Should contain one clock for entry in clock-names.
> +- clock-names:
> +   - "ipg": main logic clock
> +- interrupt-controller: Identifies the node as an interrupt controller.
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. The value must be 2.
> +   - the 1st cell: hardware interrupt number> +   - the 2nd cell: channel index, value must smaller than channels used

As per the xlate function, 1st cell is channel index and 2nd cell is hw
interrupt number no?

Thanks and regards,
Lokesh

> +
> +Optional properties:
> +
> +- fsl,intmux_chans: The number of channels used for interrupt source. The
> +  Maximum value is 8. If this property is not set in DT then driver uses
> +  1 channel by default.
> +
> +Example:
> +
> +	intmux@37400000 {
> +		compatible = "fsl,imx-intmux";
> +		reg = <0x37400000 0x1000>;
> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clk IMX8QM_CM40_IPG_CLK>;
> +		clock-names = "ipg";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> 
