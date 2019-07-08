Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B00C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6BA217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562614214;
	bh=i6tbNBsBoWSwTh5JgOLuj/WvJ6Crb5Fy9vhDVyeE3bg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=so5gkwfAyfQz2/YWMyvy4hrjker5PXT1HfxPK/zVCqFBSAJ1it16N0HFJHyJ9W1Yp
	 wX2/pULJ1pyi4SJw9emm88lII4vKfzbbZWDNOnIKxg1TdmAYTAQV9mllYM0LN8PXf+
	 je1wWT1akqWABMhVCzldmPSUm0IGdB7wriyTiOcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbfGHTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404551AbfGHTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:30:10 -0400
Subject: Re: [GIT pull] irq/core for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562614209;
        bh=i6tbNBsBoWSwTh5JgOLuj/WvJ6Crb5Fy9vhDVyeE3bg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ve1RNeTm6+j0pH859K8o0TI2r56sNQVZMuWx/AuTGMfL1E7iz/+lOBswdTXxgVnrN
         ncTfsbGLMsg9ruBjytus7m4lYFsFLo98ruuGSIfzgY+5ZUqLW0UpA3xICBUSCAjDKI
         UArwHYjmEegxZYV5pbnicHf8Ly2fdLC6XqchNMJE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156257673794.14831.13178949602156587608.tglx@nanos.tec.linutronix.de>
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673794.14831.13178949602156587608.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156257673794.14831.13178949602156587608.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus
X-PR-Tracked-Commit-Id: 3a1d24ca9573fbc74a3d32c972c333b161e0e9dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a1ccd31420a7b1acd6ca37b2bec2d723aa093e4
Message-Id: <156261420961.31351.13546213535978297697.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jul 2019 19:30:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 08 Jul 2019 09:05:37 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a1ccd31420a7b1acd6ca37b2bec2d723aa093e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
