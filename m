Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC99C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B672A20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555701012;
	bh=W3+P/xTt5EUvmSvC6A5pHA837Kgg4Yqi/doKEwRffKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EYlQPoUdB/j1WVYcDUGjFnffUtsAu3PFkA8mHNJBSEOATEJym0k3Ey7zt9G0tFmXj
	 GapigzQnedJW7X+Cr6eYrXKnERqjlMwYuFqy1Wryr2uB2seV1FpWgGhSjFsmOgfrwD
	 CYdLUc3i5vnbPQV7rxEgEUoydOCYIE6GTfZ0gm3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfDSTKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfDSTKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:10:06 -0400
Subject: Re: [git pull] Input updates for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555701006;
        bh=W3+P/xTt5EUvmSvC6A5pHA837Kgg4Yqi/doKEwRffKM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mm2LTTn0IaBKuiWNoaq1YYSCay1sFaxDdoi00Nqd3Clcur3ptJyjnkXNk21anssAJ
         MH29Y6a8bAaaalsnw7VF8DVCNRvqpxPoIa8qmtZYbANC+D1whh/Wp0/pVpojunQ2aa
         P05zIfZrBBqPhN5B0F5DtrBN4udTVs99WFUaO1io=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190419073157.epllrynbv5ww4a7r@penguin>
References: <20190419073157.epllrynbv5ww4a7r@penguin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190419073157.epllrynbv5ww4a7r@penguin>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: bf2a7ca39fd3ab47ef71c621a7ee69d1813b1f97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 240206fcab661afe9bed72e8704cef1d6e83e338
Message-Id: <155570100631.4805.12117270780214333954.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Apr 2019 19:10:06 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 07:31:57 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/240206fcab661afe9bed72e8704cef1d6e83e338

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
