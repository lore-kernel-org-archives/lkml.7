Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA860C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2481217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614230;
	bh=6tb7g2ly9Cs4WJD28I1TUA90kUuVTe7fy/aHg8D3ETE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W/Qar+0A5dio/JqF6KDaBcNLQNSYay8uxMrRK+r5JN+q5vx86m9EXET47Wv/INhcX
	 YMG3fkwMMKTcNKwS3HUPNaqRmgssr5PDUDEIq+iz2Gr0me5wrNlHvWTpLwwVIUVIVV
	 J3fK0ocSsDAM67IdYtIdyK/i9wclWAwu7obK8It8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404652AbfGHTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404589AbfGHTaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:11 -0400
Subject: Re: [GIT pull] x86/pti for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614211;
        bh=6tb7g2ly9Cs4WJD28I1TUA90kUuVTe7fy/aHg8D3ETE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qB17kyF+0d6drb9cte0UwQXpCPFbBwHsCECk4Q2sgxdk9u6fgp6REjhsaipo5vSM5
         YVADey7ToYIOo7OvF8pwqqWfhPwbQgVYxq/3bE66J1dcRRyVJA61dzRThjLpjwYFj/
         XXVYXIQnhNZJ31QwtI7Kyc1i6B9zaR0Te3+o2wtE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus
X-PR-Tracked-Commit-Id: 993773d11d45c90cb1c6481c2638c3d9f092ea5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 223cea6a4f0552b86fb25e3b8bbd00469816cd7a
Message-Id: <156261421095.31351.1721467204330588762.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/223cea6a4f0552b86fb25e3b8bbd00469816cd7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
