Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F040C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40C920857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfDHV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:28:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:33649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfDHV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:28:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N6Kl7-1gp0TL0O2T-016jYr; Mon, 08 Apr 2019 23:28:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] s390: cio: fix cio_irb declaration
Date:   Mon,  8 Apr 2019 23:26:20 +0200
Message-Id: <20190408212648.2407234-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ha6PNgK0PYpqwPhlNU5XWyfhsmbCXU4naSHTKfBYwheY6UWeYAT
 r+vInJvVpAWCMC4Tp4cuBYykXoLxXiWEgJ8tTEOUTfbCxA2PbaRJxriXiZSirRyZHzXZDOl
 WUTkzwc/NdsdtVOV0ALHzQqV42zFSNjNJL8sEGzz6HfMy1Wqpbrc013M+rL8aCAMdro4nuE
 3w3wjFfHMYViSa9JpLVIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ggJ9BSGwLmo=:aEmq0SVEfr/yQYnHXxiXHi
 DWaBMfkP0YN8Y/XH3dqZMG0wG/ZLxgDICXH81SkxxRvxUSsyyAdc2WUH1QuyGDlvpU8wg2MVq
 D6/SpnuWOqjHKbNBM0rPe2gSx3n8m3Hcc9R5E1zb/ZDEjkZxDtvfqEtfQJV/54zf1cKX3yK4J
 dNnp759ZBKcsFoEXheOnT960pUQJcRvmM4Kk19xSQ9Va0HEsJf82pCgpKhS+xlFwQwBk/ksY1
 Ehs/JsQbbOVdGJiPKrm3jZ+gu/6ff015MD2fDF4NUAH+IHkVE6DIojwoJkI5YfV4/01OMvpM5
 OLum7Lz1j3xkEywUJI31jo9/iVAoGEOeV4iPmhbhLAMHK70Fc3oVSE1mRsdM03l1i+6VWXlt3
 m2g8aO5/RiCz8ScQnNUJE3sjBEEv+elj2lK2q0JP+79DbbnJE7NG5efOY1ygzzViEsPGnc9TM
 Yc4V5LcxGYEK00R3XLYwoYd1Di9/GuEdbbp2r5nlYVHCunnQ6PhEX+pmpve8DL6lrwZPlzPgB
 3Q+cU5k0Io4pjFZZ96npDafp08hGaKbBcmc0LJTK87jBqBWl4SAPiu+2d4MRqcoFeDDpGOdf0
 BhIMDm79LwEgbfgFrFX6keHgNf7cmYmATMTMFKerC7zRvA3mV38/ZRb+RLWtx8zmn1B/tV23W
 /20EeBSzIgxwoWsr4TOUqxTesn8Nw6zDPoVtT+g6a6Zq278r2dqQYjRiozxz1COvPLpbJvA0m
 1c7saP9TW+2sFH3QlE4ADPeSn4APUMUWFbHz3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that the declaration of cio_irb does not match the
definition exactly, it is missing the alignment attribute:

../drivers/s390/cio/cio.c:50:1: warning: section does not match previous declaration [-Wsection]
DEFINE_PER_CPU_ALIGNED(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:150:2: note: expanded from macro 'DEFINE_PER_CPU_ALIGNED'
        DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)     \
        ^
../include/linux/percpu-defs.h:93:9: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
../drivers/s390/cio/cio.h:118:1: note: previous attribute is here
DECLARE_PER_CPU(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:111:2: note: expanded from macro 'DECLARE_PER_CPU'
        DECLARE_PER_CPU_SECTION(type, name, "")
        ^
../include/linux/percpu-defs.h:87:9: note: expanded from macro 'DECLARE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
Use DECLARE_PER_CPU_ALIGNED() here, to make the two match.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/cio/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 9811fd8a0c73..92eabbb5f18d 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -115,7 +115,7 @@ struct subchannel {
 	struct schib_config config;
 } __attribute__ ((aligned(8)));
 
-DECLARE_PER_CPU(struct irb, cio_irb);
+DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
 
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
-- 
2.20.0

