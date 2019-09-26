Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDAC47E48
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F6F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfIZKC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:02:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41032 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfIZKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:02:27 -0400
Received: from [65.39.69.237] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iDQbF-0003Zu-9K; Thu, 26 Sep 2019 12:02:13 +0200
Date:   Thu, 26 Sep 2019 12:01:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
cc:     fweisbec@gmail.com, mingo@kernel.org, peterz@infradead.org,
        erosca@de.adit-jv.com, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] tick: broadcast-hrtimer: Fix a race in
 bc_set_next
In-Reply-To: <20190925142029.13648-2-balasubramani_vivekanandan@mentor.com>
Message-ID: <alpine.DEB.2.21.1909261144250.5528@nanos.tec.linutronix.de>
References: <20190925115541.1170-1-balasubramani_vivekanandan@mentor.com> <20190925142029.13648-1-balasubramani_vivekanandan@mentor.com> <20190925142029.13648-2-balasubramani_vivekanandan@mentor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, Balasubramani Vivekanandan wrote:
> 
> Since it is now allowed to start the hrtimer from the callback, there is

Is now allowed? 

> no need for the try to cancel logic. All that is now removed.

Sure I can see that it is removed from the patch, but why and why is it
correct?

> [1]: rcu stall warnings noticed before this patch
> 
> [   26.477514] INFO: rcu_preempt detected stalls on CPUs/tasks:

<SNIP>

I which way is this backtrace giving any useful information about the
problem?

> 
> Signed-off-by: Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Interesting. You claim authorship on that patch and then you put my SOB
after yours just because you feel entitled to do so?

I surely appreciate the time you spent to analyze the problem and I
wouldn't have said anything if you just would have done the right thing:

 1) Write a changelog which explains why the change is actually correct

 2) Not wreckage the formatting which I intentionally did for readability
    sake

 3) Add 'Originally-by: Thomas Gleixner' or at least having the courtesy to
    mention that this is not your work.

Thanks,

	tglx


