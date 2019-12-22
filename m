Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6855C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE1F206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577041814;
	bh=sWzONr3qKC6qgg10Sb+Bn9JI8FPF3i2gvsdC80RQ/NE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ex7EXrKJjGnaQJ+TmpM/xRb1MgJ52MEBQRCnLpGxYjF1SEN+AzUhg7EZjD1aQcbM7
	 8XnuFMruhpD/RvsZ4o2dAccg3KaQ9rnmMGxfFLvZJkK0DIaZhOTHQrVt5jC7Sj3vt+
	 RrmmwrDAvmbBz+HJyLSBqxWXMnpAZV/syrRhNWTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfLVTKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 14:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:32778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfLVTKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 14:10:12 -0500
Subject: Re: [GIT PULL] KVM patches for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577041812;
        bh=sWzONr3qKC6qgg10Sb+Bn9JI8FPF3i2gvsdC80RQ/NE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cS8FXONXU3VpA2crffLZs7vCSV7ik09fT+SJqGIZ5nZTN8LeSny8K1hh+0sc1JqsI
         1Xustuqs7FDbVN+wLup/zoh3XnckfuF+6ObGR2hltDtaf/vQhf1q6l0V4zWK5Bsx7l
         wytdxLVmqa/ldcHP0EOGqGb17dqCy4NcQkZ15SxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1577023254-13034-1-git-send-email-pbonzini@redhat.com>
References: <1577023254-13034-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1577023254-13034-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: d68321dec1b2234fb32f423e32c3af5915eae36c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a313c8e056f86d13ae95a4aef30715918efff20f
Message-Id: <157704181215.1067.14583320724918228605.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Dec 2019 19:10:12 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Dec 2019 15:00:54 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a313c8e056f86d13ae95a4aef30715918efff20f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
