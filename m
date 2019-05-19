Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A23AC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 22:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539D0206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 22:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558306523;
	bh=x4ObgeUi92DGbonQhJAis7tW4qYwHoWEYangY0RPymU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YmnIsPv7UcYxrEerIczCV7N3JIqiZyn7PO1K9p2go1G6nU1wL+Io4sSTpWLiEoJaV
	 rZAUgrUlpavAsQiUBjI+CmOZkVVLj5+3FatOiAb4Gc1DKecgqLvUyUQPaZQqJtDuXQ
	 We5voWLiFhz1sPi++0fr5fQpnIZgh1XjmcTopq/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfESWzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 18:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfESWzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 18:55:22 -0400
Subject: Re: [GIT PULL] UBIFS fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558306521;
        bh=x4ObgeUi92DGbonQhJAis7tW4qYwHoWEYangY0RPymU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c6PY2jN80se+l40JBw4+7GhpiJ4nk8cSGudtgwH1m/6tsbLsldh8pXj74QWLdfjm2
         iDIS9j/JL2Y5buC22nX6fQQL10LyQddfaiO7VPCwo/hTaSk4b59sY+hdX8Lcwv0vTI
         5SJFZ9rmCcQ43xApme1jrMdKYcQJQ+zN0EbmvMms=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <273612995.64271.1558295651158.JavaMail.zimbra@nod.at>
References: <273612995.64271.1558295651158.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <273612995.64271.1558295651158.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.2-rc2
X-PR-Tracked-Commit-Id: 4dd0481584d09221849ac8a3af4cd3cefd58c11e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e2c12200153e63749f836109cef8150f9c61ed8
Message-Id: <155830652141.17736.5762172980478555027.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 22:55:21 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 May 2019 21:54:11 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e2c12200153e63749f836109cef8150f9c61ed8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
