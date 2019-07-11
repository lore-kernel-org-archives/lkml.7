Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C6C74A54
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3A82084B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562848854;
	bh=fBvTdE9EJZ85xLYjGQdJYlwP6IuerljHtOrpJo0l+QY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=UJHYwZ0us9aHm1BYAO47IXpyaOso30JpMTxR15qy83ML+KYovKXOGxzd0Pl2aGRcW
	 MddMHsFq1NWZiaf/sS+RPCaiCAzypyRJtDVmxftA4Fx/4FWmIjCghI7HelhoSymX+U
	 LyEK808pJsJIQWBAIg2QwMrbTRPYPxZGA5APhgYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfGKMkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:40:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46475 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfGKMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:40:52 -0400
Received: by mail-oi1-f193.google.com with SMTP id 65so4328167oid.13;
        Thu, 11 Jul 2019 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3r8RKtycl9G1tLYjoZAbYjqh6Yg25nxXvfCqJ3/8bm0=;
        b=UnQ6KemIIrDWirK13JLkFFJW7RTFYVWlfJLcokSiENLRkXePvuO453C6qzufciu12M
         1Xg1Fd6RMOanTMVGX01HV3UgSjdrbavBW+U/xubbVIdpEra3dq9EoX1zQZoXm3W+J/S4
         mToIMDROmBmnoY/GHkjCejVzo+bU7FxImjFoCIqvtwHnfy641PAzKmb7+e/dVZcXmeQK
         H7I70prvnpm404LJbVyABGydhNFPFdbIZ+N9KInPpDVNuzZJ69U2OiX+5PnfdseWP0zD
         SePkLH2HAb2igkOHvcCzP0ckw6GOnz/Gjip0+NuLIfOqBZO8iEP3iGt8/IvTkmmp7a97
         YnqA==
X-Gm-Message-State: APjAAAULcuWWQxuez7I1ix2EzuxHyRaORE5Bq6dCtovArooSpnG7NS0s
        beXwBLpQsfgqwEYCwvhNmYCHvHahAnm/II9Mu9z5bSW1
X-Google-Smtp-Source: APXvYqxT5dZUSbX1DZlSvKZsT9GBLXHmwUGOqKziTTCbEXunvEyJyGkiwy3m6EKspZmwSnuVmxRaMeJCn6FYxcv+vr8=
X-Received: by 2002:aca:cdd3:: with SMTP id d202mr2006883oig.115.1562848851832;
 Thu, 11 Jul 2019 05:40:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 Jul 2019 14:40:40 +0200
Message-ID: <CAJZ5v0jTMK6rMomux6JfmRX_nRxZ+JqA_V8WKt-UJTGus6TfOQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.3-rc1-2

with top-most commit 6cf7fb5a95dec9743f4bfd96f9ece580a355cdd1

 Revert "ACPICA: Update table load object initialization"

on top of commit 4b4704520d97b74e045154fc3b844b73ae4e7ebd

 Merge tag 'acpi-5.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an ACPI fix for 5.3-rc1.

This reverts a recent ACPICA commit causing systems to hang
at boot time.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPICA: Update table load object initialization"

---------------

 drivers/acpi/acpica/exconfig.c | 16 ++++++++++------
 drivers/acpi/acpica/tbxfload.c | 10 +++++++---
 2 files changed, 17 insertions(+), 9 deletions(-)
