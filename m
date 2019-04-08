Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F767C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6335B20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfDHQrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:47:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfDHQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:47:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D42A15AB;
        Mon,  8 Apr 2019 09:47:38 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BEF93F718;
        Mon,  8 Apr 2019 09:47:36 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:47:33 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH] perf vendor events arm64: Add Cortex-A72 events
Message-ID: <20190408164733.GC7872@fuggles.cambridge.arm.com>
References: <20190407213422.19059-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407213422.19059-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Sun, Apr 07, 2019 at 02:34:22PM -0700, Florian Fainelli wrote:
> The Cortex-A72 supports all ARMv8 recommended events up to the
> RC_ST_SPEC (0x91) event, create an appropriate JSON file for mapping
> those events and update the mapfile.csv for matching the Cortex-A72 MIDR
> to that file.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../arm64/arm/cortex-a72/core-imp-def.json    | 206 ++++++++++++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
>  2 files changed, 207 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a72/core-imp-def.json

It would be worth checking how many of these events are common between a57
and a72, as they may be able to share much of the json file.

Cheers,

Will
