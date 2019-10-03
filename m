Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD40C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF51222C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HeBXdINN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJCCEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:04:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18324 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJCCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:04:51 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9557490000>; Wed, 02 Oct 2019 19:04:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 19:04:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Oct 2019 19:04:49 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 02:04:48 +0000
Received: from [10.19.108.102] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct 2019
 02:04:46 +0000
Subject: Re: [PATCH 5/6] arm64: tegra: Add XUSB and pad controller on Tegra194
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-6-jckuo@nvidia.com> <20191002101001.GF3716706@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <ca1d5b4c-ee33-f1d7-ab50-69453bb90e90@nvidia.com>
Date:   Thu, 3 Oct 2019 10:04:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002101001.GF3716706@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570068297; bh=GflgmXG8mgKpQcPspa+tQDK8oUn7/yZP4zB2fpIz2H4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HeBXdINNEdgvuwt48Gb/GZ4/DLgfyLNoQ/kIqklv+i9LrKijRfBJV5tPiyBMBZgff
         H4ukCMLWM1rYYAppu0PUMbpNSb3IFD2w+p/eklHzA/qRRUTvigqy5dnjzq24LyzBcV
         l0VLl6LY84gS0ZkNr1SDE8lm2cMN2FSFbSNs59uBGMdQGRYMeSnJqcxk2UG9kgWC6r
         U7iYswADwb/d7WosMyByoDsWEjcoi9KQCnZVWfdfgCvZOU+n/BY2CYQKBHnZMBmw4v
         rzLMImvkCWnBDMPPF0Rdc7xjl4i1KxYWqRPIR9xGBJTUgQA37g9/TWW5Yniwi1smaR
         iQ2XkEyCRe95A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 6:10 PM, Thierry Reding wrote:
> On Wed, Oct 02, 2019 at 04:00:50PM +0800, JC Kuo wrote:
>> Adds the XUSB pad and XUSB controllers on Tegra194.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 130 +++++++++++++++++++++++
>>  1 file changed, 130 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> index 3c0cf54f0aab..4d3371d3a407 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
>> @@ -1599,4 +1599,134 @@
>>  		interrupt-parent = <&gic>;
>>  		always-on;
>>  	};
>> +
>> +	xusb_padctl: padctl@3520000 {
>> +		compatible = "nvidia,tegra194-xusb-padctl";
>> +		reg = <0x0 0x03520000 0x0 0x1000>,
>> +			<0x0 0x03540000 0x0 0x1000>;
> 
> These should generally be aligned. Use tabs first and then spaces to
> make the opening < on subsequent lines align with the opening < on the
> first line. There are a couple more like this below.
Thanks. I will make those aligned.
> 
>> +		reg-names = "padctl", "ao";
>> +
>> +		resets = <&bpmp TEGRA194_RESET_XUSB_PADCTL>;
>> +		reset-names = "padctl";
>> +
>> +		status = "disabled";
>> +
>> +		pads {
>> +			usb2 {
>> +				clocks = <&bpmp TEGRA194_CLK_USB2_TRK>;
>> +				clock-names = "trk";
>> +
>> +				lanes {
>> +					usb2-0 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb2-1 {
> 
> I prefer blank lines to visually separate blocks here and below.
Sure, will do.
> 
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb2-2 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb2-3 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +				};
>> +			};
>> +			usb3 {
>> +				lanes {
>> +					usb3-0 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb3-1 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb3-2 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +					usb3-3 {
>> +						nvidia,function = "xusb";
>> +						status = "disabled";
>> +						#phy-cells = <0>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		ports {
>> +			usb2-0 {
>> +				status = "disabled";
>> +			};
>> +			usb2-1 {
>> +				status = "disabled";
>> +			};
>> +			usb2-2 {
>> +				status = "disabled";
>> +			};
>> +			usb2-3 {
>> +				status = "disabled";
>> +			};
>> +			usb3-0 {
>> +				status = "disabled";
>> +			};
>> +			usb3-1 {
>> +				status = "disabled";
>> +			};
>> +			usb3-2 {
>> +				status = "disabled";
>> +			};
>> +			usb3-3 {
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>> +
>> +	tegra_xhci: xhci@3610000 {
> 
> The tegra_xhci is unused, so I don't think we need to add it. Also, the
> name of this node should be usb@3610000 since it's the compatible string
> that defines (together with the bindings) that this is XHCI capable. But
> it is fundamentally a USB controller, so the name should reflect that.
> 
Understood. I will fix in the next revision.
>> +		compatible = "nvidia,tegra194-xusb";
>> +		reg = <0x0 0x03610000 0x0 0x40000>,
>> +			<0x0 0x03600000 0x0 0x10000>;
>> +		reg-names = "hcd", "fpci";
>> +
>> +		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
>> +				<GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
>> +				<GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +		clocks = <&bpmp TEGRA194_CLK_XUSB_CORE_MUX>,
>> +			<&bpmp TEGRA194_CLK_XUSB_CORE_HOST>,
>> +			<&bpmp TEGRA194_CLK_XUSB_CORE_SS>,
>> +			<&bpmp TEGRA194_CLK_XUSB_FALCON>,
>> +			<&bpmp TEGRA194_CLK_XUSB_FALCON_HOST>,
>> +			<&bpmp TEGRA194_CLK_XUSB_FALCON_SS>,
>> +			<&bpmp TEGRA194_CLK_XUSB_FS>,
>> +			<&bpmp TEGRA194_CLK_XUSB_FS_HOST>,
>> +			<&bpmp TEGRA194_CLK_XUSB_SS>,
>> +			<&bpmp TEGRA194_CLK_XUSB_SS_SUPERSPEED>,
>> +			<&bpmp TEGRA194_CLK_UTMIPLL>,
>> +			<&bpmp TEGRA194_CLK_CLK_M>,
>> +			<&bpmp TEGRA194_CLK_PLLE>;
>> +		clock-names = "xusb_hs_src", "xusb_host",
>> +			"xusb_core_superspeed_clk", "xusb_falcon_src",
>> +			"xusb_falcon_host_clk", "xusb_falcon_superspeed_clk",
>> +			"xusb_fs_src", "xusb_fs_host_clk", "xusb_ss_src",
>> +			"xusb_ss", "pll_u_480m", "clk_m", "pll_e";
> 
> Some of these clocks are not defined in the bindings. Many of them are
> also not used by the driver. Are all of these really needed? If they
> are, please add the required ones to the bindings.
> 
> Also, for new ones, drop the _clk suffix. The fact that these are clocks
> is already conveyed by the property name.
> 
> Thierry
Thanks. I will clean this up.
> 
>> +
>> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_XUSBC>,
>> +				<&bpmp TEGRA194_POWER_DOMAIN_XUSBA>;
>> +		power-domain-names = "xusb_host", "xusb_ss";
>> +
>> +		nvidia,xusb-padctl = <&xusb_padctl>;
>> +		status = "disabled";
>> +	};
>>  };
>> -- 
>> 2.17.1
>>
