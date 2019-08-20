Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB40C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122362054F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfHTNJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:09:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51945 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:09:55 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i03tZ-0005ue-QH; Tue, 20 Aug 2019 15:09:53 +0200
Date:   Tue, 20 Aug 2019 15:09:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 00/44] posix-cpu-timers: Cleanup and consolidation
In-Reply-To: <20190820021837.GA9594@infradead.org>
Message-ID: <alpine.DEB.2.21.1908201509020.2223@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190820021837.GA9594@infradead.org>
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

On Mon, 19 Aug 2019, Christoph Hellwig wrote:

> On Mon, Aug 19, 2019 at 04:31:41PM +0200, Thomas Gleixner wrote:
> > The series applies on top of:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> > 
> > and is available from git as well:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.timers/core
> 
> It seems like this basically reverts the last patch in timers/core
> again.  Do you really want to keep that or start with a better baseline?

If the callback variant is agreed on, I'm going to zap that patch which it
replaces.


