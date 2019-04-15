Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF8120651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfDOIgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:36:45 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfDOIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:36:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFKX3-1h5Hzu1RFp-00Fifa; Mon, 15 Apr 2019 10:36:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Philipp Rudo <prudo@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] s390: drop CONFIG_VIRT_TO_BUS
Date:   Mon, 15 Apr 2019 10:35:53 +0200
Message-Id: <20190415083605.2560074-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415083605.2560074-1-arnd@arndb.de>
References: <20190415083605.2560074-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RpXOI9r4llgr/CwD9D8tACloN8YtHezuuKyt2D/etozZiiNP4Hz
 JtiNMMEJA+N+rGv1SFVaYJzX3+ecJBY6sPib8s5hF7p0UcOJuD7+SvEWQMPiYWeq/NCK00y
 HFCR9ohWaQzUgBTF9BQwTpUuOQjSZKHmmywk0gfN088aoJYderI9Cv33hd2g/FqPaAnm/5N
 E1TsYcBLEYVwZuaTGzi1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jGQh2FY4J0k=:gNuT3QiEPnZXHglvsHk17d
 4RwdbUienEQUj9+e7JI+QL16eWsF830eAUb1zun6snzijN8pY9RoutgUxGJU/4MYQNM9K2MJT
 y3h+Qanu8hnq5PMgeLfmaxnVvT6Chp/UZMt+Zasl5VDeYFXeWf7IweUa7aiqzOS9b4tZMPHDr
 VfvXsgjtCdEk+EDp8BHYgaU9Oi3ixLaB/oEsc/2vTjADLtlDj3qjLWlJ9ik0hh7+FDqFTvcJF
 aDhSJvyxkOMjQW7oUTH5SWxXlEpaquAtUVrIeOAZo2POY3qEiyePC+2o/UEMLHM3cvIGZ/RIO
 n5J499S26a1KOOwzRIDageVhhjKnUiBTkOstWSg+4r7fO3K62gacwJUjOkEDUpysBOOi6DKFT
 AkdZH+BQY0DDYGc4iwc/xG+oImHhXyA3Nn8dbpFjhKxrcJE6bezbQJDJD27+OA7iXUpJEX39r
 U5Bn9g3uJ3fYM1xo69DjXfPJkiCkm2RUUDzBTdQNd/FFCWV80ly7/15tPXEaYNR1nxz0nMQ0J
 9E0ke4lexNyspzrmwGeiRIh7OoJdWO4+dBRNKze7HKyylYWtNz/kXwOWoSnPrg1OyTSu40crS
 z9Y9i+wfcb+BUwN4C4FDEmvmvVarxXWudcDOuhjP9ml/YQUxVfpQONq/FKdUDQ8Q65VZpUcX3
 3PzRpF8KKJZCMWP2HzBQ3V4SwGA11shKJ+ZbBDsdtN2xzpTRR0lke8a0yreZXYvENVTL8PVCD
 rd21kpuTUc8Gh62WQxoXw6FCtSg1TQaZmV4J2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIRT_TO_BUS is only used for legacy device PCI and ISA drivers using
virt_to_bus() instead of the streaming DMA mapping API, and the
remaining drivers generally don't work on 64-bit architectures.

Two of these drivers also cause a build warning on s390, so instead
of trying to fix that, let's just disable the option as we do on
most architectures now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 1a2eec61196d..25e0e7375166 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -188,7 +188,6 @@ config S390
 	select TTY
 	select VIRT_CPU_ACCOUNTING
 	select ARCH_HAS_SCALED_CPUTIME
-	select VIRT_TO_BUS
 	select HAVE_NMI
 
 
-- 
2.20.0

