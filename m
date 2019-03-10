Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B0CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B252084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552241115;
	bh=21QGtENVUFxFEfdj9S3ynyEK0lo8BXaVF1NU4fzDii8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=D3/THDo2NyEyEopwkTkZob6glQvqMjlIKcobXLaHLQvE49xzmZeJemGMRs3Kj/ZBG
	 E7IipUAwxLB/e0zQHTkF1c+Xj4MZZQNmDvXyE/Q5ISGHY34l+QCWaCgLu3fGua1hGv
	 zppdV+qhAkeuiP9Gc2bhVHHK14qp+EdM7LE54yxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfCJSFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbfCJSFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:05:13 -0400
Subject: Re: [GIT PULL] arch/nios2 updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552241113;
        bh=21QGtENVUFxFEfdj9S3ynyEK0lo8BXaVF1NU4fzDii8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P2foq3bCs66hAve/8JcvrlPC5bpvoi6Zdb4esvqrIYi8aVnqHgdv0zeZ6KHKccpIJ
         4iClDV0KQKlVrNlhC16PburChivdtovc2Id/vxW34FY9tQgZbTrLMvDPzbYSCShQCN
         UZKqAGH+Omotje6N5kGfapLJmbPd7MR6YGqg/zrg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1552067623.5582.8.camel@intel.com>
References: <1552067623.5582.8.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1552067623.5582.8.camel@intel.com>
X-PR-Tracked-Remote: (unable to parse the git remote)
X-PR-Tracked-Commit-Id: 21e6bff5e0ef0033d776e64c40e6873d7c75e74b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6075262969321bcb5d795de25595fc2a141ac02
Message-Id: <155224111328.12168.11962048622544113198.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 18:05:13 +0000
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "; lftan.linux"@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 09 Mar 2019 01:53:43 +0800:

> (unable to parse the git remote)

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6075262969321bcb5d795de25595fc2a141ac02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
