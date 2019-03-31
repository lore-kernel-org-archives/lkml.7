Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD1420856
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048029;
	bh=uDrIeVmMHJA0OvX4kP6GCIUMQPUk+DLoQFYK/AW5sy0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=CdcFyGstZJ6Gu1CWti4OQpjM5kNqDd4Rav+8FE4lvZdkQkZLi+0eJZvahP7hjCsIl
	 DvuB8MlhnIguN1dDU9u8c8BBtDYcbTeXsrYXWy0jbqVMh9yJ/I9uwM2Uc7In6opVGW
	 YVlV+ofZ4jMkQIRyD+AxSclT5VVunzQ04HS9DoJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfCaQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731393AbfCaQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:14 -0400
Subject: Re: [GIT PULL] KVM fixes for Linux 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048014;
        bh=uDrIeVmMHJA0OvX4kP6GCIUMQPUk+DLoQFYK/AW5sy0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v0yRsR0uYtHqQqszNo3hCNd47L+xhZZFGGqcjmBiIzr93PqcqxeTbtq44ctOkJx36
         NnHJdOy05oFL5NOn97/B/tIbwPUKKRjUTzqoXesT91m0OlpJzM7YC9TCA/hTlipU4W
         FCw8DSwoXpFE6vQZC8UeCh9nKBJTwuv4MNyIfdpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1554042691-30532-1-git-send-email-pbonzini@redhat.com>
References: <1554042691-30532-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1554042691-30532-1-git-send-email-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git
 tags/for-linus
X-PR-Tracked-Commit-Id: 690edec54cbaa0e98dc592aae6864272f48f3c84
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63fc9c23488d6cf34e4c233e24ba59b7e5548412
Message-Id: <155404801421.15219.7216454355036128502.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:14 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        rkrcmar@redhat.com, kvm@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 16:31:31 +0200:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63fc9c23488d6cf34e4c233e24ba59b7e5548412

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
