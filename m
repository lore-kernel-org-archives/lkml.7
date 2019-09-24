Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EAC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0337A21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 14:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437189AbfIXOYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 10:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:37886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389030AbfIXOYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:24:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32F38AE2D;
        Tue, 24 Sep 2019 14:24:39 +0000 (UTC)
Date:   Tue, 24 Sep 2019 16:24:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LinusTorvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        PraritBhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: printk meeting at LPC
Message-ID: <20190924142438.fjicbolo2xmgn4t7@pathway.suse.cz>
References: <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
 <20190918051933.GA220683@jagdpanzerIV>
 <87h85anj85.fsf@linutronix.de>
 <20190918081012.GB37041@jagdpanzerIV>
 <20190918081012.GB37041@jagdpanzerIV>
 <877e66nfdz.fsf@linutronix.de>
 <20190918164155.ymyuro6u442fa22j@pathway.suse.cz>
 <20190918124801.04fe999d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918124801.04fe999d@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-09-18 12:48:01, Steven Rostedt wrote:
> On Wed, 18 Sep 2019 18:41:55 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > Regarding SysRq. I could imagine introducing another SysRq that
> > would just call panic(). I mean that it would try to flush the
> > logs and reboot in the most safe way.
> 
> You mean sysrq-c ?

Sysrq-c is confusing because the NULL pointer dereference is reported.
I meant a completely new sysrq that would just call panic() without
an artificial noise.

Hmm, sysrq is already using most of the keys. sysrq-c might be good enough
after all.

Best Regards,
Petr
