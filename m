Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17458C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC789222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k+8BLZSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfJCBus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:50:48 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1701 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:50:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9553f50000>; Wed, 02 Oct 2019 18:50:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 18:50:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Oct 2019 18:50:45 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 01:50:45 +0000
Received: from [10.19.108.102] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct 2019
 01:50:43 +0000
Subject: Re: [PATCH 4/6] dt-bindings: phy: tegra: Add Tegra194 support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-5-jckuo@nvidia.com> <20191002094438.GD3716706@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <f0455be3-a73e-4abe-2031-425f9b936890@nvidia.com>
Date:   Thu, 3 Oct 2019 09:50:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002094438.GD3716706@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570067446; bh=cxg5hwQSVwdU7dic5YEs47eqPNAMewPNmwrxcP/+lvY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k+8BLZSCNte0C17STOYVwDBbhBTEv27XZ+ygV9WX7+/KNo61SYldVWRffoH21DMyr
         YXlG2ZCqK+r9u1kDuNPcB4FFWhWCxVym0Ya4LwezJrsyYwrJi8cKGVXYEY1Ztjl0iQ
         eup9scurDETMkfHXTl8L1do9SPcjJTw2hXLMt+CjpNrACfIu/fsM+c95c3F06rl26X
         id27vZdcTZDpgkrwk6SXBolaUBIanFE3qmNKHaj2hdy/szzmc+jkNrbCsMUlq7NALm
         JZkKOMyavqA5ktnBg0yfT9l7dR2tafXyvmSo19ech5pCkyxxhk3v+AqeTA2JwCXCdB
         W/0C3XEyjf2xQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Thierry. I will fix the typo in the next revision.

On 10/2/19 5:44 PM, Thierry Reding wrote:
> On Wed, Oct 02, 2019 at 04:00:49PM +0800, JC Kuo wrote:
>> Extend the bindings to cover the set of features found in Tegra194.
>> Note that, technically, there are four more supplies connected to the
>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
>> , but the power sequencing requirements of Tegra194 require these to be
>> under the control of the PMIC.
>>
>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it is
>> possible for some platforms have long signal trace that could not
>> provide sufficient electrical environment for Gen 2 speed. To deal with
>> this, a new device node property "nvidia,disable-gen2" was added to
>> Tegra194 that be used to specifically disable Gen 2 speed for a
>> particular USB 3.0 port so that the port can be limited to Gen 1 speed
>> and avoid the instability.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  .../bindings/phy/nvidia,tegra124-xusb-padctl.txt | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> index 9fb682e47c29..3bef37e7c365 100644
>> --- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> +++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> @@ -37,6 +37,7 @@ Required properties:
>>    - Tegra132: "nvidia,tegra132-xusb-padctl", "nvidia,tegra124-xusb-padctl"
>>    - Tegra210: "nvidia,tegra210-xusb-padctl"
>>    - Tegra186: "nvidia,tegra186-xusb-padctl"
>> +  - Tegra194: "nvidia,tegra194-xusb-padctl"
>>  - reg: Physical base address and length of the controller's registers.
>>  - resets: Must contain an entry for each entry in reset-names.
>>  - reset-names: Must include the following entries:
>> @@ -62,6 +63,10 @@ For Tegra186:
>>  - vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
>>  - vddio-hsic-supply: HSIC PHY power supply. Must supply 1.2 V.
>>  
>> +For Tegra194:
>> +- avdd-usb-supply: USB I/Os, VBUS, ID, REXT, D+/D- power supply. Must supply
>> +  3.3 V.
>> +- vclamp-usb-supply: Bias rail for USB pad. Must supply 1.8 V.
>>  
>>  Pad nodes:
>>  ==========
>> @@ -154,6 +159,11 @@ For Tegra210, the list of valid PHY nodes is given below:
>>  - sata: sata-0
>>    - functions: "usb3-ss", "sata"
>>  
>> +For Tegra194, the list of valid PHY nodes is given below:
>> +- usb2: usb2-0, usb2-1, usb2-2, usb2-3
>> +  - functions: "xusb"
>> +- usb3: usb3-0, usb3-1, usb3-2, usb3-3
>> +  - functions: "xusb"
>>  
>>  Port nodes:
>>  ===========
>> @@ -221,6 +231,9 @@ Optional properties:
>>    is internal. In the absence of this property the port is considered to be
>>    external.
>>  
>> +- nvidia,disable-gen2: A boolean property whose presence determines that a port
>> +  should be limited to USB 3.1 Gen 1. This properlty is only for Tegra194.
> 
> s/properlty/property/
> 
> With that:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
