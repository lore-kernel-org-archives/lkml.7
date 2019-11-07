Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C45C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCCD214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbfKGQ2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:28:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48580 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:28:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iSkeI-0001HM-HV; Thu, 07 Nov 2019 17:28:42 +0100
Date:   Thu, 7 Nov 2019 17:28:42 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] percpu-refcount: Use normal instead of RCU-sched"
Message-ID: <20191107162842.2qgd3db2cjmmsxeh@linutronix.de>
References: <20191002112252.ro7wpdylqlrsbamc@linutronix.de>
 <20191107091319.6zf5tmdi54amtann@linutronix.de>
 <20191107161749.GA93945@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191107161749.GA93945@dennisz-mbp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-07 11:17:49 [-0500], Dennis Zhou wrote:
> Hello,

Hi,

> I just want to clarify a little bit. Is this patch aimed at fixing an
> issue with RT kernels specifically? 

Due to the implications of preempt_disable() on RT kernels it fixes
problems with RT kernels.

> It'd also be nice to have the
> numbers as well as if the kernel was RT or non-RT.

The benchmark was done on a CONFIG_PREEMPT kernel. As said in the commit
log, the numbers were mostly the same, I can re-run the test and post
numbers if you want them.
This patch makes no difference on PREEMPT_NONE or PREEMPT_VOLUNTARY
kernels.

> Thanks,
> Dennis

Sebastian
