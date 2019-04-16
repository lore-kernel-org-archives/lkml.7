Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E79FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54832075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555437006;
	bh=uVR7Z/DhxbZ3vmw1mTpm+K7VXJFkh4jSkn9E9ryN0MM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mX/GITeNMW9DY3xz/XpEntJpBHFCcT6kO3HM+DI3oWk5ebxIYc/R70jsrkoNeoCrH
	 qlwdC2LnPpMFQH08pegET60aBJxGsPSDLEZ9E0qkJZNYcHgF7XeI9l7XK/zNBUZSxN
	 rCRArp86qaMOtZX8tcjfVZKdlRJwBoETRlC5yzmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbfDPRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDPRuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:50:05 -0400
Subject: Re: [GIT PULL v2] KVM changes for Linux 5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555437004;
        bh=uVR7Z/DhxbZ3vmw1mTpm+K7VXJFkh4jSkn9E9ryN0MM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q+LJVmE5IlHxaDR4ylHIA3kOnc6gMVh20p7zPJYYYUpZiyBadNcrRA8/PHrud9oPl
         MmIhKB/rcxNMB4kBS8cgA88gzSGE2FsQi3+Bfofe0pRls0whuidSvoNfpMGwMyCAOP
         nHjT7y52/qDxd3wLy+xu1w3XI1eyGsjd+eFGDEbI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1555422100-50658-1-git-send-email-pbonzini@redhat.com>
References: <1555422100-50658-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1555422100-50658-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 7a223e06b1a411cef6c4cd7a9b9a33c8d225b10e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5de3c5026f52b6b409904a1c37f590a6c0e44c5
Message-Id: <155543700465.32308.11140724175778942044.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Apr 2019 17:50:04 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Apr 2019 15:41:40 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5de3c5026f52b6b409904a1c37f590a6c0e44c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
