Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97710C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623CF2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565554819;
	bh=i4w8B+cpVPXThlxBvwy4MnGi42Qt5vWodoM8k3EI0oc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uIrCQpSMkrQKUxrREfGpdz5Wod7nLrldykWzXvOJHngiKCdXrhWaxfUlPtTZy8IPM
	 +Gc1efd6yHNuGe+Mi78QDyD64WorI8RVEZqFTEAwg5ZeXqKBCgPeFYeR+gXNi5Oyyd
	 LxAioe2AVGoeBqDQqQ7tHH6cSccBEt/PkpkWmtBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfHKUUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 16:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfHKUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 16:20:17 -0400
Subject: Re: [GIT PULL] dax fixes v5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565554813;
        bh=i4w8B+cpVPXThlxBvwy4MnGi42Qt5vWodoM8k3EI0oc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=prCFR2BhegsueU5De1GSXYh3GJ3xKxMD9aceQyN2kMhmCSJYAV8UMigzQq5GccTXY
         fS6JzB3mnDutkrtArtYRQgdvhVefGnKulp+ZkEWDcF4/sXU+l/CqIkaY+GbiTT1yZi
         Zr/HRfxtkgxAYeF3lmT0z4bVbu1NvfWrtsx8IR8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
References: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4iaYiXbv2sf-Znn5dYphLKEi77NjafkEzXA2kAEMqyR0w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/dax-fixes-5.3-rc4
X-PR-Tracked-Commit-Id: 06282373ff57a2b82621be4f84f981e1b0a4eb28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6c0649caf351d39e1dfb5698d7b3bb7536850b1
Message-Id: <156555480716.24420.8804304827340944517.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Aug 2019 20:20:07 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Aug 2019 12:01:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-fixes-5.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6c0649caf351d39e1dfb5698d7b3bb7536850b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
