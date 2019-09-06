Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE39C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6337A2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567800010;
	bh=2K3R/dyDKxGrrVxKDbGMHID5lj8Lbh6A2qaZcfIDRjQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nEkDee+7MIdNtbv55KlD2kLqX+wWjeRQh7une0+P/RWmnKE5F4gguydaZwN7sVlAZ
	 R16eJe0z+9NBOGfqnFXzByFq4MaQ6lads0GJg1ssrA3oLw1N2BavbYvdF34p6OwbK/
	 WYXtsFbumMiLmNkCicmovJ/Qk88UbbExXIXJnOHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394073AbfIFUAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfIFUAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:00:06 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.3-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567800006;
        bh=2K3R/dyDKxGrrVxKDbGMHID5lj8Lbh6A2qaZcfIDRjQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1EpUlSbuKCPvixmzdFzIHfoW/q+JlEyj97X4CwnTg9brBZ+74Mgd9dsS6/UhZw233
         GvWgQlUfzy/9nKQH/GCp2jMvltduiDCmC9OCcFi2wd/hSvU14Ns44iDGaOo1zIIc/l
         bMlUAFa8j6je1MVDIGGkSwza4CSMmXH+1j9OpjzU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190906151220.GA8420@8bytes.org>
References: <20190906151220.GA8420@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190906151220.GA8420@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.3-rc7
X-PR-Tracked-Commit-Id: 754265bcab78a9014f0f99cd35e0d610fcd7dfa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76f5e9f870b045546b9a429f21b65205baf69c0c
Message-Id: <156780000639.21952.17823516206887580681.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Sep 2019 20:00:06 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Sep 2019 17:12:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76f5e9f870b045546b9a429f21b65205baf69c0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
