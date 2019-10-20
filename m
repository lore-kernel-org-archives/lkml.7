Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B121A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571590207;
	bh=BLualv0EIbHs2KY8osjkcA8lzlOz/kzcSnbqGa2Nkis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wokOkxYbgvKEeWMI3DmNvKdL5255mFYHIgY0Fi9gOJdD4Uz3cQnyvMeTY9fVcBOaB
	 w4ba4ThUHaLJaFCN/yWbM90jKGfm1CAyASdPXc6W0BlTVCeBEJ6tISE6Cd/CF6l9A0
	 0fLb54c7kj/GnHKsk6m3KxpgU7HIDmPn2s4KFDjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJTQuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfJTQuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:50:06 -0400
Subject: Re: [GIT PULL] Kbuild fixes for v5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571590205;
        bh=BLualv0EIbHs2KY8osjkcA8lzlOz/kzcSnbqGa2Nkis=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c2pQ4mfN/Mi726JFpX+HW7lHGgpwHXnCEXChuW57PtBsr3jrpQONB8KW3I7/oWnXX
         RCIbK/IObyObSu6IMx4qcMSVLLREVlgHW5AoJ8m3MfvXy3+8XtgQK0ltxdtQJpB28N
         fmGwO19Ke5V0tfOP3JRe4Yw/qyteTuUX3fKCH5qY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNAScdn6BuvdrVhW=We50f8_618+hh72d2q6rZbSP1u5Abg@mail.gmail.com>
References: <CAK7LNAScdn6BuvdrVhW=We50f8_618+hh72d2q6rZbSP1u5Abg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNAScdn6BuvdrVhW=We50f8_618+hh72d2q6rZbSP1u5Abg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-fixes-v5.4-2
X-PR-Tracked-Commit-Id: 700dea5a0bea9f64eba89fae7cb2540326fdfdc1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2ab4ef83fe279e6f8e06ffa490144d082b95493
Message-Id: <157159020556.10717.13276241716340384631.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 16:50:05 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Oct 2019 01:17:57 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2ab4ef83fe279e6f8e06ffa490144d082b95493

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
