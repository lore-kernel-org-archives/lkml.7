Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04238C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AB7205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEAPh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:37:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51224 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfEAPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:37:25 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hLrIF-0001Nb-SC; Wed, 01 May 2019 17:37:12 +0200
Date:   Wed, 1 May 2019 17:37:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        mgalka@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: next/master boot bisection: next-20190430 on beagle-xm
Message-ID: <20190501153711.pxmapo2k3n5ynqrc@linutronix.de>
References: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cc8b55c.1c69fb81.c3759.1c27@mx.google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-04-30 13:51:40 [-0700], kernelci.org bot wrote:
> next/master boot bisection: next-20190430 on beagle-xm
> 
> Summary:
>   Start:      f43b05fd4c17 Add linux-next specific files for 20190430
>   Details:    https://kernelci.org/boot/id/5cc84d7359b514b7ab55847b
>   Plain log:  https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.txt
>   HTML log:   https://storage.kernelci.org//next/master/next-20190430/arm/multi_v7_defconfig+CONFIG_SMP=n/gcc-7/lab-baylibre/boot-omap3-beagle-xm.html
>   Result:     6d25be5782e4 sched/core, workqueues: Distangle worker accounting from rq lock
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     beagle-xm
>   CPU arch:   arm
>   Lab:        lab-baylibre
>   Compiler:   gcc-7
>   Config:     multi_v7_defconfig+CONFIG_SMP=n
>   Test suite: boot
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 6d25be5782e482eb93e3de0c94d0a517879377d0
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Mar 13 17:55:48 2019 +0100
> 
>     sched/core, workqueues: Distangle worker accounting from rq lock

According to the bootlog it just stopped its output. This commit is in
next since a week or two so I don't understand why this pops up now.

I just revived my BBB and I can boot that commit in question. Currently
that as close as I get to a beagle-xm. 
Looking at
	https://kernelci.org/boot/id/5cc9a64359b514a77f5584af/
it seems that the very same board managed to boot linux-next for
next-20190501.

Side note: I can't boot next-20190501 on my BBB, bisect points to commit
  1a5cd7c23cc52 ("bus: ti-sysc: Enable all clocks directly during init to read revision")

any idea?

Sebastian
