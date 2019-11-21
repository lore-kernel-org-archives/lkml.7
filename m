Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37275C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0354B20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306420;
	bh=hVkxoEI79R7DdxvXL/DPDcM1msvwvzOehyyh0Ejz86g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q/Bxy3wlVgH9+NwzRWPP+D0dGGzIH6P7xVAOo5TtgpUU/Nu8xqbiPuyMxjel3BBP+
	 58dvT2aIcaJkGxWqpZ0LBQK9AfvZVHbkfkIUtviwzUQ1JghONnfpCkDSOGCwJe/Z+q
	 Zn3CSsLvPG2e1h+9B4eUqy1ueiLV6AENqGOfiALw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfKUDUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbfKUDUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:16 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8C67208CC;
        Thu, 21 Nov 2019 03:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306415;
        bh=hVkxoEI79R7DdxvXL/DPDcM1msvwvzOehyyh0Ejz86g=;
        h=From:To:Cc:Subject:Date:From;
        b=gQU/9GWnRhTWwHyo3oBCHFTI2Br3XVnfw1e/bv4TkN6OK3ie/ZsRgAiPwdkZeDJR7
         5KWwSBaYobqloVgn3rT4abiyE5hXnR5HhrnlUx27bZiko1HLe4NeOstvLZVkNjldkE
         OLHeugZGvC6S7S+44kF2CcX2oYht6ZuBdhcKMrcs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH v2] staging: fwserial: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:12 +0100
Message-Id: <1574306412-21883-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 drivers/staging/fwserial/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index 9543f8454af9..6964aac2a7ed 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config FIREWIRE_SERIAL
-       tristate "TTY over Firewire"
-       depends on FIREWIRE && TTY
-       help
-          This enables TTY over IEEE 1394, providing high-speed serial
+	tristate "TTY over Firewire"
+	depends on FIREWIRE && TTY
+	help
+	  This enables TTY over IEEE 1394, providing high-speed serial
 	  connectivity to cabled peers. This driver implements a
 	  ad-hoc transport protocol and is currently limited to
 	  Linux-to-Linux communication.
@@ -14,18 +14,18 @@ config FIREWIRE_SERIAL
 if FIREWIRE_SERIAL
 
 config FWTTY_MAX_TOTAL_PORTS
-       int "Maximum number of serial ports supported"
-       default "64"
-       help
-          Set this to the maximum number of serial ports you want the
+	int "Maximum number of serial ports supported"
+	default "64"
+	help
+	  Set this to the maximum number of serial ports you want the
 	  firewire-serial driver to support.
 
 config FWTTY_MAX_CARD_PORTS
-       int "Maximum number of serial ports supported per adapter"
-       range 0 FWTTY_MAX_TOTAL_PORTS
-       default "32"
-       help
-          Set this to the maximum number of serial ports each firewire
+	int "Maximum number of serial ports supported per adapter"
+	range 0 FWTTY_MAX_TOTAL_PORTS
+	default "32"
+	help
+	  Set this to the maximum number of serial ports each firewire
 	  adapter supports. The actual number of serial ports registered
 	  is set with the module parameter "ttys".
 
-- 
2.7.4

