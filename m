Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC124C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F53206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 01:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfHVBCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:02:54 -0400
Received: from verein.lst.de ([213.95.11.211]:42405 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729135AbfHVBCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:02:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9778868BFE; Thu, 22 Aug 2019 03:02:50 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:02:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch V2 00/38] posix-cpu-timers: Cleanup and consolidation
Message-ID: <20190822010250.GC11104@lst.de>
References: <20190821190847.665673890@linutronix.de> <20190822005434.GA10938@lst.de> <20190822010203.GG22020@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822010203.GG22020@lenoir>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 03:02:04AM +0200, Frederic Weisbecker wrote:
> > which repeats every time I fetch.  I can't of anythign particular on
> > my side that would cause this.
> 
> Yeah I had to run "git remote prune tip" and fetch again.
> 
> Apparently there was an old remote branch tip/WIP.timers and git
> seem to refuse to have a new subpath branch.

Thanks, that seems to have fixed the issue for me.
