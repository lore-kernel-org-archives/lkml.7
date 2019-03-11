Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A12C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25122084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfCKNUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgek6-1gZnyy4Au4-00h4X1 for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 101/114] drivers: atm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:53 +0100
Message-Id: <1552310346-7629-102-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:vdSkPUbJJp83Wpo97Na8GMX4fgpQbZey2RXGsOIpCHU0WzsyEWO
 H1BN/e3ZFIwYjcg7cMmkZJbMfkxx5IFQmXpAe7M0whUfPz3n1HMA6AqlosJI3Bp+JqjTm4Q
 Kurf2L/cjJrrPHiIyC+F+D2pMGquyo4BxJ/6BwACeSFdoHZiuIuKymMRKC19IDOMvOs2E/W
 olYhKNX9xEY/9ur8Gj2Sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6o60wlUvlb8=:IqFmycq5lneJv1KpfTlg0V
 Iltq6e0EuK9uU3v7MNWaXh7qwB3rrCFF+ZRqFoiaIaTKruZ37WWxSPN+3zzGWZY0Uy/Sebyk5
 WOPLazmxGOmNbHKJeADzXcx0XLCQWnRUzaaPkl+mNld7kigo2/+zcQgHETPa+qoKxrk4/Fdfd
 jYw51C6HcMNuxPud+nCWtF6FQfOavqG+9Sk0e/vAMNzK20wuO0x0dNAtqAj+CblaZJaVc3BPR
 PjaiblxDOhocLOv2eDSMzjVde8mdcdU88BAd7gJpbw+Tb4eVfvJRNc750HGdb7YgCsiwVnPEV
 5TT8So5/u0iZXn5+WNlJ8OOOjMbcj1c7yvT+PDyzyU3RHnxuhgEBgQ0r44HFzVvbyMP0Eazxq
 /jidnF7v1By68ZSSJz64Ak0OwUAlG5lleQeIjjDAzctTgOjYaTmiwtZZj/qCpwcmDhWZwRfRz
 cP2Da/KMYtj/Rnxpt69RLl2u7+s23FPx3WSH+cyFHW6NtaDlzwQJZey1N3yd06ZY0ad1cNsKd
 lX5oqxJkSYg9sTQ5W8y85UzqQdmR9waO7N5xg/iH6MEw8T9kP3YMU+xUIrOjc8s+X3G/3O7K3
 iaIXw6HKadRPc/QR3LFZlqEWnEFzT3XoqmTsMGZVVk4S8j2BAR+9Mdl4iSezmSStHKNmlSekF
 rfYKE6PKpJwUGGrd/pQcLPg14uCtgnvDHzlfSAT68INU1g6oRl5rtMm1k3t/htRoduZPVQ6/j
 rgpKZ6FJLNT6yvvCCHxZFAN5FYNkjIqC7Im4WQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/atm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/Kconfig b/drivers/atm/Kconfig
index 2e2efa5..a156e06d 100644
--- a/drivers/atm/Kconfig
+++ b/drivers/atm/Kconfig
@@ -302,7 +302,7 @@ config ATM_IA
 	  control memory (128K-1KVC, 512K-4KVC), the size of the packet
 	  memory (128K, 512K, 1M), and the PHY type (Single/Multi mode OC3,
 	  UTP155, UTP25, DS3 and E3). Go to:
-	  	<http://www.iphase.com/>
+	        <http://www.iphase.com/>
 	  for more info about the cards. Say Y (or M to compile as a module
 	  named iphase) here if you have one of these cards.
 
-- 
1.9.1

