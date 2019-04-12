Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2FEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115DB2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083013;
	bh=1tOsJ3H5oRJ+mSd5NRSdKnvjzqdv+pwa0IGk5X8RX6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=L8Y6jg85sbofK5mtRbFFu7PfmQy/CLJVQi3adliDLwpwI09Mavdyyz4e3RRJvL3UJ
	 CldQcZZ87MmZNxM29a67TWKoW+CXaW0d18k+DawxZaPUSS4WgpYwRCxDAjUNnZIo9F
	 ZrBs1St6IoHn/1D0sQA4blXCOz5dcJB2PlwMmKaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDLPaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbfDLPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:08 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083008;
        bh=1tOsJ3H5oRJ+mSd5NRSdKnvjzqdv+pwa0IGk5X8RX6g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QQI9uJliauPicbBqWNXhTKggcITNgHvsRNJ6Bj+axe4hr7ezTLJtEXWiAltFc3qEL
         kgi640n2zR7ROcFf5sDr2dQwtJFdQOivu0jWSGHdBFs53JtmhislDwVl5SonQ9DnG9
         PMUSKORXf876eVA6xhrdGRy4Mknfj52JmAxYYa6U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412151901.GA14497@infradead.org>
References: <20190412151901.GA14497@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412151901.GA14497@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.1-1
X-PR-Tracked-Commit-Id: 8c5165430c0194df92369162d1c7f53f8672baa5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ee15f3248660f85102a47410079d408615723d4
Message-Id: <155508300802.31973.10103032526645452851.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:08 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 17:19:01 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ee15f3248660f85102a47410079d408615723d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
