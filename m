Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8EEC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F56218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554508218;
	bh=cV4KojDww8ghKRnroe/+5yFSac1Q07I+KKePpbDgHIs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yxnfI+wOeLLJgQKQOM4etcLiboS+tpX/8GxcoTqi5u4KzYaw8h9kHHG///kcx5HvS
	 eDCFFXClgmB4WwgQ3eIWt1v0wRkPYNLebmYLdhmyGt5dNLgQ4z9DWvgOFa5VTGVt9z
	 TlTvFlyta1tjBdDhsMW9FkLCBTuThfV7EUSWNZck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDEXuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfDEXuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 19:50:08 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554508207;
        bh=cV4KojDww8ghKRnroe/+5yFSac1Q07I+KKePpbDgHIs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DgEZfXca7QKmhln0pns9Q+ST1x/gHyTvzHKAc8LEUhxZkLvb147z3GFIqKa3q33Lc
         kj0aGUN9hWdgVj9+3fiNHAf/DTiHIBLeTWBwFCtp6Hy4kxHXi2Cjl9nspYWeHpVdxm
         VGbTteTd3QmQd/KnChV7el/FLEH7XLvQVvRA2oyI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1554504347-8396-1-git-send-email-pbonzini@redhat.com>
References: <1554504347-8396-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1554504347-8396-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: c73f4c998e1fd4249b9edfa39e23f4fda2b9b041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc5725f97408ce78e61735858a113f514738ba3b
Message-Id: <155450820772.23520.14483709064431854316.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 23:50:07 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  6 Apr 2019 00:45:47 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc5725f97408ce78e61735858a113f514738ba3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
