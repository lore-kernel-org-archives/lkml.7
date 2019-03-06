Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B82063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfCFSta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:49:30 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:40565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfCFSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:49:30 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M59am-1h2hXI3PNc-001E2y; Wed, 06 Mar 2019 19:49:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH] drivers: infiniband: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:49:27 +0100
Message-Id: <1551898167-18310-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:xLKptFMnb+HHMaR8P1ckRKRl6l1dh9rKK1TZ29cChjUvpmaVuB5
 JaILNw/goDGhCXOWw1+BMfJ82aOk68A58dQw9azQ97uoOaXDp+S8yrHVtm92HCv/WNMCQIO
 hlERZdGq6kFukbI/Oiy23pUhFQBPlUd3BqqNPmUWBDAj6FaEjrVnZ7xFt/uBXy3IlyG24pD
 P4jvBLWkw/+l13JYH1asg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Bvflw5fYD8=:QpOxi1LMOeYmj16QbwWUEy
 JJ1uEsOHcvOiXcWolk37Vo/5bG1FfLD/3IhyJM/71XZx8+TWhqFFu1vPpcnkECbCRO9jZaTUw
 fGALlmkOXDKe42iPmwvQleJm3TLkpA484gWf2DXvC7DIHpmImwnpNQF3+8B7fNsQdFmrlIFSz
 zO7tFRuE751VruywISpOY0it9FeT5u/muk9ntM0GfF3wDGsZ1O8Ts81c+k9TpIJssbyyUqTwM
 sMoYqKyoql4tnS99NjYpuHQTW3lBQ9ezlRzpdq8HraVKXQKi+5oOWXjjA/LDj4i/ICMxxw9ea
 6QJw5Z9yTmtsn35islI/xQ1ZC5/SFHR35xktKv3VrNFE1Iz3eA+fn2olpb7ykg+Qjqn0IdDMw
 ZHIGkTSp1GeW0/Ag11jVzNcQhyKB69TppGz7sd1UBeLhiFfTH8xGTpH+gyVrs6MXo0c7S2ieR
 rPoVqenFo2NihFbgHLgnntjFmOaWQvtA5xSvr1JTW7q6Z5FbRVH82+9Iwyz0rc8tQdCIItoRI
 k6TwypOZDVsTBJXK8yeD6U89r5CD5jIBFaXuZDjeOfBN0J+7+CRSuNUERg+e/Hi0YrU6in/tg
 DMCEGLlSF/MK5qie8106KF9RRd++FyUjbTRsHEhKLD8UG7VjJpMFGwF0hcX63l84RzZ99XB+i
 ycdh60lueqwf89cdOFQaTPuO0MvPsE0qU9zFCu3ZXYOIwbsNSZr553TDPeX3T9tHttieMxkJ8
 i9ggmBMmYabG5tuOlxSKeH62ITDe5ExRcsHX9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

