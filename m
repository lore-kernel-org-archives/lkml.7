Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA4C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9190D204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfGALqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:46:08 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:36744 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbfGALqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:46:08 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hhuky-0004UT-J6; Mon, 01 Jul 2019 13:46:00 +0200
Date:   Mon, 1 Jul 2019 13:46:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+0165480d4ef07360eeda@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, fw@strlen.de, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in xfrm_hash_rebuild
Message-ID: <20190701114600.gvlpwdajyxobqujy@breakpoint.cc>
References: <000000000000d028b30588fed102@google.com>
 <000000000000f66c6e058c7cd4e0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f66c6e058c7cd4e0@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+0165480d4ef07360eeda@syzkaller.appspotmail.com> wrote:
> syzbot has bisected this bug to:
> 
> commit 1548bc4e0512700cf757192c106b3a20ab639223
> Author: Florian Westphal <fw@strlen.de>
> Date:   Fri Jan 4 13:17:02 2019 +0000
> 
>     xfrm: policy: delete inexact policies from inexact list on hash rebuild

I'm looking at this now.
