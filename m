Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6151EC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4343A206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbfJIBO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:14:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727051AbfJIBO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:14:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CCD477714687AFCF4908;
        Wed,  9 Oct 2019 09:14:55 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 9 Oct 2019
 09:14:46 +0800
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
To:     John Garry <john.garry@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <80d5b29a-64fe-7c0f-6e5d-74a030851fd8@hisilicon.com>
Date:   Wed, 9 Oct 2019 09:14:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Thanks for your nice work, these are useful for performance profiling
if anyone is unfamiliar with the uncore PMU events on hip08.
For this patchset, please feel free to add
Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks,
Shaokun

On 2019/9/4 23:54, John Garry wrote:
> This patchset adds some missing uncore PMU events for the hip08 arm64
> platform.
> 
> The missing events were originally mentioned in
> https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> 
> It also includes a fix for a DDRC eventname.
> 
> John Garry (4):
>   perf jevents: Fix Hisi hip08 DDRC PMU eventname
>   perf jevents: Add some missing events for Hisi hip08 DDRC PMU
>   perf jevents: Add some missing events for Hisi hip08 L3C PMU
>   perf jevents: Add some missing events for Hisi hip08 HHA PMU
> 
>  .../arm64/hisilicon/hip08/uncore-ddrc.json    | 16 +++++-
>  .../arm64/hisilicon/hip08/uncore-hha.json     | 23 +++++++-
>  .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
>  3 files changed, 93 insertions(+), 2 deletions(-)
> 

