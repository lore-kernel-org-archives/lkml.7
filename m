Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55699C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C2218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfCUCKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:10:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726914AbfCUCKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:10:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5AC4CFC5E2E3DEAA3472;
        Thu, 21 Mar 2019 10:10:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 10:09:59 +0800
Subject: Re: [PATCH 0/2] minor fixes for perf cs-etm
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20190320063626.14792-1-yuehaibing@huawei.com>
 <CANLsYkwNz6sJVCSqCcNYJ+0nMDZcPyL9VxSc0a1dG5ghu9JBYg@mail.gmail.com>
CC:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <395a4c8a-ee85-799a-06c3-20c2b06c3950@huawei.com>
Date:   Thu, 21 Mar 2019 10:09:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CANLsYkwNz6sJVCSqCcNYJ+0nMDZcPyL9VxSc0a1dG5ghu9JBYg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/3/21 0:16, Mathieu Poirier wrote:
> On Wed, 20 Mar 2019 at 00:37, Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> This patch series fixes two issue:
>> 1. fix pass-zero-to-ERR_PTR warning
>> 2. return correct errcode to upstream callers
>>
>> YueHaibing (2):
>>   perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>>     cs_etm__process_auxtrace_info
>>   perf cs-etm: return errcode in cs_etm__process_auxtrace_info()
>>
>>  tools/perf/util/cs-etm.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Please run your work through checkpatch and resend.
> 

Sorry, I will check and resend v2.

> Mathieu
> 
>>
>> --
>> 2.7.0
>>
>>
> 
> .
> 

