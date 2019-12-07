Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66F7C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8500C2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLGTLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:11:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55327 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:11:31 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYedH-1iGj1o0shn-00VfUD; Sat, 07 Dec 2019 20:10:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] time: posix-stubs: provide compat itimer supoprt for alpha
Date:   Sat,  7 Dec 2019 20:10:26 +0100
Message-Id: <20191207191043.656328-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FnOMuTqNkYh1zOphjAXkeSa0YP/RgdiwY9sOcbhXU8ppye9esY5
 RK4bhWuGfTpD7jPJmjzT6gDuJrAtXBfoiHwn+BasAafwJ0ivKuBsuNh8P/c5ia2zXAyT76t
 VQwC9W/r8z/cAQUAQnKokfOcRhthwuDdpiPNBai5M9+4B0806NSQIFTotfPThhlIK4nevpA
 pPd/6PbAhDC3nvdu7KhCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k7jGVmzOwJk=:KveIdCulhuTvHXyjjP/N53
 91of+zTxJv9LtN29iaSW7LQJNZJ3UeZ2UwkLLnPN7fpDPD7UOKrB9GTQmNGnA83GSs5R465uc
 QSFCt1rvdwRIJwxUGq/PHgbeJblUwlkD6hP1+SPgs26OfAHwdL363WOStNOp+HDyksZaeNfT1
 SkFBuW5K3iiY4APopNRNUCXreMFslq0b5UmAIrqiuP2zVLBeU4EgplBMiSv/PmXTwQ4Z7UNqx
 MmGPleFPwqsPgt+D+1bI9TiejcrNUQMFINktBjnPJioEUi/uqN3PnLtt6Rk4Wq07bDVYT9Ozb
 AWFNlJuIkVmbIqU47WcqHAzYzZEUjWdge9HpEcCsl3e0Uw0Ndp7C607Vk7/fmVqpNTkngrwH2
 /rWMeG5uorz/RFVLriEaSZMdE4I2RwsDqV6dyykiqC4VBTTwjiWGfGBQctvkAQD7lVMDBdXT1
 5wNy+EsxjT0dRngrMqLnRQq3LhrZaSJlyfPADrS+veAA9K8vX++8pUHmtUWFE4zcRcHL4LOoM
 kMpdFiv0nBA9N7ZQhUf2oc2FuTOzCeuEpNqDDqbNtxXOyT6RFXcFWW9ZOTTKEX2R8lzklY6yJ
 0LJv+1UOps+CzEc+6DMGEzK1Vl4Aa3d3qwj5DSUzmiVYolgkWB1oflrpAJFYbiGodvN5R8YgK
 VnCJlP62KgjfiqX1UXm1MWQ+HMt+faZwz86uI1oQkZ7sVxQwUma1QszTDwL9HWZIK08wxmI67
 tT0PA2qZ8Q0a7fFHpqOyGL7kapjuuwLGrs/MfslrFRgXkEKZ4qIuwDErfEbGEW1w2ClgmAcJR
 sWenC2H+X3Ehlo+XohNmDpYtJrJ6xmfZ/4GjapnbRmRgjWi7mVAJ7oEWN/RA1DLmgm4Svjsjx
 XSuCguz3tGBnfq3sEmfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using compat_sys_getitimer and compat_sys_setitimer on alpha
causes a link failure in the Alpha tinyconfig and other configurations
that turn off CONFIG_POSIX_TIMERS.

Use the same #ifdef check for the stub version as well.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 4c22ea2b9120 ("y2038: use compat_{get,set}_itimer on alpha")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/posix-stubs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..20c65a7d4e3a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -151,6 +151,9 @@ SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYS_NI(timer_create);
+#endif
+
+#if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
 COMPAT_SYS_NI(getitimer);
 COMPAT_SYS_NI(setitimer);
 #endif
-- 
2.20.0

