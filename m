Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B7BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3F5214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfHANPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:15:36 -0400
Received: from foss.arm.com ([217.140.110.172]:35992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHANPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:15:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A16F337;
        Thu,  1 Aug 2019 06:15:35 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 216BE3F575;
        Thu,  1 Aug 2019 06:15:34 -0700 (PDT)
Date:   Thu, 1 Aug 2019 14:15:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vexpress: Add missing newline at end of file
Message-ID: <20190801131527.GA23424@e107155-lin>
References: <20190617143547.4721-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617143547.4721-1-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 04:35:47PM +0200, Geert Uytterhoeven wrote:
> "git diff" says:
>
>     \ No newline at end of file
>
> after modifying the file.
>

Sorry for missing this earlier. Just found this unread and thought of
applying it to v5.4

However doing a quick check on the tree revealed more file and wonder
why you are addressing only handful of them. Why not all in one go ?
My script showed the following files:

Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
arch/arm/boot/dts/vexpress-v2m.dtsi
drivers/media/dvb-frontends/cxd2880/Kconfig
drivers/parport/Makefile
tools/perf/pmu-events/arch/powerpc/power9/cache.json
tools/perf/pmu-events/arch/powerpc/power9/floating-point.json
tools/perf/pmu-events/arch/powerpc/power9/frontend.json
tools/perf/pmu-events/arch/powerpc/power9/marked.json
tools/perf/pmu-events/arch/powerpc/power9/memory.json
tools/perf/pmu-events/arch/powerpc/power9/other.json
tools/perf/pmu-events/arch/powerpc/power9/pipeline.json
tools/perf/pmu-events/arch/powerpc/power9/pmc.json
tools/perf/pmu-events/arch/powerpc/power9/translation.json
tools/perf/pmu-events/arch/x86/bonnell/cache.json
tools/perf/pmu-events/arch/x86/bonnell/floating-point.json
tools/perf/pmu-events/arch/x86/bonnell/frontend.json
tools/perf/pmu-events/arch/x86/bonnell/memory.json
tools/perf/pmu-events/arch/x86/bonnell/other.json
tools/perf/pmu-events/arch/x86/bonnell/pipeline.json
tools/perf/pmu-events/arch/x86/bonnell/virtual-memory.json
tools/perf/pmu-events/arch/x86/broadwell/cache.json
tools/perf/pmu-events/arch/x86/broadwell/floating-point.json
tools/perf/pmu-events/arch/x86/broadwell/frontend.json
tools/perf/pmu-events/arch/x86/broadwell/memory.json
tools/perf/pmu-events/arch/x86/broadwell/other.json
tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
tools/perf/pmu-events/arch/x86/broadwell/uncore.json
tools/perf/pmu-events/arch/x86/broadwell/virtual-memory.json
tools/perf/pmu-events/arch/x86/broadwellde/cache.json
tools/perf/pmu-events/arch/x86/broadwellde/floating-point.json
tools/perf/pmu-events/arch/x86/broadwellde/frontend.json
tools/perf/pmu-events/arch/x86/broadwellde/memory.json
tools/perf/pmu-events/arch/x86/broadwellde/other.json
tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
tools/perf/pmu-events/arch/x86/broadwellde/virtual-memory.json
tools/perf/pmu-events/arch/x86/broadwellx/cache.json
tools/perf/pmu-events/arch/x86/broadwellx/floating-point.json
tools/perf/pmu-events/arch/x86/broadwellx/frontend.json
tools/perf/pmu-events/arch/x86/broadwellx/memory.json
tools/perf/pmu-events/arch/x86/broadwellx/other.json
tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
tools/perf/pmu-events/arch/x86/broadwellx/virtual-memory.json
tools/perf/pmu-events/arch/x86/cascadelakex/cache.json
tools/perf/pmu-events/arch/x86/cascadelakex/floating-point.json
tools/perf/pmu-events/arch/x86/cascadelakex/frontend.json
tools/perf/pmu-events/arch/x86/cascadelakex/memory.json
tools/perf/pmu-events/arch/x86/cascadelakex/other.json
tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
tools/perf/pmu-events/arch/x86/cascadelakex/virtual-memory.json
tools/perf/pmu-events/arch/x86/goldmont/cache.json
tools/perf/pmu-events/arch/x86/goldmont/frontend.json
tools/perf/pmu-events/arch/x86/goldmont/memory.json
tools/perf/pmu-events/arch/x86/goldmont/other.json
tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
tools/perf/pmu-events/arch/x86/goldmont/virtual-memory.json
tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
tools/perf/pmu-events/arch/x86/goldmontplus/other.json
tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
tools/perf/pmu-events/arch/x86/haswell/cache.json
tools/perf/pmu-events/arch/x86/haswell/floating-point.json
tools/perf/pmu-events/arch/x86/haswell/frontend.json
tools/perf/pmu-events/arch/x86/haswell/memory.json
tools/perf/pmu-events/arch/x86/haswell/other.json
tools/perf/pmu-events/arch/x86/haswell/pipeline.json
tools/perf/pmu-events/arch/x86/haswell/uncore.json
tools/perf/pmu-events/arch/x86/haswell/virtual-memory.json
tools/perf/pmu-events/arch/x86/haswellx/cache.json
tools/perf/pmu-events/arch/x86/haswellx/floating-point.json
tools/perf/pmu-events/arch/x86/haswellx/frontend.json
tools/perf/pmu-events/arch/x86/haswellx/memory.json
tools/perf/pmu-events/arch/x86/haswellx/other.json
tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
tools/perf/pmu-events/arch/x86/haswellx/virtual-memory.json
tools/perf/pmu-events/arch/x86/ivybridge/cache.json
tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
tools/perf/pmu-events/arch/x86/ivybridge/frontend.json
tools/perf/pmu-events/arch/x86/ivybridge/memory.json
tools/perf/pmu-events/arch/x86/ivybridge/other.json
tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
tools/perf/pmu-events/arch/x86/ivybridge/uncore.json
tools/perf/pmu-events/arch/x86/ivybridge/virtual-memory.json
tools/perf/pmu-events/arch/x86/ivytown/cache.json
tools/perf/pmu-events/arch/x86/ivytown/floating-point.json
tools/perf/pmu-events/arch/x86/ivytown/frontend.json
tools/perf/pmu-events/arch/x86/ivytown/memory.json
tools/perf/pmu-events/arch/x86/ivytown/other.json
tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
tools/perf/pmu-events/arch/x86/ivytown/virtual-memory.json
tools/perf/pmu-events/arch/x86/jaketown/cache.json
tools/perf/pmu-events/arch/x86/jaketown/floating-point.json
tools/perf/pmu-events/arch/x86/jaketown/frontend.json
tools/perf/pmu-events/arch/x86/jaketown/memory.json
tools/perf/pmu-events/arch/x86/jaketown/other.json
tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
tools/perf/pmu-events/arch/x86/jaketown/virtual-memory.json
tools/perf/pmu-events/arch/x86/knightslanding/cache.json
tools/perf/pmu-events/arch/x86/knightslanding/frontend.json
tools/perf/pmu-events/arch/x86/knightslanding/memory.json
tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
tools/perf/pmu-events/arch/x86/knightslanding/virtual-memory.json
tools/perf/pmu-events/arch/x86/nehalemep/cache.json
tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
tools/perf/pmu-events/arch/x86/nehalemep/frontend.json
tools/perf/pmu-events/arch/x86/nehalemep/memory.json
tools/perf/pmu-events/arch/x86/nehalemep/other.json
tools/perf/pmu-events/arch/x86/nehalemep/pipeline.json
tools/perf/pmu-events/arch/x86/nehalemep/virtual-memory.json
tools/perf/pmu-events/arch/x86/nehalemex/cache.json
tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
tools/perf/pmu-events/arch/x86/nehalemex/frontend.json
tools/perf/pmu-events/arch/x86/nehalemex/memory.json
tools/perf/pmu-events/arch/x86/nehalemex/other.json
tools/perf/pmu-events/arch/x86/nehalemex/pipeline.json
tools/perf/pmu-events/arch/x86/nehalemex/virtual-memory.json
tools/perf/pmu-events/arch/x86/sandybridge/cache.json
tools/perf/pmu-events/arch/x86/sandybridge/floating-point.json
tools/perf/pmu-events/arch/x86/sandybridge/frontend.json
tools/perf/pmu-events/arch/x86/sandybridge/memory.json
tools/perf/pmu-events/arch/x86/sandybridge/other.json
tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
tools/perf/pmu-events/arch/x86/sandybridge/uncore.json
tools/perf/pmu-events/arch/x86/sandybridge/virtual-memory.json
tools/perf/pmu-events/arch/x86/silvermont/cache.json
tools/perf/pmu-events/arch/x86/silvermont/frontend.json
tools/perf/pmu-events/arch/x86/silvermont/memory.json
tools/perf/pmu-events/arch/x86/silvermont/other.json
tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
tools/perf/pmu-events/arch/x86/silvermont/virtual-memory.json
tools/perf/pmu-events/arch/x86/skylake/cache.json
tools/perf/pmu-events/arch/x86/skylake/floating-point.json
tools/perf/pmu-events/arch/x86/skylake/frontend.json
tools/perf/pmu-events/arch/x86/skylake/memory.json
tools/perf/pmu-events/arch/x86/skylake/other.json
tools/perf/pmu-events/arch/x86/skylake/pipeline.json
tools/perf/pmu-events/arch/x86/skylake/uncore.json
tools/perf/pmu-events/arch/x86/skylake/virtual-memory.json
tools/perf/pmu-events/arch/x86/skylakex/cache.json
tools/perf/pmu-events/arch/x86/skylakex/floating-point.json
tools/perf/pmu-events/arch/x86/skylakex/frontend.json
tools/perf/pmu-events/arch/x86/skylakex/memory.json
tools/perf/pmu-events/arch/x86/skylakex/other.json
tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
tools/perf/pmu-events/arch/x86/skylakex/virtual-memory.json
tools/perf/pmu-events/arch/x86/westmereep-dp/cache.json
tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
tools/perf/pmu-events/arch/x86/westmereep-dp/frontend.json
tools/perf/pmu-events/arch/x86/westmereep-dp/memory.json
tools/perf/pmu-events/arch/x86/westmereep-dp/other.json
tools/perf/pmu-events/arch/x86/westmereep-dp/pipeline.json
tools/perf/pmu-events/arch/x86/westmereep-dp/virtual-memory.json
tools/perf/pmu-events/arch/x86/westmereep-sp/cache.json
tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
tools/perf/pmu-events/arch/x86/westmereep-sp/frontend.json
tools/perf/pmu-events/arch/x86/westmereep-sp/memory.json
tools/perf/pmu-events/arch/x86/westmereep-sp/other.json
tools/perf/pmu-events/arch/x86/westmereep-sp/pipeline.json
tools/perf/pmu-events/arch/x86/westmereep-sp/virtual-memory.json
tools/perf/pmu-events/arch/x86/westmereex/cache.json
tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
tools/perf/pmu-events/arch/x86/westmereex/frontend.json
tools/perf/pmu-events/arch/x86/westmereex/memory.json
tools/perf/pmu-events/arch/x86/westmereex/other.json
tools/perf/pmu-events/arch/x86/westmereex/pipeline.json
tools/perf/pmu-events/arch/x86/westmereex/virtual-memory.json
tools/perf/scripts/python/bin/intel-pt-events-report
tools/power/cpupower/bench/cpufreq-bench_plot.sh
tools/power/cpupower/bench/cpufreq-bench_script.sh

--
Regards,
Sudeep
