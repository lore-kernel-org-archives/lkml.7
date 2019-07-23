Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E417C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1691822389
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfGWDHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:07:44 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:12294 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfGWDHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:07:44 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 22 Jul 2019 20:07:24 -0700
Received: from akaher-lnx-dev.eng.vmware.com (unknown [10.110.19.203])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id DCBFFB28A8;
        Mon, 22 Jul 2019 23:07:38 -0400 (EDT)
From:   Ajay Kaher <akaher@vmware.com>
To:     <gregkh@linuxfoundation.org>
CC:     <torvalds@linux-foundation.org>, <aarcange@redhat.com>,
        <hughd@google.com>, <dave.hansen@intel.com>, <mgorman@suse.de>,
        <riel@redhat.com>, <mhocko@suse.cz>, <jannh@google.com>,
        <linux-kernel@vger.kernel.org>, <stable@kernel.org>,
        <stable@vger.kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <amakhalov@vmware.com>,
        <srinidhir@vmware.com>, <bvikas@vmware.com>, <srostedt@vmware.com>,
        <akaher@vmware.com>
Subject: [PATCH 0/8] Backported fixes for 4.4 stable tree
Date:   Tue, 23 Jul 2019 16:38:23 +0530
Message-ID: <1563880111-19058-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: akaher@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches include few backported fixes for the 4.4 stable
tree.
I would appreciate if you could kindly consider including them in the
next release.

Ajay

---
[PATCH 1/8]:
Backporting of upstream commit f958d7b528b1:
mm: make page ref count overflow check tighter and more explicit

[PATCH 2/8]:
Backporting of upstream commit 88b1a17dfc3e:
mm: add 'try_get_page()' helper function

[PATCH 3/8]:
Backporting of upstream commit 7aef4172c795:
mm: handle PTE-mapped tail pages in gerneric fast gup implementaiton

[PATCH 4/8]:
Backporting of upstream commit a3e328556d41:
mm, gup: remove broken VM_BUG_ON_PAGE compound check for hugepages

[PATCH 5/8]:
Backporting of upstream commit d63206ee32b6:
mm, gup: ensure real head page is ref-counted when using hugepages

[PATCH 6/8]:
Backporting of upstream commit 8fde12ca79af:
mm: prevent get_user_pages() from overflowing page refcount

[PATCH 7/8]:
Backporting of upstream commit 7bf2d1df8082:
pipe: add pipe_buf_get() helper

[PATCH 8/8]:
Backporting of upstream commit 15fab63e1e57:
fs: prevent page refcount overflow in pipe_buf_get

