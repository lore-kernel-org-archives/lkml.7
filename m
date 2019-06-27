Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CAEC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B9F120B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b9smVVLU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfF0PSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:18:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42661 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfF0PSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:18:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RF4C4G329218
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 08:04:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RF4C4G329218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561647854;
        bh=qZDlnFBhlDF/zaT3mrC23ago7pE8TfNPNyvEGaRJ6L8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b9smVVLU5grNPXAseXCt5iqoaiIVLoTz28nBEoGkJzGyI1g8+yI6ZQA6OQIj4FBY5
         Kd/a7DwmOUz9i1O1GObKA8noTizEKVskv1IkkySuKTNf0Vso2sP7ooRk1GOhlfF5rr
         0a1V3Y7kp+U0lot/nsfncNVGGtU7km78cZ8uLaebFBGLkGlMnxVg9PBj77Q70ZC28t
         LHGeXzF9O/UOo7CpaQHTBvuLTbU8UW8WhJbFDXAI/hIaVG6QjlMo2w5+G3wtR2B2Vm
         jvz7Cu1YUV7Eq+k9wLvvebEAOf/lR+SNN918OAR1BXQwMzkeqXFXdyvCpQZJtf6BPL
         FIlZVaOKJTA3w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RF4B1f329214;
        Thu, 27 Jun 2019 08:04:11 -0700
Date:   Thu, 27 Jun 2019 08:04:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Zhenzhong Duan <tipbot@zytor.com>
Message-ID: <tip-d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com, zhenzhong.duan@oracle.com, hpa@zytor.com,
        bp@alien8.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, jan.kiszka@siemens.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          zhenzhong.duan@oracle.com, bp@alien8.de
In-Reply-To: <1561539289-29180-1-git-send-email-zhenzhong.duan@oracle.com>
References: <1561539289-29180-1-git-send-email-zhenzhong.duan@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/jailhouse: Mark jailhouse_x2apic_available()
 as __init
Git-Commit-ID: d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea
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

Commit-ID:  d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea
Gitweb:     https://git.kernel.org/tip/d97ee99bf225d35a50ed8812c3d037b2ba7ad2ea
Author:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
AuthorDate: Wed, 26 Jun 2019 16:54:49 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Jun 2019 16:59:19 +0200

x86/jailhouse: Mark jailhouse_x2apic_available() as __init

.. as it is only called at early bootup stage.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: jailhouse-dev@googlegroups.com
Link: https://lkml.kernel.org/r/1561539289-29180-1-git-send-email-zhenzhong.duan@oracle.com

---
 arch/x86/kernel/jailhouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55a2dfb..d96d56310d51 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -203,7 +203,7 @@ bool jailhouse_paravirt(void)
 	return jailhouse_cpuid_base() != 0;
 }
 
-static bool jailhouse_x2apic_available(void)
+static bool __init jailhouse_x2apic_available(void)
 {
 	/*
 	 * The x2APIC is only available if the root cell enabled it. Jailhouse
