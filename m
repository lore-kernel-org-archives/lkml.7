Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C06520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552012231;
	bh=kMAR0B16j0QE7bHh9o0RItmbtc6y07ye5sOEBlcfwAg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kw04+HM9qQcR6YtrvXdFMDVgwJDZMljBKiqwD244nJenKEUQ8Cyh7XrRyOiP6IXO9
	 RA2A7lUiX6mK4DhBU6CANk9DQ1ixv1q0eednhwyiWJJ3m3DIAvY2oNi9e47MrUsvyX
	 6jwRTJ4ekrqzm8RrmqaweiLvAP2Z2fmR+tuqx2I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCHCa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:30:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfCHCaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:30:21 -0500
Subject: Re: [GIT PULL] x86/uv changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552012221;
        bh=kMAR0B16j0QE7bHh9o0RItmbtc6y07ye5sOEBlcfwAg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g70QedQP2hTE8dMgVNfZiNG7bGaXp3aG1P1npq3+ZsbpXk7IPjjOxRxzMEHu/UTPm
         cj7mjyeSsMJ5BI8gjatFIejOM3iUqN+T0nca6trI2jNDzt/vLt7blXXs1dBt9R8Ub7
         adKHKXiS7wDYjvf2EXYI/zyhLt5nqsN4VTIY8AW4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307195559.GA112460@gmail.com>
References: <20190307195559.GA112460@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307195559.GA112460@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-uv-for-linus
X-PR-Tracked-Commit-Id: 8945d96f7b3ead56e053ac79b8f7b0de98a30bfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 610cd4eadec4f97acd25d3108b0e50d1362b3319
Message-Id: <155201222112.3231.3352536638410023358.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 02:30:21 +0000
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

The pull request you sent on Thu, 7 Mar 2019 20:55:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-uv-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/610cd4eadec4f97acd25d3108b0e50d1362b3319

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
