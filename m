Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FF6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9346B218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556052909;
	bh=Vun2gANAeOVaCXBi2RhvJy6pAiq/AfH21/MM5yJy4Xg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DS1NrDCIwsGO0mGP6UjW6iCYrGaum46EZKg6ejfPS41xmr7/zRvmg3zte8OBX6HgE
	 rMTv9LSMlzA5TnWAj3dWY5yzK2nl1GAMuApqU2RWHjVsitL34nrt0KBna0tFgutfH6
	 M1a8roKsz/Zw+S5Ep5Z9RHEtYXH2mn+PmRdcKUVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfDWUzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfDWUzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:55:06 -0400
Subject: Re: [GIT PULL] arch: add pidfd and io_uring syscalls everywhere
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556052905;
        bh=Vun2gANAeOVaCXBi2RhvJy6pAiq/AfH21/MM5yJy4Xg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eRhl7vWnKN7xxdmsQgOVCc3M0CbiNs0V4b1lVVO7SsQFgdfh4JDWUuoQvr00YPlbn
         Ui+cmPmgPVAy0Qany3SwoYK5vXnLpXRIivSxpulzcRAaJ///UhscbG9ZpSmvq/NiGL
         u/WdTdAuEpTQJy9cCxjzf5p6m8KinneX2xM/YlM8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
References: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
 syscalls-5.1
X-PR-Tracked-Commit-Id: 39036cd2727395c3369b1051005da74059a85317
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d286e13d53f54b00bcd7443eedd067cd432cf547
Message-Id: <155605290564.7507.13998777148509687578.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Apr 2019 20:55:05 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Apr 2019 21:28:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscalls-5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d286e13d53f54b00bcd7443eedd067cd432cf547

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
