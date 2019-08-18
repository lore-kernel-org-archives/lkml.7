Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52C9C3A59E
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B26D2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566147309;
	bh=rpZtayxYFM3ucEsRnhRHHUJjy/px8jz1mwQLbSXm/vQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RBRSqi80RZzGZNq98okhpw56d9Xf1Ii5Sq3bm0kZhO2gx2VOJcRvfRwTqln06MMsy
	 HLYZWfqViEL2ykpi/+uB/H6uQzjMLhbpMVEf4gZB1euiqMmXNh6/FGQPLXUrltmOjR
	 b6zQKMlRAY2OVZVmitNVi46leeJlPmxssUE7m0Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfHRQzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRQzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:08 -0400
Subject: Re: [GIT PULL] SPDX fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147307;
        bh=rpZtayxYFM3ucEsRnhRHHUJjy/px8jz1mwQLbSXm/vQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IGCKQPv1GQ6kJE62TXlFaY7N56FcuzHf6eFhtIZCjxyVdIrwzEK8KYo06INCk2KD3
         /S67FVJzmfSvL8wFa8N++DgB3GMNTI3l0aSUb9XC5xUTOMi89jtaM8zo2mmgUdq3+T
         xYMmlp5g1HIvnGOXbr/6NyKHcgMEMF+4vCWsUOhk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190818091022.GA30528@kroah.com>
References: <20190818091022.GA30528@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190818091022.GA30528@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git
 tags/spdx-5.3-rc5
X-PR-Tracked-Commit-Id: 0dda5907b0fc60f72f67f479f224e02c95d06e21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bba5c9c86b31895f5cb67f2db2b0f0cddc96dc6
Message-Id: <156614730729.21549.10349470515792730139.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 11:10:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bba5c9c86b31895f5cb67f2db2b0f0cddc96dc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
