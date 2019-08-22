Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B234233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498617;
	bh=rDFs1OPoLcQmx88wK5clfuSNgdRP29wexEvjicodM1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=H6roTnkfGkJHLJnHSMfqSZUSjimtoZtaoelFGTu+yrY6aO4Yp2mOslaXm92/G5PM6
	 3Jta3mLu8WG1x6YYTz4AUWqiswXSsW7ZXQCHRuP6IXuiV6Vpgnh8dXZ8/NvAystzt4
	 NjTbleVr/R7F+JRyUcA8SjSo3XKAdXDRD/HZvXLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbfHVSaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390246AbfHVSaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:30:08 -0400
Subject: Re: [GIT PULL] chrome-platform fixes for v5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566498607;
        bh=rDFs1OPoLcQmx88wK5clfuSNgdRP29wexEvjicodM1k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l+NSE2uRT6jxVXet4fu4/vjz9KDL1WveWN4/YbsNlCB8wXyyiGS3QHQ6NL8iq6RjH
         RgAOsrPCV4mTYA0xy0uK/5BRF5EoVtUSJw5NCEnXIoNB77h/s+ax+cRdCSepH6TFGL
         etGMv3ICj8+ROMnBWBlfhdq9ASTYlNaY2PVq1Y38=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190822165641.GA17062@google.com>
References: <20190822165641.GA17062@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190822165641.GA17062@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.3-rc6
X-PR-Tracked-Commit-Id: 9cdde85804833af77c6afbf7c53f0d959c42eb9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5b7c167e46f7b412aeafc91c22805eb76b91ad4
Message-Id: <156649860775.11049.3610074751327925768.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Aug 2019 18:30:07 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@kernel.org,
        bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Aug 2019 09:56:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5b7c167e46f7b412aeafc91c22805eb76b91ad4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
