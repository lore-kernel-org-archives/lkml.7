Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D6DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632B621726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564519220;
	bh=rxzvltql7wVZw/jwNUEDC1Qb9+r4GqOzZran/66ezKg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dkCL35aK9LQ9/IWeJIcsYZRkblGtAnIL4URvQovT2mAHhDLXknZtQgxKF8nnh1/R6
	 k/Yo2SVqr5peRbKH0Ecvo8ua8m+arvWQVN1zGm4agXAg3atRxmLJByVjTH4q+UKi5+
	 to6ot5Msh7/njwdz1ySIWPIwSpLBl5wL6TBNFbI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfG3UkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfG3UkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:40:18 -0400
Subject: Re: [GIT PULL] Please pull hmm changes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519218;
        bh=rxzvltql7wVZw/jwNUEDC1Qb9+r4GqOzZran/66ezKg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kCpNm0q+triJorfoXGYTORFoq/HS39NKRUfUtHqV0M0bRJcVPyTpWj6wG4Bc+zMPL
         iPZF7bfHnLxay59cZ/uuXJuXD1Oxxoc21SG2T3x8f1Alv0WDzhgnRN9sa7ObvZdPn/
         xvFeYcKzbG0K102nvvGz5KUQ1Ccb0UsnoeL0IHP0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190730115831.GA15720@ziepe.ca>
References: <20190730115831.GA15720@ziepe.ca>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190730115831.GA15720@ziepe.ca>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
 tags/for-linus-hmm
X-PR-Tracked-Commit-Id: de4ee728465f7c0c29241550e083139b2ce9159c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 515f12b9eeed35250d793b7c874707c33f7f6e05
Message-Id: <156451921813.18459.2711445926920761419.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Jul 2019 20:40:18 +0000
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 11:58:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/515f12b9eeed35250d793b7c874707c33f7f6e05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
