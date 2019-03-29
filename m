Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776F1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC39217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553900115;
	bh=/VEp+SgN3qmbu/Noq4OqCZ5enEdkJkFStEUpAn+PMwY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=au5iK3KSZWSwQ5LADN/JyLsFjUBC9ZZx+hM3hAVrv4fI4GtvDgdCxBmYY633PxJzt
	 PqJzc6KtEbwYGL4BxKeKa0cOTU9+YLlJclFMBrAf6W1B9AD46tYa8U+aHA37mAJDYg
	 /emiMIDOOPUef/Gc0l4R28SasIIU8z++laT9WDAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfC2WzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbfC2WzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:55:12 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553900112;
        bh=/VEp+SgN3qmbu/Noq4OqCZ5enEdkJkFStEUpAn+PMwY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z3dKxphtHr3/1NNPpYeNoD9rucfu0+pvB74uXTCsNBOi6JxangBzDD+atiz5Ez+UG
         sXz7TOAzB+GCNi33ngg93YQcqhlPZK7VzwDXf7Sdk9Z2+1TIasU1D6vDrQIQ3op+vc
         Q+BPaOLiOEz6R9Ut2HnpNKqT3sv6HvI3G+H3hCGw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329190132.GA45422@arrakis.emea.arm.com>
References: <20190329190132.GA45422@arrakis.emea.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329190132.GA45422@arrakis.emea.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 9e0a17db517d83d568bb7fa983b54759d4e34f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9007cc601e7b7ed2e0f0c1664d8252fdce964d3
Message-Id: <155390011225.19491.18229426893167522049.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:55:12 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 19:01:34 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9007cc601e7b7ed2e0f0c1664d8252fdce964d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
