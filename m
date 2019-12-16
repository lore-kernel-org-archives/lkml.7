Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E3C2D0CF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151A3206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="pdne5z84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLPIoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:44:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57112 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbfLPIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:44:31 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBG8Y0Db017279;
        Mon, 16 Dec 2019 09:44:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=PJqSVGtMd6PUNoyoHJdaGLduaNwj7hJN0wsA7xo1/94=;
 b=pdne5z84gtgpxXRktsXb4F+rtlwA9UQQ+B2R0Dzw7lIMYHpPdZ4gSmGbFz9JuZIuPSe0
 bHKsG713AUuO2j/CHmUhuKc2uBdza2qZCjEX4JdVaMJN7QpMPo568bokRW5PGU0iqB7Z
 K3zUpsX0h+qthruKdkRDwGQNdPy02ps4MpHVAp+aWd44DLBhHLpJgigT5mr13PTWhxlG
 db4wZsjPc6wSv2Z9yp3HNiH4Eree73v4VXff+QwS/KJD0MAXmu3VmKQ6TpDaPFzIDBtE
 H/P8fZ51mvrxWthrDXXa6B6FKPrF1I9ZhIZ3xgbFeuTWRusjT/i6kvD0yQfkbfL35iLl LA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wvqgpg3gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Dec 2019 09:44:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42482100039;
        Mon, 16 Dec 2019 09:44:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 33C082B5463;
        Mon, 16 Dec 2019 09:44:16 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.49) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Dec
 2019 09:44:15 +0100
Subject: Re: [PATCH] dt-bindings: stm32: convert mlahb to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
References: <20191128154603.6911-1-arnaud.pouliquen@st.com>
 <20191213213916.GA1292@bogus>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <7ac83aa6-0ec6-db4f-556d-a17c28d2bcab@st.com>
Date:   Mon, 16 Dec 2019 09:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191213213916.GA1292@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-16_01:2019-12-16,2019-12-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 12/13/19 10:39 PM, Rob Herring wrote:
> On Thu, Nov 28, 2019 at 04:46:03PM +0100, Arnaud Pouliquen wrote:
>> Convert the ML-AHB bus bindings to DT schema format using json-schema
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> ---
>> Notice that this patch requests an update of the simple-bus schema to add
>> the support of the "dma-ranges" property.
>> A Pull request has been sent in parallel to the dt-schema github repo:
>> https://github.com/devicetree-org/dt-schema/pull/30
>>
>> To remind the topic around the use of "dma-ranges" please
>> refer to following discussion: https://lkml.org/lkml/2019/4/3/1261
>> ---
>>  .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
>>  .../bindings/arm/stm32/st,mlahb.yaml          | 69 +++++++++++++++++++
>>  2 files changed, 69 insertions(+), 37 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>> deleted file mode 100644
>> index 25307aa1eb9b..000000000000
>> --- a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
>> +++ /dev/null
>> @@ -1,37 +0,0 @@
>> -ML-AHB interconnect bindings
>> -
>> -These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
>> -a Cortex-M subsystem with dedicated memories.
>> -The MCU SRAM and RETRAM memory parts can be accessed through different addresses
>> -(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
>> -Cortex-M firmware accesses among those ports allows to tune the system
>> -performance.
>> -
>> -[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
>> -[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
>> -
>> -Required properties:
>> -- compatible: should be "simple-bus"
>> -- dma-ranges: describes memory addresses translation between the local CPU and
>> -	   the remote Cortex-M processor. Each memory region, is declared with
>> -	   3 parameters:
>> -		 - param 1: device base address (Cortex-M processor address)
>> -		 - param 2: physical base address (local CPU address)
>> -		 - param 3: size of the memory region.
>> -
>> -The Cortex-M remote processor accessed via the mlahb interconnect is described
>> -by a child node.
>> -
>> -Example:
>> -mlahb {
>> -	compatible = "simple-bus";
>> -	#address-cells = <1>;
>> -	#size-cells = <1>;
>> -	dma-ranges = <0x00000000 0x38000000 0x10000>,
>> -		     <0x10000000 0x10000000 0x60000>,
>> -		     <0x30000000 0x30000000 0x60000>;
>> -
>> -	m4_rproc: m4@10000000 {
>> -		...
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
>> new file mode 100644
>> index 000000000000..8ad3f7c7f9ab
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: STMicroelectronics STM32 ML-AHB interconnect bindings
>> +
>> +maintainers:
>> +  - Fabien Dessenne <fabien.dessenne@st.com>
>> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> +
>> +description: |
>> +  These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
>> +  a Cortex-M subsystem with dedicated memories. The MCU SRAM and RETRAM memory
>> +  parts can be accessed through different addresses (see "RAM aliases" in [1])
>> +  using different buses (see [2]): balancing the Cortex-M firmware accesses
>> +  among those ports allows to tune the system performance.
>> +  [1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
>> +  [2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
>> +
>> +allOf:
>> + - $ref: /schemas/simple-bus.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    contains:
>> +      enum:
>> +        - st,mlahb
>> +
>> +  dma-ranges:
>> +    description: |
>> +      Describe memory addresses translation between the local CPU and the
>> +      remote Cortex-M processor. Each memory region, is declared with
>> +      3 parameters:
>> +      - param 1: device base address (Cortex-M processor address)
>> +      - param 2: physical base address (local CPU address)
>> +      - param 3: size of the memory region.
>> +    maxItems: 3
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - '#address-cells'
>> +  - '#size-cells'
>> +  - dma-ranges
>> +
>> +examples:
>> +  - |
>> +    mlahb: ahb {
>> +      compatible = "st,mlahb", "simple-bus";
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      reg = <0x10000000 0x40000>;
>> +      dma-ranges = <0x00000000 0x38000000 0x10000>,
>> +                   <0x10000000 0x10000000 0x60000>,
>> +                   <0x30000000 0x30000000 0x60000>;
>> +
> 
> Fails to build:
> 
> builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dt.yaml: 
> ahb: 'ranges' is a required property
> 
> Run 'make dt_binding_check'

Yes, that why i posted in parallel the PR on the tool:
https://github.com/devicetree-org/dt-schema/pull/30. 

I don't know if you saw my answer on this post so i copy/paste  it here:

How to describe the stm32mp1 coprocessor mapping and translations based on this "ranges" requirement?

On stm32mp1 we have 2 RAM memories accessible by the Cortex-A7 running Linux and used by the Cortex-M4 coprocessor to run its code. Each Cortex has a specific mapping of the memories. Some memory translations are needed by:

- rproc driver to load the Cortex-M4 firmware in RAMs
- rpmsg & virtio frameworks for shared memory

Here is the memory mapping:

- RETRAM (64 kB);
  - Cortex-A7 @ : 0x38000000
  - Cortex-M4 @: 0x00000000
- MCUSRAM (up to 384 kB)
  - Cortex-A7 @ : 0x30000000 or 0x10000000 ( 2 addresses for the same memory)
  - Cortex-M4 @: 0x30000000 or 0x10000000 ( 2 addresses for the same memory)
  =>addresses used on both side depend on the MCURAM access optimization

Today our upstreamed solution is based on dma-range only (https://lkml.org/lkml/2019/4/3/1261)

What about adding an "unused" ranges property in DT to match the requirement?

	mlahb {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 0x38000000 0x10000>,
			       <1 0x10000000 0x60000>,
			       <2 0x30000000 0x60000>;
		dma-ranges = <0x00000000 0x38000000 0x10000>,
			     <0x10000000 0x10000000 0x60000>,
			     <0x30000000 0x30000000 0x60000>;

		m4_rproc: m4@10000000 {
		        ---
		};
	};

Thanks in advance for your feedback.
Regards,
Arnaud

> 
>> +      m4_rproc: m4@10000000 {
>> +       reg = <0x10000000 0x40000>;
>> +      };
>> +    };
>> +
>> +...
>> -- 
>> 2.17.1
>>
