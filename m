Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22515C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1A421721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 17:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555177208;
	bh=RTHrMoqGugReUwiTG/hvDtm/geATPimS0027GV6pTrk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lA65my/r8oEEcsT+RsrxU1wJjKjrAQlGnan62a2wmBLm9ybEf0pWMMqDfcSDWzPU0
	 BUh6D/vTM1Jh6TxfcP83jMmpjiNTBD7PjuT0FPTz0Stle9ONMYQ3bGC3BkLoXmONmI
	 y/26pW3qQu7JplXCItE7HMKdDjFxnRLfjRDtnk1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDMRkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 13:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbfDMRkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 13:40:05 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555177205;
        bh=RTHrMoqGugReUwiTG/hvDtm/geATPimS0027GV6pTrk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w4DJ+aPyFBrqzz8MaGXpMjPbGVHu/GUzFvBi4SeVcBKjgUKnEPyB+zhO6w11hErYN
         xUpRMuncQd1ixU6BqKjFOjPN7Hf3q0bF1P6+h+D2gj2DVTOFt46suZJ+xS1wl7mNnc
         xQv0ZeIl+bE10siDBMQL4T35F8mndT1DxJMqZbqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zhoutuuw.fsf@concordia.ellerman.id.au>
References: <87zhoutuuw.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87zhoutuuw.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.1-5
X-PR-Tracked-Commit-Id: cf7cf6977f531acd5dfe55250d0ee8cbbb6f1ae8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf60528f8ab805ba03e21ce4ce6ab11647cede9b
Message-Id: <155517720508.14034.3220952584944082303.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 17:40:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Apr 2019 14:03:19 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf60528f8ab805ba03e21ce4ce6ab11647cede9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
