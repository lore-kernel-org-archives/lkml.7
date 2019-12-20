Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC179C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFF521655
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Edqfovjo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfLTMb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:31:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35150 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfLTMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:31:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBKCVQhb094857;
        Fri, 20 Dec 2019 06:31:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576845086;
        bh=lmntjsYZD2zvLWbmw/UGvX0UwtRYBUAg3GKS2/RioC0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=EdqfovjoXUhrUmZVLvo8IG25HziLhocUDtW2NRqPV9bkHbuBhEdHxyBBXNbPNRPtA
         SMQVWE0yJrWuCdVCV8Gu3oO2MyJGbP1IipzHxhobmi9Jtr0aevopl2Qz0aJjaeDs/x
         BtzegG4jogMKo3v20oXUXYzq+5QXzD5DmdJCPnb8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKCVP4F030517;
        Fri, 20 Dec 2019 06:31:25 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 20
 Dec 2019 06:31:25 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 20 Dec 2019 06:31:25 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBKCVLPG099921;
        Fri, 20 Dec 2019 06:31:22 -0600
Subject: Re: [PATCH V3 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <maz@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>, <fugang.duan@nxp.com>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>
References: <1576827431-31942-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576827431-31942-2-git-send-email-qiangqing.zhang@nxp.com>
 <0cecd3af-8bca-c0d3-1312-925624c63dbf@ti.com>
Message-ID: <dab8f6ba-2b5e-7b98-55c9-ace98f14842e@ti.com>
Date:   Fri, 20 Dec 2019 18:00:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0cecd3af-8bca-c0d3-1312-925624c63dbf@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/12/19 5:10 PM, Lokesh Vutla wrote:
> 
> 
> On 20/12/19 1:07 PM, Joakim Zhang wrote:
>> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
>> for i.MX8 family SoCs.
>>
>> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
>> ---
>>  .../interrupt-controller/fsl,intmux.txt       | 36 +++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>> new file mode 100644
>> index 000000000000..3ebe9cac5f20
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.txt
>> @@ -0,0 +1,36 @@
>> +Freescale INTMUX interrupt multiplexer
>> +
>> +Required properties:
>> +
>> +- compatible: Should be:
>> +   - "fsl,imx-intmux"
>> +- reg: Physical base address and size of registers.
>> +- interrupts: Should contain the parent interrupt lines (up to 8) used to
>> +  multiplex the input interrupts.
>> +- clocks: Should contain one clock for entry in clock-names.
>> +- clock-names:
>> +   - "ipg": main logic clock
>> +- interrupt-controller: Identifies the node as an interrupt controller.
>> +- #interrupt-cells: Specifies the number of cells needed to encode an
>> +  interrupt source. The value must be 2.
>> +   - the 1st cell: hardware interrupt number> +   - the 2nd cell: channel index, value must smaller than channels used
> 
> As per the xlate function, 1st cell is channel index and 2nd cell is hw
> interrupt number no?

Sorry my bad, I read it wrong. Ignore this comment.

Thanks and regards,
Lokesh

> 
> Thanks and regards,
> Lokesh
> 
>> +
>> +Optional properties:
>> +
>> +- fsl,intmux_chans: The number of channels used for interrupt source. The
>> +  Maximum value is 8. If this property is not set in DT then driver uses
>> +  1 channel by default.
>> +
>> +Example:
>> +
>> +	intmux@37400000 {
>> +		compatible = "fsl,imx-intmux";
>> +		reg = <0x37400000 0x1000>;
>> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&clk IMX8QM_CM40_IPG_CLK>;
>> +		clock-names = "ipg";
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +	};
>> +
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
