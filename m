Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0256C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EA3206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557194110;
	bh=ZNBcidNlVwZptX9Lyt06Klcg26mCxSciTp3dGjgqvf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nK/gV+zxNZWXmZTfpV3jzvp4+ptBKuN3738USjP2ggefuBLKuYGdGcAJTM3p3iivW
	 aVYjmSP1fbDmSz5NWQ/YkTqpmwkGHJd9NIiQS2mH8qXd6QQYAk/ayRyZHwbVfQa+No
	 kmHKZ9xVy0t105eq6yz8zi020cNO7Is42ehhY33c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGBzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfEGBzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:55:06 -0400
Subject: Re: [GIT PULL] arm64: updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557194105;
        bh=ZNBcidNlVwZptX9Lyt06Klcg26mCxSciTp3dGjgqvf8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XyZS1z83Ypd5Enf71TPKNHy03S1HfzlJwAQlCSNQx/11ZvMTc0Prb+BMwugVzsfX2
         KjeYsJpbaA3mKd7sHd1vfmfS0sTsxOu/i5jtcxWfwJqKEt3bfhqnJCcihwYVpSLIXd
         L/KIakggHc/e+WsAtL9n52OFZOb9sw3jDx3k9VYI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506181122.GC2875@brain-police>
References: <20190506181122.GC2875@brain-police>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506181122.GC2875@brain-police>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-upstream
X-PR-Tracked-Commit-Id: b33f908811b7627015238e0dee9baf2b4c9d720d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c620f7bd0ba5c882b3e7fc199a8d5c2f6c2f5263
Message-Id: <155719410565.3542.4447338603353960187.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 01:55:05 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        tglx@linutronix.de, marc.zyngier@arm.com, jpoimboe@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 19:11:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c620f7bd0ba5c882b3e7fc199a8d5c2f6c2f5263

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
