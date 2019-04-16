Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06280C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C643320684
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfDPJrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:47:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfDPJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:47:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hGKgZ-0003ew-U3; Tue, 16 Apr 2019 11:47:28 +0200
Date:   Tue, 16 Apr 2019 11:47:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        john.ogness@linutronix.de, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Document that RT task priorities
 are 1...99
Message-ID: <20190416094727.xanzq5t2xjuflcbt@linutronix.de>
References: <20190403210821.10916-1-bigeasy@linutronix.de>
 <tip-37a8f8590f307db8f8cfa62dfd82b3fc0978607c@git.kernel.org>
 <20190416093634.GS11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416093634.GS11158@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-16 11:36:34 [+0200], Peter Zijlstra wrote:
> On Tue, Apr 16, 2019 at 01:13:11AM -0700, tip-bot for Sebastian Andrzej Siewior wrote:
> > Commit-ID:  37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> > Gitweb:     https://git.kernel.org/tip/37a8f8590f307db8f8cfa62dfd82b3fc0978607c
> > Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > AuthorDate: Wed, 3 Apr 2019 23:08:21 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 16 Apr 2019 10:06:08 +0200
> > 
> > sched/core: Document that RT task priorities are 1...99
> > 
> > John identified three files which claim that RT task priorities start at
> > zero. As far as I understand, 0 is used for DL and has nothing to do
> > wihich RT priorities as identified by the RT policy.
> 
> DL is -1, 0 is still very much FIFO/FF

but it can't be set. The lowest we can set is 1. Is this a bug then?

Sebastian
