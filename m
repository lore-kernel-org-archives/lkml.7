Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1612C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9702073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="h2X6yxD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKOR26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:28:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727543AbfKOR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:28:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFHR2Bb022462;
        Fri, 15 Nov 2019 18:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Vv7O4F/V6ixbd+frkI+QsLdh11OHFWF8Mp0fyUbyBg0=;
 b=h2X6yxD6m5aDfzGWZpbtttJkSWPTPGMF/bYfW1y0BmuIFWW34L3iPPFXb9ZFRSYLRWzr
 SrFcLyKeGJtk7cUIg2JXzYuyMB9rWka9B/kq7nalJz1cil53mGaNeF11kRyuQT/Cx2oW
 bUhzLtmkXnt35aTBNMWBKT4sGgqcU4k1K8ZZLgJir0l+oHyzbi7R9PZwpswOAWHUN2cq
 axV1enA8CNNgA2sz5r9QwYffuPULi6FFgyJaQCPT6GbOciPA+aVv1g0YWqeUN2Yxz/dH
 /r+IamdHqcYoPgFMl2yuxwuKAqSrFJgKH0CtFsnrVKGjxLkAnr457pvO2Y1ZvVvXXL3G sQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2w7psbng5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 18:28:35 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 50B4E10002A;
        Fri, 15 Nov 2019 18:28:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AF022D3777;
        Fri, 15 Nov 2019 18:28:33 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 Nov
 2019 18:28:32 +0100
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert stm32-exti to
 json-schema
To:     Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20191114164104.22782-1-alexandre.torgue@st.com>
 <CAL_JsqKJZwJ0MyRp37Y-F0ujPdVEKARd8qcUCN1xmawpkiffLg@mail.gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <7415fff5-030c-a65b-a405-a1197e166432@st.com>
Date:   Fri, 15 Nov 2019 18:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKJZwJ0MyRp37Y-F0ujPdVEKARd8qcUCN1xmawpkiffLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_05:2019-11-15,2019-11-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/19 6:18 PM, Rob Herring wrote:
> On Thu, Nov 14, 2019 at 10:41 AM Alexandre Torgue
> <alexandre.torgue@st.com> wrote:
>>
>> Convert the STM32 external interrupt controller (EXTI) binding to DT
>> schema format using json-schema.
>>
>> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
>> ---
>>
>> Hi Rob,
>>
>> I planned to use "additionalProperties: false" for this schema but as I add a
>> property under condition, I got an error (property added under contion seems
>> to be detected as an "additional" property and then error is raised).
>>
>> Is there a way to fix that ?
> 
> See below.
> 
>>
>> regards
>> Alex
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>> deleted file mode 100644
>> index cd01b2292ec6..000000000000
>> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.txt
>> +++ /dev/null
>> @@ -1,29 +0,0 @@
>> -STM32 External Interrupt Controller
>> -
>> -Required properties:
>> -
>> -- compatible: Should be:
>> -    "st,stm32-exti"
>> -    "st,stm32h7-exti"
>> -    "st,stm32mp1-exti"
>> -- reg: Specifies base physical address and size of the registers
>> -- interrupt-controller: Indentifies the node as an interrupt controller
>> -- #interrupt-cells: Specifies the number of cells to encode an interrupt
>> -  specifier, shall be 2
>> -- interrupts: interrupts references to primary interrupt controller
>> -  (only needed for exti controller with multiple exti under
>> -  same parent interrupt: st,stm32-exti and st,stm32h7-exti)
>> -
>> -Optional properties:
>> -
>> -- hwlocks: reference to a phandle of a hardware spinlock provider node.
>> -
>> -Example:
>> -
>> -exti: interrupt-controller@40013c00 {
>> -       compatible = "st,stm32-exti";
>> -       interrupt-controller;
>> -       #interrupt-cells = <2>;
>> -       reg = <0x40013C00 0x400>;
>> -       interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>> -};
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>> new file mode 100644
>> index 000000000000..39be37e1e532
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: GPL-2.0
> 
> If ST has copyright on the old binding, can you add BSD here.
> 

I will.

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/st,stm32-exti.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32 External Interrupt Controller Device Tree Bindings
>> +
>> +maintainers:
>> +  - Alexandre Torgue <alexandre.torgue@st.com>
>> +  - Ludovic Barre <ludovic.barre@st.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +        - enum:
>> +          - st,stm32-exti
>> +          - st,stm32h7-exti
>> +      - items:
>> +        - enum:
>> +          - st,stm32mp1-exti
>> +        - const: syscon
>> +
>> +  "#interrupt-cells":
>> +    const: 2
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  hwlocks:
>> +    maxItems: 1
>> +    description:
>> +      Reference to a phandle of a hardware spinlock provider node.
>> +
>> +required:
>> +  - "#interrupt-cells"
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - st,stm32-exti
>> +              - st,stm32h7-exti
>> +    then:
>> +      properties:
>> +        interrupts:
>> +          allOf:
>> +            - $ref: /schemas/types.yaml#/definitions/uint32-array
> 
> Standard property, doesn't need a type. You just need 'maxItems' or an
> 'items' list if the index is not meaningful. This appears to be the
> former case.

ok

> 
>> +          description:
>> +            Interrupts references to primary interrupt controller
>> +      required:
>> +        - interrupts
> 
> You can move the definition to the main section as you only need
> 'required' here. That should fix your additionalProperties issue.
> 
Doing that it fails as I don't have interrupts define for mp1 
compatible. Maybe I missed something ?

> In hindsight, the mp1 case probably should have used interrupt-map.

For MP1 driver is written differently and mapping is done inside the driver.

> 
>> +
>> +examples:
>> +  - |
>> +    //Example 1
>> +    exti1: interrupt-controller@5000d000 {
>> +        compatible = "st,stm32mp1-exti", "syscon";
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        reg = <0x5000d000 0x400>;
>> +    };
>> +
>> +    //Example 2
>> +    exti2: interrupt-controller@40013c00 {
>> +        compatible = "st,stm32-exti";
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        reg = <0x40013C00 0x400>;
>> +        interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>> +    };
>> +
>> +...
>> --
>> 2.17.1
>>
