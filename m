Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDF8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5FD2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573594208;
	bh=Xn05UwxRxNZPQ4TJREH7ftOeqhRlLG4jE9UBKAnWikk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZdvaERXxRPtLyBEXavfP7ZmO9vt1fE8Lyfwho3YtodHufyCWOdLLq3OXRhrBN/snW
	 fk8JSrRmGFCNPu+NuXJl4w41CIehb1IaEuxpUf/Mn8MF+lgbGauqr6a9GPm32et7bi
	 x81t94sn/QLc7ei7Bw3j8hqshbO5682f3tCKwOTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKLVaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:43118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLVaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:30:06 -0500
Subject: Re: [GIT PULL] KVM patches for Linux 5.4-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573594206;
        bh=Xn05UwxRxNZPQ4TJREH7ftOeqhRlLG4jE9UBKAnWikk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pM1cgqMj1taizNNTj+9GGiysAWowRP3Ds0jwqFuY6zyje2zglWWxm+j+WOVSnLzdd
         /gEnba1GTBp6dNy/CaRgTViCQku9gRDdJD7pkLACE4Phq0+/eiGLJuNcMun6sevMb8
         O1G1/XCeHxqVwixqq218dMbdjixGHod9TqtmDK/s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
References: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1573593036-23271-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: a78986aae9b2988f8493f9f65a587ee433e83bc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c5bd25bf42effd194d4b0b43895c42b374e620b
Message-Id: <157359420626.2595.15197469210319317559.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Nov 2019 21:30:06 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Nov 2019 22:10:36 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c5bd25bf42effd194d4b0b43895c42b374e620b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
