Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA25C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661A02084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCKNk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:40:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfCKNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:40:55 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkIAB-1gfWnv0uNt-00kie1; Mon, 11 Mar 2019 14:40:54 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org
Subject: [PATCH] virt: kvm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:40:53 +0100
Message-Id: <1552311653-18595-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:u1jix/6K8Toh5XLlYAGtszL+xBlH4g9wOKoYhCEq8j7dyYbCpvZ
 hYg7E93c4uH3Hwg/qREJ6BJ+ZrEPXb8Y+iNKMa5dgDxk078ZXN/qw73uQXrwUI6KH1y/dj9
 FyCH4A+1QCzvh9wpd3LNIzj2n471q6Yfn8X/FYKmcX91FY06yQUTOqwBIh+ispvniMIvVtp
 h7sKoWt9EdNAnJbPZt0+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mND8FyfhOWQ=:EOh1/Rh9N/SclgtmfNZyLb
 KtIiLNceSOvXQMA42QHRz+yGG5kAOVd58IpXAWh8Fc0sJSFVxU+bEMg/ul4mQL5sYzeYbzqm8
 VBoenPqXTOg8E+PtOKbnrEYGwYI6JfOM3zkRrmqJ0gYgVcY9IF6FU9jM6lXeWrOiSAbCJsqYm
 l1g9yfeWGGlpzgI/vL2v0zUis5ucvbRYJBHqGOl7Wb5MkdvaFfCLveZINxQBzVFsqOb1Wd2wx
 TLr6PW+9F5QFGK//PnZx7JFmxlv4FuOMKINCYo9jEs9IFsxs77/8TAPlzWrdFww2zxV5UnxIw
 DCLthDdZT0LAMKrgFe0mBGJx67U+rZBb6XB135BQYfOKbm55RqDri8nTpe1VGklMTy1jShRvi
 NDbG5xJpid+7ADHSgxAGdRmDDYYXbRSHN8Inmbxw/BkWJLnN6T3oWwepdZFV3NHKfRUxpWBpv
 C2WIPTi5fPyPnDVbo3N1rij15/O/daqIKZDIRJll2qBVX6EhRyV1iCr8NowA5xQCJrdaoVjPJ
 Ge5SjXdnoOqugPre7IYTP9EPfasxQo7kDG8aHLuNDj9JKK7QDMphFahbJKCFRHKiqpIXODa8N
 Brf2iz/n4xs/5ffolzrPPwayIHMLOG4mGel7WlvCxbADyttdDROkWR9aiP6JosaeQogMC+sGw
 JjXXNQ6L4TMRbSxYS5JyCC4gjU2xNeFKIWAaV+P8BLVlJngQqIWmKchzuWhrsFHUukAhOk4Uw
 tX9ytwckvLWOgL/PcAYJEu4Fx5vZju1bRRP1PyAPWw5P8LqrY8c///na/dJI/AhETxT8xlko4
 oFiT3Wmgj4AviHhJOuaP+9jTwhqiVIEj5HcMJwYijkom8mYb6PVZHRioR8eFSV24ZodYTE/0+
 a4sakJmFCqY8KQYXQlqAUXtXSqP1/A0Hqj9D0/5QNpaT7ZqEmLzN/ZqdAw1RD+
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

