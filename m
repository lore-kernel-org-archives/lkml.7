Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F068C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD320835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551705868;
	bh=lxSQhMYcWWm7vcL6/X6YEneZFkJo4m88M0pILD6qYiY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=AJRVMcvReXc3os30duoIUzCDiyOillqP4pTdbyRhxoq5C/z4GwCwRonYTkTpzAuSW
	 gDmWSIXzWx592ncxktyjDWKTNDs7aNCitfmEIDdt7V3VCLmk8dxt6sNsDfSGK60tAT
	 2SEtatWdYA8qlmLkf5l1XitrBofAciGHLo6F2l98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfCDNY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:24:26 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:40598 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCDNY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:24:26 -0500
Received: by mail-oi1-f171.google.com with SMTP id x187so3795215oia.7;
        Mon, 04 Mar 2019 05:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P0qs5mGgDYRKNZ4wgJw1ugL5HNqZYjlo5udlyPeo+8E=;
        b=Xix7p8dFJj0rcHsS8PxH5C3BdGd+GNwErEKZxTirRQUwQkxb856F3mPoVhGQ7mH4Kv
         Zx/CrEZz7fkbFutkuVfiSpKfRp0eaWYHzRDUgE75/aUZv/v/Z8M6ajrP+EDPj8e1LPWU
         1HaeUnlT2rUiQDYM/ojHaox5gNJsOZGLF6vi19P3P3jd0qH/I4nljEo+KMOHlcqK2Gs1
         iFJ2lycJJo6fB5YMR2O8Sm2kKpID+B5PufKOVTbzWVTi1hoI5Xktuss0nrv1jI3CddoB
         hesRp/R/gG1SvOoQMrF0GxnkrnPGZe9z09yqIVg9Jzezx77r/w7nMaF1DG0KTXDNt8yd
         5DTg==
X-Gm-Message-State: AHQUAua9WqjvspaglZoEu7a2YCd/ClNZtoNdbp+j2v/dTec2LwnoDO8P
        y5xLSpiqLCEXBmv+GAdKtoeH/LxrefOe8xMs9b5Gb0l0
X-Google-Smtp-Source: AHgI3IbbOWiMpozHnyFmm5to2iPuEs7+5dag9iUMrZlkCSqpQirEAhRdPHGAldOgw2Iol1dN7RVnpmDtn6jJELHCerQ=
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr12149146oih.76.1551705865211;
 Mon, 04 Mar 2019 05:24:25 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Mar 2019 14:24:14 +0100
Message-ID: <CAJZ5v0jP3p-fnqyVLmA=Saq9MSUdhCuKpkG_NkT+0AKSNU2sOQ@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.1-rc1
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
 devprop-5.1-rc1

with top-most commit 344798206f171c5abea7ab1f9762fa526d7f539d

 software node: Implement get_named_child_node fwnode callback

on top of commit f17b5f06cb92ef2250513a1e154c47b78df07d40

 Linux 5.0-rc4

to receive device properties framework updates for 5.1-rc1.

These fix the length value used in the PROPERTY_ENTRY_STRING()
macro and make software nodes use the get_named_child_node()
fwnode callback (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (2):
      device property: Fix the length used in PROPERTY_ENTRY_STRING()
      software node: Implement get_named_child_node fwnode callback

---------------

 drivers/base/swnode.c    | 23 +++++++++++++++++++++++
 include/linux/property.h |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)
