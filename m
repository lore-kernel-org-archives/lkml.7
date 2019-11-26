Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8CAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC0A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GhNKSt0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKZEUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:20:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1377 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfKZEUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:20:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddca8010001>; Mon, 25 Nov 2019 20:20:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 25 Nov 2019 20:20:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 25 Nov 2019 20:20:15 -0800
Received: from [10.24.193.46] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Nov
 2019 04:20:12 +0000
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
To:     Thierry Reding <thierry.reding@gmail.com>,
        JC Kuo <jckuo@nvidia.com>, "Rob Herring" <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com> <20191009233900.GA9109@bogus>
 <20191014131752.GF422231@ulmo>
 <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
 <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
 <20191017120128.GE3122066@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <0fd1f30c-5155-e1df-69b9-a49271b7cbce@nvidia.com>
Date:   Tue, 26 Nov 2019 09:51:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191017120128.GE3122066@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574742017; bh=z3EDY6Eao4JzaFtK6U1s4QYBS3tl1Z7pp75azK3pO0o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=GhNKSt0c59jg+kLa61P4Y7fUmS5B6/57P69x4BbS3s3kr9ya+cgppsDi9gAODDoOM
         CHe9bpxybhbX5WkOTH1zyXv455rh2nUDr1mBks7ZMTsXoZjc5MyfZm05DW5RAqacQX
         zDvMrj6WnkiaQj63jDEMcfeSaUph5eAu0mH4BAjoK/2kiMkLK7ey1Zr8lS8tybxXtI
         33RfTA9tQ5cEBvZU4qyb5Dt2v7MWl7ow4luF8uqK2i+BRAv/RsF7r2nN779yZYuXa1
         Mm9i5l7ltO05tkpPW7zAGM9wkSVR5qOr46u53lpEL7nihLrxSmdrXZBgKhNRKnx2mi
         m+l2KPQXG1Y+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17-10-2019 17:31, Thierry Reding wrote:
> On Thu, Oct 17, 2019 at 03:48:52PM +0800, JC Kuo wrote:
>> Hi Thierry, Hi Rob, Hi Kishon,
>> Please let me know your thoughts of the below implementation.
>>
>> 1. Add a "bool disable_gen2" to "phy->attrs" structure.
>> 2. In _of_phy_get() of phy-core.c to add the follow to parse a generic property.
>>
>> 	phy->attrs.disable_gen2 = of_property_read_bool(args.np,
>> 							"usb-disable-gen2");
> 
> Regarding this, I'm not sure how Rob imagined the generic properties to
> work. Perhaps he was thinking about something like the max-link-speed
> property found in the PCI bindings.
> 
> We could have something like this:
> 
>   - max-link-speed:
>       If present this property specifies the USB generation supported on
>       the PHY/port. Must be:
>         1: for USB 3.1 Gen 1 (a.k.a. USB 3.0)
>         2: for USB 3.1 Gen 2
> 
> I'm not sure if we need to consider anything prior to USB 3.0. I suppose
> we could do a similar mapping to what I proposed for the PHY ->set_mode
> callback:
> 
>   - max-link-speed:
>       If present this property specifies the USB generation supported on
>       the PHY/port. Must be:
>         0x0100: for USB 1.0 (Low-Speed)
>         0x0101: for USB 1.1 (Full-Speed)
>         0x0200: for USB 2.0 (Hi-Speed)
>         0x0300: for USB 3.0 (SuperSpeed) (a.k.a. USB 3.1 Gen 1)
>         0x0301: for USB 3.1 (SuperSpeed 10 Gbit/s) (a.k.a. USB 3.1 Gen 2)
>         0x0302: for USB 3.2 (SuperSpeed 20 Gbit/s) (a.k.a. USB 3.2 Gen 2 x 2)
>         ...
> 
> Or those could just be sequentially enumerated, like in the above
> example.
> 
> Rob, any thoughts?
> 
> Thierry
> 

"Documentation/devicetree/bindings/usb/generic.txt" file already has dt-property named
maximum-speed, which fulfills current requirement. So to disable gen2 feature simply
add below entry to corresponding usb3 port entry.
		padctl@3520000 {
			status = "okay";

			ports {
				usb3-3 {
					maximum-speed = "super-speed";
				};
		};

Read the property using API usb_get_maximum_speed.

Thanks,
Nagarjuna
>> 3. In individual phy driver, to add SOC/PHY specific programming accordingly.
>>
>> Thanks,
>> JC
>>
>> On 10/14/19 9:40 PM, Rob Herring wrote:
>>> On Mon, Oct 14, 2019 at 8:17 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>>>>
>>>> On Wed, Oct 09, 2019 at 06:39:00PM -0500, Rob Herring wrote:
>>>>> On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
>>>>>> Extend the bindings to cover the set of features found in Tegra194.
>>>>>> Note that, technically, there are four more supplies connected to the
>>>>>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
>>>>>> , but the power sequencing requirements of Tegra194 require these to be
>>>>>> under the control of the PMIC.
>>>>>>
>>>>>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
>>>>>> possible for some platforms have long signal trace that could not
>>>>>> provide sufficient electrical environment for Gen 2 speed. To deal with
>>>>>> this, a new device node property "nvidia,disable-gen2" was added to
>>>>>> Tegra194 that be used to specifically disable Gen 2 speed for a
>>>>>> particular USB 3.0 port so that the port can be limited to Gen 1 speed
>>>>>> and avoid the instability.
>>>>>
>>>>> I suspect this may be a common issue and we should have a common
>>>>> property. Typically, this kind of property is in the controller though
>>>>> and supports multiple speed limits. See PCI bindings for inspiration.
>>>>
>>>> Given that support for gen 2 speeds is dependent on signal trace length,
>>>> it doesn't really make sense to restrict the whole controller to a given
>>>> speed if only the signal trace for a single port exceeds the limit for
>>>> which gen 2 would work.
>>>>
>>>> Also, the USB PHYs are in a different hardware block than the USB
>>>> controller, so this really is a property of the PHY block, not the USB
>>>> controller.
>>>
>>> Okay, but still should be common for USB PHYs IMO.
>>>
>>> Rob
>>>
