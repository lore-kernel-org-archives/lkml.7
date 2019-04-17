Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DDC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180FF217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555523410;
	bh=wOGENtEpA0JIFFLivsD0YPE0DT/uG8DM+4MkpSef1SA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2hFAPSlFHvNWn1R4MU1NSH8Tsm8DwGxbV4G29MTgj8WNbIcgltfJCrUmhuwkRmKxx
	 WMeRh3I00PmCwbm4ImD+1hGW6LJqMXrVEMQt9a4d/tq59/lNlLZvPvDAhX0vFUZYwY
	 5HN4Z5qAPZIlq3nnkIVphq9eGawtR0VLHFAnyieY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbfDQRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731696AbfDQRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:50:04 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555523403;
        bh=wOGENtEpA0JIFFLivsD0YPE0DT/uG8DM+4MkpSef1SA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=11dSOeLqAGAa0HAzsgeo9xcE0lajUru8eIqey68pIPdLQObVkyOhDrX74DZlpI3oJ
         b3lyHufFHaubBVowDGyo1pB7x6Gd96LeXWzLgHFxSm0mbAFTp4E4BI2GAJG+Pse4TQ
         0jFmLPjL6WsUkZJwNx6AX1F21xrxx6wiU1bAEtfQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190416.221625.898048119534445238.davem@davemloft.net>
References: <20190416.221625.898048119534445238.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190416.221625.898048119534445238.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
 refs/heads/master
X-PR-Tracked-Commit-Id: e6986423d28362aafe64d3757bbbc493f2687f8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a3a028fc61d03e80ac57091330eb514280bd5be
Message-Id: <155552340385.18419.11029455183848801067.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Apr 2019 17:50:03 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Apr 2019 22:16:25 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a3a028fc61d03e80ac57091330eb514280bd5be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
