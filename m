Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F350CC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9DC82064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLFMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:32:07 -0500
Received: from foss.arm.com ([217.140.110.172]:42110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfLFMcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:32:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A39DC31B;
        Fri,  6 Dec 2019 04:32:06 -0800 (PST)
Received: from [192.168.1.13] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94B563F52E;
        Fri,  6 Dec 2019 04:32:03 -0800 (PST)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
 <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
 <838f233e-fa4c-d5a3-9b50-69e2e121edda@arm.com>
 <5c5b61fa-e8f7-5aa7-0fe0-91cb0d4736fb@linux.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1cc0a6a4-85e9-4b53-7139-261558682582@arm.com>
Date:   Fri, 6 Dec 2019 13:31:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <5c5b61fa-e8f7-5aa7-0fe0-91cb0d4736fb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.19 18:13, Parth Shah wrote:
> 
> 
> On 12/5/19 7:33 PM, Dietmar Eggemann wrote:
>> On 05/12/2019 11:49, Valentin Schneider wrote:
>>>  
>>> On 05/12/2019 09:24, Dietmar Eggemann wrote:
>>>> On 25/11/2019 10:46, Parth Shah wrote:

[...]

>> OK, I went through this thread again. So Google or we have to provide
>> the missing per-taskgroup API via cpu controller's attributes (like for
>> uclamp) for the EAS usecase.
> 
> I suppose many others (including myself) will also be interested in having
> per-taskgroup attribute via CPU controller.

Ok, let us have a look since Android needs it.

[...]

> I kept choosing appropriate name and possible values for this new attribute
> in the separate thread. https://lkml.org/lkml/2019/9/30/215
> From which discussion, looking at Patrick's comment
> https://lkml.org/lkml/2019/9/18/678 I thought of picking latency_tolerance
> as the appropriate name.
> Still will be happy to change as per the community needs.

Yeah, SCHED_FLAG_LATENCY_TOLERANCE seems to be pretty long.
