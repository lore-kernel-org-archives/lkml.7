Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131AECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2210B2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393077AbfJQJOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:14:46 -0400
Received: from [217.140.110.172] ([217.140.110.172]:36276 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1733113AbfJQJOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:14:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2101684;
        Thu, 17 Oct 2019 02:14:19 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EE33F718;
        Thu, 17 Oct 2019 02:14:18 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:14:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] cpufreq: simplify and remove lots of debug messages
Message-ID: <20191017091416.GC8978@bogus>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-4-sudeep.holla@arm.com>
 <20191017024200.3hhak2wx7yvjifqh@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017024200.3hhak2wx7yvjifqh@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 08:12:00AM +0530, Viresh Kumar wrote:
> On 16-10-19, 12:03, Sudeep Holla wrote:
> > cpufreq_arm_bL_ops is no longer needed after merging the generic
> > arm_big_little and vexpress-spc driver. Remove cpufreq_arm_bL_ops
> > and rename all the bL_* function names to ve_spc_*.
> >
> > This driver have been used for year now and the extensive debug
> > messages in the driver are not really required anymore.
>
> This does lots of cleanup in this patch and not strictly what the commit log
> says. Can you please create separate patches for remove ops, debug messages and
> other formatting things ?
>

Yes I did notice just after posting. These patches were sitting in my tree
for long time and didn't look at them in detail before posting. I will
split the patch accordingly.

--
Regards,
Sudeep
