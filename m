Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C67FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B7B2077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570386017;
	bh=vtKjxgXVhNL7l+sHOv51OqBy3Vg4AbXAWqnIMjxAo+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=093tM8m0Fr+myCgomerSBcKu/r0WLdpU9J1qe0SEW2WKhcXuOMlNBQlAuDLJskLnQ
	 DNOHaXMBNAmYjOx8m6NWXMjOffzd/NhRBd6PF1BmMQuLrL9T1Fk1mBrFFhIEZHJqWc
	 qReFo+hs06ksFcysR7NzmaTFAjqhbpspUT5q9tYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfJFSUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfJFSUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 14:20:15 -0400
Subject: Re: [GIT PULL] dma-mapping regression fix for 5.4-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570386015;
        bh=vtKjxgXVhNL7l+sHOv51OqBy3Vg4AbXAWqnIMjxAo+w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wbHaJZp80I0Ip4ENaW65UOngeRJPbk4YBfNE295RSbMGcG2H8Hz7jl+v2E2HpjDZ2
         5kbcMNMOPrXEO24SJWhvaEFZ+JWYYy7kgsJ0xGVaeaa/h1I4+C4I6OfLTVQiSvohbM
         iGkIxlyI3whZwjs0pPiuzgzAK++eagDPKV9erYY0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191006162740.GA27870@infradead.org>
References: <20191006162740.GA27870@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191006162740.GA27870@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.4-1
X-PR-Tracked-Commit-Id: 2cf2aa6a69db0b17b3979144287af8775c1c1534
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cdb85df6061d001fffd09c6adfbcf20356615e2
Message-Id: <157038601134.10784.18310088469834465902.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Oct 2019 18:20:11 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Oct 2019 18:27:40 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cdb85df6061d001fffd09c6adfbcf20356615e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
