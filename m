Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B32C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6023221734
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070129;
	bh=vU2w22F34KmPQIkHWCKhGviBeF6HNcOgKYbXCOkqrPs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XV3riqUocub9flUaBRc/k7raMPQ0obpWGTZCCIm8CaVaYYOY7qljEcT+G8Absxsde
	 e6wFJZcN/up0rRc84srDDWMf8pMfGo1CaaCiBA6DdTKRh36Z+EUF+2u6ZMiZ24NhAj
	 3CewkSJEi/qa/Ls5WQ2/wSY0D//mgsmjC7WK/PLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfCHSf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbfCHSfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:22 -0500
Subject: Re: [GIT PULL] HID for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070121;
        bh=vU2w22F34KmPQIkHWCKhGviBeF6HNcOgKYbXCOkqrPs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iV18akUG/5/VnoN/HAW6WvrTzi5x45D/OluzKQAMXdlKM+omd0STkAy31P7cIscGp
         c28TNlcHaCBKob6EKIiRNagMnV4kMzT2c8L10vqCnLq6H3+nId105cPnKGHghW0QbI
         PgpbysLT7lGZt2jweHOWGQ0S8HSe2VukY55mKvqA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1903051558000.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1903051558000.19912@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1903051558000.19912@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 49374f006191edad94c5273b2684e6be27792099
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6400e5cef5eafc259e649ceedc4c7eecc9069d8
Message-Id: <155207012178.7904.14291888026660658873.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:21 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 16:09:11 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6400e5cef5eafc259e649ceedc4c7eecc9069d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
