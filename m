Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93502C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766E920692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbfIMWwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:52:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:51512 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404136AbfIMWwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:52:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="386557590"
Received: from spandruv-mobl3.jf.intel.com ([10.251.25.193])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2019 15:52:04 -0700
Message-ID: <4226d5f460604a8130f8079b74ef3fb1d60009d7.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86,sched: Add support for frequency invariance
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net
Cc:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        matt@codeblueprint.co.uk, viresh.kumar@linaro.org,
        juri.lelli@redhat.com, pjt@google.com, vincent.guittot@linaro.org,
        qperret@qperret.net, dietmar.eggemann@arm.com
Date:   Fri, 13 Sep 2019 15:52:04 -0700
In-Reply-To: <20190909024216.5942-2-ggherdovich@suse.cz>
References: <20190909024216.5942-1-ggherdovich@suse.cz>
         <20190909024216.5942-2-ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-09 at 04:42 +0200, Giovanni Gherdovich wrote:

...

> +
> +/*
> + * APERF/MPERF frequency ratio computation.
> + *
> + * The scheduler wants to do frequency invariant accounting and
> needs a <1
> + * ratio to account for the 'current' frequency, corresponding to
> + * freq_curr / freq_max.
I thought this is no longer the restriction and Vincent did some work
to remove this restriction. 


Thanks,
Srinivas

