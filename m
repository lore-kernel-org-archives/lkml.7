Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDCC74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24E8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562823015;
	bh=rxXxLkkxpApXjLOWqL2u+u/hhAy8NMRZoTDymv1m3mI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C5jebyrbs8kcQRiF4EdjaJJAAONCa/+TSaH7u/d7mRpZ8td1w14MbbagCZHD31I8o
	 RJnUDkHZ4SduMykeXyQ+gDrnA18pqGVj0X/ECN4VXL89EtZFPGFlo2CsLIysodtSVH
	 Pq35yFuFHlCs57mJwx2LFPfjXpYRfR+BoBIQevnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGKFaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfGKFaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:30:10 -0400
Subject: Re: [git pull] m68k updates for 5.3 (take two)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562823009;
        bh=rxXxLkkxpApXjLOWqL2u+u/hhAy8NMRZoTDymv1m3mI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=u2k3O5XDFCinNkwRvHJE5nZkxSDtoHx+W58taYcMsspUAnF1fQO6ZjRzc5nuFOuwp
         MbIhl9TaBWYe/XEG0zckMpyu+RWmICjIqhJbSSymVIfzKWJo48c4Fj/rx2cSXJ7l94
         OZJfFt09SWBYx2DlrX7AJ7duHfUrexaLcy/e16g4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710121120.11156-1-geert@linux-m68k.org>
References: <20190710121120.11156-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710121120.11156-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.3-tag2
X-PR-Tracked-Commit-Id: f28a1f16135c9c6366f3d3f20f2e58aefc99afa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29cd581b59496c26334c910a8b848baa81a6becd
Message-Id: <156282300898.30654.3609784094329076966.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 05:30:08 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 14:11:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.3-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29cd581b59496c26334c910a8b848baa81a6becd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
