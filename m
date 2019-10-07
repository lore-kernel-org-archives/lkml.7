Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B1FC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B958A2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 07:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfJGHmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 03:42:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:38280 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfJGHmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 03:42:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 00:42:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="183358550"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2019 00:42:20 -0700
Received: from [10.226.38.27] (unknown [10.226.38.27])
        by linux.intel.com (Postfix) with ESMTP id 7791A5803E4;
        Mon,  7 Oct 2019 00:42:18 -0700 (PDT)
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190904055344.25512-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190917142337.GA27151@bogus>
 <9cdc49bc-61af-5b36-6ef1-67d1f1977730@linux.intel.com>
Message-ID: <3e06d22c-cd9a-d05f-b524-846bde6393b6@linux.intel.com>
Date:   Mon, 7 Oct 2019 15:42:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9cdc49bc-61af-5b36-6ef1-67d1f1977730@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 18/9/2019 10:23 AM, Ramuthevar, Vadivel MuruganX wrote:
> Hi Rob,
>
> Thank you for the review comments.
>
> On 17/9/2019 10:23 PM, Rob Herring wrote:
>> On Wed, Sep 04, 2019 at 01:53:43PM +0800, Ramuthevar,Vadivel MuruganX 
>> wrote:
>>> From: Ramuthevar Vadivel Murugan 
>>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>
>>> Add a YAML schema to use the host controller driver with the
>>> eMMC PHY on Intel's Lightning Mountain SoC.
>>>
>>> Signed-off-by: Ramuthevar Vadivel Murugan 
>>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>> ---
>>> changes in v5:
>>>    - earlier Review-by tag given by Rob
>>>    - rework done with syscon parent node.
>>>
>>> changes in v4:
>>>    - As per Rob's review: validate 5.2 and 5.3
>>>    - drop unrelated items.
>>>
>>> changes in v3:
>>>    - resolve 'make dt_binding_check' warnings
>>>
>>> changes in v2:
>>>    As per Rob Herring review comments, the following updates
>>>   - change GPL-2.0 -> (GPL-2.0-only OR BSD-2-Clause)
>>>   - filename is the compatible string plus .yaml
>>>   - LGM: Lightning Mountain
>>>   - update maintainer
>>>   - add intel,syscon under property list
>>>   - keep one example instead of two
>>> ---
>>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 69 
>>> ++++++++++++++++++++++
>>>   1 file changed, 69 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml 
>>> b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>> new file mode 100644
>>> index 000000000000..8f6ac8b3da42
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>> @@ -0,0 +1,69 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/phy/intel,lgm-emmc-phy.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Intel Lightning Mountain(LGM) eMMC PHY Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Ramuthevar Vadivel Murugan 
>>> <vadivel.muruganx.ramuthevar@linux.intel.com>
>>> +
>>> +description: Bindings for eMMC PHY on Intel's Lightning Mountain 
>>> SoC, syscon
>>> +  node is used to reference the base address of eMMC phy registers.
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        const: intel,lgm-syscon
>> This, plus...
>
> you mean, need to add two compatible here-itself look like below
>
> const: intel,lgm-syscon
> const: intel,lgm-emmc-phy
>
> Is it right?
>
Shall I proceed with above compatibles if you agree upon. Thanks!

With Best Regards
Vadivel Murugan
>>> +
>>> +    reg:
>>> +      maxItems: 1
>>> +
>>> +  required:
>>> +    - compatible
>>> +    - reg
>>> +
>>> +properties:
>>> +  "#phy-cells":
>>> +    const: 0
>>> +
>>> +  compatible:
>>> +    contains:
>>> +      const: intel,lgm-emmc-phy
>> ...this should not pass validation as they contradict each other.
> when  I do "make dt_binding_check" didn't throw an error,  let me 
> double confirm once clarified first comment.
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - "#phy-cells"
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +
>>> +examples:
>>> +  - |
>>> +    sysconf: chiptop@e0200000 {
>>> +      compatible = "intel,lgm-syscon";
>>> +      reg = <0xe0200000 0x100>;
>> I'm still waiting for a complete description of what all is in this
>> block.
> Agree!, I will  add it.
>>> +
>>> +      emmc-phy: emmc-phy {
>>> +        compatible = "intel,lgm-emmc-phy";
>>> +        reg = <0x00a8 0x4>,
>>> +              <0x00ac 0x4>,
>>> +              <0x00b0 0x4>,
>>> +              <0x00b4 0x4>;
>> Looks contiguous and can be a single entry:
>>
>> <0xa8 0x10>
> Agreed, will fix it.
>
> Best Regards
> Vadivel
>>> +        clocks = <&emmc>;
>>> +        clock-names = "emmcclk";
>>> +        #phy-cells = <0>;
>>> +      };
>>> +    };
>>> +...
>>> -- 
>>> 2.11.0
>>>
