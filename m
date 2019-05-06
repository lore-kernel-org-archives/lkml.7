Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4909C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710C02087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186060;
	bh=qAMTid5RwZAgF6WlFv4/tBCUpJaXbxE9kU1gXZeqnM8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0VTmqs8YDpfQkSndQAD2okEe0qF4GzfCsC23+sdVV862N6wHIYwXZxp4FdCvOltyk
	 H6Tw2YcNM6dt6mXuH7tCnjbv3ONyrmTc0UHOQw55bPZUIW6H/hg5tweioH2l/9zeql
	 WVOJfCYuwtq5u0nhunTHBIEcIvWG9iFcOWGed85Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfEFXk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfEFXkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:11 -0400
Subject: Re: [GIT PULL] x86/cleanups for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186011;
        bh=qAMTid5RwZAgF6WlFv4/tBCUpJaXbxE9kU1gXZeqnM8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D6lDhDFdMvHmLdp5Mp3vZdJOK4ibj2BInoGasQi1X2sYJ1yN6USkmXFRxuecd0JMx
         /WE+Cd9P59mFVLlDktsLqIByD12xnU3k2zl9NKcDBQsg3rQM5Z4dgUJN93Hm0Jhewh
         SvcaKwbiS0gI1qPG8jdzCOS+BLGWbxzrh4c35uVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506101351.GA122275@gmail.com>
References: <20190506101351.GA122275@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506101351.GA122275@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-cleanups-for-linus
X-PR-Tracked-Commit-Id: 15854edd193ae5d9daf8f50ce5f9f1724cebe344
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46e80e6c3d456aed2f4c261425ff737bf82ce7bf
Message-Id: <155718601107.9113.8061520935273868141.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:13:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46e80e6c3d456aed2f4c261425ff737bf82ce7bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
