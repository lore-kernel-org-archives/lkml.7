Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A517222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570221614;
	bh=Z7Zi/ugxF+Q3pcYNcdgcQQvCqIBbDj42thUFa54CgCY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IppA97wOr6F6vMTHtwua+s5omn/s9KciU/0S4IP8aBCZiWiPp3zxF/YGTvKNwF2mT
	 wVW5UFflJg19rzDVxbxaO1/7f1QW7QqPAu0aqqzWrttfGmse8h0m40bGTrroBRcbO6
	 WxXSnIxvsw1JUbsu0IUUiSXVSrYMU7xzR1waYxY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfJDUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388217AbfJDUkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:40:13 -0400
Subject: Re: [GIT PULL] Devicetree fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570221613;
        bh=Z7Zi/ugxF+Q3pcYNcdgcQQvCqIBbDj42thUFa54CgCY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EU8tWiIUErYlsSMsfibswATQWXLATBWUTrDloGzm3DZFkZfW3fideJiTVdKMp/rid
         Yo7jJPs1DFIuQV/O2dngcU6fu814RemlyE3QW62+jH2WC4/N+wtkF2WUNYCqIIJQ65
         cJBQu7l9Bg0zaClntAMEyTTmepjJFj1wpP5mUH/c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191004132203.GA29838@bogus>
References: <20191004132203.GA29838@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191004132203.GA29838@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
 tags/devicetree-fixes-for-5.4
X-PR-Tracked-Commit-Id: f437ade3296bacaddb6d7882ba0515940f01daf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ad51e9528e614a60c8828901ee9d7b9f4538d5
Message-Id: <157022161303.19958.16424809656101131288.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Oct 2019 20:40:13 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 4 Oct 2019 08:22:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ad51e9528e614a60c8828901ee9d7b9f4538d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
