Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C245C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F79520862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfEOJCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:02:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfEOJCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:02:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5EA2FF5CA70894C1290;
        Wed, 15 May 2019 17:02:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 May 2019
 17:02:09 +0800
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Remove [[:xdigit:]]
 wildcard
To:     Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>
References: <20190513202522.9050-1-f.fainelli@gmail.com>
 <20190513202522.9050-2-f.fainelli@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <153ce6d0-d4dd-ef2f-9fd7-47335cfeb67b@huawei.com>
Date:   Wed, 15 May 2019 10:02:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190513202522.9050-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2019 21:25, Florian Fainelli wrote:
> ARM64's implementation of get_cpuidr_str() masks out the revision bits
> [3:0] while reading the CPU identifier, there is no need for the
> [[:xdigit:]] wildcard.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index 59cd8604b0bd..da5ff2204bf6 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -12,7 +12,7 @@
>  #

JFYI, this was discussed before, but this a53 entry seemed to make it 
though:
https://lkml.org/lkml/2018/3/7/1236

>  #
>  #Family-model,Version,Filename,EventType
> -0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
> +0x00000000410fd030,v1,arm/cortex-a53,core
>  0x00000000420f5160,v1,cavium/thunderx2,core
>  0x00000000430f0af0,v1,cavium/thunderx2,core
>  0x00000000480fd010,v1,hisilicon/hip08,core
>


