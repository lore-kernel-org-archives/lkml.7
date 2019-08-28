Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CF6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336B92189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfH1LLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfH1LLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:11:43 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2vrZ-0001WD-AR; Wed, 28 Aug 2019 13:11:41 +0200
Date:   Wed, 28 Aug 2019 13:11:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+654f89dafed9092dac4d@syzkaller.appspotmail.com>
cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in posix_cpu_timer_del
In-Reply-To: <000000000000a64c4a05911db6fe@google.com>
Message-ID: <alpine.DEB.2.21.1908281309400.1869@nanos.tec.linutronix.de>
References: <000000000000a64c4a05911db6fe@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, syzbot wrote:
> HEAD commit:    ed858b88 Add linux-next specific files for 20190826
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=130c2eca600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
> dashboard link: https://syzkaller.appspot.com/bug?extid=654f89dafed9092dac4d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133cbeb6600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e931ca600000
> 
> Bisection is inconclusive: the first bad commit could be any of:

It's this one:

> ce709abd posix-cpu-timers: Utilize timerqueue for storage

The issue got already spotted by review. The fix is folded back and the
cleaned up result will be in next as of tomorrow.

Thanks,

	tglx
