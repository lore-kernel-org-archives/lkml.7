Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B3C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B72F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfFQMZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:25:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:25:36 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N95Rn-1ietfb3wbn-016B0V; Mon, 17 Jun 2019 14:25:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: ixp4xx: mark ixp4xx_irq_setup as __init
Date:   Mon, 17 Jun 2019 14:24:31 +0200
Message-Id: <20190617122449.457744-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190617122449.457744-1-arnd@arndb.de>
References: <20190617122449.457744-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CfnD4zPWOhfoEEt+/aRsFBaVUzGsrQvBx7m6qk640ipp4z5nl4t
 TDWUJOpBWr3Mi5Bwm6O1XCkdR1gUsL9Xr9MyjAbvJtIRmWaUPKlFVtQ+qwMZCAFtsbHxhF1
 Tt/R4JggHGbNS2wANcBLECFtfMN0/DvlcWqwoxkuoREchnYLdYRf7eXf04VTiTyjXT/ER0V
 ceiPHFFJIMhaKYrZAh1Dg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KZSi4hhzRXQ=:5JRWx406OFkC9CWGAFDw7N
 ZsdoxNqBpiy2pMOKqpj9CbGV/eeM/6TFHKpPMTdDrAsyAo53oHE6jSWKTxc72Cd1fT1HCPJTJ
 sYoggALe8wDKqg3Ci/1q8WBEB2ApUOfm7NZ0b+PWec0GvpQx2rA9o98y7IuuoZeOXrO4Utxbg
 jZ2TtzxizCnF3b6OJH/gGeFzoJhFTeQBkZeFCOgH+cfQ0q+rjzKQAtsl5MrTmyRrlB3FX3FBW
 hT/AmPcnu6zgeouhX96dowduS3EvT5iIEAFMoL23GdJ8Tfi8cJaq1YILWvBxXhkw/w5G5FRTQ
 W4Y0mRy7jKEzVPrkw2y+8t9Ugn0dE0gw1qj8++Ztk8ZK1tuKa0Bd87A9PlIrRA6esCjx8Zsln
 av10VaPjwu1zVqC/y6C06WQZuzIhlMRjgzKDih0vIwlHKta7jlUAwmkwEbeqAxt+ffnf7ykEF
 MatlVJ2SGsrMmVfJMDfcpoUiMYR8hGO1kgOdRbTJIWBjS35PkRWrRL2dUl5aE0Qa9NiSZrCRF
 ydnifDq9bNeHiRnC1OgEtKlXE7xlYhH0GaPxX8vpGKiieU4eHvDf+UMMSdxKZcOOBJuG9XwiJ
 29EgNNoXbtuIiPvF26vvZ4Mrle1nLWnaLsJx7bdZtDJLpiTjs7n+tQ4OoPXEJTukTejhVl84C
 ySyEXoS1xzmDvKVPSsjW7yScwpn3eUKsd8zliHJg4lj0PXAXP+saVNdbLqGEuqbve0KjEhTw7
 Aws9R1XLVqu9ZKJGGlYvNu6Dipb7fblBP0UjnoaFctbwXufiHDR6etFPE44=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kbuild complains about ixp4xx_irq_setup not being __init
itself in some configurations:

WARNING: vmlinux.o(.text+0x85bae4): Section mismatch in reference from the function ixp4xx_irq_setup() to the function .init.text:set_handle_irq()
The function ixp4xx_irq_setup() references
the function __init set_handle_irq().
This is often because ixp4xx_irq_setup lacks a __init
annotation or the annotation of set_handle_irq is wrong.

I suspect it normally gets inlined, so we get no such warning,
but clang makes this obvious when the function is left out
of line.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-ixp4xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index d576809429ac..6751c35b7e1d 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -252,10 +252,10 @@ static const struct ixp4xx_irq_chunk ixp4xx_irq_chunks[] = {
  * @fwnode: Corresponding fwnode abstraction for this controller
  * @is_356: if this is an IXP43x, IXP45x or IXP46x SoC variant
  */
-static int ixp4xx_irq_setup(struct ixp4xx_irq *ixi,
-			    void __iomem *irqbase,
-			    struct fwnode_handle *fwnode,
-			    bool is_356)
+static int __init ixp4xx_irq_setup(struct ixp4xx_irq *ixi,
+				   void __iomem *irqbase,
+				   struct fwnode_handle *fwnode,
+				   bool is_356)
 {
 	int nr_irqs;
 
-- 
2.20.0

