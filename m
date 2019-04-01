Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F719C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3141A206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GKcw0itE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfDASJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:09:18 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:60068 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfDASJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:09:15 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id AA22110C1B85;
        Mon,  1 Apr 2019 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1554142154; bh=X2vEap8QyGsYOhHhNYstKy6P734YLI9dL8Q2H9Fdg9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=GKcw0itE12J2KY44wazEtjktpiBWEZoaHM1o270/tsIwPR9RYE/YAKJ9ZWpAoKlOA
         yyEHwtIT3KI0/SzKpYLJ1Rw8hXmoRsudVjRpXT7kuWLvwaxuumENSwXex8rzUzR7Eb
         UeDwqFC9IapwK4w4193saIn+xvsSgBTUop8Q2/0d5e3r2VmZEkqtv2bHiOvd4vHZ/Z
         yoMfF+jze+fTm/maMIxn58HzVCJUq5UbxiqLshS9TFxtAeizcfoMIq7Qs3qMOg8mPw
         NyKaHCITQw1FOC+jYtWb2JNGOk/mjn9N+p5iJX02/6FJsqRCIT0AQx3usTKC9WN1fv
         fVkKN3Qkm8p4A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id 32453A005A;
        Mon,  1 Apr 2019 18:09:11 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joe Perches <joe@perches.com>, Vinod Koul <vkoul@kernel.org>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH trivial v2] MAINTAINERS: fix bad file pattern in SYNOPSYS DESIGNWARE AXI DMAC DRIVER
Date:   Mon,  1 Apr 2019 21:09:09 +0300
Message-Id: <20190401180909.6288-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1fe20f1b8454 ("dmaengine: Introduce DW AXI DMAC driver")
added an incorrect file pattern. Fix it.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..be8285e81b6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14987,7 +14987,7 @@ F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	drivers/dma/dwi-axi-dmac/
+F:	drivers/dma/dw-axi-dmac/
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.14.5

