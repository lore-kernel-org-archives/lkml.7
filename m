Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCSRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:02:34 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33645 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCSRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:02:34 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6I8D-0002Ir-Gn; Tue, 19 Mar 2019 18:02:29 +0100
Date:   Tue, 19 Mar 2019 18:02:29 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v2] rcu: Allow to eliminate softirq processing from
 rcutree
Message-ID: <20190319170229.zzecy2cqrbl5kuc3@linutronix.de>
References: <20190315111130.4902-1-bigeasy@linutronix.de>
 <20190318022434.GE4102@linux.ibm.com>
 <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
 <20190319155923.GY4102@linux.ibm.com>
 <20190319162431.4w2dqtssqkx6t4pq@linutronix.de>
 <20190319165007.GB4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319165007.GB4102@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-19 09:50:07 [-0700], Paul E. McKenney wrote:
> Besides, it looks very weird for me to have two Signed-off-by lines.  ;-)

See commit 602cae04c4864 ("perf/x86/intel: Delay memory deallocation
until x86_pmu_dead_cpu()")

> In theory, the trace_rcu_utilization() should be added, just like at
> the beginning and end of the function rcu_core(), but as far as I know,
> no one uses that, so I actually have it on my list to remove.

oki. Then nothing should be done :)

> 							Thanx, Paul

Sebastian
