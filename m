Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A3C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B745205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575922833;
	bh=oPYMTRA1htOX1kFGQUomEL6W11AY5GspiE/x8Y4ldk8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vVf5J6bbZzkwoETuFE+z0t80Mek7r70zqX19xLVaW/Yk3iVdTR6j1Tibct6WHNTnW
	 logkghboFFzHfNPIkSxu/KaIm4o6CVHCXoMOIwfO3oSda++JO37VuGhquYibNkOCZy
	 txtTfxqPCKnz4kCnBiNV6XJEsHTokfT6fYldJvBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLIUU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfLIUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:20:26 -0500
Subject: Re: [GIT PULL] Final pr_warning() removal
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575922826;
        bh=oPYMTRA1htOX1kFGQUomEL6W11AY5GspiE/x8Y4ldk8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2nzzSA8ovezAWqqdJW10VbPEjyLJPkvXUmqcdiluzofsKDA8h478QTdoiSEqhUqJr
         GZWYGYqMfQVH7u1wg3Rc/6h/af5vup4ceryOAVTDvHoP83vkEcfUapYJY5kOYHxa1M
         908uhf3ugjcvogM+BTPGGqjtdHZfPjaogWiMXPM0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191209121900.s2foip7ovavr3d5c@pathway.suse.cz>
References: <20191209121900.s2foip7ovavr3d5c@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191209121900.s2foip7ovavr3d5c@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.5-pr-warning-removal
X-PR-Tracked-Commit-Id: 969bea5e4d8b96d903637b100640acb92158c4e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 184b8f7f91ca7938c09533df83ce84817e682975
Message-Id: <157592282647.794.16377918678011355276.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Dec 2019 20:20:26 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Dec 2019 13:19:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.5-pr-warning-removal

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/184b8f7f91ca7938c09533df83ce84817e682975

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
