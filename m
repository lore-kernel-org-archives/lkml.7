Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B481C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157C22073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgAGWPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 17:15:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAGWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 17:15:17 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9wg-1iuW631tIC-00Gbup; Tue, 07 Jan 2020 23:15:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ata: brcm: mark PM functions as __maybe_unused
Date:   Tue,  7 Jan 2020 23:14:59 +0100
Message-Id: <20200107221506.2731280-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DovMoR4b0nCpsdlDujncpNJUI2J0ouf307+Lf21R7sM5u6OzvUg
 gJq6cbUMas+EN4O5Js+6Rmp7Bhl/HHPDxn2nyrB1sd6DkRxKYG/5+o/6PeapiCX8nucTQ7g
 S3QM9wm0QdEW2/NFoNbIErNW88BxtKqnPeCu1nDUCzCvj7bOKldXuHSJN1l7WZROWiWde0n
 sw7oi82zk/quPS4mUExNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qchDad6Zzps=:mnwYVMD1anhgN4O0Kjzm5z
 PLKaLb1ESjAwVHCh8ct35hH+95LNEtDCew/25yEm10Ifoev9p+cdrKI0S+q88FSb8HqBHhZ6X
 sG8Vjg6dgxh3LJU1o6bocPobKKF8bJBh9InqZlxzKnOn2TMNrAcz+Ajn1VB2vK/DzLQwLvI0d
 bc767CIPQo9cfpUxps3qGM6EantmELhf4Km09aIVOjsgwB+A+9wPvioViREby64QFCXJ6qqnx
 tjqTd4n+BS960mOI9e+vMhCB6H/wiR9p0l5RHKXwUcmkXaVevMzrRs1IXQXtI77R617CPgCbo
 t/olOzJOGOLqCQ4B0ZxSAVxwNB6vu8ERkhIFiAV6me4UJKs4lblSCNedtf4a4AsKeJdBr281q
 CeQdWw46RL1Qr6bbWgwrP72FCsPQLCV1oPF05JL6GqsJVYrmG54jEQPYLxWfDqgJg7R15ZBid
 rMXwnaT///N5BhmEUkU8u5XEJWvfvzTbT2ZErj0ltqdBUG8JRGQO1TJL1hLSxaXOBExi4W/YP
 BJUM2W2BFw+NpKJQ3L0Dj7olwjmmVeBxpelX43vXwatgBOXoZMFKj81Vbd/ppsOB/Z4f2be1B
 /fRkKunIxjydl++V4qWL8Wc3Qrf1molEoSz2wvxw5dFrwTf9eZS4RJfBnXwYBQag5bCPh7IPF
 OHryOi3zknhMYc0HXQ/mWZgAD1AgG8uFAGfH1xktMUKdym7Flz1kd6s1aLGdKQ/CrNfMIwAr8
 YYKoQOJ4CTn/yBpR9Z7EBDf2KTZAVtwabB78JNRAkAgOxOQB/0W5zu03g6pKbESKEoO2WDmjd
 1URLJEDO2q/OBVIFqlv47XCObtn0mVOJ+g5g6NyB7C5Hq8PBzaQb8kWmf/THGx31kWUBqGZlt
 N2m/7APz0vfhqa0hFFsg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new shutdown callback causes a link failure:

drivers/ata/ahci_brcm.c: In function 'brcm_ahci_shutdown':
drivers/ata/ahci_brcm.c:552:8: error: implicit declaration of function 'brcm_ahci_suspend'; did you mean 'brcm_ahci_shutdown'? [-Werror=implicit-function-declaration]
  ret = brcm_ahci_suspend(&pdev->dev);
        ^~~~~~~~~~~~~~~~~

Remove the incorrect #ifdef and use __maybe_unused annotations
instead to make this more robust.

Fixes: 7de9b1688c1d ("ata: ahci_brcm: Add a shutdown callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ata/ahci_brcm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 13ceca687104..239333d11b88 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -338,7 +338,6 @@ static const struct ata_port_info ahci_brcm_port_info = {
 	.port_ops	= &ahci_brcm_platform_ops,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int brcm_ahci_suspend(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
@@ -348,7 +347,10 @@ static int brcm_ahci_suspend(struct device *dev)
 
 	brcm_sata_phys_disable(priv);
 
-	ret = ahci_platform_suspend(dev);
+	if (IS_ENABLED(CONFIG_PM_SLEEP))
+		ret = ahci_platform_suspend(dev);
+	else
+		ret = 0;
 
 	if (!IS_ERR_OR_NULL(priv->rcdev))
 		reset_control_assert(priv->rcdev);
@@ -356,7 +358,7 @@ static int brcm_ahci_suspend(struct device *dev)
 	return ret;
 }
 
-static int brcm_ahci_resume(struct device *dev)
+static int __maybe_unused brcm_ahci_resume(struct device *dev)
 {
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv = host->private_data;
@@ -405,7 +407,6 @@ static int brcm_ahci_resume(struct device *dev)
 	ahci_platform_disable_clks(hpriv);
 	return ret;
 }
-#endif
 
 static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
-- 
2.20.0

