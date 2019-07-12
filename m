Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D3EC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33EC2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGLRVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:21:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:57916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfGLRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:21:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 519E2AF51;
        Fri, 12 Jul 2019 17:21:11 +0000 (UTC)
From:   Petr Tesarik <ptesarik@suse.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add uncompressed Linux banner to s390 bzImage
Date:   Fri, 12 Jul 2019 19:20:59 +0200
Message-Id: <cover.1562950641.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches make it easy to determine the kernel version from a
compressed binary by scanning for the Linux banner string in the
uncompressed portion of bzImage.

Petr Tesarik (2):
  init: Separate banner from init_uts_ns
  s390: add Linux banner to the compressed image

 arch/s390/boot/compressed/Makefile |  1 +
 init/Makefile                      |  2 +-
 init/banner.c                      | 21 +++++++++++++++++++++
 init/version.c                     | 10 ----------
 4 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 init/banner.c

-- 
2.16.4

