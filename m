Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F9FC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 07:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F65C2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 07:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F6J4cbKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLZHDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 02:03:47 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19068 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfLZHDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 02:03:46 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e045b450000>; Wed, 25 Dec 2019 23:03:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 25 Dec 2019 23:03:46 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 25 Dec 2019 23:03:46 -0800
Received: from [10.19.108.118] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Dec
 2019 07:03:43 +0000
Subject: Re: [Patch V2 05/18] phy: tegra: xusb: Add support to get companion
 USB 3 port
To:     Nagarjuna Kristam <nkristam@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-6-git-send-email-nkristam@nvidia.com>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <e37a083d-e5de-1b7c-f175-ec4234f60441@nvidia.com>
Date:   Thu, 26 Dec 2019 15:03:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576660591-10383-6-git-send-email-nkristam@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577343813; bh=tMcZd/vUVLSibr+qNoQapk0JfXa5Y2ZYS9MCE9nZAEs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=F6J4cbKedi3SNU0TEmkuAFJGd+YQREX5vKbEVHpOXAiKCtAzbjNhJ3qTwITDW5evk
         D5q3x3hgSMpUmh4jlqn2TgdrjicvH3WgnzmazLoGnTE4Opz9hOfJ9C6Y57FTDVk7py
         6BVfXUz5JOSL9+SNMSSLbM2dUru/litHn7pgc7Sg/mcPTU05fXpKGafdsR1sZbq38/
         49qJ3Ed2jhEczOAmasIUqmYDufGfg1tD/RDD0XODoIFAK+Pm72uYd9yhzGa4+0KfEZ
         iuaoqRtp7gKN+lnLVsbhjRgEUHSulhyfid5hSSfD6eYTQxgJvYZYSRduxOGPVJVySq
         7YenrpWPV4DDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/19 5:16 PM, Nagarjuna Kristam wrote:
> Tegra XUSB host, device mode driver requires the USB 3 companion port
> number for corresponding USB 2 port. Add API to retrieve the same.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
> V2:
>  - Added -ENODEV as return instead of -1, to sync other errors.
> ---
>  drivers/phy/tegra/xusb.c       | 21 +++++++++++++++++++++
>  include/linux/phy/tegra/xusb.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> index 5bde8f1..e75cd71 100644
> --- a/drivers/phy/tegra/xusb.c
> +++ b/drivers/phy/tegra/xusb.c
> @@ -1256,6 +1256,27 @@ int tegra_phy_xusb_utmi_port_reset(struct phy *phy)
>  }
>  EXPORT_SYMBOL_GPL(tegra_phy_xusb_utmi_port_reset);
>  
> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
> +				    unsigned int port)
> +{
> +	struct tegra_xusb_usb2_port *usb2 = tegra_xusb_find_usb2_port(padctl,
> +								      port);
> +	struct tegra_xusb_usb3_port *usb3;
> +	int i;
> +
> +	if (!usb2)
> +		return -EINVAL;
> +
> +	for (i = 0; i < padctl->soc->ports.usb3.count; i++) {
> +		usb3 = tegra_xusb_find_usb3_port(padctl, i);
> +		if (usb3 && usb3->port == usb2->base.index)
> +			return usb3->base.index;
> +	}
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(tegra_xusb_padctl_get_usb3_companion);
> +
>  MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
>  MODULE_DESCRIPTION("Tegra XUSB Pad Controller driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/phy/tegra/xusb.h b/include/linux/phy/tegra/xusb.h
> index 1235865..71d9569 100644
> --- a/include/linux/phy/tegra/xusb.h
> +++ b/include/linux/phy/tegra/xusb.h
> @@ -21,4 +21,6 @@ int tegra_xusb_padctl_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
>  int tegra_xusb_padctl_set_vbus_override(struct tegra_xusb_padctl *padctl,
>  					bool val);
>  int tegra_phy_xusb_utmi_port_reset(struct phy *phy);
> +int tegra_xusb_padctl_get_usb3_companion(struct tegra_xusb_padctl *padctl,
> +					 unsigned int port);
>  #endif /* PHY_TEGRA_XUSB_H */
> 
Reviewed-by: JC Kuo <jckuo@nvidia.com>
