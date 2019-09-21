Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8369FC4740C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5859F218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569087627;
	bh=QMUm8w2h4xxkOwuPaavGzwi/fzLvIKfCdG453NuY2t8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=crMr+dHmypuceii5/kaIJ5m6c1EgbqT4o9h0+1wigRCkbIuRJFdgZ6M6Tt87MubAH
	 IEw6lwMldYSVLIxhARN40t9VyMzwWebfK6qovJXHzkFMnHYa4+csNDrUuIv+X9rIui
	 4W/2oqDA8l2f6VE+1xbK0vnOxlqUa27l9Ui9aWFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbfIURkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731241AbfIURkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:40:22 -0400
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569087622;
        bh=QMUm8w2h4xxkOwuPaavGzwi/fzLvIKfCdG453NuY2t8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=d5E9eAi2VSpAfji0j5aZWnaOqHj7URZ5zFPEIJjd8LwbCm18Z3GGit/l1WJICy9XR
         5wjVyCRztZai5en8RxPjSLz9Cv7gghveWo92iTZitT8YSIvnT3EQHxXv7pfSCtT9eh
         UmzvukWDQG6mmvqOBmjqF369b7s1VSTUZ3ObCd34=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919163435.GA4578@ziepe.ca>
References: <20190919163435.GA4578@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919163435.GA4578@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 3eca7fc2d8d1275d9cf0c709f0937becbfcf6d96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 018c6837f3e63b45163d55a1668d9f8e6fdecf6e
Message-Id: <156908762234.32622.3376107748199470066.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Sep 2019 17:40:22 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 16:34:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/018c6837f3e63b45163d55a1668d9f8e6fdecf6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
