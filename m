Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C54C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFCF20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCFWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:08:50 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFWIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:08:50 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md66H-1gTQIG0I9D-00aF2H; Wed, 06 Mar 2019 23:08:47 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH v2] drivers: infiniband: Kconfig: pedantic formatting
Date:   Wed,  6 Mar 2019 23:08:45 +0100
Message-Id: <1551910125-26368-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551898167-18310-1-git-send-email-info@metux.net>
References: <1551898167-18310-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:SMPlWpx7GizanHM6xccGqGFznQKTa/lCdGm9oYUZA3mHhWvifHi
 45tgihsCXaglCV9eWOttzFqcVkF/HXdo4wrdoVVyKoOaxusWshBJgA5RDKgCfK8GzAqitMA
 SxpfYALdjnrSsycOVlQlGX2fICJIMu0zBA6CWLDs3/Xl7U0M0PAkSt+bTQMckLVcqrHD/WM
 PV/fp1a7AVgTxH9QBtNPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hK1QVTLFZo4=:Y0NMaPe2S+57ePX8nC40uD
 K2RcEDZx6qFge4Y+1NneKmNr6sM99rRPw+Iez9i1SRIkBQ+oUrE2FSHu7EODF6uns9knrxEi0
 Toe3QQ4n7Wtq3dCvQvA5pLLzPt2HA0I5n5Adbr2NwxBthCdeLLnEgDOxhqFQbyGHtUszJr4K+
 F8fUsr7UlS9cAkWI05avBLT8mEu/cEUlfUZcw6M0fHAG98e306CRX5Nd1jrnJh1jw4r3mXKss
 KTTF4Z19dOai+08jbVBVf6UNDjdDSCIhho8BsX9O00rgyICq0jS3G3BIpxPPcaaFJurJ482zI
 8VZ6WVeqC8R8HJyTUuE+8W0i7AotjPPivRVDoSgQDxzkC8xVEYGdSG737myqc8pwtlT4dlM6B
 ZpZW4AvSFa/HBDYqgYTIZNmrUf/igExa0WOHjE9/ZCBEtRrGjGE51BuzWifl3RtiGn7PVyyDD
 YS6Tvon/VZRKoDuAblRGCPiMbfty4JMBoFVdVpsg2LEzC39bUwLBEsUrA0o8yxz6loUffUuQq
 kVAHqsJeUCS2npWX3YAYujcbPl9ggjakyP979LVQUB/hzBTBocyPFZ0RgJNXIa4Uf2WzMT46Z
 eZFIyOMha2vueQv02hWQjYeP7tzhjvly0QGFT6Yl09NsjEePQc1vGixXL7AvC3eABJ6yJBkh+
 BQssFxUUpzAeGz5pFueKMwYcDKmojfeo0U6NscXTH7WxknOmp2XNNjgr/NBropsC5m4X9/Vab
 tiOWd23DUvlgK+OA86aABEruwDKCKHKKULIQvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/infiniband/hw/bnxt_re/Kconfig | 10 +++++-----
 drivers/infiniband/ulp/iser/Kconfig   |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
index 19982a4..05aa9fa 100644
--- a/drivers/infiniband/hw/bnxt_re/Kconfig
+++ b/drivers/infiniband/hw/bnxt_re/Kconfig
@@ -1,9 +1,9 @@
 config INFINIBAND_BNXT_RE
-    tristate "Broadcom Netxtreme HCA support"
-    depends on ETHERNET && NETDEVICES && PCI && INET && DCB
-    select NET_VENDOR_BROADCOM
-    select BNXT
-    ---help---
+	tristate "Broadcom Netxtreme HCA support"
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

