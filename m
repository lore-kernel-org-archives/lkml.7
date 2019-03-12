Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AC7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410018;
	bh=kTU5PTMsXMLoeyNCnDTF7uFni7kYIBP3NBUHzKReQXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u+KMbIwdouQrr93e6eAW4NYEw50wKzbXWBb9MzEpbExc8XYZe/TJgoydYW0CiMuKW
	 pp8yHv0NITHKoM2JM6ZdhzU0buE5Kp5X843654TohRJHMCwgnPOLnUtD0j6ZYquiQm
	 kDzvOoHeTqp8L6PUqDYRyJBWTCzFyi9j3/ZydRXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCLRAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:00:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbfCLRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:00:16 -0400
Subject: Re: [GIT PULL] chrome-platform updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410016;
        bh=kTU5PTMsXMLoeyNCnDTF7uFni7kYIBP3NBUHzKReQXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ov6NCPgqtJZMKQbtlcbIK38nkwc8kYkvY80e40xiEP1YAUz6GxjcoDwjEwad9pJYr
         enxVkMYqgC0bDhYopVW5OPta7Pc97GaAN9B7STLGzZLVmj2yO7eZiSvQQEQHJeeki5
         OkYowkLOAoDOO0ZLjGbf0ahMO9PBTT/KTOl5WI24=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190312043908.GA261883@google.com>
References: <20190312043908.GA261883@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190312043908.GA261883@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 tags/tag-chrome-platform-for-v5.1
X-PR-Tracked-Commit-Id: 2794449576a6024e203eca5cc2c1a3ae33102b8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f47d633134f7033e3d0c667419d9f8afd69e308d
Message-Id: <155241001616.28785.13981190410539877525.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Mar 2019 17:00:16 +0000
To:     Benson Leung <bleung@google.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        bleung@chromium.org, bleung@google.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Mar 2019 21:39:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f47d633134f7033e3d0c667419d9f8afd69e308d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
