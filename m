Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECF0C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37390263BC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559276718;
	bh=t9/y1ITY40z/T8C2kwC1Ud11fTEficOcI/zNCGUtbD0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XehTJl4ILPnI4DYdH0kgyU5KePlVg9zxzqz0jIaIP0sxrx+Scv7smHm1/a5H09rkt
	 er+mbvlEAs0zEXV1Q8r8alwlrm7Stcpt2vW2KEuVvGHCJSHTdqbUoUcIl9nVKXFY0i
	 byqiOLe37j2tfZZG9lJoNyxE8jj57CFgMwue1cPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfEaEZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbfEaEZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:25:13 -0400
Subject: Re: [GIT PULL] arm64: fixes for -rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559276712;
        bh=t9/y1ITY40z/T8C2kwC1Ud11fTEficOcI/zNCGUtbD0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J6itRnKC2xdXDl4JQ2LxKhXsA3J3asTIfTtKuksfi7eOeJuss7a6pYXILLTU1WMG+
         rF15D5ZkMTk/R6noZAkpVh+ayyFTUvy2Y5EObNUW8BQYWHxukeGSXSsTaLmE8JD0GV
         XFPFjL64eZ9zzQ4ozZW69KuUgOnDOcHsOnFyhP3Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190530161126.GB16230@fuggles.cambridge.arm.com>
References: <20190530161126.GB16230@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190530161126.GB16230@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 1e29ab3186e33c77dbb2d7566172a205b59fa390
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adc3f554fa1e0f1c7b76007150814e1d8a5fcd2b
Message-Id: <155927671265.23225.14504311744693326939.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 04:25:12 +0000
To:     Will Deacon <will.deacon@arm.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        ebiederm@xmission.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 17:11:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adc3f554fa1e0f1c7b76007150814e1d8a5fcd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
