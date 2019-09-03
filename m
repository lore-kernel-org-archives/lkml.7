Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72792C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AFA22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfICKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:08:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:12479 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfICKIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:08:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 03:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; 
   d="scan'208";a="333791593"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2019 03:08:48 -0700
Received: from [10.226.38.16] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.16])
        by linux.intel.com (Postfix) with ESMTP id 5B24158043A;
        Tue,  3 Sep 2019 03:08:46 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190828124315.48448-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190828124315.48448-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190902033716.GA18092@bogus>
 <9f4d6bdd-072a-ab71-1ef1-1d00c22bd064@linux.intel.com>
 <CAL_JsqKm=-5F-Ej1mzRaygJnjS2Lec6uJF4J3vfCnqdkQNNbug@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <39d6fe60-e9f5-d205-ec6c-4a3143fe1e13@linux.intel.com>
Date:   Tue, 3 Sep 2019 18:08:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKm=-5F-Ej1mzRaygJnjS2Lec6uJF4J3vfCnqdkQNNbug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

  Thank you so much for prompt reply.

On 3/9/2019 5:19 PM, Rob Herring wrote:
> On Tue, Sep 3, 2019 at 2:57 AM Ramuthevar, Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> Hi Rob,
>>
>> Thank you for review comments.
>>
>> On 2/9/2019 9:38 PM, Rob Herring wrote:
>>> On Wed, Aug 28, 2019 at 08:43:14PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>
>>>> Add a YAML schema to use the host controller driver with the
>>>> SDXC PHY on Intel's Lightning Mountain SoC.
>>>>
>>>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> ---
>>>>    .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 52 ++++++++++++++++++++++
>>>>    .../devicetree/bindings/phy/intel,syscon.yaml      | 33 ++++++++++++++
>>>>    2 files changed, 85 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>>>>    create mode 100644 Documentation/devicetree/bindings/phy/intel,syscon.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>>>> new file mode 100644
>>>> index 000000000000..99647207b414
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>>>> @@ -0,0 +1,52 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
>>>> +
>>>> +maintainers:
>>>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: "intel,syscon.yaml"
>>> You don't need this. It should be selected and applied by the compatible
>>> string matching.
>> Agreed, fix it in the next patch.
>>>> +
>>>> +description: Binding for SDXC PHY
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: intel,lgm-sdxc-phy
>>>> +
>>>> +  intel,syscon:
>>>> +    description: phandle to the sdxc through syscon
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  clock-names:
>>>> +    maxItems: 1
>>>> +
>>>> +  "#phy-cells":
>>>> +    const: 0
>>>> +
>>>> +required:
>>>> +  - "#phy-cells"
>>>> +  - compatible
>>>> +  - intel,syscon
>>>> +  - clocks
>>>> +  - clock-names
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    sdxc_phy: sdxc_phy {
>>>> +        compatible = "intel,lgm-sdxc-phy";
>>>> +        intel,syscon = <&sysconf>;
>>> Make this a child of the below node and then you don't need this.
>>>
>>> If there's a register address range associated with this, then add a reg
>>> property.
>> Thanks for comments,  I have defined herewith example
>>
>> sysconf: chiptop@e0020000 {
>>               compatible = "intel,syscon";
> Needs to be SoC specific value.
Agreed! it should be "intel, lgm-syscon"
>>               reg = <0xe0020000 0x100>;
>>
>>               emmc_phy: emmc_phy {
>>                   compatible = "intel,lgm-emmc-phy";
>>                   intel,syscon = <&sysconf>;
> This is redundant because you can just get the parent node.
>
> If there's a defined register range within the 'intel,syscon' block
> then define it here with 'reg'.

Agreed!, avoided redundant

sysconf: chiptop@e0020000 {
             compatible = "intel,lgm-syscon";
             emmc_phy: emmc_phy {
                 compatible = "intel,lgm-emmc-phy";
                 reg = <0xe0020000 0x100>;
                 clocks = <&emmc>;
                 clock-names = "emmcclk";
                 #phy-cells = <0>;
            };
};

if this is correct, then will send updated patch-set.

Best Regards
Vadivel
>>                   clocks = <&emmc>;
>>                   clock-names = "emmcclk";
>>                   #phy-cells = <0>;
>>              };
>> };
>>
>> Is this way need to add right?
>>
>>>> +        clocks = <&sdxc>;
>>>> +        clock-names = "sdxcclk";
>>>> +        #phy-cells = <0>;
>>>> +    };
>>>> +
>>>> +...
