Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73251C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4235E206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfDOMmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:42:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34090 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfDOMmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F3E8374;
        Mon, 15 Apr 2019 05:42:24 -0700 (PDT)
Received: from [10.1.196.92] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C12F03F706;
        Mon, 15 Apr 2019 05:42:21 -0700 (PDT)
Subject: Re: [PATCH v4 03/10] of/irq: document properties for wakeup interrupt
 parent
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     swboyd@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Rob Herring <robh@kernel.org>
References: <20190313211844.29416-1-ilina@codeaurora.org>
 <20190313211844.29416-4-ilina@codeaurora.org>
 <20190318174236.072f0a95@why.wild-wind.fr.eu.org>
 <20190404155838.GD10883@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <acd726c2-23fa-841a-a5c2-e00d39980021@arm.com>
Date:   Mon, 15 Apr 2019 13:42:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404155838.GD10883@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2019 16:58, Lina Iyer wrote:
> On Mon, Mar 18 2019 at 11:54 -0600, Marc Zyngier wrote:
>> On Wed, 13 Mar 2019 15:18:37 -0600
>> Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Please do Cc Rob when posting DT related patches.
>>
>>> Some interrupt controllers in a SoC, are always powered on and have a
>>> select interrupts routed to them, so that they can wakeup the SoC from
>>> suspend. Add wakeup-parent DT property to refer to these interrupt
>>> controllers.
>>>
>>> If the interrupts routed to the wakeup parent are not sequential, than a
>>> map needs to exist to associate the same interrupt line on multiple
>>> interrupt controllers. Providing this map in every driver is cumbersome.
>>> Let's add this in the device tree and document the properties to map the
>>> interrupt specifiers
>>>
>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>> ---
>>> Changes in v4:
>>> 	- Added this documentation
>>> ---
>>>  .../interrupt-controller/interrupts.txt       | 39 +++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> index 8a3c40829899..917b598317f5 100644
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>> @@ -108,3 +108,42 @@ commonly used:
>>>  			sensitivity = <7>;
>>>  		};
>>>  	};
>>> +
>>> +3) Interrupt wakeup parent
>>> +--------------------------
>>> +
>>> +Some interrupt controllers in a SoC, are always powered on and have a select
>>> +interrupts routed to them, so that they can wakeup the SoC from suspend. These
>>> +interrupt controllers do not fall into the category of a parent interrupt
>>> +controller and can be specified by the "wakeup-parent" property and contain a
>>> +single phandle referring to the wakeup capable interrupt controller.
>>> +
>>> +   Example:
>>> +	wakeup-parent = <&pdc_intc>;
>>> +
>>> +
>>> +4) Interrupt mapping
>>> +--------------------
>>> +
>>> +Sometimes interrupts may be detected by more than one interrupt controller
>>> +(depending on which controller is active). The interrupt controllers may not
>>> +be in hierarchy and therefore the interrupt controller driver is required to
>>> +establish the relationship between the same interrupt at different interrupt
>>> +controllers. If these interrupts are not sequential then a map needs to be
>>> +specified to help identify these interrupts.
>>> +
>>> +Mapping the interrupt specifiers in the device tree can be done using the
>>> +"irqdomain-map" property. The property contains interrupt specifier at the
>>> +current interrupt controller followed by the interrupt specifier at the mapped
>>> +interrupt controller.
>>> +
>>> +   irqdomain-map = <incoming-interrupt-specifier mapped-interrupt-specifier>
>>> +
>>> +The optional properties "irqdomain-map-mask" and "irqdomain-map-pass-thru" may
>>> +be provided to help interpret the valid bits of the incoming and mapped
>>> +interrupt specifiers respectively.
>>> +
>>> +   Example:
>>> +	irqdomain-map = <22 0 &intc 36 0>, <24 0 &intc 37 0>;
>>> +	irqdomain-map-mask = <0xff 0>;
>>> +	irqdomain-map-pass-thru = <0 0xff>;
>>
>>
>> This doesn't quite explain how the mask and pass-thru properties are
>> used. I guess that the mask is used to define the 'useful bits' on the
>> incoming side, but pass-thru puzzles me. In your example, does it mean
>> that incoming lines map to outgoing interrupt <0 0>?
>>
> Sorry about the late reply.
> 
> How about this to go with the rest of the documentation -
> 
> In the above example, the input interrupt specifier map-mask <0xff 0> applied
> on the incoming interrupt specifier of the map <22 0>, <24 0>, returns the
> input interrupt 22, 24 etc. The second argument being irq type is immaterial
> from the map and is used from the incoming request instead. The pass-thru
> specifier parses the output interrupt specifier from the rest of the unparsed
> argments from the map <&intc 36 0>, <&intc 37 0> etc to return the output
> interrupt 36, 37 etc.

I think you need to add #interrupt-cells in your example, which is
otherwise hard to interpret.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
