Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A1C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E0218A6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614210;
	bh=R2XBA85tA3T6+y/zKgz/yuQnaBT2Cnhozmru+9lqhz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ocZD4KERcude/KyTDWxt0UFPXjQlD+oyJSd6PjsyLpTUoQ7WNJiuko35fTKZpZ1KC
	 3HlY7/RXtpAf4dqNnqqrqno82OUdjjlCVXMrb/NqP9etcV37P1FjVE8ryODUEZfFeB
	 rKFZm5LTo2mFHG7w3ec3Za3cifuumI0FjPvcrMJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbfGHTaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404551AbfGHTaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:07 -0400
Subject: Re: [GIT pull] core/debugobjects for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614206;
        bh=R2XBA85tA3T6+y/zKgz/yuQnaBT2Cnhozmru+9lqhz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sVcK4PcawzOmTIPOyMzTRqtJM6sB3YWt33CXZBeJeVnk4yQ+mjxCSNg9nWuxBkazE
         tFxlnf/BLZz1ZtEITq+CJ2oRupLeXdhx0rd/fRxQZpcGEc9R+xHbl9qBNZ1eIcUErM
         jDkpp75x1xn9OCBcmd/v/cGJYvSPPAq4fQ/6vCCo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-debugobjects-for-linus
X-PR-Tracked-Commit-Id: d5f34153e526903abe71869dbbc898bfc0f69373
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b37754790067c9b25cf75fbf72b69edd6d7fffd
Message-Id: <156261420679.31351.9412634215783758887.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b37754790067c9b25cf75fbf72b69edd6d7fffd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
