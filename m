Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9ACC06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CFBE214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGAACB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 20:02:01 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:48319 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726759AbfGAACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:02:01 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 1 Jul 2019 09:01:59 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 1 Jul 2019 09:01:59 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Mon, 1 Jul 2019 09:01:14 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Message-ID: <20190701000114.GB23795@X58A-UD3R>
References: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
 <20190627134240.GB215968@google.com>
 <20190627205703.GF26519@linux.ibm.com>
 <20190628024339.GA13650@X58A-UD3R>
 <20190630193834.GU26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630193834.GU26519@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 12:38:34PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 28, 2019 at 11:43:39AM +0900, Byungchul Park wrote:
> > On Thu, Jun 27, 2019 at 01:57:03PM -0700, Paul E. McKenney wrote:
> > > On Thu, Jun 27, 2019 at 09:42:40AM -0400, Joel Fernandes wrote:
> > > > On Thu, Jun 27, 2019 at 04:07:46PM +0900, Byungchul Park wrote:
> > > > > Hello,
> > > > > 
> > > > > I tested if the WARN_ON_ONCE() is fired with my box and it was ok.
> > > > 
> > > > Looks pretty safe to me and nice clean up!
> > > > 
> > > > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Agreed, but I still cannot find where this applies.  I did try rcu/next,
> > > which is currently here:
> > > 
> > > commit b989ff070574ad8b8621d866de0a8e9a65d42c80 (rcu/rcu/next, rcu/next)
> > > Merge: 4289ee7d5a83 11ca7a9d541d
> > > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > > Date:   Mon Jun 24 09:12:39 2019 -0700
> > > 
> > >     Merge LKMM and RCU commits
> > > 
> > > Help?
> > 
> > commit 204d7a60670f3f6399a4d0826667ab7863b3e429
> > 
> >      Merge LKMM and RCU commits
> > 
> > I made it on top of the above. And could you tell me which branch I'd
> > better use when developing. I think it's been changing sometimes.
> 
> That would be because idiot here took so much care to avoid risking
> pushing some early development commits into the upcoming merge window
> that he managed to misplace them entirely.  The -rcu tree's "dev" branch
> now includes them.  Could you please port to it?

Of course, I can.

> a1af11a24cb0 ("rcu/nocb: Make __call_rcu_nocb_wake() safe for many callbacks")
> 
> > Thank you for the answer in advance!
> 
> And please accept my apologies for the very confusing tree layout this
> time around!

It would be totally OK if you give me the answer when I feel confused
with branch for development. :)

> 
> 							Thanx, Paul
