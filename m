Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64ECC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CE82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575405435;
	bh=OCSI2LzloDpnctHPnYG4kiEWVi+4HK516dI/r+4tQ/w=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r/tisZi34SibufKbH1VdnyB/BBvNq5aBDLU+5kWaywuptTi8fE5OLLY1zcdhKZPlB
	 bawy4FFuFLde9FDt8XOwjlb9cSqAbd2QjAr+zOH785VUB0hgztLxzKZfQnrxM8qmgd
	 gsF64tEdmFpzIVzvvo3molUcNXb0XgU1HhnPuR7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLCUhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfLCUhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:37:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F97C20803;
        Tue,  3 Dec 2019 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575405433;
        bh=OCSI2LzloDpnctHPnYG4kiEWVi+4HK516dI/r+4tQ/w=;
        h=Date:From:To:Cc:Subject:From;
        b=0D+FSGM8Fj1Anu4XRWyly3UQWRO6Zbz30rs1hzGH3G5iig9MYIiKwsDoQJQQSiZiE
         rAfx2o7afWyy3VaEOqIRG3I/fJcz39gBpM1at1f/yLTiEUHA7JQGrMif7EnuvXX9tF
         lVwvdY4z9E39Xe9sNTfmm7M1G7rIBRJkI+A4C8To=
Date:   Tue, 3 Dec 2019 21:37:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX fix for 5.5-rc1
Message-ID: <20191203203711.GA3189820@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.5-rc1

for you to fetch changes up to bf49d9dd6fef688733e2ddbd55f7bcb57df194e4:

  export,module: add SPDX GPL-2.0 license identifier to headers with no license (2019-11-14 11:36:53 +0800)

----------------------------------------------------------------
SPDX fix for 5.5-rc1

Here is a single SPDX fixup for 5.5-rc1

It resolves an issue where we had missed a few .h files with the
auto-tagging scripts because they had "GPL" text in strings within the
file themselves.  This single patch fixes up the issue and provides the
proper SPDX tags at the top of them as needed.

This patch has been in linux-next for many many weeks now with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Masahiro Yamada (1):
      export,module: add SPDX GPL-2.0 license identifier to headers with no license

 include/asm-generic/export.h | 1 +
 include/linux/export.h       | 1 +
 include/linux/license.h      | 1 +
 include/linux/module.h       | 7 +++++--
 4 files changed, 8 insertions(+), 2 deletions(-)
