Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F07AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C5C21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDEMgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:36:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfDEMgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B09170D64;
        Fri,  5 Apr 2019 12:36:22 +0000 (UTC)
Received: from krava (unknown [10.40.205.144])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA5ED1001E6F;
        Fri,  5 Apr 2019 12:36:19 +0000 (UTC)
Date:   Fri, 5 Apr 2019 14:36:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 0/2] arm64: perf: Expose Cortex-A53 micro architectural
 events
Message-ID: <20190405123618.GA10844@krava>
References: <20190404232545.2627-1-f.fainelli@gmail.com>
 <9f90bfc1-3f83-8fc1-f109-114467d4e574@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f90bfc1-3f83-8fc1-f109-114467d4e574@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 05 Apr 2019 12:36:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:36:20AM +0100, Robin Murphy wrote:
> Hi Florian,
> 
> On 05/04/2019 00:25, Florian Fainelli wrote:
> > Hi all,
> > 
> > This patch series adds support for the Cortex-A53 micro architectural
> > events that I recently had to use for some debugging exercise.
> > 
> > Events from 0xC0 - 0xD2 are exposed, others could easily be added later
> > if we wanted to.
> 
> As far as I'm aware (which admittedly is not all-the-way far) these events
> should already be understood by userspace, per
> tools/perf/pmu-events/arch/arm64/arm/cortex-a53/* - is there a specific
> reason to need in-kernel definitions?

right, we store events in perf tools in json files, please
check commits changelogs under tools/perf/pmu-events/arch

jirka
