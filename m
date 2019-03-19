Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327EC2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553020515;
	bh=BVEHNcuTy4yThpPPEVp8LbPzrxs92Cz0+XAHK3DbPnQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=v0zRVQ2wdKajbHreMp/1v5ICjgV803sDI9FNInqEBhfDsFpW2tPWijsGF1mKlq80q
	 I1PG3nu1lz7FsLdB3bhmQg3/zTIUa5VuJa0+Cst9prDs01BRZVEQq8yqh47UzVhVcY
	 yA30gn2EJcTJGudyvLe1BS92speWyHO75FmbERxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSSfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSSfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:35:13 -0400
Subject: Re: [GIT PULL] chrome platform fixes for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553020513;
        bh=BVEHNcuTy4yThpPPEVp8LbPzrxs92Cz0+XAHK3DbPnQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=djlURiCRfCqwSv6tO3NDJozEuikReqvlitRVdN+B2q3qT/f5Zz+WdmTRtLSmcIWXh
         BYknzZs4ZGfz6brxKdZpSY/1J9U3A6yPzaTkMkF5hX/agwobF3bNvvescdtoYPBj3w
         3Otgi3fv8p37aZQUDx3TBV2vk19eZbOqCcGD0fBM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190319182555.GA197525@google.com>
References: <20190319182555.GA197525@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190319182555.GA197525@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-fixes-for-v5.1-rc2
X-PR-Tracked-Commit-Id: 57aeef7f7a6848024b92c32bf23e8c85a8ac896d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: babf09c3837f3cf4b58225225609445419c338e6
Message-Id: <155302051301.29029.13955489957534672548.pr-tracker-bot@kernel.org>
Date:   Tue, 19 Mar 2019 18:35:13 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, enric.balletbo@collabora.com,
        bleung@google.com, linux@roeck-us.net, ncrews@chromium.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 19 Mar 2019 11:25:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-fixes-for-v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/babf09c3837f3cf4b58225225609445419c338e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
