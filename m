Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70578C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB1E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552563387;
	bh=RhBDmULxg0FqS6EKgwcA30H3qMldyfYd0dwGjMkVVms=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=YKsY1txrfnmPNYVc1WR2oB3sVIQRztdhY/1iBN7Mi/gX7nuE4UOgQ4JQQlN4pYfNc
	 DvBHslbR2t1ReMYftfgkgfDOQSSWcek+RTS7m1JZzrlKS7AIqX0OWg7XxoEIgR/Al5
	 KLfzuaRS6V4zIji8LFEaC9ndqRWw/93Wq6pmmeUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfCNLg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:36:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45288 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCNLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:36:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12so4747925otp.12;
        Thu, 14 Mar 2019 04:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fgCGmqFZdANvDCQ7uBSCD0Xuo2RL0pStbPTNkwYqJ6A=;
        b=Hj+bl6HHXaiGqH3p/vH7N3KQezSe+ilZOTWTYLCBBJDOKp47uuq23q0C9sl5Lr+2Hl
         rXFspMECp9dIqByesMRx0vHf/mfeKbdRVKpAI7InlIo0n8gkUY9bxXzBMCwD/2padDW0
         Y81y+6XQOB2IBsEge07Egbim/J8aJv6CQ5Zg7sYrKjNXomugSuji1ycERN0TT3fXBuT6
         8rAzP/qr3o+oRTxRM0fMw4xtvuDUTz4JAGdXw6Up73CAMY75UdZerS498NkM+kHqzLn/
         OHrE68zLy0hATkbR231sLFF6xVZIyMS3FZsq+uDThojJDhGJJ/BrAYz4+a/TN2+HJ5j8
         TmQg==
X-Gm-Message-State: APjAAAVKMNyUzE2Og1QwwmNrTwEyvNCCRvIqYDZSLIArIimqgkcLq/Xp
        tsvcZ6pAFlKf2oUDDo7dKuPJKFuie41xUbWIq0wwNVew
X-Google-Smtp-Source: APXvYqweZYP2OWIjfwWGVTlWSITRNtsTMT5ju6wJ554Qxh0MWYW7WJSSk1lTzVEgTpv7bFvwhg8n4fEzRj+4beC9ifk=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr29171544otf.124.1552563384123;
 Thu, 14 Mar 2019 04:36:24 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 12:36:13 +0100
Message-ID: <CAJZ5v0iLKAVM0Ftv8LhS0cS=XPHXRx7sCMMtRJ9PLymGhgh4uQ@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.1-rc1-2

with top-most commit b6e88119f1edcdc1fa3fd3a168310ac2d433a873

 Merge branches 'acpi-tables', 'acpi-debug', 'acpi-doc' and 'acpi-misc'

on top of commit d276709ce6c90b9eceecdbd01a0c083ab04d3a52

 Merge tag 'acpi-5.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.1-rc1.

These fix a couple of issues and do some cleanups on top of the
previous ACPI changes for 5.1-rc1.

Specifics:

 - Fix a crash caused by unloading an SSDT overlay (Andy Shevchenko).

 - Prevent user space from getting confusing error values on failing
   ACPI sysfs accesses (Rafael Wysocki).

 - Simplify leaf node detection in the PPTT parsing code by using a
   new flag defined in ACPI 6.3 (Jeremy Linton).

 - Add missing "static" in some places in the ACPI configfs code
   (Andy Shevchenko).

 - Fix acpidbg tool path in the ACPI documentation (Flavio Suligoi).

Thanks!


---------------

Andy Shevchenko (3):
      ACPI / configfs: Mark local functions static
      ACPI / configfs: Mark local data structures static
      ACPI / device_sysfs: Avoid OF modalias creation for removed device

Flavio Suligoi (1):
      ACPI: Documentation: Fix path for acpidbg tool

Jeremy Linton (1):
      ACPI: tables: Simplify PPTT leaf node detection

Rafael J. Wysocki (1):
      ACPI: sysfs: Prevent get_status() from returning acpi_status

---------------

 Documentation/acpi/aml-debugger.txt |  4 ++--
 drivers/acpi/acpi_configfs.c        | 25 +++++++++++++------------
 drivers/acpi/device_sysfs.c         |  6 +++++-
 drivers/acpi/pptt.c                 |  3 +++
 drivers/acpi/sysfs.c                | 21 ++++++++++++---------
 5 files changed, 35 insertions(+), 24 deletions(-)
