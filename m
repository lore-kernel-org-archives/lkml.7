Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FE3216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTDPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:15:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:64291 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfHTDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 20:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,407,1559545200"; 
   d="scan'208";a="183056988"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Aug 2019 20:15:49 -0700
Received: from [10.226.38.19] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.19])
        by linux.intel.com (Postfix) with ESMTP id 056BA58050C;
        Mon, 19 Aug 2019 20:15:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: intel-emmc-phy: Add new
 compatible for LGM eMMC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190819034416.45192-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqL2m-3BJHCSg2pwogyPDbp6yADUP1MQEV6QyZMpgta4xw@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <a5930a65-9ee5-7dd9-9a16-eac6808ecfed@linux.intel.com>
Date:   Tue, 20 Aug 2019 11:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL2m-3BJHCSg2pwogyPDbp6yADUP1MQEV6QyZMpgta4xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/8/2019 3:27 AM, Rob Herring wrote:
> On Sun, Aug 18, 2019 at 10:44 PM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a new compatible to use the host controller driver with the
>> eMMC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../bindings/phy/intel-lgm-emmc-phy.yaml           | 70 ++++++++++++++++++++++
>>   1 file changed, 70 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
>> new file mode 100644
>> index 000000000000..52156ff091ad
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel-lgm-emmc-phy.yaml
>> @@ -0,0 +1,70 @@
>> +# SPDX-License-Identifier: GPL-2.0
> Preference for new bindings is (GPL-2.0-only OR BSD-2-Clause)
Thanks a lot for the review comments, agreed, will update in the next 
patch version.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel-lgm-emmc-phy.yaml#
> Preferred filename is the compatible string (plus .yaml).
Agreed!
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel LGM e-MMC PHY Device Tree Bindings
> LGM is what?
Intel's Lightning Mountain(LGM) SoC.
>> +
>> +maintainers:
>> +  - Rob Herring <robh+dt@kernel.org>
>> +  - Mark Rutland <mark.rutland@arm.com>
> I don't know anything about this h/w. Please put yourself here.
Agreed, will update.
>> +
>> +intel,syscon:
> This will throw an error with 'make dt_binding_check'...
agreed, will remove
>> +   $ref: /schemas/types.yaml#definitions/phandle
>> +   description:
>> +    - |
>> +      e-MMC phy module connected through chiptop. Phandle to a node that can
>> +      contain the following properties
>> +        * reg, Access the e-MMC, get the base address from syscon.
>> +        * reset, reset the e-MMC module.
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
>> +    sysconf: chiptop@e0020000 {
>> +        compatible = "intel,chiptop-lgm", "syscon";
>> +        reg = <0xe0020000 0x100>;
>> +        #reset-cells = <1>;
>> +     };
>> +
>> +  - |
> Looks like 1 example to me, not 2.
Agreed, I will keep the below one example.

Best Regards
Vadivel
>> +    emmc_phy: emmc_phy {
>> +        compatible = "intel,lgm-emmc-phy";
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
