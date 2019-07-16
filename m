Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C1C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8FA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 22:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KsCC8CGA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfGPWrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:47:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfGPWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 18:47:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GMlSK01257651
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 15:47:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GMlSK01257651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563317248;
        bh=Akjcf1QiixNG4db3ljJQs2nNpazQWd07xt3BvmTKQK8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KsCC8CGAB7Z2WDYMTM5mX4P08dMfpqsnBm5+VThzVVCgwsTyf3JHy2UVsnylKcVYu
         1qBC2DsljH6UDVwrpnE+miG1hYJ55JLuknz3j2+MqlSBJCzGlxH7Wp9Eyo9qxQdyAZ
         thmDvnbLxhiQNEwSteOzGGDtnxnXWGjl2SKF0tcpz5UCJEYLvXDgQnv3VOPqGYkqhd
         rF1aX5PAixBRTSPB3vmtyidMeD6FZoC271Wxo3pRFNQS8RPjlBIIYJkHoyCEdJyatO
         whbEIu/lbiy/sQZBEM3ms3cWPHSP6n5UWLw5X6sb7UVuRAvgujU8u8sY2PdZD3ACbA
         DPF4h3W59ulAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GMlRah1257648;
        Tue, 16 Jul 2019 15:47:27 -0700
Date:   Tue, 16 Jul 2019 15:47:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Hellstrom <tipbot@zytor.com>
Message-ID: <tip-406de552c2be6ded524c75d14a73cf7f027f587e@git.kernel.org>
Cc:     thellstrom@vmware.com, linux-kernel@vger.kernel.org,
        akataria@vmware.com, mingo@kernel.org, jgross@suse.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: thellstrom@vmware.com, linux-kernel@vger.kernel.org,
          akataria@vmware.com, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, jgross@suse.com
In-Reply-To: <20190328120558.29897-1-thellstrom@vmware.com>
References: <20190328120558.29897-1-thellstrom@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
Git-Commit-ID: 406de552c2be6ded524c75d14a73cf7f027f587e
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

Commit-ID:  406de552c2be6ded524c75d14a73cf7f027f587e
Gitweb:     https://git.kernel.org/tip/406de552c2be6ded524c75d14a73cf7f027f587e
Author:     Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate: Thu, 28 Mar 2019 12:06:37 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 00:42:27 +0200

MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and VMWARE_HYPERVISOR_INTERFACE

Alok Kataria will be handing over VMware's maintainership of these
interfaces to Thomas Hellström, with pv-drivers as backup contact.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alok Kataria <akataria@vmware.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20190328120558.29897-1-thellstrom@vmware.com

---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5533d1bda2e..80fa7a4a0b56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12074,7 +12074,8 @@ F:	Documentation/parport*.txt
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Alok Kataria <akataria@vmware.com>
+M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	Documentation/virtual/paravirt_ops.txt
@@ -17087,7 +17088,8 @@ S:	Maintained
 F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
-M:	Alok Kataria <akataria@vmware.com>
+M:	Thomas Hellstrom <thellstrom@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
 L:	virtualization@lists.linux-foundation.org
 S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
