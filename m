Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F8C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC8921916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553191805;
	bh=r/SrWNLGe+RmuOn9U51vbIJN+btlumo0N8yk1Aw+p4w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gsdY9HeAH8uxTAnBNXQW+KFG80DZ9aiVRaXS6FTEivw7B/bevCm01Vw2Z9JMjmgC/
	 AQOoVKQMiIDTjg7dDbq2Dg5GXNPeveYJHJBPnU/YpTXvj34aCn73P8M85GWgy40dwZ
	 oGSk6BDStda9LXNrEOOAue7uLuiFfFtazJ+DAuGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfCUSKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbfCUSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:10:04 -0400
Subject: Re: [GIT PULL] fanotify and inotify fixes for v5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553191803;
        bh=r/SrWNLGe+RmuOn9U51vbIJN+btlumo0N8yk1Aw+p4w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HP3D8aeb4NhehTwmM67vjYo6yxGDVp7DlbNExfiw+gWxNKDoX83wq64EnoaNd+x5n
         Q5SUAZYn1LKiugDyuE+3J259Chfb+8WWjmA7NrctXAnrA/t4glhlRtA0DzwvsLd8ZC
         uJQI+gbKrfW3EAIwgGyMmVbmDwRgLUKTlzPrkpIc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190321085950.GA29086@quack2.suse.cz>
References: <20190321085950.GA29086@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190321085950.GA29086@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.1-rc2
X-PR-Tracked-Commit-Id: b2d22b6bb33aac10c415e4ba13c8eade201c6f09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7294fbd4416ab29bfb280f4f84ac78c28957c035
Message-Id: <155319180338.2124.235152118686333900.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Mar 2019 18:10:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Mar 2019 09:59:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7294fbd4416ab29bfb280f4f84ac78c28957c035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
