Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E62C20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574884822;
	bh=fZcPhKtg4Eyt+zaHypDi0lDtktOjuqRadpEPnhXscEM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U29wdIYyJt/C1sMSsbGtMMRBkZXZKJjixdXsK8iVKp+zJh2rMJIcFq7unkbWW+7ku
	 NBh/a2MHEEY1o20KCk5fa8a0PAbbhZ9J7rBMRvDosLZNPvxJLlq4wVxDDwnI5jQYzF
	 sCA2OZVJxsnmcClQI6rKgFbN49OBADvf+K1MPE5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfK0UAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbfK0UAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:00:18 -0500
Subject: Re: [GIT PULL] arch/microblaze patches for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574884818;
        bh=fZcPhKtg4Eyt+zaHypDi0lDtktOjuqRadpEPnhXscEM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IzN085izgIoUQMtd+PVPVkVQCyjoLNv4ZVo9UHerfbDOtFpdsLBFj0aimtCIeGCbi
         MUj7PZ1sT/PbgUCvjhFS6zw0K/fJZ4lUe8oveOa5ZwDXnYsELKiOe89C2nYQJvbMP6
         q2QD5f1BYGtXsnaOlt5IYFmiyqafBWwwMOkQm4dQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <026c97b9-565c-adc3-3d78-fe2e839e9ecd@monstr.eu>
References: <026c97b9-565c-adc3-3d78-fe2e839e9ecd@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <026c97b9-565c-adc3-3d78-fe2e839e9ecd@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.5-rc1
X-PR-Tracked-Commit-Id: 22648c989cb8305f51b96b5962df8674697bb2ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 477093b3e144aa0ece07a5fd2a84013d037e2776
Message-Id: <157488481798.30408.1857832385030124730.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 20:00:17 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 15:53:42 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/477093b3e144aa0ece07a5fd2a84013d037e2776

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
