Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008FBC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78132171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbfHHLoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:44:05 -0400
Received: from foss.arm.com ([217.140.110.172]:60428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbfHHLoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:44:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEE3F15A2;
        Thu,  8 Aug 2019 04:44:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D513F694;
        Thu,  8 Aug 2019 04:44:03 -0700 (PDT)
Date:   Thu, 8 Aug 2019 12:44:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: fix equation in comment
Message-ID: <20190808114401.ziyxnm5yffjupnpm@e107158-lin.cambridge.arm.com>
References: <20190802104628.8410-1-qais.yousef@arm.com>
 <20190805130620.GL2349@hirez.programming.kicks-ass.net>
 <13854122.nn4VJ8hDQq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13854122.nn4VJ8hDQq@kreacher>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/19 11:42, Rafael J. Wysocki wrote:
> On Monday, August 5, 2019 3:06:20 PM CEST Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 11:46:28AM +0100, Qais Yousef wrote:
> > > scale_irq_capacity() call in schedutil_cpu_util() does
> > > 
> > > 	util *= (max - irq)
> > > 	util /= max
> > > 
> > > But the comment says
> > > 
> > > 	util *= (1 - irq)
> > > 	util /= max
> > > 
> > > Fix the comment to match what the scaling function does.
> > > 
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > 
> > Thanks!
> > 
> 
> I've applied this, so please let me know if it has gone into -tip too and I'll drop it then.

FYI I've just got an email from tip-bot that it was committed there.

Thanks!

--
Qais Yousef
