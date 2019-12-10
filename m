Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DBBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEA32073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfLJUeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:34:21 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:57521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJUeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:34:19 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8hlZ-1iafTh1vDF-004kr7; Tue, 10 Dec 2019 21:34:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mmp: include the correct cputype.h
Date:   Tue, 10 Dec 2019 21:34:00 +0100
Message-Id: <20191210203409.2875880-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TYAVyXZgBYEko4NYVCn4X559DV/JN37TG56E9DTOSjQgKZUotME
 +7SX6MDl243LqHXqdDvEgumQAYCErDA36xAmLWEj8PUEy9hunzEkslRwnZA2MRQu4Ce4ch2
 i8QQfAihBHYBxnm348B+iQdREe+NBDyg3AXlxUQRt1UxEQHRaYV4cOSKTwu4wbyFEKAt/kp
 vWWIx6wXTp+ZXCJIEngNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3HiHdPJVe7M=:7cSklzDdqM2TTJj0lOR2Ub
 2g5KEPlXreb/mo5YWw7e3DVba9pcj81DkjylhmMqGnz4i35x2eIAm3o/wiB3HnQ0YucEQAqqV
 PgRljNhR+iQv8AYEwnq5r63vcNRM6or9YaVlsW0QCatE+5s5IozH1nX9CPmNEWcN8AkffFrmH
 NiLx601YlWIsRvDdWhjRpErHvQ80OeY1dV98Mv3Fs/ZGxJP/4rD6fVQOBYUMFb7x+J3mo9E5Q
 JVpc9UHwAt41sUhd2TV55lZsyz2+xQPcbjtR+cyBLmi75bhiF6c/6qjIaRRFGRJ/q3i1+9VI2
 PsOWOxdkQooTTJh0SdhkH4/5z/8FqcYp2SSzHnN6yW4PVoYpM8Y4dZ7xVVC5SAHZXNDTsjxXM
 Ra4La6NPVq1fNGyf1VYV7f6FhA59mynJv1DwwTSVGfGlYyVYFxbULfFZUC3qJ6gLpkULO+LYn
 YJ2XcksLuN6cIDwp+ZFIUSPEzP8Q3duijvExGPXSh1sp4v928MHbgtzRrk8I2F7atpp87I1oU
 gKUMfPIRlXLHQsMkPsG2R3c5OFBn7r+NmH+VPK+BU3v2vT695goh/1C69Vk7XrDv6Bl1m3eg1
 sRQMMxgU/O8tq6vwpovXbGoTAjioMKz3GRP2hOXGpN0rl1nJ7tNGZ3BWGwsDuoVYhQdgP+yb+
 9hBS9C3rNAfH7Y87iTmbvzY3gK405RMJIk/NmjGRfOmQ48SZQshU+YN1rW1CVJnx+4gzBzPRm
 YizD6uevSC6aIaZbC+DjiM3i9a7BThnXuy6De6uA3iF7cjlJYgWTlSpF/e4I581SD6aqub1s3
 p+8R7biP43pV2Y7UiAFxkoi5ny8QD6ylcNSo/UJO6OsKsYSFz3mKE3LCtJvFigIeZwUGOdqz7
 BNmP5NPjKu3Bbh9kxTBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file was moved, causing a build error:

In file included from /git/arm-soc/arch/arm/mach-mmp/pxa168.c:28:
arch/arm/mach-mmp/pxa168.h:22:10: fatal error: cputype.h: No such file or directory

Include it from the new location.

Fixes: 32adcaa010fa ("ARM: mmp: move cputype.h to include/linux/soc/")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/pxa168.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index 6dd17986e360..34f907cd165a 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -17,9 +17,9 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/pxa168_eth.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/soc/mmp/cputype.h>
 
 #include "devices.h"
-#include "cputype.h"
 
 extern struct mmp_device_desc pxa168_device_uart1;
 extern struct mmp_device_desc pxa168_device_uart2;
-- 
2.20.0

