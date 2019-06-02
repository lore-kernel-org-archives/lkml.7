Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03072C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51AB27999
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559496316;
	bh=TfLxWpOC4SbTif7Gsn4xrF0ocHhDsjWMGlOTKoLN1lc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0NJJ6hC6aWvfW/R+LB5H/4bY6odswYt2UUqTZPicOmonRNmxGvz9INvypR1IN5Kh5
	 ovBpgFv3g+wHCoBDJ/6VgGHrRQkw4KaW2ePiUJ0HVnsRtVRm8UlMaEiN26YQTGCD8K
	 ZvdbADUsk6YgtRP/u9Jpl7XJB7vkyPelhBYARjUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfFBRZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfFBRZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:25:15 -0400
Subject: Re: [GIT PULL] KVM fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559496314;
        bh=TfLxWpOC4SbTif7Gsn4xrF0ocHhDsjWMGlOTKoLN1lc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jtlJlsakSJYX9uj2Oy+0tv6IkDt2Tx5c5zRgVRVvWmFuJ6eLxnf7SJ1aFy4wTXvjw
         HiwaZEYuaMlw6Tr7ofB3fKeEy6EFuParAVTgUI6O6K1ojmWwiktYoiVew9jDdaTbk3
         8y3CjuSP+D+54oaqdvV0tKlmAS5HVa/wB58Sf8OY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559469039-42045-1-git-send-email-pbonzini@redhat.com>
References: <1559469039-42045-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559469039-42045-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: f8d221d2e0e1572d0d60174c118e3554d1aa79fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b44a1dd3f648a433c525efcdd6ba95ad89d50e27
Message-Id: <155949631467.24242.16308911266332915750.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 17:25:14 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  2 Jun 2019 11:50:39 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b44a1dd3f648a433c525efcdd6ba95ad89d50e27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
