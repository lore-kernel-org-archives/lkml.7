Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE349CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8A72087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 21:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572556151;
	bh=NrGgjyhNy2XdFzwav441l2E0+4ygqgCiThCMrn4g7pY=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=uzrCZ9DILybzJr7tJ3NTohUQUnWQxonXWSrCkmDNpPX4fjNiFbHSeerZ+aD/nGV+t
	 A3K3cPvhV1GU8Phg3dbPPSzsGuMDBGowlEOlCplYJBcMtjbcJxvRDbNXWpmQCsWBGa
	 L9gcKfaeiLBiVTfxVm6yIHAZo8lsAXed9f8dl4ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfJaVJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 17:09:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37718 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfJaVJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:09:10 -0400
Received: by mail-oi1-f193.google.com with SMTP id y194so6478808oie.4;
        Thu, 31 Oct 2019 14:09:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OeM65qzQlCMGxnDQEqx3A4bb6MsrgL6yvE3aZD4ZDCc=;
        b=dW7g2eBJDkHplEhCqrlvwA10d1mKm313R/35IGodio88xbo1iniv7xtZcPT4XfrHD6
         RMWQezkqA06dZtSdSOly/oKJyxnoa/uvZjRfhhWr4zK6Hu+rNMCsAqOF+v0Q4wH61O1l
         5xUxwnrbbS+ZNikQ65HgPPq2aRc+J5MZtvf1pyqVC8PA/lc4gZWTQvoYAed/G/rDhb+m
         fbtL+eE/+9jgw23a1HCATAr2TOlUo0A5IB4PNib70GC+AWypVAhkfovuxi7hPwKymmfp
         fDkgew/H0Sexn+QElnhkNXpVngRpFonXENWzRN1qA6TzC3TZlO1DBeibIJvhKaAKaXV2
         1hrA==
X-Gm-Message-State: APjAAAXrsRTt987EbwpCqChI10yfM5Jliaa3qsqw23Ir9fE7D+X/ryCe
        6y3iGgOCG8ylntzseuHUWmprR+ui8ewi+xPJBWcj6ULhXNE=
X-Google-Smtp-Source: APXvYqzGQWTo4sfQ84u/7FyPH4asPCHM/cbRLhyZmcDAqE9JZ1pjBLbCtms4+t5vPsqQgLdGcvF6jWb6sdv5e3gblCc=
X-Received: by 2002:a05:6808:84:: with SMTP id s4mr2371555oic.115.1572556149657;
 Thu, 31 Oct 2019 14:09:09 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 31 Oct 2019 22:08:58 +0100
Message-ID: <CAJZ5v0gSz1Pk=7u0s-cgjc9_0ibCyA6RNCcVHw7+GLWWoCj22g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.4-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.4-rc6

with top-most commit e82b7457909afd2e973ebd251ad79945d04ca376

 Merge branch 'pm-cpufreq'

on top of commit 767d2d710e9066c47919a4e5f05a21e1ad40ddc4

 Merge branches 'pm-cpuidle' and 'pm-opp'

to receive a power management fix for 5.4-rc6.

This fixes a recently introduced (mostly theoretical) issue that the
requests to confine the maximum CPU frequency coming from the platform
firmware may not be taken into account if multiple CPUs are covered
by one cpufreq policy on a system with ACPI.

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: processor: Add QoS requests for all CPUs

---------------

 drivers/acpi/processor_perflib.c | 34 +++++++++++++++++++++-------------
 drivers/acpi/processor_thermal.c | 34 +++++++++++++++++++++-------------
 2 files changed, 42 insertions(+), 26 deletions(-)
