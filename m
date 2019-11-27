Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F41C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064D920866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880320;
	bh=Et45nYjHHhdlrb0u6s5hUgzH/53qX2G2iHPEcjL8L5o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MQSNTaRnwDF7r9cG0HS5CW5d53GvZFjVZ7DhsjezstGbuM894YVQh5/YhefPb+2DB
	 AxH4bS4FwWj1WaXOFMp9HjxRBlHiTA/lvsKk0RIQHtB9kxS2K7kFw3shFpMJb0KpSZ
	 WREdzS/mJyAG9X8GpOeXnlDHuBFB7HSoEaHmwsMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfK0SpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:45:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbfK0SpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:15 -0500
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574880315;
        bh=Et45nYjHHhdlrb0u6s5hUgzH/53qX2G2iHPEcjL8L5o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IWjCMvEGQ+u2BZQvmLR2xi37QPQm1Fj7fNmUei96JtpAiFjJgfiNehXbuPOWHB6ix
         sLiGAt3A9/ggGmXyhUDEY6oyMkG+f6kZ4IxqK82UqV+GL84JHtQQY5bjsNi5MwdFRp
         vTV1GkXP7xAt/WH99eAwtwWpqBur7eveoGvql02U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191126154851.14737-1-ulf.hansson@linaro.org>
References: <20191126154851.14737-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191126154851.14737-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5
X-PR-Tracked-Commit-Id: def7bd940f8cceb41ec3d1383acd8ab937056dcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e45384cecccaa950783e67e7a29ed470133f19d
Message-Id: <157488031536.21185.583861190630466522.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 18:45:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Nov 2019 16:48:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e45384cecccaa950783e67e7a29ed470133f19d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
