Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C31C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B622173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zgmMXUDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388838AbfGPVYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:24:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbfGPVYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:24:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6GLODJg1232047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Jul 2019 14:24:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6GLODJg1232047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563312253;
        bh=Q3ESaGqqQf6w5cnwnUZQgoBbk6fBK2PtjvWNE+GFdP0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=zgmMXUDNmKD+A/qXgFaYLjtuZJO7wrH1g0YG9DiI7Rrn/ohZog98ZVx9LCuV7c4iC
         GJdQATv8yGClmsNpuZehdlaOGXb5I8G7kJyihu+40TeCHQQ3phMMXqkwW4zWi+AUbk
         bMv2snjIsfXiWsTpvlmC9BtstPePMfpfWdkoc1aQqd/Ppf3tmKar7BYolAVfo46l/N
         tkcJSeMzM3+5CYpgJzRPBD+RRa9V9fqwm3+iZK3nTsEGa/Cdsay8RuWuj9n3yNvJ+i
         d15cnGIkMpUepm/QPBKhpl5qUVHF6Robh5sil3PH+A2aBH0EGjGGOKDKc5t0zNQ3W0
         gZkoMRZMNcooQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6GLOCOS1232044;
        Tue, 16 Jul 2019 14:24:12 -0700
Date:   Tue, 16 Jul 2019 14:24:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Hellstrom <tipbot@zytor.com>
Message-ID: <tip-907cb11da7a725445dccc6c2ca2d428739f6cd71@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        akataria@vmware.com, linux-kernel@vger.kernel.org,
        thellstrom@vmware.com, jgross@suse.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          thellstrom@vmware.com, jgross@suse.com, akataria@vmware.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190328120558.29897-1-thellstrom@vmware.com>
References: <20190328120558.29897-1-thellstrom@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
Git-Commit-ID: 907cb11da7a725445dccc6c2ca2d428739f6cd71
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

Commit-ID:  907cb11da7a725445dccc6c2ca2d428739f6cd71
Gitweb:     https://git.kernel.org/tip/907cb11da7a725445dccc6c2ca2d428739f6cd71
Author:     Thomas Hellstrom <thellstrom@vmware.com>
AuthorDate: Thu, 28 Mar 2019 12:06:37 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 16 Jul 2019 23:13:50 +0200

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
