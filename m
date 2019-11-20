Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD35C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2C22506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257137;
	bh=7Z0S6u4MJcVLHWCK6oT8ief28EkL2UMiOucl3BESb0A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XN4WhKsrI8GYwaYK+rn98T9dnqKKrK3b15vOGKv+wpaIy7WXY2tkZ0xZ8/HUkQv6/
	 uHSSyxViRE8t5GEtuIBxgjrcWcI+JWLCT6RsOlMim5F81UkgVhIFmSa+OZ8PySy61D
	 TV++AQAuhDE773oCvJGjaGzDOcp0Sp21FhuYQ3HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfKTNi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfKTNix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:53 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BE3E224FA;
        Wed, 20 Nov 2019 13:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257133;
        bh=7Z0S6u4MJcVLHWCK6oT8ief28EkL2UMiOucl3BESb0A=;
        h=From:To:Cc:Subject:Date:From;
        b=0mJGvxDRgZbqbjUgOP/SA2ml+z8fwxw+W4Vn/EOie3LZ2qZW0aZC50ywbFw0l81XV
         jjL9myLDUMOgOc0zi2FxSARpovxbBowKqFjwdoK6yFVjpDBbvwoOeZ8tJUrA3uBF4h
         fivHMLgzc8v6DJHiyLgTG/2Hpq3HMacZxnHdzfH8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: vc04: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:48 +0800
Message-Id: <20191120133848.13250-1-krzk@kernel.org>
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
 drivers/staging/vc04_services/bcm2835-audio/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Kconfig b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
index f66319512faf..d32ea348e846 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Kconfig
+++ b/drivers/staging/vc04_services/bcm2835-audio/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config SND_BCM2835
-        tristate "BCM2835 Audio"
-        depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
-        select SND_PCM
-        select BCM2835_VCHIQ
-        help
-          Say Y or M if you want to support BCM2835 built in audio
+	tristate "BCM2835 Audio"
+	depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
+	select SND_PCM
+	select BCM2835_VCHIQ
+	help
+	  Say Y or M if you want to support BCM2835 built in audio
 
-- 
2.17.1

