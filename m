Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A7C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7E5206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHPMld convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:41:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42168 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfHPMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:41:32 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hybXa-00010v-Ni; Fri, 16 Aug 2019 14:41:10 +0200
Date:   Fri, 16 Aug 2019 14:41:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     syzbot <syzbot+774fddf07b7ab29a1e55@syzkaller.appspotmail.com>
Cc:     antoine.tenart@bootlin.com, ard.biesheuvel@linaro.org,
        baruch@tkos.co.il, davem@davemloft.net, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        maxime.chevallier@bootlin.com, mingo@kernel.org,
        netdev@vger.kernel.org, paulmck@linux.ibm.com,
        paulmck@linux.vnet.ibm.com, rmk+kernel@armlinux.org.uk,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Subject: Re: WARNING in tracepoint_probe_register_prio (3)
Message-ID: <20190816124110.pohillduyajfuo2p@linutronix.de>
References: <000000000000ab6f84056c786b93@google.com>
 <000000000000479a1705903b2dc9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <000000000000479a1705903b2dc9@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-16 05:32:00 [-0700], syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit ecb9f80db23a7ab09b46b298b404e41dd7aff6e6
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Aug 13 08:00:25 2019 +0000
> 
>     net/mvpp2: Replace tasklet with softirq hrtimer
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ffb9ee600000

that bisect is wrong. That warning triggered once and this commit was
the top most one in net-next at the time…

Sebastian
