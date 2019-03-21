Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D11C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2490218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfCUDoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:44:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:58766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbfCUDoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:44:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 92A4EAD49;
        Thu, 21 Mar 2019 03:44:18 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Thu, 21 Mar 2019 14:42:39 +1100
Subject: [PATCH 0/2] Two clean-ups for rhashtable.
Cc:     tgraf@suug.ch, netdev@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org
Message-ID: <155313966311.31132.17461701268394583387.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches make small improvements to
rhashtable, but are otherwise unrelated.

Thanks to Herbert, Miguel, and Paul for the review.

NeilBrown

---

NeilBrown (2):
      rhashtable: don't hold lock on first table throughout insertion.
      rhashtable: rename rht_for_each*continue as *from.


 .clang-format              |    8 +++----
 include/linux/rhashtable.h |   53 ++++++++++++++++---------------------------
 lib/rhashtable.c           |   54 ++++++++++++++------------------------------
 3 files changed, 41 insertions(+), 74 deletions(-)

--
Signature

