Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885AE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfCKNTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCKNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:31 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mgvj1-1ga56K3c0T-00hLVu for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 017/114] drivers: infiniband: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:29 +0100
Message-Id: <1552310346-7629-18-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:szbzZwFDgwd5tNU5my7bTNb5V+RQUXqEoAu1Tl96kdKdpQaEjt9
 W++z+vSDJQhkK/XszzdTJLLTK+HaDfe9lia7U6q/cDyNHcvsRdZANgE1ra4a09cQUIWMeSt
 2ZK2qphK15jUMBgnCqxNVoAHwu0RGhfCH8sL3WTTc9VZ48mvILNyuEFUPMDKTJ3EvXkZgHD
 /uSLseaqzr33uv0Z1f5jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFhXMdpED+U=:wg/doe3G5oY6UcIXXzadYL
 PvDMnjsphTQL17yH+1DThzITucKoU2Tvwr26sqZqcx4uQOmF/q577lswNuxeE6BTytwnV7+Xz
 0Cz+1cwwLKU4qcQo/J5gGfvrlGfJG+sLxNMgp6O3oksQw2gQSc3RVEMWpD3jS9gBv/cpNGp5x
 TDEnhx4TaFbuWpE3Sfqvz7pkestWImZzPNeIE6ngh2tAihOUzfmP0KBLDBZEf0s4j0cSkYYKb
 E2yhFek/0PCj/L5pK773eYIxW4uXfSAYHEQnUxBGa67GsbHVhnx5a3Xv/pIBgo/d5kUA0VJBI
 ssNBQYkZwRxhT6MOUjbI3oz8HrRcKl/uFo3YY+imH9cbRTpBcrm7UrvqGV+AQgA0LIJRU3KbA
 Z4i6UeXDu9/MykCkmpA3LdZ00aAscq7zUjg85dYjfbmRF9FHjl3nE16BcsyxuBfRe1BZ8kH+L
 mZXg6WlcN8yCsBzkQUVxJaPzIAKLkeBeILg6pq1y54n+ZV3m6TErhZF2kw1RpdBp0rxMn8iaV
 TKOXZrx+tRYXOma8rZL3epa5QHhme1sTPgdS4ZVdkJqwSRj6Di6EK/SiyskZw0+DZAezd3pMX
 7Jze7ARudyVzUsdavl3FfZSHVLynIiAo081kSb2qNK2e/goP53nt77BW+gqE7xLOuF05PsLNP
 gO/bLaKICHvLa8T4vGmcqh+zzbBRS/BTpEgjKrNzpXbmrVHbScWhPdqbRE6wPFGs+gWPyTpuD
 Y1muIIPbg9UY2BbjhqG8MqJ5tbwtU1ViXlkzPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/infiniband/hw/bnxt_re/Kconfig | 12 ++++++------
 drivers/infiniband/ulp/iser/Kconfig   |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
index d25439c..b158bf6 100644
--- a/drivers/infiniband/hw/bnxt_re/Kconfig
+++ b/drivers/infiniband/hw/bnxt_re/Kconfig
@@ -1,10 +1,10 @@
 config INFINIBAND_BNXT_RE
-    tristate "Broadcom Netxtreme HCA support"
-    depends on 64BIT
-    depends on ETHERNET && NETDEVICES && PCI && INET && DCB
-    select NET_VENDOR_BROADCOM
-    select BNXT
-    ---help---
+	tristate "Broadcom Netxtreme HCA support"
+	depends on 64BIT
+	depends on ETHERNET && NETDEVICES && PCI && INET && DCB
+	select NET_VENDOR_BROADCOM
+	select BNXT
+	---help---
 	  This driver supports Broadcom NetXtreme-E 10/25/40/50 gigabit
 	  RoCE HCAs.  To compile this driver as a module, choose M here:
 	  the module will be called bnxt_re.
diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
index d00af71..299268f 100644
--- a/drivers/infiniband/ulp/iser/Kconfig
+++ b/drivers/infiniband/ulp/iser/Kconfig
@@ -4,8 +4,8 @@ config INFINIBAND_ISER
 	select SCSI_ISCSI_ATTRS
 	---help---
 	  Support for the iSCSI Extensions for RDMA (iSER) Protocol
-          over InfiniBand. This allows you to access storage devices
-          that speak iSCSI over iSER over InfiniBand.
+	  over InfiniBand. This allows you to access storage devices
+	  that speak iSCSI over iSER over InfiniBand.
 
 	  The iSER protocol is defined by IETF.
 	  See <http://www.ietf.org/rfc/rfc5046.txt>
-- 
1.9.1

