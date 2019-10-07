Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2290CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F274420867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfJGMBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 08:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:38300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbfJGMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:01:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C31CAACAA;
        Mon,  7 Oct 2019 12:01:35 +0000 (UTC)
Date:   Mon, 7 Oct 2019 14:01:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        David Lehman <dlehman@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Re: printk meeting at LPC
Message-ID: <20191007120134.ciywr3wale4gxa6v@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <30f29fe6-8445-0016-8cdc-3ef99d43fbf5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30f29fe6-8445-0016-8cdc-3ef99d43fbf5@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-10-04 09:48:24, Tony Asleson wrote:
> On 9/13/19 8:26 AM, John Ogness wrote:
> > 9. Support for printk dictionaries will be discontinued. I will look
> > into who is using this and why. If printk dictionaries are important for
> > you, speak up now!
> 
> I think this functionality is important.
> 
> I've been experimenting with a change which adds dictionary data to
> storage related printk messages so that a persistent durable id is
> associated with them for filtering, eg.
> 
> $ journalctl -r _KERNEL_DURABLE_NAME=naa.0000000000bc614e
> 
> This has the advantage that when the device attachment changes across
> reboots or detach/reattach cycles you can easily find its messages
> throughout it's recorded history.

Thanks for the pointers. I think that we will need to keep the
dictionaries then.

Just for explanation. We were not aware of this functionality when
it was discussed. The expectation was that this feature has never
been used in userspace. We were too optimistic ;-)

Best Regards,
Petr
