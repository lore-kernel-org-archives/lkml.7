Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0F6C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CE220830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568283317;
	bh=hN6bU7QDxK+290PSR7C2ecFhoCXe6ZL7euHhk7yUXxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OX/ZTS8hjIEj3TdOLyIgY1SvJjvPPgv4K3SaA6YLhlqbiXE8YpSu5d+Hgc9W5iBcq
	 qjigAQTi3X3jMqGEWQoZ+aDwx8/QrVkn31mKuG+MfQXXsC9zaL7DvVn1BYsCujYEe5
	 NkBuopREWz+A/HzCTrd6LaIYBSI7gJr+ayQU6Kyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfILKPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbfILKPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:15:07 -0400
Subject: Re: [GIT PULL] IRQ fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568283306;
        bh=hN6bU7QDxK+290PSR7C2ecFhoCXe6ZL7euHhk7yUXxs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1KjYc/ieRXGgvY8l5rDospIR7GSmwjKwoOKoTnbcBV30PCOi3IKbWYLr6Ha1mnedc
         bPpJUVO40Ts+ACsprBKZTZtrSUp3A8bLnT0siZeMKEjlqavnlbtXMNLKIjDuwmLOyK
         CcncJpXy7czLiadKJXEL1RPI2h/Qx/19pRTBQePI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190912083503.GA124477@gmail.com>
References: <20190912083503.GA124477@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190912083503.GA124477@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: eddf3e9c7c7e4d0707c68d1bb22cc6ec8aef7d4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95779fe8506d4f750f1e66e958b6b3c405182d7a
Message-Id: <156828330691.21107.15394111119879330524.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Sep 2019 10:15:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 10:35:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95779fe8506d4f750f1e66e958b6b3c405182d7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
