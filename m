Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71985C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAE21848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 16:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405968AbfHWQpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:45:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:3623 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbfHWQpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 12:45:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 09:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="354668581"
Received: from tlchoatx-mobl1.amr.corp.intel.com (HELO [10.254.187.90]) ([10.254.187.90])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2019 09:44:59 -0700
Subject: Re: [alsa-devel] [RESEND PATCH v4 1/4] dt-bindings: soundwire: add
 slave bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
 <7da8aa89-2119-21d1-0e29-8894a8d40bf0@linux.intel.com>
 <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d538238d-25d8-f179-c900-90be50ce814d@linux.intel.com>
Date:   Fri, 23 Aug 2019 11:44:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <37be6b6d-7e7f-2cd6-f9e9-f0cac48791ad@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/19 10:57 AM, Srinivas Kandagatla wrote:
> 
> 
> On 23/08/2019 16:41, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/22/19 6:37 PM, Srinivas Kandagatla wrote:
>>> This patch adds bindings for Soundwire Slave devices that includes how
>>> SoundWire enumeration address and Link ID are used to represented in
>>> SoundWire slave device tree nodes.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>>>   1 file changed, 75 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml 
>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> new file mode 100644
>>> index 000000000000..91aa6c6d6266
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SoundWire Controller Generic Binding
>>> +
>>> +maintainers:
>>> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> +
>>> +description: |
>>> +  SoundWire busses can be described with a node for the SoundWire 
>>> controller
>>> +  device and a set of child nodes for each SoundWire slave on the bus.
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"

re-reading this, it looks like you are defining the controller bindings, 
but there are no real controller-level properties except for the fact 
that they include slave bindings?

In MIPI the notion of controller is that it can deal with multiple 
links, each of which having specific properties (clock speed, clock stop 
properties, etc).

>>> +
>>> +  "#address-cells":
>>> +    const: 2
>>> +
>>> +  "#size-cells":
>>> +    const: 0
>>> +
>>> +patternProperties:
>>> +  "^.*@[0-9a-f]+$":
>>> +    type: object
>>> +
>>> +    properties:
>>> +      compatible:
>>> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
>>
>> So is this a 64-bit value, as in the MIPI spec, or is this part of the 
>> _ADR description?
> 
> Rob did not like encoding compatible string exactly like _ADR encoding.
> 
> https://lkml.org/lkml/2019/8/22/490

Wondering if we are talking about different concepts?

Rob's point was about the InstanceID

"Assuming you could have more than 1 of the same device on the bus,
then you need some way to distinguish them and the way that's done for
DT is unit-address/reg. And compatible strings should be constant for
each instance."

You can use the MIPI encoding *except* for the InstanceID, that'd be 
fine. It'll just be a bit weird since the Slave device will report the 
48 bits that include the Instance ID, so you'll have to special case 
this field, but if this is a DT requirement then fine.

Rob's point does not apply to the link ID - which is used when you have 
multiple masters in your controller. The Slave device is attached in one 
location and will never move, so that is a constant value.

> 
>> I also don't get why the first item in in base10?
>>
> 
> As this corresponds to Soundwire Version, and I have no visibility of 
> version number encoding after reaching number 9 in this field.
> 
> This can be updated once we have more info on how the Version encoding 
> will look like in future.
> 
> Idea of limiting regex to [0-9] for version is to enforce some checking!

the version is a 4 bit value starting at 1 for SoundWire 1.0. There is 
nothing in the spec that talks about a limit to 9.

It's unlikely we'll ever reach that but you are interpreting a spec 
here. plus just below you mention all fields as being hexadecimal.

> 
> --srini
> 
>>
>>> +      description:
>>> +      Is the textual representation of SoundWire Enumeration
>>> +      address. compatible string should contain SoundWire Version ID,
>>> +      Manufacturer ID, Part ID and Class ID in order and shall be in
>>> +      lower-case hexadecimal with leading zeroes.
>>> +      Valid sizes of these fields are
>>> +      Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
>>> +      and '0x2' represents SoundWire 1.1 and so on.
>>> +      MFD is 4 nibbles
>>> +      PID is 4 nibbles
>>> +      CID is 2 nibbles
>>> +      More Information on detail of encoding of these fields can be
>>> +      found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
>>> +
>>> +      reg:
>>> +        maxItems: 1
>>> +        description:
>>> +          Instance ID and Link ID of SoundWire Device Address.
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - reg
>>> +
>>> +examples:
>>> +  - |
>>> +    soundwire@c2d0000 {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +        compatible = "qcom,soundwire-v1.5.0";
>>> +        reg = <0x0c2d0000 0x2000>;
>>> +
>>> +        speaker@1 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <1 0>;
>>> +        };
>>> +
>>> +        speaker@2 {
>>> +            compatible = "sdw10217201000";
>>> +            reg = <2 0>;
>>> +        };
>>> +    };
>>> +
>>> +...
>>>
