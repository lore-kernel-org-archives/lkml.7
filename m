Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9704C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BC12080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 03:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1Dr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 23:47:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:18265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfH1Dr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 23:47:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 20:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="192458391"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Aug 2019 20:47:57 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id A10515800BD;
        Tue, 27 Aug 2019 20:47:55 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
References: <20190827082652.43840-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190827082652.43840-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqJsTDNR7FsdFouLetzhsRhmr3fVT_xzzhKbR7KuTwepuQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <2a915595-be5f-83f4-34e8-34d667875cc2@linux.intel.com>
Date:   Wed, 28 Aug 2019 11:47:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJsTDNR7FsdFouLetzhsRhmr3fVT_xzzhKbR7KuTwepuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 27/8/2019 8:39 PM, Rob Herring wrote:
> On Tue, Aug 27, 2019 at 3:27 AM Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add a YAML schema to use the host controller driver with the
>> SDXC PHY on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>> new file mode 100644
>> index 000000000000..be05020880bf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
>> +
>> +maintainers:
>> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> +
>> +description: Binding for SDXC PHY
>> +
>> +properties:
>> +  compatible:
>> +    const: intel,lgm-sdxc-phy
>> +
>> +  intel,syscon:
>> +    description: phandle to the sdxc through syscon
>> +    $ref: '/schemas/types.yaml#/definitions/phandle'
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - "#phy-cells"
>> +  - compatible
>> +  - intel,syscon
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    sdxc_phy: sdxc_phy {
>> +        compatible = "intel,lgm-sdxc-phy";
>> +        intel,syscon = <&sysconf>;
> Rather than a phandle, can this be a child node of sysconf? You need a
> binding for sysconf first anyways.
intel,syscon is phandle, emmc_phy is not child node of sysconf, access 
emmc_phy
register over sysconf so made as reference here.

Best Regards
Vadivel
>> +        clocks = <&sdxc>;
>> +        clock-names = "sdxcclk";
>> +        #phy-cells = <0>;
>> +    };
>> +
>> +...
>> --
>> 2.11.0
>>
