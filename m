Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C84C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6653121A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 02:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q6b6/5rE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfJCCBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:01:01 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19600 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfJCCBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 22:01:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d95565c0001>; Wed, 02 Oct 2019 19:01:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 19:00:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 02 Oct 2019 19:00:57 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct
 2019 02:00:57 +0000
Received: from [10.19.108.102] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Oct 2019
 02:00:55 +0000
Subject: Re: [PATCH 3/6] phy: tegra: xusb: Add Tegra194 support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>
References: <20191002080051.11142-1-jckuo@nvidia.com>
 <20191002080051.11142-4-jckuo@nvidia.com> <20191002100204.GE3716706@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <3220d9f4-0a01-65c8-84d8-f6e0e465c7d5@nvidia.com>
Date:   Thu, 3 Oct 2019 10:00:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191002100204.GE3716706@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570068060; bh=EmiY1Z+RrUHsE3ATlAUj/XHjV7WwSGUCfV8Rsiq4dxI=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q6b6/5rE8Z/ZmRWOhp7hnq9oBTQxxA5SRRGze9erw+eTUnWZ+9JyRovIuZnAf8ZUY
         Thzt0TK5rl+DvBv0GEig5tpq9fshU37Wd2/wjU6jAjTj7VvM8T5BLOEvUFybeCYNhk
         bwYnGZcI1Oq5FT1zg5v6nBLdVJMMfXP3Hl6fVAEg5tGT4CwZYKMLppOSnOSJ5fP/Ny
         dqapkr08hdDUeSo23SJLHGM2LVUzugCL75R04uwrTaucjoc8EXAGStFdrGqt9b1CSi
         Is3IS/60M3oUb2L0eFdMgcTRTEswPurorz401liM1oaVF/SUcpCwE4hRW4wJw34XL3
         qQb8sHgT3dPcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/19 6:02 PM, Thierry Reding wrote:
> On Wed, Oct 02, 2019 at 04:00:48PM +0800, JC Kuo wrote:
>> Add support for the XUSB pad controller found on Tegra194 SoCs. It is
>> mostly similar to the same IP found on Tegra186, but the number of
>> pads exposed differs, as do the programming sequences. Because most of
>> the Tegra194 XUSB PADCTL registers definition and programming sequence
>> are the same as Tegra186, Tegra194 XUSB PADCTL can share the same
>> driver, xusb-tegra186.c, with Tegra186 XUSB PADCTL.
>>
>> Tegra194 XUSB PADCTL supports up to USB 3.1 Gen 2 speed, however, it
>> is possible for some platforms have long signal trace that could not
>> provide sufficient electrical environment for Gen 2 speed. This patch
>> introduce a new device node property "nvidia,disable-gen2" that can
>> be used to specifically disable Gen 2 speed for a particular USB 3.0
>> port so that the port can be limited to Gen 1 speed and avoid the
>> instability.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/phy/tegra/Makefile        |  1 +
>>  drivers/phy/tegra/xusb-tegra186.c | 77 +++++++++++++++++++++++++++++++
>>  drivers/phy/tegra/xusb.c          | 13 ++++++
>>  drivers/phy/tegra/xusb.h          |  4 ++
>>  4 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index 320dd389f34d..89b84067cb4c 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -6,4 +6,5 @@ phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>>  phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_186_SOC) += xusb-tegra186.o
>> +phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_194_SOC) += xusb-tegra186.o
>>  obj-$(CONFIG_PHY_TEGRA194_P2U) += phy-tegra194-p2u.o
>> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
>> index 6f3afaf9398f..4e27acf398b2 100644
>> --- a/drivers/phy/tegra/xusb-tegra186.c
>> +++ b/drivers/phy/tegra/xusb-tegra186.c
>> @@ -64,6 +64,13 @@
>>  #define  SSPX_ELPG_CLAMP_EN_EARLY(x)		BIT(1 + (x) * 3)
>>  #define  SSPX_ELPG_VCORE_DOWN(x)		BIT(2 + (x) * 3)
>>  
>> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
>> +#define XUSB_PADCTL_SS_PORT_CFG			0x2c
>> +#define   PORTX_SPEED_SUPPORT_SHIFT(x)		((x) * 4)
>> +#define   PORTX_SPEED_SUPPORT_MASK		(0x3)
>> +#define     PORT_SPEED_SUPPORT_GEN1		(0x0)
>> +#endif
> 
> I wouldn't bother protecting these with the #if/#endif.
It will be removed in the next revision.
> 
>> +
>>  #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
>>  #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
>>  #define  TERM_SEL				BIT(25)
>> @@ -635,6 +642,17 @@ static int tegra186_usb3_phy_power_on(struct phy *phy)
>>  
>>  	padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CAP);
>>  
>> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
>> +	if (padctl->soc == &tegra194_xusb_padctl_soc && port->disable_gen2) {
>> +		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_CFG);
>> +		value &= ~(PORTX_SPEED_SUPPORT_MASK <<
>> +			PORTX_SPEED_SUPPORT_SHIFT(index));
>> +		value |= (PORT_SPEED_SUPPORT_GEN1 <<
>> +			PORTX_SPEED_SUPPORT_SHIFT(index));
>> +		padctl_writel(padctl, value, XUSB_PADCTL_SS_PORT_CFG);
>> +	}
>> +#endif
> 
> Same here. Also, I think you can drop the extra check for padctl->soc
> and only rely on port->disable_gen2. This is not a lot of code, so might
> as well make our life simpler by building it unconditionally.
> 
> On another note: checking the padctl->soc pointer against a SoC-specific
> structure is a neat way to check for this support. However, it's not
> very flexible. Consider what happens when the next chip is released. I
> think we can assume that it will also support gen 2 and may also require
> some boards to disable gen 2 because of long signal traces. In order to
> accomodate that, you'd have to extend this check with another comparison
> to that new SoC structure.
> 
> A better alternative would be to add this as a "feature" flag to the SoC
> structure:
> 
> 	struct tegra_xusb_pad_soc {
> 		...
> 		bool supports_gen2;
> 	};
> 
> Presumably every SoC that supports gen 2 will also need support for
> explicitly disabling gen 2 if the board doesn't support it, so you can
> use that new feature flag to conditionalize this code.
> 
> This way, the next SoC generation can support can simply be added by
> setting supports_gen2 = true, without requiring any actual code changes
> (unless of course if it supports new features).
> 
> Multi-SoC support is also a good argument for dropping the #if/#endif
> protection, because those would need to be extended for the next SoC
> generation as well.
> 
Thanks Thierry. This implementation is better. I will take it in the next revision.

>> +
>>  	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_1);
>>  	value &= ~SSPX_ELPG_VCORE_DOWN(index);
>>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_1);
>> @@ -894,6 +912,65 @@ const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc = {
>>  };
>>  EXPORT_SYMBOL_GPL(tegra186_xusb_padctl_soc);
>>  
>> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
> 
> It doesn't look like we have this type of protection for Tegra186. It
> might make sense to add a patch to this series (before this patch) to
> slightly clean up the Tegra186 SoC data (reshuffle the data so that a
> single #if/#endif block can be used, like you do for Tegra194).
Okay, I will do it in the next revision.
> 
> But we can equally well do that in a follow-up.
> 
>> +static const char * const tegra194_xusb_padctl_supply_names[] = {
>> +	"avdd-usb",
>> +	"vclamp-usb",
>> +};
>> +
>> +static const struct tegra_xusb_lane_soc tegra194_usb2_lanes[] = {
>> +	TEGRA186_LANE("usb2-0", 0,  0, 0, usb2),
>> +	TEGRA186_LANE("usb2-1", 0,  0, 0, usb2),
>> +	TEGRA186_LANE("usb2-2", 0,  0, 0, usb2),
>> +	TEGRA186_LANE("usb2-3", 0,  0, 0, usb2),
>> +};
>> +
>> +static const struct tegra_xusb_pad_soc tegra194_usb2_pad = {
>> +	.name = "usb2",
>> +	.num_lanes = ARRAY_SIZE(tegra194_usb2_lanes),
>> +	.lanes = tegra194_usb2_lanes,
>> +	.ops = &tegra186_usb2_pad_ops,
>> +};
>> +
>> +static const struct tegra_xusb_lane_soc tegra194_usb3_lanes[] = {
>> +	TEGRA186_LANE("usb3-0", 0,  0, 0, usb3),
>> +	TEGRA186_LANE("usb3-1", 0,  0, 0, usb3),
>> +	TEGRA186_LANE("usb3-2", 0,  0, 0, usb3),
>> +	TEGRA186_LANE("usb3-3", 0,  0, 0, usb3),
>> +};
>> +
>> +static const struct tegra_xusb_pad_soc tegra194_usb3_pad = {
>> +	.name = "usb3",
>> +	.num_lanes = ARRAY_SIZE(tegra194_usb3_lanes),
>> +	.lanes = tegra194_usb3_lanes,
>> +	.ops = &tegra186_usb3_pad_ops,
>> +};
>> +
>> +static const struct tegra_xusb_pad_soc * const tegra194_pads[] = {
>> +	&tegra194_usb2_pad,
>> +	&tegra194_usb3_pad,
>> +};
>> +
>> +const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc = {
>> +	.num_pads = ARRAY_SIZE(tegra194_pads),
>> +	.pads = tegra194_pads,
>> +	.ports = {
>> +		.usb2 = {
>> +			.ops = &tegra186_usb2_port_ops,
>> +			.count = 4,
>> +		},
>> +		.usb3 = {
>> +			.ops = &tegra186_usb3_port_ops,
>> +			.count = 4,
>> +		},
>> +	},
>> +	.ops = &tegra186_xusb_padctl_ops,
>> +	.supply_names = tegra194_xusb_padctl_supply_names,
>> +	.num_supplies = ARRAY_SIZE(tegra194_xusb_padctl_supply_names),
>> +};
>> +EXPORT_SYMBOL_GPL(tegra194_xusb_padctl_soc);
>> +#endif
>> +
>>  MODULE_AUTHOR("JC Kuo <jckuo@nvidia.com>");
>>  MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB Pad Controller driver");
>>  MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index 2ea8497af82a..266c08074b28 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -65,6 +65,12 @@ static const struct of_device_id tegra_xusb_padctl_of_match[] = {
>>  		.compatible = "nvidia,tegra186-xusb-padctl",
>>  		.data = &tegra186_xusb_padctl_soc,
>>  	},
>> +#endif
>> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)
>> +	{
>> +		.compatible = "nvidia,tegra194-xusb-padctl",
>> +		.data = &tegra194_xusb_padctl_soc,
>> +	},
>>  #endif
>>  	{ }
>>  };
>> @@ -739,6 +745,13 @@ static int tegra_xusb_usb3_port_parse_dt(struct tegra_xusb_usb3_port *usb3)
>>  
>>  	usb3->internal = of_property_read_bool(np, "nvidia,internal");
>>  
>> +#if IS_ENABLED(CONFIG_ARCH_TEGRA_194_SOC)
>> +	if (port->padctl->soc == &tegra194_xusb_padctl_soc) {
>> +		usb3->disable_gen2 = of_property_read_bool(np,
>> +							"nvidia,disable-gen2");
>> +	}
>> +#endif
> 
> Do we really need the #if/#endif here? Or the conditional for that
> matter? nvidia,disable-gen2 is only defined for Tegra194, so any earlier
> SoCs are not going to have one, in which case the above code would just
> set usb3->disable_gen2 to false (the default).
> 
> Removing the conditional allows you to have the above on a single line.
> 
I will remove #if/#endif and the if() in the next revision. Thanks.
> Thierry
> 
>> +
>>  	usb3->supply = devm_regulator_get(&port->dev, "vbus");
>>  	return PTR_ERR_OR_ZERO(usb3->supply);
>>  }
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 093076ca27fd..6b71978ba15d 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -332,6 +332,7 @@ struct tegra_xusb_usb3_port {
>>  	bool context_saved;
>>  	unsigned int port;
>>  	bool internal;
>> +	bool disable_gen2;
>>  
>>  	u32 tap1;
>>  	u32 amp;
>> @@ -444,5 +445,8 @@ extern const struct tegra_xusb_padctl_soc tegra210_xusb_padctl_soc;
>>  #if defined(CONFIG_ARCH_TEGRA_186_SOC)
>>  extern const struct tegra_xusb_padctl_soc tegra186_xusb_padctl_soc;
>>  #endif
>> +#if defined(CONFIG_ARCH_TEGRA_194_SOC)
>> +extern const struct tegra_xusb_padctl_soc tegra194_xusb_padctl_soc;
>> +#endif
>>  
>>  #endif /* __PHY_TEGRA_XUSB_H */
>> -- 
>> 2.17.1
>>
