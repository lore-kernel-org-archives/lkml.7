Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB28C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1F222CF7
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 05:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392017AbfHWFWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 01:22:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:54842 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391664AbfHWFWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 01:22:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 22:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="190824147"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2019 22:22:03 -0700
Received: from [10.226.39.22] (ekotax-mobl.gar.corp.intel.com [10.226.39.22])
        by linux.intel.com (Postfix) with ESMTP id 4B4E0580258;
        Thu, 22 Aug 2019 22:22:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add YAML schemas for the Intel
 Reset controller
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <c909a3a19a1c06ac3ed9e1c42da3193ff8e43b7a.1566454535.git.eswara.kota@linux.intel.com>
 <CAL_JsqKpbXEw63PszfKX+DL-j1itfzpXNqwcJmijpo758dYZuw@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <8e302ef7-4d3a-d160-7d9a-81ebceffbb99@linux.intel.com>
Date:   Fri, 23 Aug 2019 13:22:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKpbXEw63PszfKX+DL-j1itfzpXNqwcJmijpo758dYZuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/23/2019 1:54 AM, Rob Herring wrote:
> On Thu, Aug 22, 2019 at 2:32 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>> Add YAML schemas for the reset controller on Intel
>> Lightening Mountain (LGM) SoC.
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   .../bindings/reset/intel,syscon-reset.yaml         | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>> new file mode 100644
>> index 000000000000..298c60085486
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/intel,syscon-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Intel Lightening Mountain SoC System Reset Controller
>> +
>> +maintainers:
>> +  - Dilip Kota <eswara.kota@linux.intel.com>
>> +
>> +properties:
>> +  compatible:
>> +    allOf:
>> +      - items:
>> +          - enum:
>> +              - intel,rcu-lgm
>> +              - syscon
> compatible:
>    items:
>      - const: intel,rcu-lgm
>      - const: syscon
Sure, will update it.
>> +
>> +  reg:
>> +    description: Reset controller register base address and size
>> +
>> +  intel,global-reset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description: Global reset register offset and bit offset.
>> +
>> +  "#reset-cells":
>> +    const: 2
> Add a description with what each cell contains.
Sure, will add the description.
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - intel,global-reset
>> +  - "#reset-cells"
> Add a:
>
> additionalProperties: false

Ok, will add it.

Thanks for the review comments.
Regards,
Dilip

>
>> +
>> +examples:
>> +  - |
>> +    rcu0: reset-controller@00000000 {
>> +        compatible = "intel,rcu-lgm", "syscon";
>> +        reg = <0x000000 0x80000>;
>> +        intel,global-reset = <0x10 30>;
>> +        #reset-cells = <2>;
>> +    };
>> +
>> +    pcie_phy0: pciephy@... {
>> +        ...
>> +        /* address offset: 0x10, bit offset: 12 */
>> +        resets = <&rcu0 0x10 12>;
>> +        ...
>> +    };
>> --
>> 2.11.0
>>
