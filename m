Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1EC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADB12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFQM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:26:04 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfFQM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:26:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhDIw-1iFm1T14Ik-00eILm; Mon, 17 Jun 2019 14:25:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: ixp4xx: include irqs.h where needed
Date:   Mon, 17 Jun 2019 14:24:32 +0200
Message-Id: <20190617122449.457744-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190617122449.457744-1-arnd@arndb.de>
References: <20190617122449.457744-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ogxG53xxYtKSunk3MRNQJAEkPnjE5pExadqIw1wtkbMkNmusoj9
 aZO36fRS80Wu/8c4ipcqJ+zvnYjQNIkJR4SCcFvTYhva+3LV3IEq749pLMtw8R/r2KrLwWa
 FagBXt9Ly5NshVz8XjZe/q/y+qht9OjYIz8VcckwU498AqLWgRsBAQ2qnmu16n/lhR7Hx0E
 Yb0tA8yzzPP6mO9cbbGOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DfHKUbhazqM=:YDY2/2Alqmy6ferl84BsB7
 aTPywctrbekMzh8cdM3EsbjDQAS4kYQ6x40t3G+jSNk1GCteQrQ9qaT8fJp2mp/2OCVzA8qsW
 kkSILkIdM8OVdMpuPg8+25kNURFM8JYrTL+TcbbHIx7k3Lq9R/vD0y+hU64s2LyqPPPh0slyn
 N3LnzMVWa4B1kQza2oz4IWYFWIhGuw4yPD4JOPm/ad6tagM9LxxM/TnaoBACJTKMLgQb8TpUb
 ZwuBcdk8NzAq9MYq3o0lou2x2/4ai9kFW+slBUVpBA6xGQkKz8+3xtq/OAkrBgrNlqdK++Djz
 tg4ZlQK6DbriSz0wargKxCiKpLafM6pwO28XW7V7aXdrBbcRivhAsohFrX7MqVhdlx9H3uiHN
 /8qILCdsv37YqYuxeFLHlcxdZoOmYpObWiDn3oe28Q0ks48ioZIstBoi6TW34Tk7Yh7LzBDuA
 QIJOBYHK2ybQccAFTmStPaVWx7bCXh44ts0sPkbzmDG/D8T2sq29iHcmy2biGDCeagMYL9H3A
 UI17s4Xo4o/GpKfGrVvHJCMRdchId8Zp79M0FLgG7WmremXejp11NuqPIPOKMgGK7xdmZi0Vq
 orq/NVKHc1ccDZL/aCh5You0KvzNWInt+AIj2ePLJNfiMNWt5Z8Pt7nvlCkDMIrGdKGE4paH8
 xMcxineZ/BYiWyGNDO77IJ5ZD6vqhh/8I54dPAAPmhlaFlGwH/D2bUmg8qz6U0Y9uGF+5CmY3
 gMlxUwAqfuMJLxF4+45prNpvpPB2L/RelpYWQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple ixp4xx specific files require macros from irqs.h that
were moved out from mach/irqs.h, e.g.:

arch/arm/mach-ixp4xx/vulcan-pci.c:41:19: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
arch/arm/mach-ixp4xx/vulcan-pci.c:49:10: error: implicit declaration of function 'IXP4XX_GPIO_IRQ' [-Werror,-Wimplicit-function-declaration]
                return IXP4XX_GPIO_IRQ(INTA);

Include this header in all files that failed to build because of
that.

Fixes: dc8ef8cd3a05 ("ARM: ixp4xx: Convert to SPARSE_IRQ")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/goramo_mlr.c   | 2 ++
 arch/arm/mach-ixp4xx/miccpt-pci.c   | 2 ++
 arch/arm/mach-ixp4xx/omixp-setup.c  | 2 ++
 arch/arm/mach-ixp4xx/vulcan-pci.c   | 2 ++
 arch/arm/mach-ixp4xx/vulcan-setup.c | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-ixp4xx/goramo_mlr.c b/arch/arm/mach-ixp4xx/goramo_mlr.c
index 4d805080020e..a0e0b6b7dc5c 100644
--- a/arch/arm/mach-ixp4xx/goramo_mlr.c
+++ b/arch/arm/mach-ixp4xx/goramo_mlr.c
@@ -18,6 +18,8 @@
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
 
+#include "irqs.h"
+
 #define SLOT_ETHA		0x0B	/* IDSEL = AD21 */
 #define SLOT_ETHB		0x0C	/* IDSEL = AD20 */
 #define SLOT_MPCI		0x0D	/* IDSEL = AD19 */
diff --git a/arch/arm/mach-ixp4xx/miccpt-pci.c b/arch/arm/mach-ixp4xx/miccpt-pci.c
index d114ccd2017c..ca889ef068a5 100644
--- a/arch/arm/mach-ixp4xx/miccpt-pci.c
+++ b/arch/arm/mach-ixp4xx/miccpt-pci.c
@@ -25,6 +25,8 @@
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 #define MAX_DEV		4
 #define IRQ_LINES	4
 
diff --git a/arch/arm/mach-ixp4xx/omixp-setup.c b/arch/arm/mach-ixp4xx/omixp-setup.c
index 2d494b454376..c02fa6f48382 100644
--- a/arch/arm/mach-ixp4xx/omixp-setup.c
+++ b/arch/arm/mach-ixp4xx/omixp-setup.c
@@ -27,6 +27,8 @@
 
 #include <mach/hardware.h>
 
+#include "irqs.h"
+
 static struct resource omixp_flash_resources[] = {
 	{
 		.flags	= IORESOURCE_MEM,
diff --git a/arch/arm/mach-ixp4xx/vulcan-pci.c b/arch/arm/mach-ixp4xx/vulcan-pci.c
index a4220fa5e0c3..6e41e5ece4e1 100644
--- a/arch/arm/mach-ixp4xx/vulcan-pci.c
+++ b/arch/arm/mach-ixp4xx/vulcan-pci.c
@@ -21,6 +21,8 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
+#include "irqs.h"
+
 /* PCI controller GPIO to IRQ pin mappings */
 #define INTA	2
 #define INTB	3
diff --git a/arch/arm/mach-ixp4xx/vulcan-setup.c b/arch/arm/mach-ixp4xx/vulcan-setup.c
index 2c03d2f6b647..d2ebb7c675a8 100644
--- a/arch/arm/mach-ixp4xx/vulcan-setup.c
+++ b/arch/arm/mach-ixp4xx/vulcan-setup.c
@@ -22,6 +22,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
 
+#include "irqs.h"
+
 static struct flash_platform_data vulcan_flash_data = {
 	.map_name	= "cfi_probe",
 	.width		= 2,
-- 
2.20.0

