Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CF3C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F53621848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560563709;
	bh=c2xG0sMMn3reLu/+z+3+JnJocsu+h7cW/PNsrKjcXH4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s5AVJNFQMvClbYx+c3s/pg8HRzYKds8rQj6bLlNIV+i0B7ku/e+08C744wgpirmpO
	 120OObN89ymQBwV80KOHowsu7HtwxyPC4RRRLpc7HLYKcJafOCxNlCpDblRZHAJWIu
	 NRi4TwzHcDuPEASy2meRJqsudPtrkchphW/BgwGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfFOBzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 21:55:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFOBzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:55:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560563706;
        bh=c2xG0sMMn3reLu/+z+3+JnJocsu+h7cW/PNsrKjcXH4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bAyH9I5YQlxI95hVPZqTSgc1q+pMHoGxYSKKGT20VzPpsZKnpYGNJpxGlPlG/mKFS
         /d6noNSffFuvWyioOcJcOGi43FUZcsZN0d0phBqUM4yqZg8YbcJjYXtvUnRis2BeZ+
         +t4uLWguSVHxhQvHhmfI7Pyy9vi/mbR/Yj9BwQRs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1560551043.27102.99.camel@HansenPartnership.com>
References: <1560551043.27102.99.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1560551043.27102.99.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 625d7d3518875c4d303c652a198feaa13d9f52d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ed1fa5f9c311a74f031cabb18a415b4defdfa03
Message-Id: <156056370681.9443.2329949705637808644.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 01:55:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 15:24:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ed1fa5f9c311a74f031cabb18a415b4defdfa03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
