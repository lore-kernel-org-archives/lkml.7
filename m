Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C1AC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712532070B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfJDOaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:30:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389076AbfJDOaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:30:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C620B9D31335E60E74F4;
        Fri,  4 Oct 2019 22:30:21 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 22:30:14 +0800
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
Date:   Fri, 4 Oct 2019 15:30:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 16:54, John Garry wrote:
> This patchset adds some missing uncore PMU events for the hip08 arm64
> platform.
>
> The missing events were originally mentioned in
> https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
>
> It also includes a fix for a DDRC eventname.

Hi guys,

Could I get these JSON updates picked up please? Maybe they were missed 
earlier. Let me know if I should re-post.

Thanks in advance,
John

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


