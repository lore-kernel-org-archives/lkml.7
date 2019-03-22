Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3C2213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfCVR70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:59:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41599 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfCVR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:59:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h7ORw-0007W4-7I; Fri, 22 Mar 2019 18:59:24 +0100
Date:   Fri, 22 Mar 2019 18:59:24 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] workqueue: Use normal rcu
Message-ID: <20190322175923.5o6y53yiseo3phif@linutronix.de>
References: <20190313165548.19713-1-bigeasy@linutronix.de>
 <20190313165548.19713-2-bigeasy@linutronix.de>
 <20190321205935.7ndo5k5zumc77h37@linutronix.de>
 <20190322174334.GC69236@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190322174334.GC69236@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-22 10:43:34 [-0700], Tejun Heo wrote:
> Hello,
Hi,

> We can switch but it doesn't really say why we'd want to.  Can you
> please explain why this is better?

there is this undocumented part. Avoiding the sched RCU means also we
are more preemptible which is good :) Especially on -RT where we can't
disable preemption across the whole critical section.

Is this good enough?

> Thanks.

Sebastian
