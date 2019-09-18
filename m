Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A49C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2C21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 18:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568830824;
	bh=GPFBgQdt1CTSJAX0HqHciIyC/bRmaqeH2vsdKoGaZ2Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bLCg0pt8ijJV477uSRcU+EQCHc6Ogd4EDmPxxnqj5juJc1m5ZSXDL8fSs4MDeGuwV
	 dh6yd6jEjhc4aAAUkDHZC3w3872U5GmAvwZb2dNXNOPq+DezsVZ/nRghkuept56wEO
	 cb1it6DWEME5IOg7xyrhpIrUVkUBpWWKUuXHz4tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbfIRSUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 14:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387996AbfIRSUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:20:23 -0400
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568830822;
        bh=GPFBgQdt1CTSJAX0HqHciIyC/bRmaqeH2vsdKoGaZ2Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uGbr+B0eix/EF4vpFgqQXln74YPUhr1FPWeaRy/5gWY2aricX8WA0+wQg0w7hL5Xh
         4A0BadC2U5XwyiFWb5qLWxfR5XVIzrx/l50j2aa5yBTc4+jgqcPsfCmoaDpxkD23am
         rRx+HmGDiSAArh7Ch8YwsW9tZdaGKIWrq0ycjrWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1568652881-21933-1-git-send-email-pbonzini@redhat.com>
References: <1568652881-21933-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1568652881-21933-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: fb3925d06c285e1acb248addc5d80b33ea771b0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe38bd6862074c0a2b9be7f31f043aaa70b2af5f
Message-Id: <156883082293.23903.6518209741876972182.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 18:20:22 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 18:54:41 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe38bd6862074c0a2b9be7f31f043aaa70b2af5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
