Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE74C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D816E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 05:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNFGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 01:06:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:55794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbfCNFGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 01:06:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B9B2ADED;
        Thu, 14 Mar 2019 05:06:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>
Date:   Thu, 14 Mar 2019 16:05:28 +1100
Subject: [PATCH 0/3] Three rhashtable improvements
Cc:     netdev@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Message-ID: <155253979234.5022.1840929790507376038.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three patches have previously been posted, but at the end of a
set where some early patches were contentious.
These patches did not depend on the others, so I'm posting them
separately.
The second patch has been changed slightly to make use of the new
API that Paul McKenney provided to check is call_rcu() has been
called yet or not.

Thanks,
NeilBrown


---

NeilBrown (3):
      rhashtable: use cmpxchg() in nested_table_alloc()
      rhashtable: don't hold lock on first table throughout insertion.
      rhashtable: rename rht_for_each*continue as *from.


 .clang-format              |    8 +++---
 include/linux/rhashtable.h |   53 +++++++++++++++------------------------
 lib/rhashtable.c           |   60 +++++++++++++++-----------------------------
 3 files changed, 45 insertions(+), 76 deletions(-)

--
Signature

