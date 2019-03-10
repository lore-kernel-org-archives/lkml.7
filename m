Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34EC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B0206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257027;
	bh=qxrh07vZiwZZgmjJ3rbF/wS7kcRQnPEltsDVX5IHCKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fVbM+376a+b3pnBJKey+1AhdSAs3l+f+UG4Im0NWt5EkbeoKkZECCyqv7LTVMpo63
	 T+if13VBKi/CRLz/pQ5VN1he2/nkl8Z/jfxaa4ughDg8ObMpXHjWSRt51L6zm8N3yz
	 Ms1bWTqPJOysrBR6tuH/MCzGymV+WJ8tPes5rSZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfCJWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfCJWaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:24 -0400
Subject: Re: [GIT pull] perf updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257023;
        bh=qxrh07vZiwZZgmjJ3rbF/wS7kcRQnPEltsDVX5IHCKg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eXHPCoMXPbhcrZYoEm47XXNSaDvj4bRJYVGnUtg88+wxfuNdvwNbjaPtJCMkGf/RD
         CHu7BO/IkbOSyIstB3kT6k2Jr4jVyl8hC3vDUzop+HxybMaDobQMbdBJ2yS21tDski
         aqoCHUq96DPN/4WHP+b8qNHacrSKOPAcBz+JZ8Ew=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155221755097.13878.7644048900738327284.tglx@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.7644048900738327284.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155221755097.13878.7644048900738327284.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: b339da480315505aa28a723a983217ebcff95c86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12ad143e1b803e541e48b8ba40f550250259ecdd
Message-Id: <155225702365.14748.5361270866742864679.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 12:33:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12ad143e1b803e541e48b8ba40f550250259ecdd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
