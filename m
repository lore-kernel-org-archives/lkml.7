Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE272075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDLTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:19:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48534 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:19:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hF1i7-0001Nc-FX; Fri, 12 Apr 2019 19:19:39 +0000
Date:   Fri, 12 Apr 2019 20:19:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ian Kent <raven@themaw.net>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20190412191939.GK2217@ZenIV.linux.org.uk>
References: <20190410002603.GS2217@ZenIV.linux.org.uk>
 <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
 <20190410121159.GY2217@ZenIV.linux.org.uk>
 <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
 <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
 <CACT4Y+YKGX0MVEM-SrDKJc0500vCH+WOZpyzNr-O_tW7p5Sn_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YKGX0MVEM-SrDKJc0500vCH+WOZpyzNr-O_tW7p5Sn_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:59:30PM +0200, Dmitry Vyukov wrote:

> Please don't ignore the bug status tracking part. Or we will only have
> options of not testing kernel or dropping most of the bug reports on
> the floor. Both are equally harmful for kernel quality.
> 
> Let's mark it as fixed by the next commit in series (which already
> made it into mainline):
> 
> #syz fix: autofs: simplify parse_options() function call
> 
> But I won't be around always.

You might want to add something like "commit discarded"...
