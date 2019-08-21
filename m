Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661FFC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E52339E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566419710;
	bh=byosRMy9yjMEJVYHDr9LnIWQHMeLco4XAsvQgbkT8HY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Rgz1blWhp7mVgQ13Pneg7H/5rRPPjF303hetzb6vmBnrPZrWubnN5Zv2f8sJiKodl
	 Sr1YL8r/phuNWIZKKsIkt9v+HIKosOLSk3iP56DP2OuW/wjJyR31exSG51Eh1MCQki
	 +V2dermPj+XBlCoOFE7e0p3oZqYo/DowBj1cCc4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfHUUfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:35:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728485AbfHUUfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:35:08 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566419707;
        bh=byosRMy9yjMEJVYHDr9LnIWQHMeLco4XAsvQgbkT8HY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ayqb/KU+hHEIHw1CjpGfMeF40sfB+fL/9XSzryNzRObID2ozCvf2MYukfXeMmn95+
         sq6Etz3BBMqYCdKVHzw7pnldfZH8yRBylaULEecIg3LwO9yNrxIvBjYFWCKlUqRl5J
         mBx+N2TL/iZyVGHaswHb7d/nrMCR9vQa2YVMe9io=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1566409010-50104-1-git-send-email-pbonzini@redhat.com>
References: <1566409010-50104-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1566409010-50104-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: e4427372398c31f57450565de277f861a4db5b3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb7ba8069de933d69cb45dd0a5806b61033796a3
Message-Id: <156641970785.4116.12918708167716551553.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Aug 2019 20:35:07 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Aug 2019 19:36:50 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb7ba8069de933d69cb45dd0a5806b61033796a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
