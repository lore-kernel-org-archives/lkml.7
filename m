Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D841C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBB220684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757234;
	bh=FSmYviZVvznqYg5bd2XfqpkkO6MZGz+fIRltVMpNarI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mQ4H8kjXIbj0MmS3SuKvBGQSNofMSFWgUf5ftz0wjVJOSOF4d4A+yvo+FAG6yVji0
	 S1XGf0nFPXaevR/snTQh+rcmQTOzBk2V0501GO/tzqfhYKf46YSJxZdsmDHnu4c7PH
	 15LrTmBkuTm+4d+YeklFDtV6HROCMSX8MmZkrmNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfCEDk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfCEDkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:05 -0500
Subject: Re: [GIT PULL] MMC updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757204;
        bh=FSmYviZVvznqYg5bd2XfqpkkO6MZGz+fIRltVMpNarI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B2L5j5apG/IfmT0xUKmvuCe/u7ML9PVvjNQ/sjcQS9mw0rZrbG6HoGN5crcY9XlP6
         17RTrTQ3pgOrPCzwbCPZmB+sJdwF7BXxaGNvs9O/+jwz2dx6QSuZpvK+SjuyhkVeb7
         cHrqpvYBz4tlNBe0+SQizVJ2TbAvlEHaTn43x9+M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190304130222.18534-1-ulf.hansson@linaro.org>
References: <20190304130222.18534-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190304130222.18534-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1
X-PR-Tracked-Commit-Id: d4721339dcca7def04909a8e60da43c19a24d8bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42eaf1851ea2394d1cacf79de075170300d170c3
Message-Id: <155175720493.14960.9435341849544886876.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Mar 2019 14:02:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42eaf1851ea2394d1cacf79de075170300d170c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
