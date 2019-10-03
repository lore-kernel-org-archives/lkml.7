Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D0B21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfJCO4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:56:12 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:10782 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbfJCO4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:56:12 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id C771AA2155;
        Thu,  3 Oct 2019 16:56:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 4j0O3i7iw2cz; Thu,  3 Oct 2019 16:56:05 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/3] document openat2(2) patch series
Date:   Fri,  4 Oct 2019 00:55:38 +1000
Message-Id: <20191003145542.17490-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first draft of the man-page changes for the openat2(2) patch
series I'm working on[1]. It includes information about the magic-link
changes as well as the primary new features (O_EMPTYPATH and openat2).

Let me know what you think. I might go into too much detail about how
extension of openat2(2) will work -- let me know if that section should
be dropped (while it is useful for userspace to understand, it isn't
really that necessary to explain exactly what the semantics are -- it
will usually just transparently work).

[1]: https://lore.kernel.org/lkml/20190930183316.10190-1-cyphar@cyphar.com/

Aleksa Sarai (3):
  symlink.7: document magic-links more completely
  open.2: add O_EMPTYPATH documentation
  openat2.2: document new openat2(2) syscall

 man2/open.2            |  47 ++++-
 man2/openat2.2         | 381 +++++++++++++++++++++++++++++++++++++++++
 man7/path_resolution.7 |  89 ++++++++--
 man7/symlink.7         |  39 ++++-
 4 files changed, 528 insertions(+), 28 deletions(-)
 create mode 100644 man2/openat2.2

-- 
2.23.0

