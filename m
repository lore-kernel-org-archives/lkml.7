Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646BDC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4357920863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560882308;
	bh=L+BH+/BGSmQQzkiJDmS7NMe77KecW+xd6L4POtLcO4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wLqZ1cq0S8ADQZlGDSk2QjcKzKM7jg34frijVLUmgSuYD1JYBRyiUJLAKOa6acVzI
	 dAAKruqbR3N/6ZGh2JlYX8AxUl62KNh90r00QKm8ZpeGAT83Bikx4SUEMntASu/MaE
	 qRBF7hc1w/aBqjUaOrGiVj27wMhtn6RfQITLiUnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbfFRSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:25:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbfFRSZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:25:06 -0400
Subject: Re: [GIT PULL] Btrfs fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560882305;
        bh=L+BH+/BGSmQQzkiJDmS7NMe77KecW+xd6L4POtLcO4Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SRwnsc84tLlud3MerfpyYzs13pbJ0GnjPhK2EnZMY+xBx2QY8rwznbkkPt9Y3mD5G
         cTyCT+WbqghOogn5vHhgfKTbCs4kIvKmgN2B4Z5smXoK8hKlLRZbisX7KY8N/izWp5
         Osjhw4ta+FT0HWxxCxHHgZnLgGUQRJXeXSc5/j7Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1560875945.git.dsterba@suse.com>
References: <cover.1560875945.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1560875945.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc5-tag
X-PR-Tracked-Commit-Id: 3763771cf60236caaf7ccc79cea244c63d7c49a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bed3c0d84e7e25c8e0964d297794f4c215b01f33
Message-Id: <156088230576.11931.6591802047054785950.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jun 2019 18:25:05 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jun 2019 18:52:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-5.2-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bed3c0d84e7e25c8e0964d297794f4c215b01f33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
