Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931DC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5606B2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgAHJyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:54:01 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:47274 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgAHJyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:54:00 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ip82H-0002PL-AJ; Wed, 08 Jan 2020 10:53:57 +0100
Date:   Wed, 8 Jan 2020 10:53:57 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+83fef78f45f4342655d8@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        gregkh@linuxfoundation.org, jeremy@azazel.net,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: general protection fault in hash_netport4_uadt
Message-ID: <20200108095357.GA795@breakpoint.cc>
References: <000000000000d06ea3059b9d5097@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d06ea3059b9d5097@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+83fef78f45f4342655d8@syzkaller.appspotmail.com> wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ae608821 Merge tag 'trace-v5.5-rc5' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cd963ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
> dashboard link: https://syzkaller.appspot.com/bug?extid=83fef78f45f4342655d8
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac4076e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f582aee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+83fef78f45f4342655d8@syzkaller.appspotmail.com

#syz dup: general protection fault in hash_ipportnet4_uadt
