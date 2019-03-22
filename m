Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DAFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710CE21841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfCVPtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:49:20 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVPtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:49:19 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MkYg4-1ginIy0yRq-00m2to; Fri, 22 Mar 2019 16:48:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Wei Qiao <wei.qiao@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lanqing Liu <lanqing.liu@unisoc.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 19/25] serial: sprd: adjust TIMEOUT to a big value
Date:   Fri, 22 Mar 2019 16:44:10 +0100
Message-Id: <20190322154425.3852517-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gOhT/IAeaMO+pVMjIITVJXtnTKyYeueytjXJBKFQR9atY7weLTO
 Kf33YvM5tw3IaV0jxPrO1kIi3edMG0BnyzSxkpC88q9JkC/vLbbpJnKUq+BGdivOlom8t/H
 ycTaBzF9E3eXgO5oTZsuSPbY1yBRxFrYq1phIx/vDYqKg8eFFQZJnTvT45I5K13X3ObbOV1
 EHwxj+5ZJ0u5+VLQyBOvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WOTRinDg7jI=:/d4Ar9PKPt5xNBU7WBQvA9
 /5yXWaOyD3Q91BImD86rnhYghtCZRuPjYgrcxz4Kl34q3wVZk/QW1sobxJpyLol5zPeqFc/oB
 zNee5gLEOIJlbB18lKB6+29Y8z++03274bZr/1ssd64sbPm3UUqpMCGuY4DD6Z012yaRQl2Ge
 xEytxJ8LJ85C8D8skBEGzwQyWnIvtv2fmL2jYgVPf5TWDnnCZUqf9Miu28Pj+dYkj51+JOnKO
 4fYWz62+uTA8P7b6l6goffR3cw95NshUJDJdITaOQjTWaS0qhj4YH6d/Ofk07/eLWWGRStJRu
 IvQ2j69H3rn3MTXxGvV8zNUC/CwEoFAED3rWi970egGuy9dZl1TrPLnd/JQb5Ed3qgmL11iV1
 Q1eUcczgcKHE1FkMl28sdIa/m/nC4nlSSufUUEnTZnskzNDOc293d1d5D1ZSNLHVMOEteEa+v
 eLhu1eNCwTWtFN7PEZsvbooy1KnRo9H1wB6nyLOq1k4LgJk71pkrq2Xn6LI67xAS6xkLP3jEr
 ClLM5OEOAip5NoDyXaCuvL+NfrZDDGOAoVA/RSujQbhtPFCmuzO9LQrR28km43imHO9vjkRwc
 z6cwJ2Kv8rKcNPIF4Vu+9pey92lAyauNlzZzvrCrBkyNBb/mLGcoADF5z8+BrBxgKN7tzDuBv
 WSn0X3CfhN7vBa0NS2SB4886WdqWb1K1jIwFI0l8rN61A5CczciUvgtHFtR8zUoKBgDru8bhL
 Jh6g/A9y66vRgVLLdILFz5yCZ3ShJ8AafFsiGA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Qiao <wei.qiao@spreadtrum.com>

SPRD_TIMEOUT was 256, which is too small to wait until the status
switched to workable in a while loop, so that the earlycon could
not work correctly.

Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1e302caaa450..176f0a2bf9d9 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -36,7 +36,7 @@
 #define SPRD_FIFO_SIZE		128
 #define SPRD_DEF_RATE		26000000
 #define SPRD_BAUD_IO_LIMIT	3000000
-#define SPRD_TIMEOUT		256
+#define SPRD_TIMEOUT		256000
 
 /* the offset of serial registers and BITs for them */
 /* data registers */
-- 
2.20.0

