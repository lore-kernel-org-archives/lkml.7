Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E341C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2608321734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jF688+TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAFHK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:10:28 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7822 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgAFHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:10:27 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e12dd520000>; Sun, 05 Jan 2020 23:10:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 05 Jan 2020 23:10:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 05 Jan 2020 23:10:26 -0800
Received: from [10.19.108.118] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jan
 2020 07:10:24 +0000
Subject: Re: [PATCH v5 3/5] dt-bindings: phy: tegra: Add Tegra194 support
To:     Rob Herring <robh@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200103081814.9848-1-jckuo@nvidia.com>
 <20200103081814.9848-4-jckuo@nvidia.com> <20200103223940.GA9205@bogus>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <baa9b5f4-74be-0ab4-0b24-bf926cf3207c@nvidia.com>
Date:   Mon, 6 Jan 2020 15:10:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103223940.GA9205@bogus>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578294610; bh=P75+nICemhj8+2AwnpQssTqZ+OlPS6ivxVr/T7XPS0Y=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jF688+TKb9BmvElPrCh0au1+bie+y+Sn4L3yjcmaErgcQI1z7QFfAgg1myvThqdip
         seRb/aNV+JI6w+XidFuDaeZVdMcOAOyoDAKsfj7ztwDnxy22ZzHpX9N7uXJVDhDoZA
         /ehu/n2R0ME+Sw2uf9kYtkth8BQBM/vPSypFhC5w1HZGamxwTpophLJwnB7YQZJ+9l
         nwqHUsRHtPFd9QNktdJVUtnSMiLtct7vg1DUlaRIodtM9HTWWG2To0tsLuAU5ferfD
         6Mf8uE8rKu7bUtpGGUmll4R4+WekfrTjWxWNSJEOTb9WzQ2qv6W2w3VVaykmsGQtvy
         fMgBXXn9xMtGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/20 6:39 AM, Rob Herring wrote:
> On Fri, Jan 03, 2020 at 04:18:12PM +0800, JC Kuo wrote:
>> Extend the bindings to cover the set of features found in Tegra194.
>> Note that, technically, there are four more supplies connected to the
>> XUSB pad controller (DVDD_PEX, DVDD_PEX_PLL, HVDD_PEX and HVDD_PEX_PLL)
>> , but the power sequencing requirements of Tegra194 require these to be
>> under the control of the PMIC.
>>
>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
>> is possible for some platforms have long signal trace that could not
>> provide sufficient electrical environment for Gen 2 speed. This patch
>> adds a "maximum-speed" property to usb3 ports which can be used to
>> specify the maximum supported speed for any particular USB 3.1 port.
>> For a port that is not capable of SuperSpeedPlus, "maximum-speed"
>> property should carry "super-speed".
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>> Changes in v5:
>> - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"
>> Changes in v4: none
>> Changes in v3: none
>> Changes in v2:
>> - fix a typo
>>
>>  .../phy/nvidia,tegra124-xusb-padctl.txt        | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
>> index 9fb682e47c29..7d0089006e67 100644
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
>> @@ -221,6 +231,11 @@ Optional properties:
>>    is internal. In the absence of this property the port is considered to be
>>    external.
>>  
>> +- maximum-speed: Only for Tegra194. A string property that specifies maximum
>> +  supported speed of a usb3 port. Valid values are:
>> +  - "super-speed-plus": default, the usb3 port supports USB 3.1 Gen 2 speed.
> 
> Not defined as a valid value in usb/generic.txt. '-gen2' instead of 
> '-plus' would be clearer IMO. However, is there any need to define the 
> maximum speed possible? The purpose of this property is to limit the 
> speed below the max.
> 
usb_get_maximum_speed(), which parses "maximum-speed" property, indeed handles
string "super-speed-plus". Should "super-speed-plus" be documented in
usb/generic.txt"?

static const char *const speed_names[] = {
	[USB_SPEED_UNKNOWN] = "UNKNOWN",
	[USB_SPEED_LOW] = "low-speed",
	[USB_SPEED_FULL] = "full-speed",
	[USB_SPEED_HIGH] = "high-speed",
	[USB_SPEED_WIRELESS] = "wireless",
	[USB_SPEED_SUPER] = "super-speed",
	[USB_SPEED_SUPER_PLUS] = "super-speed-plus",
};

A proprietary "nvidia,disable-gen2" property was proposed in earlier revision to
"limit the speed below the max". I like it because it fit our needs better and
requires only one line of code change.

   usb3->disable_gen2 = of_property_read_bool(np, "nvidia,disable-gen2");

Should I fallback to that approach?

Thanks,
JC

>> +  - "super-speed": the usb3 port supports USB 3.1 Gen 1 speed only.
>> +
>>  For Tegra124 and Tegra132, the XUSB pad controller exposes the following
>>  ports:
>>  - 3x USB2: usb2-0, usb2-1, usb2-2
>> @@ -233,6 +248,9 @@ For Tegra210, the XUSB pad controller exposes the following ports:
>>  - 2x HSIC: hsic-0, hsic-1
>>  - 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
>>  
>> +For Tegra194, the XUSB pad controller exposes the following ports:
>> +- 4x USB2: usb2-0, usb2-1, usb2-2, usb2-3
>> +- 4x super-speed USB: usb3-0, usb3-1, usb3-2, usb3-3
>>  
>>  Examples:
>>  =========
>> -- 
>> 2.17.1
>>
