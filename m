Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DD6C10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848A4217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfDEJg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:36:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44570 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbfDEJg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:36:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF6EB16A3;
        Fri,  5 Apr 2019 02:36:27 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD38F3F721;
        Fri,  5 Apr 2019 02:36:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] arm64: perf: Expose Cortex-A53 micro architectural
 events
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <20190404232545.2627-1-f.fainelli@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9f90bfc1-3f83-8fc1-f109-114467d4e574@arm.com>
Date:   Fri, 5 Apr 2019 10:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404232545.2627-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 05/04/2019 00:25, Florian Fainelli wrote:
> Hi all,
> 
> This patch series adds support for the Cortex-A53 micro architectural
> events that I recently had to use for some debugging exercise.
> 
> Events from 0xC0 - 0xD2 are exposed, others could easily be added later
> if we wanted to.

As far as I'm aware (which admittedly is not all-the-way far) these 
events should already be understood by userspace, per 
tools/perf/pmu-events/arch/arm64/arm/cortex-a53/* - is there a specific 
reason to need in-kernel definitions?

Robin.

> 
> Thanks!
> 
> Florian Fainelli (2):
>    arm64: perf: Group common ARMv8 v3 PMU events in a macro
>    arm64: perf: Expose Cortex-A53 micro architectural events
> 
>   arch/arm64/kernel/perf_event.c | 241 ++++++++++++++++++++++++---------
>   1 file changed, 179 insertions(+), 62 deletions(-)
> 
