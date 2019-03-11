Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A17C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7FB2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfCKNhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:37:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:51398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727824AbfCKNhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:37:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BB9CAEC6;
        Mon, 11 Mar 2019 13:37:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Mar 2019 14:37:51 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     akpm@linux-foundation.org
Cc:     dbueso@suse.de, dvyukov@google.com, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in ep_poll_callback
In-Reply-To: <0000000000008f34570583d15823@google.com>
References: <0000000000008f34570583d15823@google.com>
Message-ID: <0ded99b8d69a74c260f3f44f5ae1ab59@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
removed from your tree, at least I got a notification on 9th of january,
also I do not see it in the linux-next tree.

Should I ignore this syzbot message?

--
Roman

On 2019-03-11 14:14, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit f92cacf118171208f62519d92502a8dd0341286d
> Author: Roman Penyaev <rpenyaev@suse.de>
> Date:   Tue Jan 8 01:15:44 2019 +0000
> 
>     epoll: loosen irq safety in ep_poll_callback()
> 
> bisection log:  
> https://syzkaller.appspot.com/x/bisect.txt?x=107ae15f200000
> start commit:   f92cacf1 epoll: loosen irq safety in ep_poll_callback()
> git tree:       linux-next
> final crash:    
> https://syzkaller.appspot.com/x/report.txt?x=127ae15f200000
> console output: 
> https://syzkaller.appspot.com/x/log.txt?x=147ae15f200000
> kernel config:  
> https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
> userspace arch: amd64
> syz repro:      
> https://syzkaller.appspot.com/x/repro.syz?x=1776034b400000
> C reproducer:   
> https://syzkaller.appspot.com/x/repro.c?x=14c2e580c00000
> 
> Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com
> Fixes: f92cacf1 ("epoll: loosen irq safety in ep_poll_callback()")



