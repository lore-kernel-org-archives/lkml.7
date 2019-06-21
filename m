Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71976C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAD221537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NGavKgri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFUGM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:12:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57786 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUGM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:12:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5L6CsMi004046;
        Fri, 21 Jun 2019 01:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561097574;
        bh=PD/ayTptu33JuDSOPUfDqiqPSm+5LeRQA4Er8+oHVf4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NGavKgrilS95a4euDX0uhK//dEkL5SN+ZoyfV1lW2J+rNgmIoS2uNR/t+HKYeLB78
         gQEUDGloMD9inCDSwwJfkFY+Xn1eUC/fXEUxiYkA5YYXfQk0noBs1xDBehCkKp+8Wt
         FcbgYZMiDR1IN5XvFpPd4YwrNEVDBxszJYYdEOv8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5L6CsLW044455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 01:12:54 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 21
 Jun 2019 01:12:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 21 Jun 2019 01:12:54 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5L6Cq41127207;
        Fri, 21 Jun 2019 01:12:53 -0500
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190612102803.25398-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
Date:   Fri, 21 Jun 2019 11:41:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612102803.25398-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the updated pull request for 5.2 -rc cycle. Here I dropped
> the patch that added "static" for a function to fix sparse warning.
> 
> I'm also sending the patches along with this pull request in case you'd
> like to look them.
> 
> Consider merging it in this -rc cycle and let me know if you want me
> to make any further changes.

Are you planning to merge this?

Thanks
Kishon

> 
> Thanks
> Kishon
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2-rc_v2
> 
> for you to fetch changes up to e3888cda394c72dcfd450afec1121d9777a59805:
> 
>   phy: tegra: xusb: Add Tegra210 PLL power supplies (2019-06-12 15:35:44 +0530)
> 
> ----------------------------------------------------------------
> phy: for 5.2-rc
> 
>   *) Move Tegra124 PLL power supplies to be enabled by xusb-tegra124
>   *) Move Tegra210 PLL power supplies to be enabled by xusb-tegra210
>   *) Minor fixes: fix memory leaks at error path and addresses coverity.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       phy: qcom-qusb2: fix missing assignment of ret when calling clk_prepare_enable
> 
> Florian Fainelli (1):
>       phy: usb: phy-brcm-usb: Remove sysfs attributes upon driver removal
> 
> Thierry Reding (3):
>       dt-bindings: phy: tegra-xusb: List PLL power supplies
>       phy: tegra: xusb: Add Tegra124 PLL power supplies
>       phy: tegra: xusb: Add Tegra210 PLL power supplies
> 
> Yoshihiro Shimoda (1):
>       phy: renesas: rcar-gen2: Fix memory leak at error paths
> 
>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 12 ++++++++++++
>  drivers/phy/broadcom/phy-brcm-usb.c                                   |  8 ++++++++
>  drivers/phy/qualcomm/phy-qcom-qusb2.c                                 |  2 +-
>  drivers/phy/renesas/phy-rcar-gen2.c                                   |  2 ++
>  drivers/phy/tegra/xusb-tegra124.c                                     |  9 +++++++++
>  drivers/phy/tegra/xusb-tegra210.c                                     |  9 +++++++++
>  6 files changed, 41 insertions(+), 1 deletion(-)
> 
