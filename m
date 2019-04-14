Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1AEC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99D920870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDNH2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:28:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDNH2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D15E43082162;
        Sun, 14 Apr 2019 07:28:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7956F19C56;
        Sun, 14 Apr 2019 07:28:09 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
        hpa@zytor.com, kirill@shutemov.name, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 RESEND 0/2] x86/mm/KASLR: Fix the wrong size of memory sections
Date:   Sun, 14 Apr 2019 15:28:02 +0800
Message-Id: <20190414072804.12560-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 14 Apr 2019 07:28:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend:
  Fine tuning the patch log.

v1->v2:
  Rewrite log of the two patches. No new code change.

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

