Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4BCC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D1620645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfF1RGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:06:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbfF1RGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:06:09 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6AA019916D69D2CF479A;
        Sat, 29 Jun 2019 01:06:03 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Jun 2019
 01:05:52 +0800
Subject: Re: [PATCH v3 1/4] perf pmu: Support more complex PMU event aliasing
To:     Andi Kleen <ak@linux.intel.com>
References: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
 <1561732552-143038-2-git-send-email-john.garry@huawei.com>
 <20190628153344.GZ31027@tassilo.jf.intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5add76dc-ea92-9778-a65b-792f3ff17040@huawei.com>
Date:   Fri, 28 Jun 2019 18:05:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190628153344.GZ31027@tassilo.jf.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2019 16:33, Andi Kleen wrote:
>> +	/*
>> +	 * Match more complex aliases where the alias name is a comma-delimited
>> +	 * list of tokens, orderly contained in the matching PMU name.
>> +	 *
>> +	 * Example: For alias "socket,pmuname" and PMU "socketX_pmunameY", we
>> +	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
>> +	 *	    "pmunameY".
>
> This needs to be documented in some manpage.

Hi Andi,

As I see, today the man page does not mention the matching from the 
alias events declared in the jsons.

The perf list command shows these aliases, so I am not sure how useful 
that info is adding to the man page.

What the man page does mention is the glob matching on the PMU device 
name - like how "imc" can match PMU device "uncore_imc_0", but I'm not 
changing around this.

Thanks,
John

>
> -Andi
>
>
> .
>


