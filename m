Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF86C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFCD2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfDPIDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:03:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47912 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfDPIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:03:24 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hGJ3p-00012Y-P3; Tue, 16 Apr 2019 10:03:21 +0200
Date:   Tue, 16 Apr 2019 10:03:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Alleged fix for writer stall on -rcu branch dev
Message-ID: <20190416080321.6avfc4zne6kwzynm@linutronix.de>
References: <20190410181538.3ocva5lmh7ghrisr@linutronix.de>
 <20190410184105.GR14111@linux.ibm.com>
 <20190410191918.g2yqnsmuqukmzdfe@linutronix.de>
 <20190410203302.GT14111@linux.ibm.com>
 <20190411000610.GA3867@linux.ibm.com>
 <20190413142153.GA17704@linux.ibm.com>
 <20190415104047.mrtmv6w6kq5m44fp@linutronix.de>
 <20190415105645.GQ14111@linux.ibm.com>
 <20190415110403.4yivka4cofckgxwb@linutronix.de>
 <20190415222652.GB14111@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415222652.GB14111@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-15 15:26:52 [-0700], Paul E. McKenney wrote:
> I feel a bit guilty monopolizing your system...

Don't be. In the end I want my stuff merged without causing any
regressions.

> I have accumulated a collection of forward-progress ideas, so one approach
> would be for me to get those written, then running well on my systems, and
> then ask for some testing on your systems.  Would that be a reasonable
> approach?

Sure.

> Might make anyone else wanting to use that system in the near term more
> happy as well.  ;-)

:)

> 							Thanx, Paul

Sebastian
