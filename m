Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3309C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813DB2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083026;
	bh=h2M8NrhlVXbwvKmntIdbgChVq2GhMDq2/JHnCxN0sKs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=koGMmVntZZj/GBTURWBE3+Ycjs5wsaFiquu1uYDXzbaME1S1C771wZFoYxE1oTkdv
	 7Q3al9qAnPp24ukJ8xVygaMmG0eR5aERhPj3tM/MQa7qe7vEuyskYH7U+0mz47Woqx
	 eON9VryieqA91mo4cYQFgR+F1+cMd9bjduX2G6yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDLPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfDLPaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083007;
        bh=h2M8NrhlVXbwvKmntIdbgChVq2GhMDq2/JHnCxN0sKs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g+tsxEYLQ/d/zr7EwePPPkktfxvro2/JRMekEaQh/OjWPwONRwRTGy0zH8oLJLOUn
         xmT7btG6VLzNeX6e68enK/moeMF/qo0rb8dUgJvVgbBRm591oQ0D595NzESEX0xVe8
         +adE5D4q5/0DlSEUccuscm/Mx2g6/ShLn/KOtkyk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412120252.3704-1-ulf.hansson@linaro.org>
References: <20190412120252.3704-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412120252.3704-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc2
X-PR-Tracked-Commit-Id: 5c41ea6d52003b5bc77c2a82fd5ca7d480237d89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea951a943f8d046fcb77e7d259b3c45eb2017ab0
Message-Id: <155508300742.31973.925361565507280470.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 14:02:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea951a943f8d046fcb77e7d259b3c45eb2017ab0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
