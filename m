Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39C4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DEC2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfDHQ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:26:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51498 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfDHQ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:26:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4697E15AB;
        Mon,  8 Apr 2019 09:26:12 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 331133F718;
        Mon,  8 Apr 2019 09:26:10 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:26:07 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf vendor events arm64: Map Brahma-B53 CPUID to
 cortex-a53 events
Message-ID: <20190408162607.GB7872@fuggles.cambridge.arm.com>
References: <20190405165047.15847-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405165047.15847-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 09:50:47AM -0700, Florian Fainelli wrote:
> Broadcom's Brahma-B53 CPUs support the same type of events that the
> Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
> events.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index 59cd8604b0bd..e97c12484bc6 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -13,6 +13,7 @@
>  #
>  #Family-model,Version,Filename,EventType
>  0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
> +0x00000000420f100[[:xdigit:]],v1,arm/cortex-a53,core
>  0x00000000420f5160,v1,cavium/thunderx2,core
>  0x00000000430f0af0,v1,cavium/thunderx2,core
>  0x00000000480fd010,v1,hisilicon/hip08,core

Acked-by: Will Deacon <will.deacon@arm.com>

Will
