Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37076C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124A2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfIQOId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:08:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63688 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfIQOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:08:32 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x8HE8U4p034336;
        Tue, 17 Sep 2019 23:08:30 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Tue, 17 Sep 2019 23:08:30 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x8HE8L0G034277
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 17 Sep 2019 23:08:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: printk meeting at LPC
To:     Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        AndreaParri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LinusTorvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        PraritBhargava <prarit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <cfc7b1fa-e629-19a6-154b-0dd4f5604aa7@I-love.SAKURA.ne.jp>
 <20190916104624.n3jh363z37ah2kxa@pathway.suse.cz>
 <20190916094314.6053f988@gandalf.local.home>
 <20190917075216.agzoy6cnol5eio6y@pathway.suse.cz>
 <20190917090254.46131564@gandalf.local.home>
 <20190917131204.GA745680@kroah.com>
 <20190917093720.51977128@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a37453ba-b749-7e08-0ea1-d3c9799bb2b9@i-love.sakura.ne.jp>
Date:   Tue, 17 Sep 2019 23:08:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190917093720.51977128@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/09/17 22:37, Steven Rostedt wrote:
> On Tue, 17 Sep 2019 15:12:04 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>>> Well, it's being used. I was thinking of dropping it if it was not.
>>> Let's keep it then.  
>>
>> I think it should be dropped, only one user of the kernel is using it in
>> a legitimate way, which kind of implies it isn't needed.
> 
> I'm thinking if it isn't hard to support then we can keep it (meaning
> that we already have to calculate the length anyway). But if it starts
> to complicate the code, then we should drop it.
> 

Due to console_loglevel (some are printed and others are not printed) and
possibility of concurrent printk() callers (one line can be printed as
multiple lines), using printk()'s return value for calculating column offset
will not always work as expected. I guess that users should not count on
printk()'s return value. They might want to try printing one line at a time
using their local buffers...
