Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC37BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF4B20818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555056700;
	bh=f6LNNY1sP63m2YWoANx0b9cAojzOKzrFAB7+nliWhuU=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=08rtZoP0/j4WUv6/hwbboAMZujZeJhHZDRTRk09DLAhG/QlgQFaerD6pRx8dPOb83
	 syIWzM2MCWNAjqbDo1v9NOENGT1elLyKTstv5qPs/WvlA6adad/pYJ9u7TEy7AeEFY
	 3jzww6Jn4p6YY07mR4yUQV0iseL9ogtNRdBgbzb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDLILj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:11:39 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46635 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDLILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:11:39 -0400
Received: by mail-oi1-f195.google.com with SMTP id x188so7220889oia.13;
        Fri, 12 Apr 2019 01:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=B2IpjxM0aHzY+BVWhPSCyxpoJj0L1vnQLxYTiu6TxCs=;
        b=lDcSDVIk4T2bVb+9ePDwNX+tJY+a59P04GYT70jPzjjuZE0wrAF9ueZGSXRKEtRC+T
         XH5gegFI7u5BjIdYYMctziQ6giSREX1bdn3Eds9Wa5F+9bW6VCzcKVFd8z50PcX7API0
         iSkRxf4eqURK1a/9aTSMn7PI3nGQ/1HbByXOZB5yilkaw0ylvu7kw0HLm5BLhjbt31ST
         aKTUIitdZr+tPQYG8iQQcd3fj3COXcM5Atu9reElpfR2sDV6lIgXVc0XM5ct5fz3IETN
         ebV/rbFPu6Rfwq0B+Y7nPlCm7tezG0GPdrwR3pOe6l2a62rng3ty2w0qrm47RS5cBqEf
         DNSQ==
X-Gm-Message-State: APjAAAWspNLIRp470tNZngXFp7EOomZKLFryEjfL+HT2AskehJUnreOY
        RB0zTMp8ymngpzS7kI/rmo0Y9kiPL4KgKFqp+rWyUNbi
X-Google-Smtp-Source: APXvYqyRYORwJW6QFGk0f+pfk4tTnKz+gNdusOG1/sIxLp+Y59bqHv0rg7SioxcChLVB9Za0KTrV894wbsxNI9PZGYk=
X-Received: by 2002:aca:6289:: with SMTP id w131mr9223111oib.84.1555056698489;
 Fri, 12 Apr 2019 01:11:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Apr 2019 10:11:27 +0200
Message-ID: <CAJZ5v0jfyUSTRs909hsPhDSEt__MGPKC+1UBsG8oieWE07nn5A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.1-rc5
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
 acpi-5.1-rc5

with top-most commit c5781ffbbd4f742a58263458145fe7f0ac01d9e0

 ACPICA: Namespace: remove address node from global list after method
termination

on top of commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d

 Linux 5.1-rc4

to receive an ACPI fix for 5.1-rc5.

This fixes an ACPICA issue introduced during the 4.20 development cycle
and causing some systems to crash because of leftover operation region
data still maintained after the operation region in question has gone
away (Erik Schmauss).

Thanks!


---------------

Erik Schmauss (1):
      ACPICA: Namespace: remove address node from global list after
method termination

---------------

 drivers/acpi/acpica/nsobject.c | 4 ++++
 1 file changed, 4 insertions(+)
