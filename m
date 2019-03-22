Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CD321917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553282127;
	bh=iy1Zwb9bZbfJQSj6Y+cfaEW1ZAbq8SfATwqP5SVnBr4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HLjU+ieiV4Z+XnqW2JGsR2uIlU+z6BguUfr5NtxuhWZsO1pUzBekB6ahZBipxPPv2
	 82/9EC0radxAFVMSvf/An1mXAV4UtPRAzdVnv7eh5IN77Oakb3KDlUPda2AyJUNDEJ
	 5RGDY55G7coCfFFjJQdY11XEMxTrMcl6gZjivMfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCVTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 15:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfCVTPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 15:15:12 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553282111;
        bh=iy1Zwb9bZbfJQSj6Y+cfaEW1ZAbq8SfATwqP5SVnBr4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Wg/7mWai01QEB6NLthLc/Mz1DdemPl5BitQV2YZS0kEJgfVBdgBuAIM6Dwccq7wf1
         F6+/zORQJXVY68DOlxWU1O7Kor6e5Xyz//6Ip3wv+Sp+ocJkxXary1AGk8F4hy4yT8
         ji5IR26kyLiGnRvjOEn2ibqowGfdTJRauxW/zgsY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0g3_wWoN4Bp1+EKLuNxi3XDp2LrMq21cXCm8FFPoo6FOg@mail.gmail.com>
References: <CAJZ5v0g3_wWoN4Bp1+EKLuNxi3XDp2LrMq21cXCm8FFPoo6FOg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0g3_wWoN4Bp1+EKLuNxi3XDp2LrMq21cXCm8FFPoo6FOg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc2
X-PR-Tracked-Commit-Id: 54e3aca84e571559915998aa6cc05e5ac37c043b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c1ada4f052d6d5e5c0bf7901617479b2146139e
Message-Id: <155328211146.18163.13971639196758585789.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Mar 2019 19:15:11 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Mar 2019 11:26:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c1ada4f052d6d5e5c0bf7901617479b2146139e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
