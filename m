Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C13921911
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988344;
	bh=SSUJBkfMlYhqcaHtLVBYuZ1a8giKpapCmr67x26gzNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nXDGSKpPbjUs57Q8y7GMqtdTTbOJ8zck65AXWv7oet2noZitOCNN7hF4RK4uMRIW+
	 vwObnu4V1IVyMI9fr4GzTPbovutn5XRPcqRxy+E/EkeXJFJnj4egwpw4BiN+QzzXvi
	 5tmXfVLaQOR4Sa6FYCODgmA34031iM1NYTtDxKcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbfGXRKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfGXRKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:10:22 -0400
Subject: Re: [GIT PULL] dma-mapping fix for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563988221;
        bh=SSUJBkfMlYhqcaHtLVBYuZ1a8giKpapCmr67x26gzNs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p8z0/gkLUJlg6QxzRk+oEILBD3aLN9GNPXnnKvgINWBARLv6w5lGSNCbArXdS+eVZ
         3muyYyAGv6NF/Gn89TaZGNyhenP2uCRuvy57RN/Bmc+WkahCMDmh7TpUmtXvdKNh2M
         n7IAIxmb/rb1eTNCOhwfNO3zYzWL2Z9qVv7HX8o0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190724144942.GA7893@infradead.org>
References: <20190724144942.GA7893@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190724144942.GA7893@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.3-2
X-PR-Tracked-Commit-Id: 06532750010e06dd4b6d69983773677df7fc5291
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2626876c24fe1f326381e3f1d48301bfc627d8e
Message-Id: <156398822137.2764.4372152990600257983.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Jul 2019 17:10:21 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 16:49:42 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2626876c24fe1f326381e3f1d48301bfc627d8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
