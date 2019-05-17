Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346EBC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B321783
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558118123;
	bh=dBoheXLcKwaJdtIdj1gCODQxnjGJGXPs5QUcffxdf8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QlnRiyhE6267Wk+IimRvQpfF04ngwICkygz4j/26zx9fPbszQRMVTK27SEC5CMu6Y
	 m771q+2T2ZP5mHdz0qWXTuf+WAn6BHRrSxIfsxWkNY1aeEIIeQZCMPH9bYnDcylxSM
	 V6a+0EjSCTvU/VOkd6t7eSmlZFThyxoeMCjcRKbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfEQSfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEQSfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:35:21 -0400
Subject: Re: [GIT PULL] KVM changes for 5.2 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558118121;
        bh=dBoheXLcKwaJdtIdj1gCODQxnjGJGXPs5QUcffxdf8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eRSrcb5T51S8XbF+acLCOIy6V59DJLVTOY8FVM2Dq74Jkjxb1swgAm1ZuPTWSTGFR
         W+42GyFEKer9FO2sKxDDrdPA1nZeRlxTy2QBW7ZOmZtuOwz41h/CpEWNS+3iSGWv8m
         G9asvc2ZLk0UXsuGlQ5ichPPBlmaQYYTBGgK0F/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1558065576-21115-1-git-send-email-pbonzini@redhat.com>
References: <1558065576-21115-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1558065576-21115-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: dd53f6102c30a774e0db8e55d49017a38060f6f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c011d23ba046826ccf8c4a4a6c1d01c9ccaa1403
Message-Id: <155811812120.11644.15152833429360428605.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 18:35:21 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 05:59:36 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c011d23ba046826ccf8c4a4a6c1d01c9ccaa1403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
