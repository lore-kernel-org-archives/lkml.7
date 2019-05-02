Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5952085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBHQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:16:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53140 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfEBHQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:16:12 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hM5wq-0001GQ-LI; Thu, 02 May 2019 09:16:04 +0200
Date:   Thu, 2 May 2019 09:16:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     "kernelci.org bot" <bot@kernelci.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        broonie@kernel.org, matthew.hart@linaro.org,
        enric.balletbo@collabora.com, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: next/master boot bisection: next-20190430 on beagle-xm
Message-ID: <20190502071604.sakn4yavh4crztdf@linutronix.de>
References: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
 <7hy33pn8w3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7hy33pn8w3.fsf@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-01 14:48:44 [-0700], Kevin Hilman wrote:
> "kernelci.org bot" <bot@kernelci.org> writes:
> 
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > next/master boot bisection: next-20190430 on beagle-xm
> >
> > Summary:
> >   Start:      f43b05fd4c17 Add linux-next specific files for 20190430
> >   Details:    https://kernelci.org/boot/id/5cc84d7359b514b7ab55847b
> >   Plain log:  https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.txt
> >   HTML log:   https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.html
> >   Result:     6d25be5782e4 sched/core, workqueues: Distangle worker accounting from rq lock
> 
> I was able to reproduce this in next-20190430, but...
> 
> I'm not sure what fixed it, but this is passing again in today's
> linux-next (next-20190501)

Okay, thanks for the confirmation.

> Kevin

Sebastian
