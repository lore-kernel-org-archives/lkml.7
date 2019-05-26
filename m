Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4643C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6A92075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558904121;
	bh=yRzCBsdoKKAB4no/aHvH1cvo7Bj2T6zZ/bZaBlVOnYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sIPrT47eQ+1OUqYvTQTi4yAhnIZXi2WHfp0sOyi9NSLfYX7f4pf6fBtywhzihp1F7
	 6c0do1pZy+tM6hNQICg7jnWNUNOEDLJL/z2FiwgftBzD3DtItGLFxb+ogWKOaZ1l8s
	 feN3nuIK70OQ4hTWzUEtxCliM2ZiUnfoSqsbwQRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfEZUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfEZUzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:55:16 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558904115;
        bh=yRzCBsdoKKAB4no/aHvH1cvo7Bj2T6zZ/bZaBlVOnYg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=twEUe5rHnrtnSJWMJHlf/NMQlvFF2CwquKqI6UHeASc0vg9spBbKhbZk5Z8xIH5d4
         S60HRPGIaeAW/oIugDIe8NqLyHL5TzyyvPCPHnA1fNhkEC9MHMg5ZJdjXI5KyOqYuf
         O/a6q0hLu/VN4nCkrb4SRQB6oRRyUPzaMGjQKP9g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
References: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 66f61c92889ff3ca365161fb29dd36d6354682ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 862f0a3227b337cea11d0488b0345dc2670fc297
Message-Id: <155890411588.17135.4509437635494463225.pr-tracker-bot@kernel.org>
Date:   Sun, 26 May 2019 20:55:15 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 May 2019 11:55:55 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/862f0a3227b337cea11d0488b0345dc2670fc297

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
