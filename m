Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A0CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC672080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfJ3Dv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:51:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:54887 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfJ3Dv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:51:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 20:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="190156181"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 29 Oct 2019 20:51:28 -0700
Received: from [10.226.38.74] (unknown [10.226.38.74])
        by linux.intel.com (Postfix) with ESMTP id 6A91958049B;
        Tue, 29 Oct 2019 20:51:26 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML schema
 for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20191021095436.50303-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191021095436.50303-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191029154842.GA3526@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <30be46f1-559a-2b37-23a5-df7383d1769a@linux.intel.com>
Date:   Wed, 30 Oct 2019 11:51:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029154842.GA3526@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 29/10/2019 11:48 PM, Rob Herring wrote:
> On Mon, Oct 21, 2019 at 05:54:35PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>> ---
>>   .../bindings/phy/intel,lgm-emmc-phy.yaml           | 63 ++++++++++++++++++++++
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..bc1285be31f9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> @@ -0,0 +1,63 @@
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
>> +description: Bindings for eMMC PHY on Intel's Lightning Mountain SoC, syscon
>> +  node is used to reference the base address of eMMC phy registers.
>> +
>> +select:
> You don't need a 'select'.

Thanks for the review.

will remove it.

>> +  properties:
>> +    compatible:
>> +      items:
>> +       - const: intel,lgm-syscon
>> +       - const: intel,lgm-emmc-phy
> This is not right. You are saying 'compatible' must be:
>
> compatible = "intel,lgm-syscon", "intel,lgm-emmc-phy";

Agreed!,   Added like the below statement...

  - compatible:         Should be one of the following:
                                  "intel,lgm-syscon", "syscon"
    - reg:
        maxItems: 1

  properties:
      compatible:
          contains:
             const: intel,lgm-emmc-phy

>> +
>> +    reg:
>> +      maxItems: 1
>> +
>> +  required:
>> +    - compatible
>> +    - reg
>> +
>> +properties:
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +
>> +examples:
>> +  - |
>> +    sysconf: chiptop@e0200000 {
>> +      compatible = "intel,lgm-syscon";
>> +      reg = <0xe0200000 0x100>;
>> +
>> +      emmc-phy: emmc-phy {
> phy@a8
add it  in the next patch.
> What else in in the chiptop block?
chiptop don't have other properties except compatible and reg.
---
With Best Regards
Vadivel
>
>> +        compatible = "intel,lgm-emmc-phy";
>> +        reg = <0x00a8 0x10>;
>> +        clocks = <&emmc>;
>> +        clock-names = "emmcclk";
>> +        #phy-cells = <0>;
>> +      };
>> +    };
>> +...
>> -- 
>> 2.11.0
>>
