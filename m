Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8748C46499
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF33D216E3
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 02:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562380511;
	bh=gxOXfyqZ4mCJRsIHx8JOT5PxKHa87DM2FX7okPEq6Bw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ijxYoNxIymKyDJ4TGwcft+zdu7JPIdHQCO5iyZ6z5tDMuE9CosCMmS1kBENJYb9eL
	 rhoPQgHonVFOlUQOiqvfQWbZcOzjW3o6zdh7bXSM8PIgANkYh0O1Wg/54wUlyqat0z
	 rhnZxeaAfI/aVkzsKmglXlE6VM1gp8Emsx/BPlf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfGFCfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 22:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfGFCfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 22:35:06 -0400
Subject: Re: [GIT PULL] Final KVM changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562380505;
        bh=gxOXfyqZ4mCJRsIHx8JOT5PxKHa87DM2FX7okPEq6Bw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cK+WcEZvB8dx8D0DWLz+pgDxEn4NlJ85xwB4qCKo/BhwPtRYaNNhxVA9RuH2bsXdh
         oX+hRmFEeAxXAUmZNDuosOgXnrgq/+uQv8l/WBIqZmqDeiCUq0rgg+LIPibIprtF4e
         USVAbMpA0+ZRIjXIVSrhUnlbeLWd3ZRJR1/l+bSU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562358570-30670-1-git-send-email-pbonzini@redhat.com>
References: <1562358570-30670-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562358570-30670-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: e644fa18e2ffc8895ca30dade503ae10128573a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fdb86c8cf9ae201d97334ecc2d1918800cac424
Message-Id: <156238050551.5324.18308686881980395353.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 02:35:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 Jul 2019 22:29:30 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fdb86c8cf9ae201d97334ecc2d1918800cac424

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
