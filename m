Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF41C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A11206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576867524;
	bh=AB4siEhED5j0416+2sMoma4toRhn6RpvO+9sj8Jbv4I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dpgaWcDeDIwKVEgIT+hh0OtGrev8mmxri8fNPpVnP+lrI5ounaIAIZHz06ja5kEFC
	 /XG36HH/7GC3sliQZHt1Jcra5gFXnAnffUxsixNHi40yIdaeXp9DnKcpyNRYgPFcuP
	 totzDPAUjS+KCK/5SrqoePqn26qWnJBcX3uyUC5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfLTSpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfLTSpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:45:12 -0500
Subject: Re: [git pull] IOMMU Fixes for Linux v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576867511;
        bh=AB4siEhED5j0416+2sMoma4toRhn6RpvO+9sj8Jbv4I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2Q2amZ74uZSr7vQG2OJFLkTXcWPoXSpAswftjGR6+psWELXAPEjJxMcv62z+BuuRS
         NUfCWfVct6wwJwB41eEG1a53hQ5+Aa1AmF+sIeQ0tQCjC8knrmadSTzRkbqSVyh/bw
         oTWmQRa9MWzTKKWUJoyYAqRkkkcijtf9RIjB8AAM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191220113020.GA18747@8bytes.org>
References: <20191220113020.GA18747@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191220113020.GA18747@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.5-rc2
X-PR-Tracked-Commit-Id: c18647900ec864d401ba09b3bbd5b34f331f8d26
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b371ddb94fae82b6565020639b7db31934043c65
Message-Id: <157686751152.22538.2666482295104019680.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Dec 2019 18:45:11 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Dec 2019 12:30:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b371ddb94fae82b6565020639b7db31934043c65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
