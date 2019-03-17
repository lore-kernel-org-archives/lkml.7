Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B84C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ED82184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552841120;
	bh=x610kgE4Zwa5KdSDJoLN/nNubZNmsc6MVMB0B8KHXdY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2ebfbz1I8y5iMwohhbiaPUSzeL+w58KtU7lQeEsNVfnbdihIbyTkf8mLU9UdJVHOt
	 hR1hgKfEKafvEJxl1kVuUMlpF+KSydj3GTSaAojwqOudz3OuF+0wG0pmCOVqno2XtJ
	 yC7M8HyepKQ8i09Lo8gk/I8+3Y/ClHNQHiUEKEUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCQQpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfCQQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:45:16 -0400
Subject: Re: [GIT PULL] 9p updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552841115;
        bh=x610kgE4Zwa5KdSDJoLN/nNubZNmsc6MVMB0B8KHXdY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YRJknRa6EcU+gOQEnvqrjrOtLI3sDOwu+NoZsrEwRFB2FdO2ylE+Rrg+n7ulDhsCi
         lg401+JjocdRbQu23bVcd3YAsR2H9eqrA8RhfvAuMhCRyOAYktKDRQcZ3cUy17wAEo
         gy39N0NzyD+55cEhTUIi2m+SJXQFHkQ8eLsuhxms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190317142524.GA5136@nautica>
References: <20190317142524.GA5136@nautica>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190317142524.GA5136@nautica>
X-PR-Tracked-Remote: git://github.com/martinetd/linux tags/9p-for-5.1
X-PR-Tracked-Commit-Id: bb06c388fa20ae24cfe80c52488de718a7e3a53f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db77bef53ba6ba5205ac1788bb8b66ce141ab020
Message-Id: <155284111567.10074.9099134468153391002.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Mar 2019 16:45:15 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Mar 2019 15:25:24 +0100:

> git://github.com/martinetd/linux tags/9p-for-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db77bef53ba6ba5205ac1788bb8b66ce141ab020

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
