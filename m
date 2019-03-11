Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0612084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCKNT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Myb8N-1grbwz3UUv-00z0vG for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 070/114] drivers: hwtracing: coresight: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:22 +0100
Message-Id: <1552310346-7629-71-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2Rdfd2sCatY/PuB1WMPKEGOXwaBnG1Ml8nJOJY71dMt+Qz1f68s
 zK51bu8IWDebzFTM3AuCcNK6ppmqP+tgiddpwmq7d5Todz+u0ef8z4bg8vB9RjTbYAuUE9x
 vxNc5hJlAF1WxVeHIcSanyYJKW7skvI61faj7N1mqVY4K8387QqqvGZKuP0hOkiFg4Zv+Vz
 a0budNIsXNmNr/sFM2buA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Seb6QtrIyRc=:xrZJJ5x3WbqRDZho84XnzO
 yROrNMSFzqyQO/mkDjOrp3pubGOrmwznUG6hIUOr41ejtQMYyIV13Ov8cbO71MJSCy5h0bzuP
 RzfwnyxI+qDcv7vS7APXzSMpmRDknicgMiwSo36UWJ2RfKizCo78gs0Vkxzh0TbRoIYQBr8Si
 fLPE0IuoSiOhgAAkusPosZ8RY3kxHmC0cxLfBHetopWXNxkat63LMGH6wta3bKT2/8Oq/BK0b
 Kl2l3vyL5I6FAgmUq0pJxNyulH3RVbGT7h5IA7mbkzm3V1tZJMimFGxCFVixsCDcuqiG49TO9
 6OQ9ybZVEJfib/FxU5htLnWBb2ZRshjT0+meahjoRL3KhnCiz5i0LkhfzWS5ddK35mV7NOgiT
 lvssZ0iyyDTVnDZDetLfwpqLGnuS72ov8czr/T84oillsH+BoPKm7gyw9DppqtKDPf0EOMPLJ
 hTp/oktdSQbx30XBHxnfoGoqhV41Hygf/BQCpbTGZLrUC0edpgzYmdviQgKWWqeMko6NJ4gPG
 k0p+NUilKj7L2/yTMBdRZYyC/647wiv0Ax7F75FaekRAt8jGzyInHgM1VhlVDX7wvh7OMWS+F
 vkhbEJ3WkGeTsrGTZfxOYFRusOImk96mSndQivm0w46ZXrsg+8th65svTfhWSU2ZWMNLIdLXL
 41uoId0qR8y+jAXmBHBuKZPhEKCG8/zRV3m/sw5S6/dZSl3RwwokCwT/PKR8Fj18dUj3iPCZE
 EFS7jZomZ+wroF/UatK8qM0qy2TzZeSkE8Y12w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/hwtracing/coresight/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index ad34380..5b6bda6 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -35,12 +35,12 @@ config CORESIGHT_CATU
 	bool "Coresight Address Translation Unit (CATU) driver"
 	depends on CORESIGHT_LINK_AND_SINK_TMC
 	help
-	   Enable support for the Coresight Address Translation Unit (CATU).
-	   CATU supports a scatter gather table of 4K pages, with forward/backward
-	   lookup. CATU helps TMC ETR to use a large physically non-contiguous trace
-	   buffer by translating the addresses used by ETR to the physical address
-	   by looking up the provided table. CATU can also be used in pass-through
-	   mode where the address is not translated.
+	  Enable support for the Coresight Address Translation Unit (CATU).
+	  CATU supports a scatter gather table of 4K pages, with forward/backward
+	  lookup. CATU helps TMC ETR to use a large physically non-contiguous trace
+	  buffer by translating the addresses used by ETR to the physical address
+	  by looking up the provided table. CATU can also be used in pass-through
+	  mode where the address is not translated.
 
 config CORESIGHT_SINK_TPIU
 	bool "Coresight generic TPIU driver"
-- 
1.9.1

