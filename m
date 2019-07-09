Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B54CC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ABC214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695525;
	bh=haDQtb26+fghg9OXTvV9KWxITnThNUfZvQFnEdNh+ik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=njIDJvjmNUgmRnyklUECH8fWgqFek/9RR0s0Hcwg2wvgs9su/t+cDHDOdlmEkQia4
	 505fM02AVmhQG354mM2rQ74X+Lxx3umqZjl5Riko9cQH6B9Woj491GfPt3DY37QdqT
	 m9pW1Vci/lRqoiyyW1fbVzURg5ZlZ/DCk7C4Z3zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfGISFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfGISFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:14 -0400
Subject: Re: [GIT PULL] fbdev changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695513;
        bh=haDQtb26+fghg9OXTvV9KWxITnThNUfZvQFnEdNh+ik=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V1uo+EaHdXkacdzeCiFbgDCjeJPUNfgKAFvfORq3I6mQnzFMHvP87HxeNo/e4pdUt
         6xlDrqzQDzJWBko/mLVR63gzJU6xMmBrCy0IIfJLcE2gJEnPxaL9X9aenEplCy0uJx
         5TSZGVzoEe4JUkzrr/4a1XJpZv5mg0lDlTZaANYU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a6d44af3-cf51-a072-7c52-f505c8990630@samsung.com>
References: <CGME20190709131028eucas1p1f45ed7a16b10e58c649da4ab4a30aff5@eucas1p1.samsung.com>
 <a6d44af3-cf51-a072-7c52-f505c8990630@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a6d44af3-cf51-a072-7c52-f505c8990630@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v5.3
X-PR-Tracked-Commit-Id: 732146a3f1dc78ebb0d3c4b1f4dc6ea33cc2c58f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d41ef5432b76ae90dc0db93026f1d981f874ec4
Message-Id: <156269551372.14383.671855111699940274.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:13 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 15:10:33 +0200:

> https://github.com/bzolnier/linux.git tags/fbdev-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d41ef5432b76ae90dc0db93026f1d981f874ec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
