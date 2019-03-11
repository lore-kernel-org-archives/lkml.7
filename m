Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0354A222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfCKN3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:51 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpUQk-1giZPb0nzo-00ppxP for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 027/114] virt: kvm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:39 +0100
Message-Id: <1552310346-7629-28-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:s4g3OoKXrJJCKi1lcezt3JE4TWEyNDEt7i7pncsRJ0yieunujvO
 M8NK5Eu1G9sOsSOCf8b/BJJFsXsqQt0MJmuz8lup9d9FIYvblmnDGE5Vo7PcBK5wtYtritZ
 gmEIthhPfhCwfsTeA0WWpEsda5JcqKEbQSyKtq0yioxL5P6fq5HvD8ndlr0I0P+jxzqr5q9
 k9Y+baJFvWLgh5/InhKVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqmG3UyfEeA=:k7pVHRWo4W0hS7FRseozXF
 ditF1069sbbjASDPLe1cq6xfnivQh2uayu5CrgjnPzlyu9VU9SUUtimEU3KSO4lFM4B64OgBJ
 PokjOYiSHOntEX/2MeVzCG7vepoLXuW1vLhfUFusDTXmASDtdTb3A92aW/TuWN/4z1gjylBFE
 LjPBg2zDkuozPL+m3u7JZxYJGC8COcj16vddmXLYBqEXxchtttM3KJTZVJPSvWymN0CR362mE
 zxU2ZI7f3CI0OP/JNgx8PJOZEvNrOuFHqXh0bcZrO5a7W/hK8byXkcNGFTi/Lq+74BqBmN0Sl
 /KPVxV7blhrvjaZlwrxN1eYZSNXY244CFQnWZNZDxF29XOikj3RIFYQAZ8X5T5GsPY7KDfYn4
 mUv+3hAPMm80rasIo/QQ+7nHUsDyL0IjXR6GJtd654pEvghU/QokjBj0kGVShMHkP2pcxFntt
 ATWhflqzLS+PMmXQOeizRSIdzX0fMQrfcms3Pc9OGqvTe3kCSUUKIzxTO4qGWP4L7DAM2sRHP
 psRKmloktVz6U5INJ/rtmGNCpGLQbef0JbmarpvgPvijR9xuhiTKnwwPOdbQoifwAqVwtZvAb
 J9CNKVCO9rjLXIRo3/Xm0wMUV/IrehgBq/NJk0eO8mLiinIyohQP6F20wU/wW63/3FjN/wz9e
 cG83BAkw51dAorf43qTG3+IHqvio8ns7M2THG2EUIPylEkCpbxp1/Yq6jNESqsJDUxDbR5rkm
 ezHCj8WMY91FRkwEwo998LVklwJ07vDjkItHfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 virt/kvm/Kconfig | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ea434dd..22f5e59 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -2,58 +2,58 @@
 # KVM common configuration items and defaults
 
 config HAVE_KVM
-       bool
+	bool
 
 config HAVE_KVM_IRQCHIP
-       bool
+	bool
 
 config HAVE_KVM_IRQFD
-       bool
+	bool
 
 config HAVE_KVM_IRQ_ROUTING
-       bool
+	bool
 
 config HAVE_KVM_EVENTFD
-       bool
-       select EVENTFD
+	bool
+	select EVENTFD
 
 config KVM_MMIO
-       bool
+	bool
 
 config KVM_ASYNC_PF
-       bool
+	bool
 
 # Toggle to switch between direct notification and batch job
 config KVM_ASYNC_PF_SYNC
-       bool
+	bool
 
 config HAVE_KVM_MSI
-       bool
+	bool
 
 config HAVE_KVM_CPU_RELAX_INTERCEPT
-       bool
+	bool
 
 config KVM_VFIO
-       bool
+	bool
 
 config HAVE_KVM_ARCH_TLB_FLUSH_ALL
-       bool
+	bool
 
 config HAVE_KVM_INVALID_WAKEUPS
-       bool
+	bool
 
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
-       bool
+	bool
 
 config KVM_COMPAT
-       def_bool y
-       depends on KVM && COMPAT && !(S390 || ARM64)
+	def_bool y
+	depends on KVM && COMPAT && !(S390 || ARM64)
 
 config HAVE_KVM_IRQ_BYPASS
-       bool
+	bool
 
 config HAVE_KVM_VCPU_ASYNC_IOCTL
-       bool
+	bool
 
 config HAVE_KVM_VCPU_RUN_PID_CHANGE
-       bool
+	bool
-- 
1.9.1

