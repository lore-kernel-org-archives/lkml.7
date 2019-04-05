Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E879C282DD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD8E2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VrI8DNhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfDER3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:29:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59712 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbfDER3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:29:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35HT21E122713;
        Fri, 5 Apr 2019 12:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554485342;
        bh=zJ/WosHMgwUHjyXBx4mSN5WtsQs5N7a25i/DYmq59yg=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=VrI8DNhe5GX7Jkv7GF0iPsseDyCYsUE4fc+WWviKCaGoWDnXr4ykKsyTWUc3ma2k2
         OCd1fwlnHrEV6v2OS4eYJ7FUE8Cy/4ljT4IRkzORu5/aT1WDh4E1A0qG2m9CTNaZ8M
         p9tdmV0RqzlLnlNTZy4ypyVAr0SPvQUjnAE7yPJk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35HT2BS096718
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 12:29:02 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 12:29:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 12:29:01 -0500
Received: from uda0868495.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35HSsuZ095744;
        Fri, 5 Apr 2019 12:29:01 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arvid.brodin@alten.se>,
        <a-kramer@ti.com>
Subject: [PATCH net 12/14] net: hsr: convert to SPDX identifier
Date:   Fri, 5 Apr 2019 13:31:34 -0400
Message-ID: <20190405173136.18050-13-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190405173136.18050-1-m-karicheri2@ti.com>
References: <20190405173136.18050-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 net/hsr/hsr_device.c   | 6 +-----
 net/hsr/hsr_device.h   | 6 +-----
 net/hsr/hsr_forward.c  | 6 +-----
 net/hsr/hsr_forward.h  | 6 +-----
 net/hsr/hsr_framereg.c | 6 +-----
 net/hsr/hsr_framereg.h | 6 +-----
 net/hsr/hsr_main.c     | 6 +-----
 net/hsr/hsr_main.h     | 6 +-----
 net/hsr/hsr_netlink.c  | 6 +-----
 net/hsr/hsr_netlink.h  | 6 +-----
 net/hsr/hsr_slave.c    | 6 +-----
 net/hsr/hsr_slave.h    | 7 +------
 12 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 99142226622c..bb7bf2002040 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_device.h b/net/hsr/hsr_device.h
index 9975e31bbb82..6d7759c4f5f9 100644
--- a/net/hsr/hsr_device.h
+++ b/net/hsr/hsr_device.h
@@ -1,9 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 602029c44050..0cac992192d0 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
index 5c5bc4b6b75f..51a69295566c 100644
--- a/net/hsr/hsr_forward.h
+++ b/net/hsr/hsr_forward.h
@@ -1,9 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 14f816149489..22203562821f 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
index 531fd3dfcac1..5f515d4cd088 100644
--- a/net/hsr/hsr_framereg.h
+++ b/net/hsr/hsr_framereg.h
@@ -1,9 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 84cacf8c1b0a..b9988a662ee1 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index d312e8c777ae..1e49675ca186 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -1,9 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 15d3dba229b9..8a5259d1d59c 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_netlink.h b/net/hsr/hsr_netlink.h
index 3f6b95b5b6b8..1121bb192a18 100644
--- a/net/hsr/hsr_netlink.h
+++ b/net/hsr/hsr_netlink.h
@@ -1,9 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 07cbc2ead64d..88b6705ded83 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -1,9 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /* Copyright 2011-2014 Autronica Fire and Security AS
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
  *
  * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
diff --git a/net/hsr/hsr_slave.h b/net/hsr/hsr_slave.h
index 3ccfbf71c92e..64b549529592 100644
--- a/net/hsr/hsr_slave.h
+++ b/net/hsr/hsr_slave.h
@@ -1,11 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2011-2014 Autronica Fire and Security AS
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- * Author(s):
  *	2011-2014 Arvid Brodin, arvid.brodin@alten.se
  */
 
-- 
2.17.0

