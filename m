Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3117BC33C9A
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 16:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B5F20866
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 16:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgAEQlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 11:41:10 -0500
Received: from foss.arm.com ([217.140.110.172]:37902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgAEQlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 11:41:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E12331B;
        Sun,  5 Jan 2020 08:41:08 -0800 (PST)
Received: from [192.168.3.111] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2BD3F534;
        Sun,  5 Jan 2020 08:41:07 -0800 (PST)
Subject: Re: [PATCH 3/3] ARM: dts: sun8i: R40: Add SPI controllers nodes and
 pinmuxes
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
References: <20200102012657.9278-1-andre.przywara@arm.com>
 <20200102012657.9278-4-andre.przywara@arm.com>
 <20200102095711.dkd2cnbyitz6mvyx@gilmour.lan>
 <20200102104158.06d9baa0@donnerap.cambridge.arm.com>
 <20200104100422.z7iz4jiyj7kdvbtw@gilmour.lan>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <42aabc62-4885-38fc-a6e5-0f057843d364@arm.com>
Date:   Sun, 5 Jan 2020 16:40:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200104100422.z7iz4jiyj7kdvbtw@gilmour.lan>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2020 10:04, Maxime Ripard wrote:

Hi,

> On Thu, Jan 02, 2020 at 10:41:58AM +0000, Andre Przywara wrote:
>> On Thu, 2 Jan 2020 10:57:11 +0100
>> Maxime Ripard <mripard@kernel.org> wrote:
>>> On Thu, Jan 02, 2020 at 01:26:57AM +0000, Andre Przywara wrote:
>>>> The Allwinner R40 SoC contains four SPI controllers, using the newer
>>>> sun6i design (but at the legacy addresses).
>>>> The controller seems to be fully compatible to the A64 one, so no driver
>>>> changes are necessary.
>>>> The first three controller can be used on two sets of pins, but SPI3 is
>>>> only routed to one set on Port A.
>>>>
>>>> Tested by connecting a SPI flash to a Bananapi M2 Berry on the SPI0
>>>> PortC header pins.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>  arch/arm/boot/dts/sun8i-r40.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 89 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
>>>> index 8dcbc4465fbb..af437391dcf4 100644
>>>> --- a/arch/arm/boot/dts/sun8i-r40.dtsi
>>>> +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
>>>> @@ -418,6 +418,41 @@
>>>>  				bias-pull-up;
>>>>  			};
>>>>
>>>> +			spi0_pc_pins: spi0-pc-pins {
>>>> +				pins = "PC0", "PC1", "PC2", "PC23";
>>>> +				function = "spi0";
>>>> +			};
>>>> +
>>>> +			spi0_pi_pins: spi0-pi-pins {
>>>> +				pins = "PI10", "PI11", "PI12", "PI13", "PI14";
>>>> +				function = "spi0";
>>>> +			};
>>>
>>> This split doesn't really work though :/
>>>
>>> The PC pins group has MOSI, MISO, CLK and CS0, while the PI pins group
>>> has CS0, CLK, MOSI, MISO and CS1.
>>>
>>> Meaning that if a board uses a GPIO CS pin, we can't really express
>>> that
>>
>> Does that actually work? I dimly remember checking our sunxi driver
>> a while ago and I wasn't sure that would be functional there.
> 
> It's something generic that should be handled by the core iirc. We
> might be missing the few things to enable it though, but that's
> irrelevant to the DT itself.

Agreed, I just remembered that I checked this a while ago and found that
we always control the SS_LEVEL bit, but never anything else. But indeed
irrelevant for this.

> 
>>> and any board using the PI pins for its SPI bus will try to
>>> claim CS0 and CS1, no matter how many devices are connected on the bus
>>> (and if there's one, there might be something else connected to PI14).
>>
>> True.
>>
>>> And you can't have a board using CS1 with the PC signals either.
>>>
>>> You should split away the CS pins into separate groups, like we're
>>> doing with the A20 for example.
>>
>> Ah, yeah, makes sense, thanks for the pointer.
>>
>>> And please add /omit-if-no-ref/ to those groups.
>>
>> I was a bit reluctant to do this:
>>
>> First there does not seem to be any good documentation about it,
>> neither in the official DT spec nor in dtc, even though I think I
>> understand what it does ;-)
> 
> If a node doesn't have a phandle pointing to it, it will be ignored at
> compilation time.

That's what I figured ;-)

>> Second it seems to break in U-Boot atm. Looks like applying your dtc
>> patch fixes that, though. Do you know if U-Boot allows
>> cherry-picking dtc patches? If yes, I could post your patch.
> 
> I know I did it for libfdt at some point, so I guess dtc would work
> too, but I'm not really sure. Rockchip is also using it iirc, so
> there's interest in supporting it in U-Boot anyway.

OK, will post it.

>> But more importantly: what are the guidelines for using this tag? I
>> understand the desire to provide every possible pin description on
>> one hand, but wanting to avoid having *all of them* in *each* .dtb
>> on the other.
> 
> Pin groups will take a lot of space in the dtb, and the DT parsing
> will take some measurable time,

Really? Where is that? In Linux, or in U-Boot, possibly with the caches
off? I am just curious. AFAIK there are some inefficient algorithms in
libfdt (which trade performance for a smaller memory footprint), but I
thought those would be called only very rarely.

> so if we can get rid of the unused pin
> groups, that's great :)

I see it is preferable over creating a separate copy of the .dts file.

>> But how does this play along with overlays? Shouldn't at least those
>> interface pins that are exposed on headers stay in each .dtb? Can we
>> actually make this decision in the SoC .dtsi file?
> 
> If the DT is compiled with overlays, that property is ignored iirc and
> the node will be output in the compiled DT, because while if you don't
> have overlays support you can tell if something points to that node,
> you can't with overlays since those references might be stored
> elsewhere.

Yeah, Chen-Yu mentioned that already. Thanks for the info, I missed that.

>> And should there be a dtc command line option to ignore those tags,
>> or even to apply this tag (virtually) to every node?
> 
> Most of the nodes are (reference) leaves in a DT though. Pretty much
> all the device nodes have no references pointing to them, just like
> most of the buses, the CPU nodes, etc. And I'm pretty sure you want to
> keep them :)

Yeah, that was a New-Year's brain-fart of mine ;-)

While I was changing the patch I figured that it gets quite lengthy.
Also looking at the a20.dtsi, I see that *all* pin groups have this tag
now. Wouldn't it be easier to introduce *one* tag that applies that to
all children of a node?

Another thing I was wondering about: Would we gain something by not
compiling nodes which have status = "disabled"? This is mentioned as a
generic property in the DT spec, although it says there that the exact
meaning is device dependent. But it sound still worthwhile, especially
since we would avoid more pin groups to be compiled in.

Cheers,
Andre.
