Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E095233A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 05:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfHVFoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 01:44:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:5691 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfHVFoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:44:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 22:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="169651574"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2019 22:44:09 -0700
Received: from [10.226.38.19] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.19])
        by linux.intel.com (Postfix) with ESMTP id 73E04580258;
        Wed, 21 Aug 2019 22:44:07 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190821101118.42774-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_Jsq+pyaYD2C8G1WZm1fL-wgkJvDYBkp0TwJTmQVKP-gHPXQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <67bca68e-a46b-e03f-bb66-23c677d8515d@linux.intel.com>
Date:   Thu, 22 Aug 2019 13:44:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+pyaYD2C8G1WZm1fL-wgkJvDYBkp0TwJTmQVKP-gHPXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 21/8/2019 9:35 PM, Rob Herring wrote:
> On Wed, Aug 21, 2019 at 5:11 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>> changes in v3:
>>    - resolve 'make dt_binding_check' warnings
>>
>> changes in v2:
>>    As per Rob Herring review comments, the following updates
>>   - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>>   - filename is the compatible string plus .yaml
>>   - LGM: Lightning Mountain
>>   - update maintainer
>>   - add intel,syscon under property list
>>   - keep one example instead of two
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 59 ++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..9342e33d8b02
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> @@ -0,0 +1,59 @@
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
>> +  syscon:
> intel,syscon like the example. You must have used 5.2 as on 5.3-rc the
> example will fail validation.
Thanks for the review comments,  used 5.3 for validation, after 
addressing the below comments
once again validate on both 5.2 and 5.3 as well.
>> +    items:
> Drop items as there is only 1.
agreed
>> +      $ref: "/schemas/types.yaml#definitions/phandle"
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
>> +  - ref
> Not documented.

Agreed, will update

With Best Regards
Vadivel
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
