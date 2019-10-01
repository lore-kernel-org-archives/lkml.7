Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F5ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F2320842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfJAOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:04:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726554AbfJAOEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:04:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D19F5D31F20412817C8C;
        Tue,  1 Oct 2019 22:04:41 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 1 Oct 2019
 22:04:36 +0800
Subject: Re: [PATCH 3/3] arm64: configs: unset CPU_BIG_ENDIAN
To:     Anders Roxell <anders.roxell@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>
References: <20190926193030.5843-1-anders.roxell@linaro.org>
 <20190926193030.5843-5-anders.roxell@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf5db3a5-96da-752c-49ea-d0de899882d5@huawei.com>
Date:   Tue, 1 Oct 2019 15:04:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190926193030.5843-5-anders.roxell@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2019 20:30, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> people wants.

Today allmodconfig does not enable CONFIG_ACPI due to BE config, which 
is quite unfortunate, I'd say.

>
> Rework so that we disable CONFIG_CPU_BIG_ENDIAN in the defcinfig file so

defconfig

> it doesn't get enabled when building allmodconfig kernels. When doing a
> 'make savedefconfig' CONFIG_CPU_BIG_ENDIAN will be dropped.

So without having to pass KCONFIG_ALLCONFIG or do anything else, what 
about a config for CONFIG_CPU_LITTLE_ENDIAN instead? I'm not sure if 
that was omitted for a specific reason.

Thanks,
John

>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 878f379d8d84..c9aa6b9ee996 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -855,3 +855,4 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_SCHED_DEBUG is not set
>  CONFIG_MEMTEST=y
>  # CONFIG_CMDLINE_FORCE is not set
> +# CONFIG_CPU_BIG_ENDIAN is not set
>


