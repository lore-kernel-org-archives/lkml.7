Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4232171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDLGz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfDLGzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C01530832DC;
        Fri, 12 Apr 2019 06:55:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-172.pek2.redhat.com [10.72.12.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA1A760C97;
        Fri, 12 Apr 2019 06:55:47 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] x86/mm/KASLR: Fix the wrong size of memory sections
Date:   Fri, 12 Apr 2019 14:55:40 +0800
Message-Id: <20190412065542.18431-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 12 Apr 2019 06:55:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
  Rewrite log of the two patches. No functionality change.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
v1 background:
The fixes for these two bugs were carried in the earlier patchset, patch
4/6 and patch 5/6:

[PATCH v4 0/6] Several patches to fix code bugs, improve documents and clean up
http://lkml.kernel.org/r/20190314094645.4883-1-bhe@redhat.com

Later, Thomas suggested posting bug fixing patches separately from those
clean up patches. So send both of them in a separate patchset.

For another bug fix patch 6/6, it happened on SGI UV system. Mike and
Frank have sent a machine with cards to our lab and loaned to me, I am
still debugging and discussing with Mike about the verification.

Baoquan He (2):
  x86/mm/KASLR: Fix the size of the direct mapping section
  x86/mm/KASLR: Fix the size of vmemmap section

 arch/x86/mm/kaslr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.2

