Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2CAC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD59E224FA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257141;
	bh=/9NJm8FBtb+c8mCuOKpMv1HbYFsrFzhxLk/5+F4za0Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Fp4BRKUejWQhnrpMXJBvTLKeO9+UDHtSzWMIVtRm4tQNxy/KfqvJAl3ywgSLGOihE
	 Wp2O6UMtnybUmAS+SziGxSSvaX9fvQxWQ3DzgsDmmKz64NFmHdLtGuuvE7U6ouvcVm
	 dkLbmQ5XZ5r1PORJvZtSjDDFWHjEG5ZgPMx2j+bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfKTNjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfKTNi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:58 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB93224FA;
        Wed, 20 Nov 2019 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257137;
        bh=/9NJm8FBtb+c8mCuOKpMv1HbYFsrFzhxLk/5+F4za0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=het8AsdSOJYIoPR+Z1Dscdm1oyCu3expVdjZvTiAsvRhm/skPdqXWGM9V+QMfnzUy
         mQ1JJfbVUmwa1sfsE9Supw2Pc3DG6JyYN7vOtXJ/VtqNnmCBrPqKyytOaj9ILqwdPr
         CsnSMXPEbe7F1r2KI7qFQBlpUbmARWXj4gY5ghuw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: pi433: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:53 +0800
Message-Id: <20191120133853.13308-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/staging/pi433/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/pi433/Kconfig b/drivers/staging/pi433/Kconfig
index 8acde0814206..dd9e4709d1a8 100644
--- a/drivers/staging/pi433/Kconfig
+++ b/drivers/staging/pi433/Kconfig
@@ -1,17 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 config PI433
-        tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
-        depends on SPI
-        help
-          This option allows you to enable support for the radio module Pi433.
+	tristate "Pi433 - a 433MHz radio module for Raspberry Pi"
+	depends on SPI
+	help
+	  This option allows you to enable support for the radio module Pi433.
 
-          Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
-          or compatible. It extends the Raspberry Pi with the option, to
-          send and receive data in the 433MHz ISM band - for example to
-          communicate between two systems without using ethernet or bluetooth
-          or for control or read sockets, actors, sensors, widely available
-          for low price.
+	  Pi433 is a shield that fits onto the GPIO header of a Raspberry Pi
+	  or compatible. It extends the Raspberry Pi with the option, to
+	  send and receive data in the 433MHz ISM band - for example to
+	  communicate between two systems without using ethernet or bluetooth
+	  or for control or read sockets, actors, sensors, widely available
+	  for low price.
 
-          For details or the option to buy, please visit https://pi433.de/en.html
+	  For details or the option to buy, please visit https://pi433.de/en.html
 
-          If in doubt, say N here, but saying yes most probably won't hurt
+	  If in doubt, say N here, but saying yes most probably won't hurt
-- 
2.17.1

