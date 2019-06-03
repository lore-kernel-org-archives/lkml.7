Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E9C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D140C27BA2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 05:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFCFVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 01:21:08 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52634 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfFCFVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 01:21:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 086FD1340D53C;
        Sun,  2 Jun 2019 22:21:08 -0700 (PDT)
Date:   Sun, 02 Jun 2019 22:21:07 -0700 (PDT)
Message-Id: <20190602.222107.923223011133534329.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 22:21:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull to get these three bug fixes, and TLB flushing one is of
particular brown paper bag quality...

Thanks.

The following changes since commit f2c7c76c5d0a443053e94adb9f0918fa2fb85c3a:

  Linux 5.2-rc3 (2019-06-02 13:55:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 56cd0aefa475079e9613085b14a0f05037518fed:

  sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD (2019-06-02 22:16:33 -0700)

----------------------------------------------------------------
Gen Zhang (1):
      mdesc: fix a missing-check bug in get_vdev_port_node_info()

James Clarke (1):
      sparc64: Fix regression in non-hypervisor TLB flush xcall

Young Xiao (1):
      sparc: perf: fix updated event period in response to PERF_EVENT_IOC_PERIOD

 arch/sparc/kernel/mdesc.c      | 2 ++
 arch/sparc/kernel/perf_event.c | 4 ++++
 arch/sparc/mm/ultra.S          | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)
