Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED1C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58442183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 21:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfFNVnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 17:43:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfFNVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 17:43:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5E3B8282442
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, ncrews@chromium.org
Subject: [PATCH v5 3/3] platform/chrome: cros_ec_lpc_mec: Fix kernel-doc comment first line
Date:   Fri, 14 Jun 2019 23:43:02 +0200
Message-Id: <20190614214302.26043-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614214302.26043-1-enric.balletbo@collabora.com>
References: <20190614214302.26043-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc comments have a prescribed format. To be _particularly_ correct
we should also capitalise the brief description and terminate it with a
period.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v5:
- Introduced this patch just to do some kernel-doc clean up.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/platform/chrome/cros_ec_lpc_mec.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index d8890bafb55d..9035b17e8c86 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -17,12 +17,10 @@
 static struct mutex io_mutex;
 static u16 mec_emi_base, mec_emi_end;
 
-/*
- * cros_ec_lpc_mec_emi_write_address
- *
- * Initialize EMI read / write at a given address.
+/**
+ * cros_ec_lpc_mec_emi_write_address() - Initialize EMI at a given address.
  *
- * @addr:        Starting read / write address
+ * @addr: Starting read / write address
  * @access_type: Type of access, typically 32-bit auto-increment
  */
 static void cros_ec_lpc_mec_emi_write_address(u16 addr,
@@ -61,15 +59,15 @@ int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
 	return 0;
 }
 
-/*
- * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
+/**
+ * cros_ec_lpc_io_bytes_mec() - Read / write bytes to MEC EMI port.
  *
  * @io_type: MEC_IO_READ or MEC_IO_WRITE, depending on request
  * @offset:  Base read / write address
  * @length:  Number of bytes to read / write
  * @buf:     Destination / source buffer
  *
- * @return 8-bit checksum of all bytes read / written
+ * Return: 8-bit checksum of all bytes read / written
  */
 u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 			    unsigned int offset, unsigned int length,
-- 
2.20.1

