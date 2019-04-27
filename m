Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A18C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B362087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfD0M5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:57:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfD0MxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:07 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mzz6s-1gXTgh3Td8-00x1Ur; Sat, 27 Apr 2019 14:52:37 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 05/41] drivers: tty: serial: dz: use pr_info() instead of incomplete printk()
Date:   Sat, 27 Apr 2019 14:51:46 +0200
Message-Id: <1556369542-13247-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:0divRPlMaEn/Gqkn0bF/qffr0mtJMzUIhhcgUCpKp3L8QfEx3BT
 Sct6DXQKPsKml0HbjLEbqZ0BVdAAcNgJ6gXOI6JC8K/1+PAe8EFl5Aq1lbdbexf9MvYSvJI
 wDh21F+qIQxeFuU3Myc3hkjl/lhNuC86c6zCO8DZIQRpkFEogbQN+oxEVR+QjYaXv/F2Er3
 D3Hg7fjgdOldNL+SYlAwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+RM97HlEygc=:XCYgbldeM4fHTujSYLo9ci
 ZNeOghoSWPCt1C8c6NBMLSfGNddK58lmCDc3rlfBH3ynfXNXoutb/zjRBWM8D3BIY49a4i4UE
 w61HuHHGGrE/nW055rXaTuGx9TatMuVoyD47DJXczfb3oO2GbP0EmAQmzpC+6kDBZdseEXdDC
 Q/7Dzh91Dv5viwhjSOg8QB3blGvc6npMCA3+LRAVdg7cmGKN+31NplbmdslmfdvUCt7Zt8txu
 wu1qVJ20ms6soMtiV40LnA1aD9QGbuHc7kSx8ChK0JcxawU9TBzFvD7nHcdQCkga/Pam6wIlh
 SozaRebsNHrmz6K0Nxx5GSTQPTFKcxIbQTjsZTv+UXWB6g6MdVA8xNYDMcxFB3I9a/OOa1+q6
 SDNeRbSCUbiTqPPGCr4Wlwd5pr0t1wGkI38yOimXepPKVf4067XO8agDegepX6eMqr1dnbVEl
 7E6hKunNpdkhyB0sNKvUPq+uvwV2l/VdX95oOhRD4521oJmMRY3DJ+fuI9JwMF0+0d43RkioS
 NAq5fkYK+cja/PvgpcgRoKs9fOqvE/DvkG7oyD8aLe7kzR0MXQDK6+nm2GtMVAfo9rLlZIslt
 eYSqlXLx6iAbP5p7IGgKyS6G3mEq0IT3MizlVzwRrPBrTI6P7aSZVck/9N5HOec9ocrRvZ2zy
 eP3CmOH7ndIUhAxgSzvJujudRMq1laldwLQ9qL1Fz34ZpgICHygnXc7BQ2s/IBPS3Nvdokjth
 xKIhRxBJYIbWNhrxBOQ1AQzGdb2SfJPFzpfkeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch warning:

    WARNING: printk() should include KERN_<LEVEL> facility level
    #934: FILE: dz.c:934:
    +	printk("%s%s\n", dz_name, dz_version);

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/dz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 559d076..e2670c4 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -931,7 +931,7 @@ static int __init dz_init(void)
 	if (IOASIC)
 		return -ENXIO;
 
-	printk("%s%s\n", dz_name, dz_version);
+	pr_info("%s%s\n", dz_name, dz_version);
 
 	dz_init_ports();
 
-- 
1.9.1

