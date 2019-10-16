Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E7C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA5420854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbfJPHjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:39:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfJPHjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:39:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKdti-0007a0-9K; Wed, 16 Oct 2019 09:39:06 +0200
Date:   Wed, 16 Oct 2019 09:39:06 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de
Subject: Re: [PATCH 06/34] csky: Use CONFIG_PREEMPTION
Message-ID: <20191016073905.yv4xqoovrdrnrbp7@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-7-bigeasy@linutronix.de>
 <CAJF2gTSVxgc5kw22dfotoHF91HxyTKC4ETYLTskEfyn3rf=kCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTSVxgc5kw22dfotoHF91HxyTKC4ETYLTskEfyn3rf=kCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 07:29:34 [+0800], Guo Ren wrote:
> Could CONFIG_PREEMPT_RT be supported in csky ? Any arch backend porting ?

It could. HIGH_RES_TIMERS is useful and IRQ_FORCED_THREADING is
required. You already have PREEMPT(ION) which is good. Then you would
have to try and my guess would be that some of spinlock_t vs
raw_spinlock_t could require changes but we should have lockdep support
for that which would make things easier.

Sebastian
