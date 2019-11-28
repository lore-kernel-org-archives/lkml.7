Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1761EC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8BC21775
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574968816;
	bh=G58HprIePJ6qbY+OHsZVZgBg2KquNToguUNtXSRHJLo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zLrC5xsshWNbm0XKh/rOGSSr+X7H/y+xccU9UMs37PbEnGvXGTkoF4UmiEV1tjqdO
	 PafdgASuW67oHgpk1vBm+hdVdzOspZxhTBW4wzWnn5IsJNDrtr8Kt0stUn+ab+MCEG
	 mw3I8ow0cy3P0/VZB92CsJ8TDN/1wAGSL3ykdPt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfK1TUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfK1TUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 14:20:15 -0500
Subject: Re: [GIT PULL] generic ioremap for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574968815;
        bh=G58HprIePJ6qbY+OHsZVZgBg2KquNToguUNtXSRHJLo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=saTkmyL8AaaF6ya38BNFEko4VLzyro3RRGO5eOHLLkmMlbmJpBPZtObVUbVnoy4jG
         j/xkb/2d3jd525W3z2wKnWm/zXQOFOuLNC3QC8DmKPa/USwQufeni2sJAHq843779j
         MtdCnVGNeV1Mk5HauujwPqtbipzPKr13F2NIISsM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125192758.GA13913@infradead.org>
References: <20191125192758.GA13913@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125192758.GA13913@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/ioremap.git
 tags/ioremap-5.5
X-PR-Tracked-Commit-Id: eafee59440623e06b0ce4a0e49f814a8cf31d8ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a308a7102215a582fc474375648965bc5692894b
Message-Id: <157496881508.25622.2949823818676822496.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Nov 2019 19:20:15 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 20:27:58 +0100:

> git://git.infradead.org/users/hch/ioremap.git tags/ioremap-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a308a7102215a582fc474375648965bc5692894b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
