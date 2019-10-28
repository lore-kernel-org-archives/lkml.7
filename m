Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F956CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606AB21734
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 14:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572271507;
	bh=tQvXaDIwCIcYHfDA7yN+FUhesHg5CVQrJJveO1spFxI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CymOsXov4EMuNpcLIKl4dYU+qm5DRcQktFbNvQolJVOlC9vZZ5ox7ILsaQZ67387S
	 c4HH/D4ZdQ4+h+nIW4Y/ZDg0G0948dk+2SoyBpqMMeBhldwcqU3phRaRpEjxShJ3fD
	 LAljB00rHRK0o+b4kpiyc9zuH5O20kjM1l0td7Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfJ1OFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 10:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfJ1OFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:05:06 -0400
Subject: Re: [GIT PULL] HID fixes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572271505;
        bh=tQvXaDIwCIcYHfDA7yN+FUhesHg5CVQrJJveO1spFxI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oXyAM1INC+6Iw96BQWkJGilMJ/A1qXAH/T5Ql/xUvtJbqmwo047l/pD2k0/peBL+m
         WaTqqDTwTRDYU7QUX809hAY2e3b0kX5EMGTJ7BVaBUiCst/oqLRzkp+V52nSU0Lmzn
         Z4hMcfj3RhYZkxLcVRI+cnUXb2fnOSwVvu2XIjAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1910281411130.13160@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 09f3dbe474735df13dd8a66d3d1231048d9b373f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0365fb6baeb1ebefbbdad9e3f48bab9b3ccb8df3
Message-Id: <157227150551.11779.13715501880943537881.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Oct 2019 14:05:05 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Oct 2019 14:17:53 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0365fb6baeb1ebefbbdad9e3f48bab9b3ccb8df3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
