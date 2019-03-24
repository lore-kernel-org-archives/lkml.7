Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F1FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2032133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452847;
	bh=hYOAVjNrZIsuLjbQqkOcKSg1fk9e71Id7dK/W1j7ftA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0QdoI4cJkkrqLMwRjk2/XvWAcRk8TDVaxUYPcOcXRJcdAwI9N74imAkgd81dAqGr6
	 xkWiAKxmbXPrY6Iot4DCcKWyP4sIHt877Bo+SBE/5p7HxxXmIMAdJHjKKY2krNd9AQ
	 hfy4EojJ0WHbQdeUbsKvIJS/U+JZvalKKIxnDoQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfCXSkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729076AbfCXSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:13 -0400
Subject: Re: [GIT pull] core updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452813;
        bh=hYOAVjNrZIsuLjbQqkOcKSg1fk9e71Id7dK/W1j7ftA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=n3+IA6gyuVPU7Os5QC3Z7iXXWUac/83cIBpGrUeDsud8RyH3uytMLPTZd7dUAJ2zI
         JHFTuQc8IfwYNiFIUIMWj7rDKrf2dh1OqrkhEp8vUvc4leItvghOWHwWziBrcSFDmE
         uFEdnrFblYdAZ3xg6i9qk/H6tyM/GQy8K30HmxaY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 48084abf212052ca1d39fae064c581b1ce5b1fdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ebf5afb23cd856043bd0a423e95f95e84d9728d
Message-Id: <155345281332.5356.16625331020669889692.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ebf5afb23cd856043bd0a423e95f95e84d9728d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
