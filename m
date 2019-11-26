Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B412C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0933C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 02:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574734522;
	bh=cMMCMjBI8Ng64frChwTghVXdOfOT4udneO/aFnuWcVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Tft7jooylMwyX8o1dbCPTqeTkkJuyZgHUKVlbLnIrbwHdZ6HKnwRw3x5L58gQqCYi
	 +mPdVL1E1lubHOWqx9cTTDIe7Hzm571G5Zrx115zuAucuPFc2xY3C+OKUE4dBlMfeL
	 vEV1jdhwGBIDqFmiU5b9wjkURF4UI0QK5dY73HDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfKZCPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 21:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfKZCPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 21:15:12 -0500
Subject: Re: [GIT PULL] KVM changes for Linux 5.5 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574734511;
        bh=cMMCMjBI8Ng64frChwTghVXdOfOT4udneO/aFnuWcVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jYvcmvRZ46feDDu3300ndbSMMX14iWHxm2lTNR6ZUYffIBMCOBw70TTrhtfNF3Bpx
         /tKvHluVLCeHZwdLaaN7S2+9FhrNYnqwlOB5bXDUSr7s9CQm6A/BG98/Jiq7QGxjLk
         YATwtVkyLG+0CgJteuHN4x5AFnHj5Pr/wF2gLGbo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1574679700-32775-1-git-send-email-pbonzini@redhat.com>
References: <1574679700-32775-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1574679700-32775-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 96710247298df52a4b8150a62a6fe87083093ff3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 752272f16dd18f2cac58a583a8673c8e2fb93abb
Message-Id: <157473451166.11733.14602358583467422705.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 02:15:11 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@kernel.org, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 12:01:40 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/752272f16dd18f2cac58a583a8673c8e2fb93abb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
