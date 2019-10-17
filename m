Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0A3FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08E52089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J0MP7wHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438683AbfJQHs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:48:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2810 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390846AbfJQHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:48:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da81ceb0000>; Thu, 17 Oct 2019 00:48:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Oct 2019 00:48:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Oct 2019 00:48:56 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Oct
 2019 07:48:56 +0000
Received: from [10.19.108.113] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Oct
 2019 07:48:54 +0000
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: tegra: Add Tegra194 support
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
References: <20191009024343.30218-1-jckuo@nvidia.com>
 <20191009024343.30218-4-jckuo@nvidia.com> <20191009233900.GA9109@bogus>
 <20191014131752.GF422231@ulmo>
 <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <57692050-8284-a31f-71fd-7441823f3f2b@nvidia.com>
Date:   Thu, 17 Oct 2019 15:48:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+aKxfAir3skanfqmM+nFFzXPFL4eMa-+pq1kH-90YTbg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571298539; bh=nIXBLya6bRUIuxRwlDLEPxSLP7joKF8reE7kSpNLl38=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=J0MP7wHYBCEfKBTs/ScBeIQ6GbtrNcqNyFlZAKn1s0n0c4EYsbdJuRD+0MGi4n//F
         n9Osq2q7nMlc4FRJYZOTtgBCcnuipPXlXdLDPnwGzkuKogfOzKfb+y6so98Qxgkc0d
         5BmEmxhdK/uCsV4LlzDWi/KvUFvkzNQwBXdoiQob/QyMc/mJJTv5zzpSVo9kqfFuRU
         f8x0bsOkvM/8uBop1OCJwRSXu16r5aoN0bYR3YrIUeW0q6NkLdgNGkyd//MTZWXTWC
         C/q4ANzzGy1cYWUQJT1j7OrmYEpOzgKcA6FC+axwM5svcij8jEIZJhNe3bnaZEimuj
         qZ5PFweU7V7AQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry, Hi Rob, Hi Kishon,
Please let me know your thoughts of the below implementation.

1. Add a "bool disable_gen2" to "phy->attrs" structure.
2. In _of_phy_get() of phy-core.c to add the follow to parse a generic property.

	phy->attrs.disable_gen2 = of_property_read_bool(args.np,
							"usb-disable-gen2");
3. In individual phy driver, to add SOC/PHY specific programming accordingly.

Thanks,
JC

On 10/14/19 9:40 PM, Rob Herring wrote:
> On Mon, Oct 14, 2019 at 8:17 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>>
>> On Wed, Oct 09, 2019 at 06:39:00PM -0500, Rob Herring wrote:
>>> On Wed, Oct 09, 2019 at 10:43:41AM +0800, JC Kuo wrote:
>>>> Extend the bindings to cover the set of features found in Tegra194.
>>>> Note that, technically, there are four more supplies connected to the
>>>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
>>>> , but the power sequencing requirements of Tegra194 require these to be
>>>> under the control of the PMIC.
>>>>
>>>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
>>>> possible for some platforms have long signal trace that could not
>>>> provide sufficient electrical environment for Gen 2 speed. To deal with
>>>> this, a new device node property "nvidia,disable-gen2" was added to
>>>> Tegra194 that be used to specifically disable Gen 2 speed for a
>>>> particular USB 3.0 port so that the port can be limited to Gen 1 speed
>>>> and avoid the instability.
>>>
>>> I suspect this may be a common issue and we should have a common
>>> property. Typically, this kind of property is in the controller though
>>> and supports multiple speed limits. See PCI bindings for inspiration.
>>
>> Given that support for gen 2 speeds is dependent on signal trace length,
>> it doesn't really make sense to restrict the whole controller to a given
>> speed if only the signal trace for a single port exceeds the limit for
>> which gen 2 would work.
>>
>> Also, the USB PHYs are in a different hardware block than the USB
>> controller, so this really is a property of the PHY block, not the USB
>> controller.
> 
> Okay, but still should be common for USB PHYs IMO.
> 
> Rob
> 
