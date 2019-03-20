Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3356218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTSOj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:14:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36214 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfCTSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:14:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h6fjX-0006SW-Rf; Wed, 20 Mar 2019 19:14:35 +0100
Date:   Wed, 20 Mar 2019 19:14:35 +0100
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
Message-ID: <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
References: <20190319114419.qlsw3i5bmndoyvao@linutronix.de>
 <20190320113219.d6c3gouqbnsnl5nj@linutronix.de>
 <20190320152146.GH4102@linux.ibm.com>
 <20190320154440.GA16332@linux.ibm.com>
 <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190320181210.GO4102@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-20 11:12:10 [-0700], Paul E. McKenney wrote:
> We could name it something like "use_softirq" and initialize it to true.
> I am OK either way.

I had to add one hunk to get it compiled. It worked then. Let me swap
the logic as you suggested and then I repost the whole thing. This will
taken an hour or two…

> 							Thanx, Paul

Sebastian
