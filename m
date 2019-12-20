Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA71C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203924679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I9taiJ6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLTIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:08:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3925 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:08:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfc81640001>; Fri, 20 Dec 2019 00:08:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 00:08:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 20 Dec 2019 00:08:36 -0800
Received: from [10.19.108.118] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 08:08:32 +0000
Subject: Re: [Patch V2 01/18] dt-bindings: phy: tegra-xusb: Add
 usb-role-switch
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-2-git-send-email-nkristam@nvidia.com>
 <20191219130503.GG1440537@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <fe47fd52-efd0-4f84-d1e4-4bce5571e425@nvidia.com>
Date:   Fri, 20 Dec 2019 16:08:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219130503.GG1440537@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576829286; bh=LyayuG4FCg05ek5s+CT8p2SyaPPTPq0PabfmeLV6GNk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I9taiJ6IKtQQ8y3wM+EAHYxm2958nOsdEBXwHCqpY2JIVHsTwrIS4qYmT2zubSGWT
         0wgh7PZbYE46aBJuyhFsa9RdnGNdpew+u1IerLA+dQsABZ1LqW6Tk8XjAwD6n0cgbb
         5jgplE46FS+ZevM7+CIzUgh2qf/Tn071nLBcQOBDWkFToF4HpQX0h/ikYJCc//Nw1v
         u0EFaLPxSPoBzofu0eLwFUjZC0VcHRRg3v+9WrDE5I/Hp4tzcxQ25pCnC8r776lzHF
         8TU/zyf08N0Pmf09Q0RS49+8DfF40Ahbju08RQ0NSv3n6EdOqkQssb6LoC3EXWPa3P
         bBfm/olAahzdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/19/19 9:05 PM, Thierry Reding wrote:
> On Wed, Dec 18, 2019 at 02:46:14PM +0530, Nagarjuna Kristam wrote:
>> Add usb-role-switch property for Tegra210 and Tegra186 platforms. This
>> entry is used by XUSB pad controller driver to register for role changes
>> for OTG/Peripheral capable USB 2 ports.
>>
>> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
>> ---
>> V2:
>>  - Moved usb-role-switch to seperate Required section as suggested by Thierry.
>>  - Added reference to usb/usb-conn-gpio.txt for connector subnode.
>> ---
>>  .../devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt         | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> index 9fb682e..23bf354 100644
>> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> @@ -174,6 +174,12 @@ Required properties:
>>    - "device": for USB device mode
>>    - "otg": for USB OTG mode
>>  
>> +Required properties for OTG/Peripheral capable USB2 ports:
>> +- usb-role-switch: Boolean property to indicate that the port support OTG or
> 
> "supports", and also, why if it supports OTG *or* peripheral? Doesn't
> OTG imply peripheral? OTG means it can be either peripheral or host,
> right? So I think the end of that sentence can be just:
> 
> 	"... the port supports OTG."
An USB OTG port is capable of both USB host and peripheral operations. An USB
peripheral port can only act as an USB peripheral.

The micro USB ports found on Jetson TX1/TX2 platforms are micro-AB ports which
should implement both host and peripheral capabilities. We say such ports
support OTG. The micro USB port found on Jetson Nano is a micro-B port which
should implement peripheral capability only. We say such ports support
peripheral, rather than OTG.

Thanks,
JC

> 
> Otherwise:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
