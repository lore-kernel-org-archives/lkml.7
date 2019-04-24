Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB7AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1DA2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfDXO7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:59:51 -0400
Received: from muru.com ([72.249.23.125]:47130 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfDXO7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:59:50 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 95A0A8102;
        Wed, 24 Apr 2019 15:00:06 +0000 (UTC)
Date:   Wed, 24 Apr 2019 07:59:46 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: linux-next: manual merge of the tegra tree with the rockchip tree
Message-ID: <20190424145946.GD8007@atomide.com>
References: <20190424094323.0ec123f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424094323.0ec123f0@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [190423 23:43]:
> Hi all,
> 
> Today's linux-next merge of the tegra tree got a conflict in:
> 
>   arch/arm/configs/multi_v7_defconfig
> 
> between commit:
> 
>   366391f04177 ("ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks")
> 
> from the rockchip tree and commit:
> 
>   35f8e2e29e74 ("ARM: multi_v7_defconfig: Update for moved options")
> 
> from the tegra tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

OK thank you!

Tony

> diff --cc arch/arm/configs/multi_v7_defconfig
> index 7a288d18e257,88d4da77ae9b..000000000000
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@@ -511,9 -501,6 +509,7 @@@ CONFIG_MFD_AC100=
>   CONFIG_MFD_AXP20X_I2C=y
>   CONFIG_MFD_AXP20X_RSB=y
>   CONFIG_MFD_CROS_EC=m
> - CONFIG_CROS_EC_I2C=m
> - CONFIG_CROS_EC_SPI=m
>  +CONFIG_MFD_CROS_EC_CHARDEV=m
>   CONFIG_MFD_DA9063=m
>   CONFIG_MFD_MAX14577=y
>   CONFIG_MFD_MAX77686=y


