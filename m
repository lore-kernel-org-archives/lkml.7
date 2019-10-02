Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC80FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7A221848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570050019;
	bh=lnqWT3HXwWR4KU58WzmU1vAViNtSyLf2IW1JrqTUg3Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=alIJMj3ZzG0n3vHuy/bTeJOFzzRgXO6CpCTeDx6lepEfqDBCgge4FZ08T4l8WFjnU
	 +FUs7qJ3zmoDVIx+1Bvjh+e40di6dLNExFuCMrEg5eQDnA4wcSBDCOQCuiDwiqCr/h
	 UYn7EEO+AEFxyjWHR5DStn5yXE9Rn+PLBkEfjXeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfJBVAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfJBVAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:00:18 -0400
Subject: Re: [GIT PULL] erofs fixes for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570050018;
        bh=lnqWT3HXwWR4KU58WzmU1vAViNtSyLf2IW1JrqTUg3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qMF4rCuy4Vt+ANcph1DvWjwPFyR+2qf2iJ2WhHDXugSI97tEFBH8vuWDB19zYagVD
         fY+jnmHFFVhL3h+bo1jqCXESvQKzjSvgcvp04lZ+VDoLx/KAbDl01R+yItd35tGNDw
         Jw7WFSIC6+U2HtAcbTMBUWoBC4XK+khtysV7/yMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191001090938.GA30542@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
 tags/erofs-for-5.4-rc2-fixes
X-PR-Tracked-Commit-Id: dc76ea8c1087b5c44235566ed4be2202d21a8504
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65aa35c93cc014c72bae944675ea6e88c47a5497
Message-Id: <157005001798.25857.18035498047418829076.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Oct 2019 21:00:17 +0000
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Oct 2019 17:09:43 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.4-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65aa35c93cc014c72bae944675ea6e88c47a5497

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
