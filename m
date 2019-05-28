Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E216C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00B720645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfE1NuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:50:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727400AbfE1NuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:50:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 658C0B01F;
        Tue, 28 May 2019 13:49:59 +0000 (UTC)
Date:   Tue, 28 May 2019 15:49:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Togyrvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] printk/sysrq: Don't play with console_loglevel
Message-ID: <20190528134958.kpo5voy2jzmw57dw@pathway.suse.cz>
References: <20190528002412.1625-1-dima@arista.com>
 <4a9c1b20-777d-079a-33f5-ddf0a39ff788@i-love.sakura.ne.jp>
 <20190528042208.GD26865@jagdpanzerIV>
 <90a22327-922d-6415-538a-6a3fcbe9f3e1@i-love.sakura.ne.jp>
 <20190528084825.GA9676@jagdpanzerIV>
 <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966f1a8d-68ab-a808-9140-4ecf1453421d@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-05-28 19:15:43, Tetsuo Handa wrote:
> On 2019/05/28 17:51, Sergey Senozhatsky wrote:
> >> You are trying to omit passing KERN_UNSUPPRESSED by utilizing implicit printk
> >> context information. But doesn't such attempt resemble find_printk_buffer() ?
> > 
> > Adding KERN_UNSUPPRESSED to all printks down the op_p->handler()
> > line is hardly possible. At the same time I'd really prefer not
> > to have buffering for sysrq.
> 
> I don't think it is hardly possible. And I really prefer having
> deferred printing for SysRq.

This thread is about problems with manipulating console_loglevel.

"Deferred printk" is another very complicated and controversial
problem. Please, discuss it in a separate thread.

Thanks in advance.

Best Regards,
Petr Mladek
