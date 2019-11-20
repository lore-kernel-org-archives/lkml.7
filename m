Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801CDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F2E2251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257154;
	bh=e7qNNmsSecBU8hJ2XxG0kI51Dv6sbTVW7xZ1AeP3diU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aJmGCoKUHPlQADV8RJTxLRW30FiLdZV4z+tri1wkJvxTvehu+766fdLsWljHMfFof
	 euwJOsVl3WNlId+LUuFoanUbBvHaxjh5al1edjCzGemE+cdYDK3hi2XcWOH829w2zY
	 sMzl+8zFtHVO0f/CucolHSjSjqkqsiGiWMhvsdXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfKTNjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbfKTNjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:11 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFCC224FC;
        Wed, 20 Nov 2019 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257151;
        bh=e7qNNmsSecBU8hJ2XxG0kI51Dv6sbTVW7xZ1AeP3diU=;
        h=From:To:Cc:Subject:Date:From;
        b=G4mPsB4C3OxVOv8OFWCQ8Jf8WnA7vHVOuDtIOkuum+7Xx9EPVUYKIa3U463eGvOes
         xiGleVKSE3WUTBg9CX2JHqPesBh4a/ADFA8n0V4qwDy+lNSWGgnHOSg6XQuxHWo0Il
         FeGWFC22EKEcD5AgnWPKEPw86fgly99oeoG/ZCUw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: fwserial: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:07 +0800
Message-Id: <20191120133907.13483-1-krzk@kernel.org>
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
 drivers/staging/fwserial/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fwserial/Kconfig b/drivers/staging/fwserial/Kconfig
index 9543f8454af9..d21124a1a127 100644
--- a/drivers/staging/fwserial/Kconfig
+++ b/drivers/staging/fwserial/Kconfig
@@ -3,7 +3,7 @@ config FIREWIRE_SERIAL
        tristate "TTY over Firewire"
        depends on FIREWIRE && TTY
        help
-          This enables TTY over IEEE 1394, providing high-speed serial
+	  This enables TTY over IEEE 1394, providing high-speed serial
 	  connectivity to cabled peers. This driver implements a
 	  ad-hoc transport protocol and is currently limited to
 	  Linux-to-Linux communication.
@@ -17,7 +17,7 @@ config FWTTY_MAX_TOTAL_PORTS
        int "Maximum number of serial ports supported"
        default "64"
        help
-          Set this to the maximum number of serial ports you want the
+	  Set this to the maximum number of serial ports you want the
 	  firewire-serial driver to support.
 
 config FWTTY_MAX_CARD_PORTS
@@ -25,7 +25,7 @@ config FWTTY_MAX_CARD_PORTS
        range 0 FWTTY_MAX_TOTAL_PORTS
        default "32"
        help
-          Set this to the maximum number of serial ports each firewire
+	  Set this to the maximum number of serial ports each firewire
 	  adapter supports. The actual number of serial ports registered
 	  is set with the module parameter "ttys".
 
-- 
2.17.1

