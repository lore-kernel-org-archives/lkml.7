Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF272C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820EC206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfJGNlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:41:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbfJGNlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:41:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D5907263AB03CEC56409;
        Mon,  7 Oct 2019 21:40:55 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 7 Oct 2019
 21:40:47 +0800
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
 <20191004143658.GA17687@kernel.org> <20191004143835.GB17687@kernel.org>
 <969729ce-6246-6fa7-45c9-3dd9cb07059d@huawei.com>
 <20191004151853.GC17687@kernel.org>
 <0492ebd9-f867-423d-034c-9fe1c74902e7@huawei.com>
 <20191004190639.GB5399@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>, James Clark <James.Clark@arm.com>,
        Ganapatrao Kulkarni <gklkml16@gmail.com>,
        "William Cohen" <wcohen@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6990f60b-2df4-b20c-2777-090bc4d9b6db@huawei.com>
Date:   Mon, 7 Oct 2019 14:40:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20191004190639.GB5399@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> As an alternative, how about just add a maintainers entry for reviewers per
>> arch? As a start, I don't mind being added there for arm64:
>>
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12767,6 +12767,10 @@ F:     arch/*/events/*
>>  F:     arch/*/events/*/*
>>  F:     tools/perf/
>>
>> +PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
>> +R:     John Garry <john.garry@huawei.com>
>> +F:     tools/perf/pmu-events/arch/arm64
>> +
>>
>> Patches per-arch should have some nod/tag from a member of the respective
>> list. Or at very least be cc'ed :)
>
> Another Ok, please send a formal patch, and it would be really nice if
> the other ARM folks would... Ack that ;-) :-) And provide extra entries
> for the other pmu-events directories or even for specific files, which
> is a possibility, right?

ok, can do. Will has kindly agreed to have his name added to the 
MAINTAINERS entry (thanks). Other Cc's from ARM community may also be 
interested to be included - shout if so.

So I'll just include tools/perf/pmu-events/arch/arm64 for now.

The code in tools/perf/pmu-events/. should be generic for all 
architectures, while I'd say tools/perf/arch/arm64 is not strictly related.

Thanks,
John

>
> On my side I'll script a bit more and make sure that a post commit hook
> warns me if the right tag is not present.
>
> - Arnaldo
>
> .
>


