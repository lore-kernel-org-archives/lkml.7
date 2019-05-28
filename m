Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF68BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B33208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfE1JIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:08:17 -0400
Received: from shell.v3.sk ([90.176.6.54]:36871 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfE1JHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:07:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5C2011048AA;
        Tue, 28 May 2019 11:07:50 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z1xslYVOyXUb; Tue, 28 May 2019 11:07:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5567D10489D;
        Tue, 28 May 2019 11:07:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RJ9icm1v8IgK; Tue, 28 May 2019 11:07:35 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id AAB601048A2;
        Tue, 28 May 2019 11:07:34 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v6 4/7] [media] marvell-ccic: rename the clocks
Date:   Tue, 28 May 2019 11:07:28 +0200
Message-Id: <20190528090731.10341-5-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190528090731.10341-1-lkundrak@v3.sk>
References: <20190528090731.10341-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the names more suitable for devicetree bindings.

There are no board files utilizing this, thus we seem to be at liberty
at renaming this without consequences.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v2:
- This patch was added to the series

 drivers/media/platform/marvell-ccic/mmp-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/marvell-ccic/mmp-driver.c b/drivers/m=
edia/platform/marvell-ccic/mmp-driver.c
index 352e67fc1062..8f1d2a972bc9 100644
--- a/drivers/media/platform/marvell-ccic/mmp-driver.c
+++ b/drivers/media/platform/marvell-ccic/mmp-driver.c
@@ -33,7 +33,7 @@ MODULE_ALIAS("platform:mmp-camera");
 MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
 MODULE_LICENSE("GPL");
=20
-static char *mcam_clks[] =3D {"CCICAXICLK", "CCICFUNCLK", "CCICPHYCLK"};
+static char *mcam_clks[] =3D {"axi", "func", "phy"};
=20
 struct mmp_camera {
 	void __iomem *power_regs;
--=20
2.21.0

