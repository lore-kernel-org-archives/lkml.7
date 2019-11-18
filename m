Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA01C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F92720866
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pODaG8n7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfKRJRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:17:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40830 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfKRJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:17:42 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI98AaL017764;
        Mon, 18 Nov 2019 10:17:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=tqobyadLeAxpEq1ZLIJ+JS/D2nGNCMa0KHm8m0SjMUo=;
 b=pODaG8n7/O3DyohIF7W4b4wbC2jktE3yI0ppa8+LZ/NH8BlRCDcBEDaK0zzy9MKSL7MI
 ycuzcyFdGFStGQ2t66U28H0urlSoBTMD9w9Xz5pev+dkXrlZ+1u2eZ4sjS6xnl1D3LwF
 5bD1YxTSI4nkpQkM8i4LcYGu2urFtyxiV4YFJY06/8osZ3hbiymguD7xLrMGUl6hrBl+
 yR+Uh+uxpSzaTQLAomUyAlSdzSOYHigEShwN1F3KhhBzdQ7dZzmjEP9RuhcEhMk3R17O
 ykkOf2Ylbj25Cy7LO34pC0Vw04asJNmCdxGGdTRQCPPu69oUBG5IBFDE2yVy8gJClUHr BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wa9uv0f78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 10:17:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ADF4C100034;
        Mon, 18 Nov 2019 10:17:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7BFB72BC119;
        Mon, 18 Nov 2019 10:17:27 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Nov
 2019 10:17:26 +0100
Subject: Re: [PATCH] dt-bindings: mailbox: convert stm32-ipcc to json-schema
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20191115145915.6887-1-arnaud.pouliquen@st.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <f0fc3a1f-69f6-be73-ed24-b3111cf59ee0@st.com>
Date:   Mon, 18 Nov 2019 10:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115145915.6887-1-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/19 3:59 PM, Arnaud Pouliquen wrote:
> Convert the STM32 IPCC bindings to DT schema format using
> json-schema
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   .../bindings/mailbox/st,stm32-ipcc.yaml       | 91 +++++++++++++++++++
>   .../bindings/mailbox/stm32-ipcc.txt           | 47 ----------
>   2 files changed, 91 insertions(+), 47 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>   delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
> new file mode 100644
> index 000000000000..6843d51d96da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: STM32 GPIO and Pin Mux/Config controller
oops stupid copy/past, V2 coming soon
> +
> +description: |
> +  The IPCC block provides a non blocking signaling mechanism to post and
> +  retrieve messages in an atomic way between two processors.
> +  It provides the signaling for N bidirectionnal channels. The number of
> +  channels (N) can be read from a dedicated register.
> +
> +maintainers:
> +  - Fabien Dessenne <fabien.dessenne@st.com>
> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp1-ipcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +     maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: rx channel occupied
> +      - description: tx channel free
> +      - description: wakeup source
> +    minItems: 2
> +    maxItems: 3
> +
> +  interrupt-names:
> +    items:
> +      enums: [ rx, tx, wakeup ]
> +    minItems: 2
> +    maxItems: 3
> +
> +  wakeup-source:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Enables wake up of host system on wakeup IRQ assertion.
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  st,proc-id:
> +    description: Processor id using the mailbox (0 or 1)
> +    allOf:
> +      - minimum: 0
> +      - maximum: 1
> +      - default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - st,proc-id
> +  - clocks
> +  - interrupt-names
> +  - "#mbox-cells"
> +
> +oneOf:
> +  - required:
> +      - interrupts
> +  - required:
> +      - interrupts-extended
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    ipcc: mailbox@4c001000 {
> +      compatible = "st,stm32mp1-ipcc";
> +      #mbox-cells = <1>;
> +      reg = <0x4c001000 0x400>;
> +      st,proc-id = <0>;
> +      interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
> +      		      <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
> +      		      <&aiec 62 1>;
> +      interrupt-names = "rx", "tx", "wakeup";
> +      clocks = <&rcc_clk IPCC>;
> +      wakeup-source;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> deleted file mode 100644
> index 1d2b7fee7b85..000000000000
> --- a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* STMicroelectronics STM32 IPCC (Inter-Processor Communication Controller)
> -
> -The IPCC block provides a non blocking signaling mechanism to post and
> -retrieve messages in an atomic way between two processors.
> -It provides the signaling for N bidirectionnal channels. The number of channels
> -(N) can be read from a dedicated register.
> -
> -Required properties:
> -- compatible:   Must be "st,stm32mp1-ipcc"
> -- reg:          Register address range (base address and length)
> -- st,proc-id:   Processor id using the mailbox (0 or 1)
> -- clocks:       Input clock
> -- interrupt-names: List of names for the interrupts described by the interrupt
> -                   property. Must contain the following entries:
> -                   - "rx"
> -                   - "tx"
> -                   - "wakeup"
> -- interrupts:   Interrupt specifiers for "rx channel occupied", "tx channel
> -                free" and "system wakeup".
> -- #mbox-cells:  Number of cells required for the mailbox specifier. Must be 1.
> -                The data contained in the mbox specifier of the "mboxes"
> -                property in the client node is the mailbox channel index.
> -
> -Optional properties:
> -- wakeup-source: Flag to indicate whether this device can wake up the system
> -
> -
> -
> -Example:
> -	ipcc: mailbox@4c001000 {
> -		compatible = "st,stm32mp1-ipcc";
> -		#mbox-cells = <1>;
> -		reg = <0x4c001000 0x400>;
> -		st,proc-id = <0>;
> -		interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
> -				      <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
> -				      <&aiec 62 1>;
> -		interrupt-names = "rx", "tx", "wakeup";
> -		clocks = <&rcc_clk IPCC>;
> -		wakeup-source;
> -	}
> -
> -Client:
> -	mbox_test {
> -		...
> -		mboxes = <&ipcc 0>, <&ipcc 1>;
> -	};
