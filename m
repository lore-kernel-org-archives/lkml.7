Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E1C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5B522CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 05:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbfHUF0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 01:26:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:61159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfHUF0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 01:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 22:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,411,1559545200"; 
   d="scan'208";a="329916334"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 22:26:17 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 51D70580258;
        Tue, 20 Aug 2019 22:26:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190820103133.53776-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqKvzogi9969fx9j6v58V5+EH-06tDx7-qy7xu84pGRSRA@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <47e6d40d-7997-d2af-95aa-022c30c36791@linux.intel.com>
Date:   Wed, 21 Aug 2019 13:26:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKvzogi9969fx9j6v58V5+EH-06tDx7-qy7xu84pGRSRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/8/2019 11:54 PM, Rob Herring wrote:
> On Tue, Aug 20, 2019 at 5:31 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>> changes in v2:
>>    As per Rob Herring review comments, the following updates
>>   - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>>   - filename is the compatible string plus .yaml
>>   - LGM: Lightning Mountain
>>   - update maintainer
>>   - add intel,syscon under property list
>>   - keep one example instead of two
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 72 ++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..ec177573aca6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> @@ -0,0 +1,72 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +
>> +description:
>> +  -  Add a new compatible to use the host controller driver with the
>> +     eMMC PHY on Intel's Lightning Mountain SoC.
>> +
>> +$ref: /schemas/types.yaml#definitions/phandle
>> +  description:
>> +    - It also requires a "syscon" node with compatible = "intel,lgm-chiptop",
>> +      "syscon" to access the eMMC PHY register.
> Not valid schema. Please build 'make dt_binding_check' and fix any warnings.
Hi Rob,

Thank you much for the review comments, will check and update .

With Best Regards
Vadivel
>> +
>> +properties:
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  compatible:
>> +    const: intel,lgm-emmc-phy
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  intel,syscon:
>> +    items:
>> +      - description:
>> +         - |
>> +           e-MMC phy module should include the following properties
>> +           * reg, Access the e-MMC, get the base address from syscon.
>> +           * reset, reset the e-MMC module.
>> +
>> +  clocks:
>> +    items:
>> +      - description: e-MMC phy module clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: emmcclk
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    emmc_phy: emmc_phy {
>> +        compatible = "intel,lgm-emmc-phy";
>> +        reg = <0xe0020000 0x100>;
>> +        intel,syscon = <&sysconf>;
>> +        clocks = <&emmc>;
>> +        clock-names = "emmcclk";
>> +        #phy-cells = <0>;
>> +    };
>> +
>> +...
>> --
>> 2.11.0
>>
