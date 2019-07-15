Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17B7C74A4B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD48214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563159616;
	bh=Ar2oLzYPfNRIJ/cKktihwM03Q0D3KOFaf7zQt3uCrhY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mpDFtj/nNj1o4acrMHa/ND3VKQuyZ0ozdRsSOBd+i23QlYKTv+1zFfinSqazkl5r8
	 lkwZExu8dSVg9T+vIxHDr0TZRRbh77nJCcTzd+3ko5AZOeYdJZ9+MEC5OUstP+R0T5
	 XGMBxPELZIe5q9Bh/Ipqk9qjCioQc3ge2vSKwZfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfGODAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbfGODAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:00:15 -0400
Subject: Re: [GIT PULL] Please pull hmm changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563159614;
        bh=Ar2oLzYPfNRIJ/cKktihwM03Q0D3KOFaf7zQt3uCrhY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g0DVxuH0O8BwZfaSxEtLyRsfEYPSCQdWnn2yhetG2F8mg12jeSXAQTnuntXE+E6hh
         3jRqBcH7Oh1Z/vN6zC0AHX0l+UoWFpMiIlodt+M38nbijWqBr0neCq5SSuXJhz8Czi
         Qp2nslOyUee5Z2RZI2rVwJKKf+p22oV15OzeaA5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709192418.GA13677@ziepe.ca>
References: <20190709192418.GA13677@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709192418.GA13677@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
 tags/for-linus-hmm
X-PR-Tracked-Commit-Id: cc5dfd59e375f4d0f2b64643723d16b38b2f2d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fec88ab0af9706b2201e5daf377c5031c62d11f7
Message-Id: <156315961463.2012.6385315659069176378.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Jul 2019 03:00:14 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 19:24:21 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fec88ab0af9706b2201e5daf377c5031c62d11f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
