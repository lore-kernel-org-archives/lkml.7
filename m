Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A7BC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B72173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567183219;
	bh=bIcxhqZxKQbXUfLLcCayl7DeVujt/jXc7X7NoYLsUwM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z5JixhE9PX/X5U7yD7rLg/F98528jYNsIlulX5wh2k+LQlW+lUmfUnAyii+VIcfeA
	 VBwgP21P9NqB95bRe2XXJqhnTSE3v4lSjQTZsZz2WHZw/fbQpTyRdj3isw+Qk41Q5a
	 UjKSuAkOydKRlEk97cccsWkBaZcYH8m1ZNNhLODc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfH3QkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbfH3QkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:40:09 -0400
Subject: Re: [GIT PULL] Ceph fixes for 5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567183208;
        bh=bIcxhqZxKQbXUfLLcCayl7DeVujt/jXc7X7NoYLsUwM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VY/AXX9Rlu6vaJ6NaHr4rObXErAuOUhrnU0IT6ev6VeVKj2tAnS6ClkDUkcPpyWEw
         bOBI/rs6aUjUnppvNRcafL4AzGJ2e/C3lM6/qVzy3z6SVPhtbempOU5mK7bTaWIFpk
         J9LPlsizIOe04eKpiUamfhQZzFZnLgy9TUttUvsc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190830141115.8049-1-idryomov@gmail.com>
References: <20190830141115.8049-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190830141115.8049-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git
 tags/ceph-for-5.3-rc7
X-PR-Tracked-Commit-Id: d435c9a7b85be1e820668d2f3718c2d9f24d5548
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbcb0b4feb5c3f5431a2ed9f0211653864cf2104
Message-Id: <156718320888.32023.5337613688472185467.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 16:40:08 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Aug 2019 16:11:15 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbcb0b4feb5c3f5431a2ed9f0211653864cf2104

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
