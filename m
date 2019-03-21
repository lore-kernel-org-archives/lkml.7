Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8340C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9329C21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfCUJcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:32:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbfCUJcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:32:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6473BAE33;
        Thu, 21 Mar 2019 09:32:19 +0000 (UTC)
Date:   Thu, 21 Mar 2019 10:32:17 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Message-ID: <20190321093217.GB7022@nazgul.tnic>
References: <2816566.rddYshD6lm@aspire.rjw.lan>
 <20190321075807.GK6058@hirez.programming.kicks-ass.net>
 <20190321092055.GA7022@nazgul.tnic>
 <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iiV3djzJrgj0GCeDuVs4hrtWKT9chtwLah5DpCw2sRaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 10:28:50AM +0100, Rafael J. Wysocki wrote:
> So as I've just said, I'm going to add a sysfs knob for adjusting EPB,
> but I'd rather not do that in this patch.

Yes, but let's do it ontop pls. Otherwise we'll never get off this
/dev/msr perpetual insanity.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
