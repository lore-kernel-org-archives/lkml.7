Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34820C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CE624650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfLSQWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:22:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE0A206EC;
        Thu, 19 Dec 2019 16:22:16 +0000 (UTC)
Date:   Thu, 19 Dec 2019 11:22:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219112214.37f1f0af@gandalf.local.home>
In-Reply-To: <af65cbaf-2f8e-0384-03e8-262d35e3790e@virtuozzo.com>
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
        <20191219131242.GK2827@hirez.programming.kicks-ass.net>
        <20191219140252.GS2871@hirez.programming.kicks-ass.net>
        <bfaa72ca-8bc6-f93c-30d7-5d62f2600f53@virtuozzo.com>
        <20191219094330.0e44c748@gandalf.local.home>
        <11d755e9-e4f8-dd9e-30b0-45aebe260b2f@virtuozzo.com>
        <20191219095941.2eebed84@gandalf.local.home>
        <44c95c18-7593-f3e7-f710-a7d424af7442@virtuozzo.com>
        <20191219104018.5f8e50d2@gandalf.local.home>
        <af65cbaf-2f8e-0384-03e8-262d35e3790e@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 19:08:05 +0300
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> Should I resend this as two patches, with your changes in a separate?

You don't have to, you can include multiple SOBs if a patch was written
by two people.

But perhaps it will better to do so, that way people will know who to
blame when the linker breaks ;-)

I'll send you a patch that you can apply just before your change. That
may be the cleanest way.

-- Steve
