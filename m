Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A58AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549CF206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 10:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZKzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 06:55:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43154 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfDZKzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 06:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A40C9ACA8;
        Fri, 26 Apr 2019 10:55:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FCC71E3619; Fri, 26 Apr 2019 12:55:11 +0200 (CEST)
Date:   Fri, 26 Apr 2019 12:55:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in fanotify_handle_event
Message-ID: <20190426105511.GA18333@quack2.suse.cz>
References: <00000000000091becf0586d104c6@google.com>
 <000000000000d97b380586d1205f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d97b380586d1205f@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-04-19 10:14:00, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Jan 10 17:04:37 2019 +0000
> 
>     fanotify: cache fsid in fsnotify_mark_connector
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
> start commit:   3f018f4a Add linux-next specific files for 20190418
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
> dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000
> 
> Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
> Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Let syzbot test the fix:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
