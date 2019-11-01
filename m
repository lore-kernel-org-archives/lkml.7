Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43227CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF00217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628222;
	bh=X+Cew2hq/ZN5wUIiN3m/lsnmILD3307MY6hSlGmW6m4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LPoOENdvnWRBSgZ4rvYX/BhCQpTPvT0Ap46nK5uRaEFYK+fh8QlWAQp8jpcCxL51Q
	 ZFpnU0mlKUhJ3JRs+zSd4z+NXm6CKbb5LHaHmjkwGsE6Ka6kZ38bPAqVmDu4My1OD/
	 JOwEDCMR29uKxRGu0cpYh3uYEx6FKdAH4hK2WFcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfKARKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbfKARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:10:06 -0400
Subject: Re: [GIT PULL] KVM patches for Linux 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628205;
        bh=X+Cew2hq/ZN5wUIiN3m/lsnmILD3307MY6hSlGmW6m4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1AQCgVCSWk98TCs0nqC23MJxz2fb8IDuti2K8UDsyj9bPvMgQKaOdEpE3Eaxnyys9
         zNXavKPVjhT8OyJnIS95eOOlmKW5+kx7sz+EQmOzNzr83+C6qOegowuQ2/qqjLOKio
         JNqeb+jaW5T4iIYXmK5yadi5BcldiQIgiBqSHeX4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191031225347.26587-1-pbonzini@redhat.com>
References: <20191031225347.26587-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191031225347.26587-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 9167ab79936206118cc60e47dcb926c3489f3bd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88866b60d98f2fe1f66f2a4e1a181d9f2b36b5d
Message-Id: <157262820591.11375.16865235101517885078.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Nov 2019 17:10:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@kernel.org, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Oct 2019 23:53:47 +0100:

> git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88866b60d98f2fe1f66f2a4e1a181d9f2b36b5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
