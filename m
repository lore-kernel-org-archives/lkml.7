Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5958C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3A620879
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551994816;
	bh=+0W1NKR4TamGtIAMvXEiPmBsj+CPBLNLdNmHR3ORXlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Q0ao6h1GaIMb+yfJdK0DJARcFylHG/R3TPxffc/ac1O5Trq/vpq8F+ZxdIYpF2/uu
	 L/vc9tKcOPKQE3SAHJoP28mr8TX57mYb5tJYkQYB9FEOTUxkrkiRLxSMpkvsgynD43
	 LyXM/lv6w8Tncyt6EZgcaH/LX9JZme4IYCjRAhqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfCGVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCGVkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:40:15 -0500
Subject: Re: [GIT PULL] RISC-V Patches for the 5.1 Merge Window, Part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551994814;
        bh=+0W1NKR4TamGtIAMvXEiPmBsj+CPBLNLdNmHR3ORXlQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mRFvUPF2NJ/589c21YVId8mhP8pYosd0OJy/81bEt43IRtGraRzWrfDCft4lbXLVO
         mAqzyl+M28+yhUTfFa1GlAoo+Sht0lJ9s3ybu4iF8UbIV4zi288GemEg/kqtQLUJR1
         6f7mIV/IKiALMA0kAOemDbO4hKRcRdDrIZL/yvj0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-abd0b24c-3a6c-47bf-9b0c-e069cef41489@palmer-si-x1c4>
References: <mhng-abd0b24c-3a6c-47bf-9b0c-e069cef41489@palmer-si-x1c4>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-abd0b24c-3a6c-47bf-9b0c-e069cef41489@palmer-si-x1c4>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
 tags/riscv-for-linus-5.1-mw0
X-PR-Tracked-Commit-Id: 13fd5de06514458eb320188b7a815d65696efd99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d72cb8c7d9dbd9ce820c80f3fddb56b296ba96fc
Message-Id: <155199481451.1630.17073118464271664401.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 21:40:14 +0000
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 05 Mar 2019 13:42:15 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.1-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d72cb8c7d9dbd9ce820c80f3fddb56b296ba96fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
