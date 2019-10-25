Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F08E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039315;
	bh=3fM2FA6QG8rgWV+HZ9oJh4rrxUuqc1MlGZpz7vRt5BU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jpqG+CajNCAR1rfUzYz+ANK7LGftnseAQf21wjZ7zUooTOnewC44bUAVJXFFVGF7s
	 s4MP52oMu1apsHL1VtTgtKUdocppxq0MUKE7vTC37HfoGx/JiQeLqb92AGKc4kb51n
	 5JlVVpIdQ/RjZMcwP5SeixF2kBcb8C90Vn6h0Uag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJYVfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfJYVfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:35:06 -0400
Subject: Re: [GIT PULL] Modules fixes for v5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039306;
        bh=3fM2FA6QG8rgWV+HZ9oJh4rrxUuqc1MlGZpz7vRt5BU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XqOcmoBMtpbZUJa6drmYyTRZNyMd30nlf7jcJ5a9WKIP618TvszYMHbvnrlNqH/db
         Iz7koeLfMb55twmISzNaNbmTF7gQFd6eTC9O1hjJCbNYhzfq14VI+oHC4LFF77zhlt
         fTPmuHUBiZ/80B0D/b8ipXxLFmVwdmhKgnwSoTOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191025155512.GA30503@linux-8ccs>
References: <20191025155512.GA30503@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191025155512.GA30503@linux-8ccs>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git
 tags/modules-for-v5.4-rc5
X-PR-Tracked-Commit-Id: 09684950050be09ed6cd591e6fbf0c71d3473237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e2dd2ca85d211a6ef2a1e95ba9239ec69959b1e
Message-Id: <157203930606.23557.2041549109544035521.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 21:35:06 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 17:55:13 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e2dd2ca85d211a6ef2a1e95ba9239ec69959b1e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
