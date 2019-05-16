Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE96C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8092173C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 02:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557972326;
	bh=vNqSnMbYYcXI324Ix8jOL7SnkxL6rCbYBcP08H/89pU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AnW/WfiKMraJb6j0UdUDxMUgQMzKq9aCkNPlFa09hWvWAJhOgZW2+/HoFRtxAtGem
	 5a2g3XE2OefgEWsFF84aTVRQgQ7flUwN836RJ4oNw/4C0ZoJp6C9t1TmZPn95YZAi8
	 RWzFZKAN7b4Du+hblPuJteAwWbrUoDKyqdJ0oQBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEPCFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 22:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfEPCFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 22:05:19 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557972318;
        bh=vNqSnMbYYcXI324Ix8jOL7SnkxL6rCbYBcP08H/89pU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Wn/bZXpxxugnsiecPZIckdqvLImTt5wLCOX08tMwAYtNtX+aJ2aI6cgFXHb3zr42S
         3BlTzDGVVImRxAdpRM5RTx+bauTDUaDVEUvt3rN+GqpXVjcFZJ3ryYwxNdfblBiXpL
         BwjmongDZJHwAhxTVt5kR58spAIgdIjOz6B9auks=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
References: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iXv7Jh4rjO9XQAFpeCJEZ4-4nvb46nZyQP554uLNbOyg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.2-rc1
X-PR-Tracked-Commit-Id: 67476656febd7ec5f1fe1aeec3c441fcf53b1e45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83f3ef3de625a5766de2382f9e077d4daafd5bac
Message-Id: <155797231889.20425.9070701612629696184.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 02:05:18 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 May 2019 17:05:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83f3ef3de625a5766de2382f9e077d4daafd5bac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
