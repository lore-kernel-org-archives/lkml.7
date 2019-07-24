Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ADC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004AE22387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988222;
	bh=xAhl0C0csUV8JTXFW2xkr4vyIY3HtsxxZk+pzzR9NyM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pFJ7D7qo5nfmndGt6p44mCKSulcZccogQ1U3vO7CzS5EusvU6y5ffBOV4KVHByg4z
	 KmLn1s9z/yinz0OvQMbIqPyTi0UJTIK/FgYvq20nA272LRnu1waUX1VHn0bQxw+EqG
	 +9F4hPJrxwKxnjSpCPebRS0IBTNcvyNSAhL+Rql4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGXRKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfGXRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:10:20 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563988220;
        bh=xAhl0C0csUV8JTXFW2xkr4vyIY3HtsxxZk+pzzR9NyM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1+NlSG6k/RJZ8sVwO+m8XK8z02aYybIA8kDaxUmz84SOcgkADpJVN6lCpPmnecZkw
         CMSM3YzdU15eYmGSJA2H3jowPy+0GP4l9mjPACliROPhkWfw6iZz6OkWQrA4nP5EC2
         K3gAiQC1RmfcLUG83GUDE7JPt6WEAAaP4UTUhMOU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1563970561-44925-1-git-send-email-pbonzini@redhat.com>
References: <1563970561-44925-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1563970561-44925-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 266e85a5ec9100dcd9ae03601453bbc96fefee5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 76260774575c0ff7464bf5a4beabc9852180799f
Message-Id: <156398822001.2764.12907694831246058752.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Jul 2019 17:10:20 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Jul 2019 14:16:01 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/76260774575c0ff7464bf5a4beabc9852180799f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
