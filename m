Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABDCA9ED0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2C222D1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfKDBKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:10:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfKDBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:10:36 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78599A16181B0DF53067;
        Mon,  4 Nov 2019 09:10:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 09:10:22 +0800
Subject: Re: stable-rc-4.19: cpufeature.c:909:21: error: 'MIDR_HISI_TSV110'
 undeclared
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <john.garry@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        <zhangshaokun@hisilicon.com>, <lkft-triage@lists.linaro.org>,
        <andrew.murray@arm.com>, <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <CA+G9fYtoODTuayzXdsv=bFuRPvw1-+dmZxHqQePy6LX8ixOG5A@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <98f10e13-8ec8-1690-a867-f212bcea969f@huawei.com>
Date:   Mon, 4 Nov 2019 09:10:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYtoODTuayzXdsv=bFuRPvw1-+dmZxHqQePy6LX8ixOG5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha, Greg,

On 2019/11/4 7:22, Naresh Kamboju wrote:
> stable rc 4.19  branch build broken for arm64 with the below error log,
> 
> Build error log,
> arch/arm64/kernel/cpufeature.c: In function 'unmap_kernel_at_el0':
> arch/arm64/kernel/cpufeature.c:909:21: error: 'MIDR_HISI_TSV110'
> undeclared (first use in this function); did you mean
> 'GICR_ISACTIVER0'?
>   MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
>                     ^
> arch/arm64/include/asm/cputype.h:141:12: note: in definition of macro
> 'MIDR_RANGE'
>   .model = m,     \
>            ^
> arch/arm64/kernel/cpufeature.c:909:3: note: in expansion of macro
> 'MIDR_ALL_VERSIONS'
>   MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
>   ^~~~~~~~~~~~~~~~~
> arch/arm64/kernel/cpufeature.c:909:21: note: each undeclared
> identifier is reported only once for each function it appears in
>   MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
>                     ^
> arch/arm64/include/asm/cputype.h:141:12: note: in definition of macro
> 'MIDR_RANGE'
>   .model = m,     \
>            ^
> arch/arm64/kernel/cpufeature.c:909:3: note: in expansion of macro
> 'MIDR_ALL_VERSIONS'
>   MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),

Patch "efd00c7 arm64: Add MIDR encoding for HiSilicon Taishan CPUs" needs to
be bacported as well, would you like me to do that, or just cherry-pick by yourself?

Thanks
Hanjun

