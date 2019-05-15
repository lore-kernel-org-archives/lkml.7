Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BEDC04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E69720881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfEORk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfEORkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A09F2084F;
        Wed, 15 May 2019 17:40:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQxtA-0006O9-Cj; Wed, 15 May 2019 13:40:24 -0400
Message-Id: <20190515173951.753467660@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 15 May 2019 13:39:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/6] ktest: Final updates for this merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: d20f6b41b7c2715b3d900f2da02029dbc14cd60a


Masayoshi Mizuma (6):
      ktest: introduce _get_grub_index
      ktest: cleanup get_grub_index
      ktest: introduce grub2bls REBOOT_TYPE option
      ktest: pass KERNEL_VERSION to POST_KTEST
      ktest: remove get_grub2_index
      ktest: update sample.conf for grub2bls

----
 tools/testing/ktest/ktest.pl    | 89 ++++++++++++++++++++---------------------
 tools/testing/ktest/sample.conf | 20 ++++++++-
 2 files changed, 62 insertions(+), 47 deletions(-)
