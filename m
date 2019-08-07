Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD00C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6FD21E71
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbfHGNXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:23:16 -0400
Received: from shell.v3.sk ([90.176.6.54]:42187 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387982AbfHGNXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:23:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 62AA0CE936;
        Wed,  7 Aug 2019 15:23:04 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qtiGHbHI3M9J; Wed,  7 Aug 2019 15:22:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6899ECE960;
        Wed,  7 Aug 2019 15:22:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2uLt4fx0TC8T; Wed,  7 Aug 2019 15:22:54 +0200 (CEST)
Received: from furthur.local (ip-37-188-233-8.eurotel.cz [37.188.233.8])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 3A902CE936;
        Wed,  7 Aug 2019 15:22:45 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] of: irq: fix a trivial typo in a doc comment
Date:   Wed,  7 Aug 2019 15:22:31 +0200
Message-Id: <20190807132231.10454-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diverged from what the code does with commit 530210c7814e ("of/irq: Repla=
ce
of_irq with of_phandle_args").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 7f84bb4903caa..a296eaf52a5b2 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -277,7 +277,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_raw);
  * of_irq_parse_one - Resolve an interrupt for a device
  * @device: the device whose interrupt is to be resolved
  * @index: index of the interrupt to resolve
- * @out_irq: structure of_irq filled by this function
+ * @out_irq: structure of_phandle_args filled by this function
  *
  * This function resolves an interrupt for a node by walking the interru=
pt tree,
  * finding which interrupt controller node it is attached to, and return=
ing the
--=20
2.21.0

