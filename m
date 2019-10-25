Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65849222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572039307;
	bh=pcJg0LOXnS2SS0hUm6EUQCdRc08q50KmG7tFF5hdh14=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0n+3Sd47YScIW/7cT/NQoruLmW4wj7dhq3/9u+X4XQWDk8vaz7oRjFX3Bbv6D/gIj
	 mtys0ZPhCV7LS0eEJjY96F/R0tfiwvQ3n0qNzKb9UWaQI1IRhfMvIh/f0Se5b8vSEv
	 ga/DnmjLzwtRIfvSFAl/OZoA3Db06TV3GaO3v1zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfJYVfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfJYVfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:35:05 -0400
Subject: Re: [GIT PULL] KVM changes for Linux 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572039305;
        bh=pcJg0LOXnS2SS0hUm6EUQCdRc08q50KmG7tFF5hdh14=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g1c1/hIze9UYEMThUbJC3/kTH6MLN9giuAD+kRknJ+1wbTUoUTD9Kz3dnN8RqUID8
         TTbdg3duymEcdX3OLFnFLInHw7DgkjPeDlx1pyMG7nPP/6pQEEn/gqI881kFCMscdU
         RfvHtdOQG4EOU8l4VvUSiReFLRHpeLd7AA5VFb3c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1572003959-43063-1-git-send-email-pbonzini@redhat.com>
References: <1572003959-43063-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1572003959-43063-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 671ddc700fd08b94967b1e2a937020e30c838609
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c123380b30f408647f3b159831c863cd56b1400
Message-Id: <157203930529.23557.6500819875416650825.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Oct 2019 21:35:05 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Oct 2019 13:45:59 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c123380b30f408647f3b159831c863cd56b1400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
