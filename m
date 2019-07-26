Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A56C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7E722BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbfGZUBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:01:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50325 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387532AbfGZUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:01:47 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr6PQ-0001rH-4D; Fri, 26 Jul 2019 22:01:44 +0200
Date:   Fri, 26 Jul 2019 22:01:43 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 01/12] hrtimer: Remove task argument from
 hrtimer_init_sleeper()
In-Reply-To: <20190726155747.72dbe27d@gandalf.local.home>
Message-ID: <alpine.DEB.2.21.1907262200450.1791@nanos.tec.linutronix.de>
References: <20190726183048.982726647@linutronix.de>        <20190726185752.791885290@linutronix.de> <20190726155747.72dbe27d@gandalf.local.home>
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

On Fri, 26 Jul 2019, Steven Rostedt wrote:

> On Fri, 26 Jul 2019 20:30:49 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > --- a/kernel/time/hrtimer.c
> > +++ b/kernel/time/hrtimer.c
> > @@ -1639,10 +1639,10 @@ static enum hrtimer_restart hrtimer_wake
> >  	return HRTIMER_NORESTART;
> >  }
> >  
> 
> Not related to the change of this patch, but I'm surprised that a
> global function like this doesn't contain any kerneldoc information.

Indeed, but it gets it in the next patch

