Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17945C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8F020855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 09:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="isFqjCoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKUJGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:06:17 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45573 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfKUJGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 04:06:16 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL92o3F028033;
        Thu, 21 Nov 2019 10:05:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=X4UEF/oAolwYF/YR+6kYxpWAn7eU7vcEn3UoypO+JG0=;
 b=isFqjCoPRp7uBat+j6CYR/dWa1UNCWVfschlhEJZgZ0w9Vt0rqNlP0QrIW/Tu3aoBI8E
 Q5ofZpBXzNfR4sT0bvgGqO0gmciVFZ5SiDz5JrZ54Pw38+HBZJLgAmhcVpQyJjvhzAJQ
 M9aXvvKexcVW7ZUEHKczpCa/lXdb5tAtPKuOzyJEbTirnFNNz3ycIcUVGImHWacOhyh9
 23OEk3DTYXASh0HRTNm4taYBqOzxzfdznqneolE5S3wk4BxSrVShcznsAFUjnW6kpnMm
 /ZYJk17zbrqi+eu0pLO+UAm9Aa02mAV4x5tgQt2+qKrCG7RjxuXivOXV6feAhmtqui9z ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2wa9usj9ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 10:05:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 465C8100034;
        Thu, 21 Nov 2019 10:05:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 318C52B2376;
        Thu, 21 Nov 2019 10:05:53 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 10:05:52 +0100
Subject: Re: [PATCH v2] dt-bindings: mailbox: convert stm32-ipcc to
 json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20191118101420.23610-1-arnaud.pouliquen@st.com>
 <CAL_Jsq+42wx1AJO=jXXBhmaKMkBq-RtoF+kxVjS2z9fSwhcaEQ@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <9d3a1e61-4c75-fd5c-7142-111f08117530@st.com>
Date:   Thu, 21 Nov 2019 10:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+42wx1AJO=jXXBhmaKMkBq-RtoF+kxVjS2z9fSwhcaEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_01:2019-11-20,2019-11-21 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 9:26 PM, Rob Herring wrote:
> On Mon, Nov 18, 2019 at 4:15 AM Arnaud Pouliquen
> <arnaud.pouliquen@st.com> wrote:
>>
>> Convert the STM32 IPCC bindings to DT schema format using
>> json-schema
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>>  .../bindings/mailbox/st,stm32-ipcc.yaml       | 91 +++++++++++++++++++
>>  .../bindings/mailbox/stm32-ipcc.txt           | 47 ----------
>>  2 files changed, 91 insertions(+), 47 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> 
> Thanks for helping me find 2 meta-schema errors. :) Please update
> dt-schema and re-run 'make dt_binding_check'.
> 
it a privilege to help you to improve the scripts ;-)

Thanks for the reviews, based on it i will also update the following patch
dt-bindings: remoteproc: convert stm32-rproc to json-schema

Regards
Arnaud

>> diff --git a/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>> new file mode 100644
>> index 000000000000..90157d4deac1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/st,stm32-ipcc.yaml
>> @@ -0,0 +1,91 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/mailbox/st,stm32-ipcc.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: STMicroelectronics STM32 IPC controller bindings
>> +
>> +description:
>> +  The IPCC block provides a non blocking signaling mechanism to post and
>> +  retrieve messages in an atomic way between two processors.
>> +  It provides the signaling for N bidirectionnal channels. The number of
>> +  channels (N) can be read from a dedicated register.
>> +
>> +maintainers:
>> +  - Fabien Dessenne <fabien.dessenne@st.com>
>> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp1-ipcc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +     maxItems: 1
>> +
>> +  interrupts:
>> +    items:
>> +      - description: rx channel occupied
>> +      - description: tx channel free
>> +      - description: wakeup source
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  interrupt-names:
>> +    items:
>> +      enums: [ rx, tx, wakeup ]
> 
> 'enums' is not a valid keyword. 'enum' is valid, but his should be in
> a defined order (so a list of items).
> 
>> +    minItems: 2
>> +    maxItems: 3
>> +
>> +  wakeup-source:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Enables wake up of host system on wakeup IRQ assertion.
> 
> Just 'true' is enough here. Assume we have a common definition.
> 
>> +
>> +  "#mbox-cells":
>> +    const: 1
>> +
>> +  st,proc-id:
>> +    description: Processor id using the mailbox (0 or 1)
>> +    allOf:
>> +      - minimum: 0
>> +      - maximum: 1
> 
> 'enum: [ 0, 1 ]' is more concise.
> 
> Also, needs a $ref to the type.
> 
>> +      - default: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - st,proc-id
>> +  - clocks
>> +  - interrupt-names
>> +  - "#mbox-cells"
>> +
>> +oneOf:
>> +  - required:
>> +      - interrupts
>> +  - required:
>> +      - interrupts-extended
> 
> The tooling takes care of this for you. Just list 'interrupts' as required.
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/stm32mp1-clks.h>
>> +    ipcc: mailbox@4c001000 {
>> +      compatible = "st,stm32mp1-ipcc";
>> +      #mbox-cells = <1>;
>> +      reg = <0x4c001000 0x400>;
>> +      st,proc-id = <0>;
>> +      interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
>> +                     <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
>> +                     <&aiec 62 1>;
>> +      interrupt-names = "rx", "tx", "wakeup";
>> +      clocks = <&rcc_clk IPCC>;
>> +      wakeup-source;
>> +    };
>> +
>> +...
