Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABFBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CC1222E5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCKNap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:45 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAwPf-1hEaIy26PJ-00BITC for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 014/114] drivers: fpga: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:26 +0100
Message-Id: <1552310346-7629-15-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kd6JYi3dQMfGiHqSPS7+dTeubG10nDe58PdLrK//33SxiQumbaN
 ZWUkMFz7DiOU52Ioi+Gbzx3Yz5h6KpVHMYkeVjvEK9oFI6fdd1YKecAXUZSnaoUVrV+zuWg
 npJbBsRbZ4EtxNJEZwKhfS4Y2pnt2VbQFNOmuhYWFKdGku2ndpYfU6lyHHb9/RbHvFh5p46
 5iw5m5PNY4U86EUyx/BYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dVzqy7PPvY4=:Fyx1sCVNqU71fR3OIgVYgE
 wkgUB7I+edrohFNA9/e6sDoCVBbt3cTeZpx8374J8qiv7gVVafLFJTm/7ZcFAvEHMgRKqZkZQ
 5BCzC7Jk1iBy/1yn73y68P/5yZwkZaQNPkBzUb776GRr5EAjm8s/3R5JTrxaT3vmBNUmNo+s6
 DCGHUZSl8mhExlJm1F2nAeAFp+nbsSBKCBvnO+JdRV9ECNQd1991koJGFnSAXAjWU3xgFy6Jg
 OdY7c0ghAih+vjJyCCbsBqCGgMQfN6e8OkTrUu5EsMl29S4DdZTJTlu4GewMF2eAyiOneDJlY
 JaJwpOgJE3rKZrXv4xrxrZVk5J5IYxD1dU9gfZjbsyzVqoFDXilevkGslSZ4DWsq1kyyggt/R
 SVehMpGs1+m25DgLvFk8h6N/m8wriVP2msY96hF1nuhO5VNwen4hbXeMcgbylnVpVlWKNpeaf
 gio8qkeV2ZHVt3Bz0RPPAsyOu/3LFz8AVvIKCsjACXmkyzdDIqysvAZ8RcLGyKIzCkCKnT0Hy
 Gz9C/Xvm18Yt66DmasriLIadIH5st+DD4PqVpxhaSioiJmHGUao4dwpcf8Eei9HWqbWhM50xU
 SrEUZumzLwREH8p9/bNNOYABdKlomUShi5BwvPBuyRThNuEQV0bWlN9CVCsqVqV9kwQzS7FEi
 BvLEfIHTyevo0hRSaY3fTtjeF4hq5NBRAP/sNi3hTlE6wlA/MhLXIFlOyJU0cCjijZXT4+KB8
 CPef+Xiars+L9D2jAZIFLQcy5PXb/ERjYk37Zw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index c20445b..d7324096 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -25,9 +25,9 @@ config FPGA_MGR_SOCFPGA_A10
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
 
 config ALTERA_PR_IP_CORE
-        tristate "Altera Partial Reconfiguration IP Core"
-        help
-          Core driver support for Altera Partial Reconfiguration IP component
+	tristate "Altera Partial Reconfiguration IP Core"
+	help
+	  Core driver support for Altera Partial Reconfiguration IP component
 
 config ALTERA_PR_IP_CORE_PLAT
 	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-- 
1.9.1

