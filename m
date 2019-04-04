Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E087C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4748520820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfDDCD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:03:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDCDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:03:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32C52F74B2;
        Thu,  4 Apr 2019 02:03:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC5D48642E;
        Thu,  4 Apr 2019 02:03:19 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        yamada.masahiro@socionext.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, thgarnie@google.com,
        mike.travis@hpe.com, frank.ramsay@hpe.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/2] x86/mm/KASLR: Fix two code bugs
Date:   Thu,  4 Apr 2019 10:03:12 +0800
Message-Id: <20190404020314.8162-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 04 Apr 2019 02:03:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixes for these two bugs were carried in the earlier patchset, patch
4/6 and patch 5/6:

[PATCH v4 0/6] Several patches to fix code bugs, improve documents and clean up
http://lkml.kernel.org/r/20190314094645.4883-1-bhe@redhat.com

Later, Thomas suggested posting bug fixing patches separately from those
clean up patches. So send both of them in a separate patchset. 

For another bug fix patch 6/6, it happened on SGI UV system. We need a
specific SGI UV machine to reproduce and verify it, still discussing
with Mike and Frank from HPE SGI about arranging a machine to test. That
machine is very rare, still waiting. So defer that bug fix reposting
later.

Baoquan He (2):
  x86/mm/KASLR: Fix the wrong calculation of memory region initial size
  x86/mm/KASLR: Calculate the actual size of vmemmap region

 arch/x86/mm/kaslr.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.17.2

