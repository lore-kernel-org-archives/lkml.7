Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C62C7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269DF22BF5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 01:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfG0Baj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 21:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfG0Bai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 21:30:38 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646B222BF5;
        Sat, 27 Jul 2019 01:30:37 +0000 (UTC)
Date:   Fri, 26 Jul 2019 21:30:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch 0/8] core, x86: Preparatory steps for RT
Message-ID: <20190726213036.2889a17d@oasis.local.home>
In-Reply-To: <20190726211936.226129163@linutronix.de>
References: <20190726211936.226129163@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 23:19:36 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by
> CONFIG_PREEMPT_RT. Both PREEMPT and PREEMPT_RT require the same
> functionality which today depends on CONFIG_PREEMPT.
> 
> The following series adjusts the core and x86 code to use
> CONFIG_PREEMPTION where appropriate and extends the x86 dumpstack
> implementation to display PREEMPT_RT instead of PREEMPT on a RT
> enabled kernel.
>

Hmm, I'm looking at v5.3-rc1 and I don't see a CONFIG_PREEMPTION
defined. And the first patch doesn't define it. Did I miss a patch
series that adds it?

-- Steve
