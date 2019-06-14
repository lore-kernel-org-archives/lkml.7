Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF6C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34A520850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aWlR3zO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfFNSfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:35:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42725 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFNSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:35:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5EIYDNv1824587
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 14 Jun 2019 11:34:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5EIYDNv1824587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560537253;
        bh=yGiKhNX1RjtAXOm5lrgRmCl8j6VAknBhL7hBHLLqAt8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aWlR3zO92kNCJ9n+QZ8Q10ZELpmq99A4BrikPU8CSBjr7LSuDGm0MLl/WFJCYpPsY
         6YZJWNj+9F8VbQb+eer3zP/jwdxgcA5c3fuL4fkCzn1FmKQ42bB/8GxNajCciSJPsF
         68nPFWOBEH+0H73pYwJQYp7HdSaf/6jwF8uMA0IGu7HR1H2B6JTWgP++S1V+3sLaCb
         fddgw0zNBg5n3unP6xwlnKW/za9vv/FwsmDZ6o8saB6OGmpEB464+NWpJMsFvtLfi3
         15tmoPF65uZljXEdV+EalHkmYkD1GwLeYXEFeMXsaPW7rB1Hqu748DGG0C1bHmzajv
         00yQdkNraDegg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5EIYB1X1824581;
        Fri, 14 Jun 2019 11:34:11 -0700
Date:   Fri, 14 Jun 2019 11:34:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-025e32048f39e24d8ddf9369d679644ea2bdcce6@git.kernel.org>
Cc:     hulkci@huawei.com, Brian.Woods@amd.com, puwen@hygon.cn,
        x86@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, linux@roeck-us.net, bhelgaas@google.com,
        mingo@kernel.org, bp@suse.de, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org
Reply-To: bhelgaas@google.com, linux@roeck-us.net, mingo@kernel.org,
          bp@suse.de, linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
          hulkci@huawei.com, Brian.Woods@amd.com, x86@kernel.org,
          puwen@hygon.cn, mingo@redhat.com, tglx@linutronix.de,
          hpa@zytor.com
In-Reply-To: <20190614155441.22076-1-yuehaibing@huawei.com>
References: <20190614155441.22076-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/amd_nb: Make hygon_nb_misc_ids static
Git-Commit-ID: 025e32048f39e24d8ddf9369d679644ea2bdcce6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  025e32048f39e24d8ddf9369d679644ea2bdcce6
Gitweb:     https://git.kernel.org/tip/025e32048f39e24d8ddf9369d679644ea2bdcce6
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Fri, 14 Jun 2019 23:54:41 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 14 Jun 2019 20:25:58 +0200

x86/amd_nb: Make hygon_nb_misc_ids static

Fix the following sparse warning:

  arch/x86/kernel/amd_nb.c:74:28: warning:
    symbol 'hygon_nb_misc_ids' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Brian Woods <Brian.Woods@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190614155441.22076-1-yuehaibing@huawei.com
---
 arch/x86/kernel/amd_nb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cc51275c8759..922e8fd5426f 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -71,7 +71,7 @@ static const struct pci_device_id hygon_root_ids[] = {
 	{}
 };
 
-const struct pci_device_id hygon_nb_misc_ids[] = {
+static const struct pci_device_id hygon_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
