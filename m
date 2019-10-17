Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F26C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD4B20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405324AbfJQGIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:08:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404944AbfJQGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:08:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 35D6EDCC53C893CB8D8C;
        Thu, 17 Oct 2019 14:08:31 +0800 (CST)
Received: from [127.0.0.1] (10.133.215.182) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:08:24 +0800
Subject: Re: [RFC PATCH 2/3] perf tools: Add support for "report" for some spe
 events
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     James Clark <James.Clark@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "yao.jin@linux.intel.com" <yao.jin@linux.intel.com>,
        "tmricht@linux.ibm.com" <tmricht@linux.ibm.com>,
        "brueckner@linux.ibm.com" <brueckner@linux.ibm.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Kim Phillips <Kim.Phillips@amd.com>
CC:     "gengdongjiu@huawei.com" <gengdongjiu@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Al Grant" <Al.Grant@arm.com>, nd <nd@arm.com>
References: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
 <1564738813-10944-3-git-send-email-tanxiaojun@huawei.com>
 <0ac06995-273c-034d-52a3-921ea0337be2@arm.com>
 <016c1ce8-7220-75a2-43fa-0efe150f897c@huawei.com>
 <805660ca-1cf3-4c7f-3aa2-61fed59afa8b@arm.com>
 <637836d6-c884-1a55-7730-eeb45b590d39@huawei.com>
 <b7e5ca2d-8c6c-8ab8-637e-a9aaebaf62a5@arm.com>
 <2b1fc8c7-c0b9-f4b9-a24f-444bc22129af@huawei.com>
 <335fedb8-128c-7d34-c5e8-15cd660fe12e@huawei.com>
 <58bed363-41ee-e425-a36e-e3c69d1a4e90@arm.com>
 <647c65eb-669c-e118-e2e7-bbc2a3143884@huawei.com>
Message-ID: <c71b197a-3121-7821-e74c-a2200e03bd05@huawei.com>
Date:   Thu, 17 Oct 2019 14:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <647c65eb-669c-e118-e2e7-bbc2a3143884@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.215.182]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/17 9:51, Tan Xiaojun wrote:
> On 2019/10/16 18:12, James Clark wrote:
>> Hi Xiaojun,
>>
>>>>
>>>> What do you mean when the user specifies "event:pp", if the SPE is available, configure and record the spe data directly via the perf event open syscall?
>>>> (perf.data itself is the same as using -e arm_spe_0//xxx?)
>>>
>>> I mean, for the perf record, if the user does not add ":pp" to these events, the original process is taken, and if ":pp" is added, the spe process is taken.
>>>
>>
>> Yes we think this is the best way to do it considering that SPE has been implemented as a separate PMU and it will be very difficult to do it in the Kernel when the precise_ip attribute is set.
>>
>> I think doing everything in userspace is easiest. This will at least mean that users of Perf don't have to be aware of the details of SPE to get precise sample data.
>>
>> So if the user specifies "event:p" when SPE is available, the SPE PMU is automatically configured data is recorded. If the user also specifies -e arm_spe_0//xxx and wants to do some manual configuration, then that could override the automatic configuration.
>>
>>
>> James
>>
>>
>>
> 
> OK. I got it.
> 
> I found a bug in the test. If I specify cpu_list(use -a or -C) when logging spe data, some events with "pid:0 tid:0" is logged. This is obviously wrong.
> 
> I want to solve this problem, but I haven't found out what went wrong.
> 
> --------------------------------------------------------------
> [root@server121 perf]# perf record -e arm_spe_0/branch_filter=1,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,store_filter=1,min_latency=0/ -a

Sorry, it should add "--all-user" here, and finally there will still be some "pid:0" events in spe_dump.out. 
(And if kernel event is included, then "pid:0" is not a problem)

This causes the pc address of some spe sampled data to be untranslated because the wrong pid/tid is obtained from here.

Thanks.
Xiaojun.

> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 7.925 MB perf.data ]
> [root@server121 perf]# perf report -D > spe_dump.out
> [root@server121 perf]# vim spe_dump.out
> 
> --------------------------------------------------------------
> ...
> 0xd0330 [0x30]: event: 12
> .
> . ... raw event: size 48 bytes
> .  0000:  0c 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00  ......0.........
> .  0010:  00 00 00 00 00 00 00 00 f8 d9 fe bd f7 08 02 00  ................
> .  0020:  00 00 00 00 00 00 00 00 4c bc 14 00 00 00 00 00  ........L.......
> 
> 0 572810090961400 0xd0330 [0x30]: PERF_RECORD_ITRACE_START pid: 0 tid: 0
> 
> 0xd0438 [0x30]: event: 12
> .
> . ... raw event: size 48 bytes
> .  0000:  0c 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00  ......0.........
> .  0010:  00 00 00 00 00 00 00 00 d8 ef fe bd f7 08 02 00  ................
> .  0020:  01 00 00 00 00 00 00 00 4d bc 14 00 00 00 00 00  ........M.......
> 
> 1 572810090967000 0xd0438 [0x30]: PERF_RECORD_ITRACE_START pid: 0 tid: 0
> ...
> --------------------------------------------------------------
> 
> Thanks.
> Xiaojun.
> 
> 
> .
> 


