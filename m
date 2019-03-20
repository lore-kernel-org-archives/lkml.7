Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C082146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="URzV/Rxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfCTIGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:06:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52672 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfCTIGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:06:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44PMvK3hZcz9v0sG;
        Wed, 20 Mar 2019 09:06:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=URzV/Rxa; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7osTP4gvoruF; Wed, 20 Mar 2019 09:06:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44PMvK2YBzz9v0sF;
        Wed, 20 Mar 2019 09:06:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1553069197; bh=qnnGg1Y54Lzp4P9+gj+fIZn03za/PcqnmOetVqUvDB8=;
        h=From:Subject:To:Cc:Date:From;
        b=URzV/RxaGrGa+SAz96KVBFxP17rBs3T+7mJOTDq9deLR/mEN4PqKGiP2cGF8uYXuf
         68b33Ae7DAJggT5Kl/YuZtSL34UfqSuhdHBygF4lhzoc6KxwM4oIWspvIzyaDXmR0C
         buZnWmem/Fb24b+3tXq7x+LFEIil/xJ8/r5bCMQQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FD248B8FD;
        Wed, 20 Mar 2019 09:06:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xDmkBSPnEuHo; Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16AA48B8F8;
        Wed, 20 Mar 2019 09:06:38 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id ACB7863AF9; Wed, 20 Mar 2019 08:06:37 +0000 (UTC)
Message-Id: <67ed3a31a16b9ece870ec55139e83c86d4d9ce60.1553069097.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc/32s: drop Hash_end
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 08:06:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash_end has never been used, drop it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/mmu_decl.h   | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 74ff61dabcb1..f7f1374ba3ee 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -104,7 +104,7 @@ extern int __map_without_bats;
 extern unsigned int rtas_data, rtas_size;
 
 struct hash_pte;
-extern struct hash_pte *Hash, *Hash_end;
+extern struct hash_pte *Hash;
 extern unsigned long Hash_size, Hash_mask;
 
 #endif /* CONFIG_PPC32 */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index f29d2f118b44..302409fcfbc7 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -36,7 +36,7 @@
 
 #include "mmu_decl.h"
 
-struct hash_pte *Hash, *Hash_end;
+struct hash_pte *Hash;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
@@ -345,8 +345,6 @@ void __init MMU_init_hw(void)
 		      __func__, Hash_size, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
-
 	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
 	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
-- 
2.13.3

