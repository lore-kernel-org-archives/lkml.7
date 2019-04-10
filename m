Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC6E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfDJMMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:12:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36112 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfDJMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:12:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hEC59-0000DF-Su; Wed, 10 Apr 2019 12:11:59 +0000
Date:   Wed, 10 Apr 2019 13:11:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at fs/inode.c:LINE!
Message-ID: <20190410121159.GY2217@ZenIV.linux.org.uk>
References: <00000000000051e9c2057d31a563@google.com>
 <00000000000036a4a9058619dff3@google.com>
 <20190410002603.GS2217@ZenIV.linux.org.uk>
 <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
 <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
 <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
 <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
 <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:

> > I'm unable to find a branch matching the line numbers.
> > 
> > Given that, on the face of it, the scenario is impossible I'm
> > seeking clarification on what linux-next to look at for the
> > sake of accuracy.
> > 
> > So I'm wondering if this testing done using the master branch
> > or one of the daily branches one would use to check for conflicts
> > before posting?
> 
> Sorry those are tags not branches.

FWIW, that's next-20181214; it is what master had been in mid-December
and master is rebased every day.  Can it be reproduced with the current
tree?
