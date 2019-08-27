Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C3C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E012186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566930909;
	bh=Cu/U9uPqMhWluyz3+nl6gAQbJCiHIIQ6v2svaE2dbk8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1BUwRJlpKVkmJpmlwG9UHtyMg0leMYKaBBk6MIsdSVHbOZAOh7oeYusUL/LWY3LHN
	 YC7s5wCdKRcgNGmqghyEZ2ycWozN+S9wBSgRfqInFb8berfzbSUgSFkAE4dVrZtC6f
	 4e3ZxpW/WQ38Tp4vFjHdO+3YSU8uOGD+DiA693fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfH0SfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfH0SfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:35:07 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566930907;
        bh=Cu/U9uPqMhWluyz3+nl6gAQbJCiHIIQ6v2svaE2dbk8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jXs1vdElxQL3IrnQNlYyCzcGvmkZylzbm5YS10bKAWCV85Js+IF+yw0y4m00XQiCt
         fZatelBWUglWGFsG/K29s6nZyyx+QDngHgZlYE/gipFxsVlswyCHaSsVFqnM3Maw57
         eZTNUmYaupZVxa2gUbYsJpugwQs/IhwIdiL0hle0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190825.232902.493461685673378789.davem@davemloft.net>
References: <20190825.232902.493461685673378789.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190825.232902.493461685673378789.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 refs/heads/master
X-PR-Tracked-Commit-Id: f53a7ad189594a112167efaf17ea8d0242b5ac00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 452a04441b4d0d2d567e4128af58867739002640
Message-Id: <156693090698.10894.2881959253070085295.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Aug 2019 18:35:06 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 23:29:02 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/452a04441b4d0d2d567e4128af58867739002640

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
