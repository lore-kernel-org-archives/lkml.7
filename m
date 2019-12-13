Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284E2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A22B246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLMU7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:59:18 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:54913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:59:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1x6X-1hhwsx45CD-012Isl; Fri, 13 Dec 2019 21:58:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        sparclinux@vger.kernel.org
Subject: [PATCH v2 24/24] y2038: sparc: remove use of struct timex
Date:   Fri, 13 Dec 2019 21:53:52 +0100
Message-Id: <20191213205417.3871055-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A7e9/MVVT8BzRCfImaCg9M4jUKmhpwO6crIaNymrEDwlQZeltNw
 ofdOA22H+2CteR63M/zW7/QJ9xk/xm5IFVcZUCEHHr0oqqYjO2F8BCaw7M36GDA1ouTCTdL
 XZuuvO73Er8lopAUQzkNngA9tNTZDinleHYow3Tyi+PYH/pzhVVO6ZyLKW/gM0r5NukKCve
 ucLS2WBHfH5TBH6bwkJlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:elooNoLl0os=:wJwvhFEbWlK180NJ0akjSc
 IwQ5iLJjeglZh0liN9JFPCnp0HP2SWD6SDJJ5dLDCQbHYYueqnXerizC/HI9HgURy2945Ym+e
 PM6PPU3k9wcvKwJVMCS2WBVFEQLDj3xjsKA597uZY2j1O4iNej+KtCgNla7T5EY/cXwJqh8yM
 tQ8JhxM4qHJezU0J7TI/AFMSDZQ7+LJXkjGLRypSzXhkJCa+XmWXGizlDiOKI7H5Y1cvYlmPr
 grNp1+Cb7FQeUwPxUofvsVCx7Jr0/ux3M3omtgiUzFqEamULFm2BdG1l1Ee+LRqs3+nuR5Y17
 0Es32GbadsSt665oJa61Q56UhPWbZaHCjMjwFBFbx0pQF5PR398evp8kkMCHrBdKXhEZ1moVG
 IE5yRTE/w6L43ko1QeqCkgYYUB4uEZULTnlLanp5LZyrsRHIDl+/3wvRgDOq62hK+SQT9R7LN
 o6uZU7XT1ifzYCob6rtsswqrbs7Gxx7h7h6D6mvVXzsYMBaHRseiIxkyQfdnpTvJCNBrJMxow
 wD7ZVP9yyDTJvzG51Q1Qv38SI2sSrB5TpHzV1eRqeA12bKmO6i0Ck5Ej1kEJrOBDwxea5BZLC
 H55xBxTLXhAV73IaWkgY7JQWaqYVQ9LSet/er0Pprh8ZkogvymsbLhc5zEYAMZhWFwVSWZ1w/
 eXAS9UBJnJVc/Pci+emwQcd8K9slTndz3hYmhZ1xADVoIQ7Iz8wMLRk3+Idz6hpSQg0SIJklt
 xY2V7xhOOGXlxK904sUolNvMcvCSNNvld7821PQK4/jM/PfsgTlaufqF0BDehwnShertppsWu
 usrFlmZ4CLcZ9qVJPm1zxMcSX6En/quVRVGCJhFFCL/ZtLaly7rEq7IHU6wkkQ3naAnlgv3gD
 rSp6ogSKRmbENOUzUb5w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct timex' is one of the last users of 'struct timeval' and is
only referenced in one place in the kernel any more, to convert the
user space timex into the kernel-internal version on sparc64, with a
different tv_usec member type.

As a preparation for hiding the time_t definition and everything
using that in the kernel, change the implementation once more
to only convert the timeval member, and then enclose the
struct definition in an #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c | 29 +++++++++++++++--------------
 include/uapi/linux/timex.h       |  2 ++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 9f41a6f5a032..1c85b0af4dfd 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -548,34 +548,35 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
-SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+SYSCALL_DEFINE1(sparc_adjtimex, struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	__kernel_old_timeval *tv = (void *)&txc->time;
 	int ret;
 
 	/* Copy the user data space into the kernel copy
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
+	kt->time.tv_usec = tv->tv_usec;
 	ret = do_adjtimex(kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	tv->tv_usec = kt->time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
-SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,
+		struct __kernel_timex __user *, txc_p)
 {
-	struct timex txc;		/* Local copy of parameter */
-	struct __kernel_timex *kt = (void *)&txc;
+	struct __kernel_timex txc;
+	__kernel_old_timeval *tv = (void *)&txc->time;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
@@ -590,18 +591,18 @@ SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex _
 	 * structure. But bear in mind that the structures
 	 * may change
 	 */
-	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+	if (copy_from_user(&txc, txc_p, sizeof(txc)))
 		return -EFAULT;
 
 	/*
 	 * override for sparc64 specific timeval type: tv_usec
 	 * is 32 bit wide instead of 64-bit in __kernel_timex
 	 */
-	kt->time.tv_usec = txc.time.tv_usec;
+	kt->time.tv_usec = tv->tv_usec;
 	ret = do_clock_adjtime(which_clock, kt);
-	txc.time.tv_usec = kt->time.tv_usec;
+	tv->tv_usec = kt->time.tv_usec;
 
-	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+	return copy_to_user(txc_p, &txc, sizeof(txc)) ? -EFAULT : ret;
 }
 
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
index 9f517f9010bb..bd627c368d09 100644
--- a/include/uapi/linux/timex.h
+++ b/include/uapi/linux/timex.h
@@ -57,6 +57,7 @@
 
 #define NTP_API		4	/* NTP API version */
 
+#ifndef __KERNEL__
 /*
  * syscall interface - used (mainly by NTP daemon)
  * to discipline kernel clock oscillator
@@ -91,6 +92,7 @@ struct timex {
 	int  :32; int  :32; int  :32; int  :32;
 	int  :32; int  :32; int  :32;
 };
+#endif
 
 struct __kernel_timex_timeval {
 	__kernel_time64_t       tv_sec;
-- 
2.20.0

