Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2863BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED93721841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfCTD7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfCTD7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:59:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD19204FD;
        Wed, 20 Mar 2019 03:58:59 +0000 (UTC)
Date:   Tue, 19 Mar 2019 23:58:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        <will.deacon@arm.com>, <joel@joelfernandes.org>,
        <namhyung@kernel.org>, <akpm@linux-foundation.org>,
        <tglx@linutronix.de>, <rppt@linux.ibm.com>,
        <linux@dominikbrodowski.net>, <adobriyan@gmail.com>, <cai@lca.pw>,
        <ard.biesheuvel@linaro.org>, <axboe@kernel.dk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: User Stack Tracer Causes Crash
Message-ID: <20190319235858.084b75b1@oasis.local.home>
In-Reply-To: <897cf5cf-fc24-8a64-cb28-847f2d2e63d2@windriver.com>
References: <897cf5cf-fc24-8a64-cb28-847f2d2e63d2@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 11:15:10 +0800
He Zhe <zhe.he@windriver.com> wrote:

> Hi,
> 
> User stack tracer causes crash and hang since the following commit till now(5.1-rc1).
> 
> c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and unify their usage")

Can you send me your .config.

-- Steve

> 
> echo 1 > /proc/sys/kernel/stack_tracer_enabled
> echo userstacktrace > /sys/kernel/debug/tracing/trace_options
> echo 1 > /sys/kernel/debug/tracing/events/enable
> dmesg
> 
