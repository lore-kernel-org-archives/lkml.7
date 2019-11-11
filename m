Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE60C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8514A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKHfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:35:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:12187 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfKKHfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:35:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Nov 2019 23:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,291,1569308400"; 
   d="scan'208";a="354702768"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2019 23:35:03 -0800
Received: from [10.226.38.147] (unknown [10.226.38.147])
        by linux.intel.com (Postfix) with ESMTP id 5DD88580261;
        Sun, 10 Nov 2019 23:35:01 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Vignesh Raghavendra <vigneshr@ti.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, robh+dt@kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20191030081155.29947-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191030081155.29947-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <b553b1e8-1c35-fd7c-6855-75a4c1c943fe@ti.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <51fa7c46-20d0-2712-8690-1d6a885cb98b@linux.intel.com>
Date:   Mon, 11 Nov 2019 15:35:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b553b1e8-1c35-fd7c-6855-75a4c1c943fe@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 5/11/2019 12:30 PM, Vignesh Raghavendra wrote:
> Hi,
>
> On 30/10/19 1:41 PM, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
> The new driver being added in patch 2/2 is supposed to replace
> drivers/mtd/spi-nor/cadence-quadspi.c. Therefore the bindings should be
> exactly same as
> Documentation/devicetree/bindings/mtd/cadence-quadspi.txt. Otherwise, it
> breaks DT backward compatibility. There cannot be two different sets of
> bindings for same HW IP.
>
> Therefore please rewrite yaml schema to match existing bindings at
> Documentation/devicetree/bindings/mtd/cadence-quadspi.txt.
> And then include a patch dropping older bindings.
sure, I will create dt-schema for the below file

Documentation/devicetree/bindings/mtd/cadence-quadspi.txt

---
With Best Regards
Vadivel

>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/spi/cadence,qspi.yaml      | 65 ++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
>> new file mode 100644
>> index 000000000000..295501f01e5e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/spi/cadence,qspi.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Cadence QSPI Flash Controller support
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +allOf:
>> +  - $ref: "spi-controller.yaml#"
>> +
>> +description: |
>> +  Add support for the Cadence QSPI controller,This controller is
>> +  present in the Intel LGM, Altera SoCFPGA and TI SoCs and this driver
>> +  has been tested On Intel's LGM SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: cadence,qspi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clocks-names:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  reset-names:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +
>> +examples:
>> +  - |
>> +    spi@ec000000 {
>> +          compatible = "cadence,qspi";
>> +          reg = <0xec000000 0x100>;
>> +          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
>> +          clock-names = "qspi";
>> +          resets = <&rcu0 0x10 1>;
>> +          reset-names = "qspi";
>> +          #address-cells = <1>;
>> +          #size-cells = <0>;
>> +
>> +          flash: flash@1 {
>> +              compatible = "spi-nand", "jedec, spi-nor";
> s/"jedec, spi-nor"/"jedec,spi-nor" (i.e no space after comma)
>
>> +              reg = <1>;
>> +              spi-max-frequency = <10000000>;
>> +          };
>> +    };
>> +
>>
