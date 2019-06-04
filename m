Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C03C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5C223C14
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFDIdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:33:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbfFDIdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:33:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C46289A8C6DCB0E85411;
        Tue,  4 Jun 2019 16:33:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 16:33:46 +0800
Subject: Re: [PATCH] arm64: arch_k3: Fix kconfig dependency warning
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <marc.zyngier@arm.com>, <lokeshvutla@ti.com>, <tony@atomide.com>,
        <t-kristo@ti.com>, <lokeshvutla@ti.com>
References: <20190510035255.27568-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <a9ea9cf2-71d0-d8f8-3139-33f1945520c5@huawei.com>
Date:   Tue, 4 Jun 2019 16:33:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190510035255.27568-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping:

Who can take this?

On 2019/5/10 11:52, YueHaibing wrote:
> Fix Kbuild warning when SOC_TI is not set
> 
> WARNING: unmet direct dependencies detected for TI_SCI_INTA_IRQCHIP
>   Depends on [n]: TI_SCI_PROTOCOL [=y] && SOC_TI [=n]
>   Selected by [y]:
>   - ARCH_K3 [=y]
> 
> Fixes: 009669e74813 ("arm64: arch_k3: Enable interrupt controller drivers")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 42eca65..9d1292f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -88,6 +88,7 @@ config ARCH_K3
>  	bool "Texas Instruments Inc. K3 multicore SoC architecture"
>  	select PM_GENERIC_DOMAINS if PM
>  	select MAILBOX
> +	select SOC_TI
>  	select TI_MESSAGE_MANAGER
>  	select TI_SCI_PROTOCOL
>  	select TI_SCI_INTR_IRQCHIP
> 

