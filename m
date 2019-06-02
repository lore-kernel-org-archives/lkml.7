Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1082AC28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E256827992
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559496320;
	bh=zLKZO8opAqDU9wz9JYCfDr9DvdxmeE3nUvhfMhwxvCA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=F+GJU4Jpub1c01dF0DPSVRWSQd1M3NA0erXN24rKeuwrOe2uiE92U4anmiTSS9RbE
	 SRspg0S1RxNlloOdMY4nPtZ5MMTf/InG71K1aYcdX7COLmmtTwBiNSDzkFgTV/1GAW
	 LehJxzQsNpr0ePhu1N1mjGRKVWYDFoUwnEZRlLhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfFBRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfFBRZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:25:15 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.2-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559496315;
        bh=zLKZO8opAqDU9wz9JYCfDr9DvdxmeE3nUvhfMhwxvCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TAfS2qyC+P0Fkw9oGYm7XMzns4arhN/xxDld24lfhxwqa359qn/f5ytJ8IdP/t5Yh
         HALtUmhAF1ZkJ3Cj4tPtZN4klK8g/M0hS8zVeTDp2k2AmHI3wwPHe2/8FmfcfwZflR
         C30z5m/V9oQncfQMXHhshDTRFXtpwVebdYFwRPMM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878suknt7b.fsf@concordia.ellerman.id.au>
References: <878suknt7b.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878suknt7b.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.2-3
X-PR-Tracked-Commit-Id: 8b909e3548706cbebc0a676067b81aadda57f47e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 460b48a0fefce25beb0fc0139e721c5691d65d7f
Message-Id: <155949631517.24242.9903627214009403536.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jun 2019 17:25:15 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        anju@linux.vnet.ibm.com, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ravi.bangoria@linux.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 02 Jun 2019 21:05:12 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/460b48a0fefce25beb0fc0139e721c5691d65d7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
