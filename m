Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F34CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F80B21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569609625;
	bh=A/Y1zfR4jdpsMGSHUOe95iEWb2V4PbAMwawWX1yjIpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=or9/PC9KVPBPw1MBiveI/IMW77juksLToquZTMgK3jcjyqlpxiOWRKbYRNnpbe3YN
	 6hIpIfJQVUEpekepME+cvC+OL9oY6KIcVVW7yOqItJNZi62bVZgZbpdoI8cb5muYgc
	 PxhQLnBlyoGj6fj8qZIqxdu5tySdKqRRniHpd11s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfI0SkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfI0SkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:40:23 -0400
Subject: Re: [GIT PULL] NTB changes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609623;
        bh=A/Y1zfR4jdpsMGSHUOe95iEWb2V4PbAMwawWX1yjIpY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iEObLx7T4yKHOYiQ1DIrgoBwelCiW5/kNYv8rzVFJ4xB51pE/8MfNN3OV6GG4UpRB
         p+GQTF+bHoVDGUpX/VQ3ebt0/7d06MlIVa+8+/6WkvCs2S6HO0vBhFLi22U/sIomAT
         lxyvm+ctZjb6yPFGKjOeOFcp+O8yhnvkF+NtH9rA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190926173522.GA15861@graymalkin>
References: <20190926173522.GA15861@graymalkin>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190926173522.GA15861@graymalkin>
X-PR-Tracked-Remote: git://github.com/jonmason/ntb tags/ntb-5.4
X-PR-Tracked-Commit-Id: 4720101fab62d0453babb0287b58a9c5bf78fb80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0cd81d77d0569f1dc1e39abeea93c6184e9b5b54
Message-Id: <156960962332.11345.15498745655077922358.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Sep 2019 18:40:23 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 Sep 2019 13:35:22 -0400:

> git://github.com/jonmason/ntb tags/ntb-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0cd81d77d0569f1dc1e39abeea93c6184e9b5b54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
