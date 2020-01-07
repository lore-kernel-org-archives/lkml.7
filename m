Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2BCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEBCF206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgAGWJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:09:45 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:09:45 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7NaW-1ilgKN14XM-007mkU; Tue, 07 Jan 2020 23:09:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jyri Sarha <jsarha@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: add dummy of_platform_device_destroy
Date:   Tue,  7 Jan 2020 23:09:31 +0100
Message-Id: <20200107220938.2412463-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S+a5hz8y5ZevQattfXcd6sfhe7pilfWd57VQ1t+xmpqnRsM0UXL
 0Ib9YnuvipOtU9qzEjhfvz/o8rL0W8IbPlhI7ljqgJZ4bSgite1X1JGrQLSY6P7ylg/evPz
 1tv8hGMvHoAadb7LG8ojSjsPqWJq/9orScpIkNvirj0muejlQXxDhaMS3tf6yyce/bNuGPJ
 /2pDgTDnepfNBbrNx7NRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nmmn8MoM4ts=:7jMcmo3i21jz46b1W+ajUm
 jOKVXgYMwWKqUR4k3ayKW47TSxiJ0hcamibfgFVEWO1Lx6iW8re3eN9z6IsC3nsg/ezhpSzfT
 IDnflhe6P3Ho5eARzAQm2scxzdsqKI2sYBWwHh+FXXusONRfQuJ/Gq/Rkl+10HRBmbaDxhBLQ
 H3bNDMoxGcD8LTf7FkBbWFnGE9Vbv8hC74F+qwbXptgYlixv2wy9O7w4q+kmWFndMiY1cuGce
 9Thn5Bze9qtgP05mmahraTpVINoChgsQkqnAUtujZcr8ud8yZPadQdCxwhIjCLo4pA2FYN3Cg
 Wl4qpLa4BbH27SDlP5GniOoat7rCbmXXWf6AYatijFkn27ImidiflWYLy97ip1WRtEiy/yPxa
 K7iCKj9Ld5SQSNc9p4xwR/zqJvh8rdiKjFahO0SHNQ7q+E1kxvE9f78EOoKQ6sSEoCUqiRe9t
 EJP3jXVwBs8ouSJ1qCdGk9YiTO0tkMTdUCa0dqMLnovlzbPVtrghXobeQTA9rbZ4B15rJsTOr
 xtlgX73ursslzyQ+8IEOxBcBsG+ODWxBO9McmPh3zub1paLdQAYHb+QMgkIKhNAZiEIWD3Lpn
 4S4QRUB5+nvrgX1qm0p/h1joN8cNhQj+l4X+p62wXb+cEoxdyZAQdCnmhOKuirMKOUSA225cZ
 3nFsYVKtrRDLf+jjvJVMZtDBA02yJFQ+l9yGgdZMdhzqruvjZQ/fPlOdRvUM5wK8iMEVpx61D
 SjOnKwcC7Kmp24Kt+C60VV7bTZ5IITWE3KMdTCjYabXf3jjH8tyejpIDgw4QD7ajCVgCVjEaa
 ZDvDeAWXSc88IS8BYNub5MrW7zFLfBKXTeH0zNMRdl01BNyAqOoN2HVrEAQIZ/c/7hyEPomsi
 AP8fETeG2ieQT6N+if0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new phy-j721e-wiz driver causes a link failure without CONFIG_OF:

drivers/phy/ti/phy-j721e-wiz.o: In function `wiz_remove':
phy-j721e-wiz.c:(.text+0x40): undefined reference to `of_platform_device_destroy'

Add a dummy version of this function to avoid having to add Kconfig
dependencies for the driver.

Fixes: 42440de5438a ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/of_platform.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..2551c263e57d 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -54,11 +54,16 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 struct device *parent);
 #ifdef CONFIG_OF
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
+extern int of_platform_device_destroy(struct device *dev, void *data);
 #else
 static inline struct platform_device *of_find_device_by_node(struct device_node *np)
 {
 	return NULL;
 }
+static inline int of_platform_device_destroy(struct device *dev, void *data)
+{
+	return 0;
+}
 #endif
 
 /* Platform devices and busses creation */
-- 
2.20.0

