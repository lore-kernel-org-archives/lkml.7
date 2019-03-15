Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018ABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3FC218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552687822;
	bh=XpEl1P7Y11qWGXBYPQ2Q+6LqoD/90bmsI1mEzxFsEVI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ykXntrozoPJ/aNIM3R4irHQQNNEXdl4q1hTiVBS7m02C7vuBrYAsedm1Lfk2aZbnV
	 05jZNkLZ9cdU99VKlbagDBWSX/yLTlh68EMpf+o2ys5buxTu9q6/8d9KHzmCezeZGb
	 lZyVBNOxNIX4TOacbJFrjlGY3zNSjIoBHFwxIQHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCOWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 18:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfCOWKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 18:10:17 -0400
Subject: Re: [GIT PULL] KVM changes for 5.1 merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552687816;
        bh=XpEl1P7Y11qWGXBYPQ2Q+6LqoD/90bmsI1mEzxFsEVI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=elZ16enEboaApZmlNP82XLsT/FCvZcpV6cJqc80EuZ5Wyp0j8YD0fhfRqKGZP+l2o
         9n4nTP72q48ma8AZ6wPclYOKRjZ2AcByKACPsfGeLMIPR5prf2RGFy6JDa4Vl6Zu9W
         52H2rnsV7qAolZUgLIC/Cn3S9S1v4hvgvew04vHc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1552684062-8119-1-git-send-email-pbonzini@redhat.com>
References: <1552684062-8119-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1552684062-8119-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 4a605bc08e98381d8df61c30a4acb2eac15eb7da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 636deed6c0bc137a7c4f4a97ae1fcf0ad75323da
Message-Id: <155268781687.7789.4449158659954037857.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 22:10:16 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 22:07:42 +0100:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/636deed6c0bc137a7c4f4a97ae1fcf0ad75323da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
