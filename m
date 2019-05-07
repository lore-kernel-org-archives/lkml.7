Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F97DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F94208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557262213;
	bh=FZRrrg1TyoUNC5xRkX5JR0KjLAaP0iMlAa87oIVA11c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vbqR87iyXka7aMwv+GP3Q9YtWtipUGI53t881unkkHGqESrWCMfA2wv1IDuCXjn1a
	 qomvmQ5FIqaHih+a4cN9LFMDQOO36IBl7g2Xz4zFaq3oXtDW+Xct0W6MRpeR2g7T2F
	 pcJaSS8IQzMalNTK294DUaTX3PsY0J8ydaGhVCoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEGUuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfEGUuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:12 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262211;
        bh=FZRrrg1TyoUNC5xRkX5JR0KjLAaP0iMlAa87oIVA11c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x29KDaY4HjUnRcVv6Eih8ZZmpa7SKAPNnT2vOLV/ki1VvSNDNb0G19wF2DSLVIKvB
         +WpMSJ2V8dwAXr8NPqnM1YRZUwW85gZV4O/RYqk/pXNslG48BZSbw8yWPoTA+9Nw8S
         wvENVmmgQ3DX+x1nq0kCR9R7TcnVBBDpDBypCDao=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507063634.8389-1-ulf.hansson@linaro.org>
References: <20190507063634.8389-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507063634.8389-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2
X-PR-Tracked-Commit-Id: 0a49a619e7e1aeb3f5f5511ca59314423c83dae2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01e5d1830cf54ac45768ef9ceb3e79cea2e1198c
Message-Id: <155726221151.25781.8513027415507932258.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  7 May 2019 08:36:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01e5d1830cf54ac45768ef9ceb3e79cea2e1198c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
