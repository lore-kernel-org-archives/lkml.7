Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851E4206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jOmu2Kxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfC2O5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:57:20 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:41304 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfC2O5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:57:20 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 16FFE10C2803;
        Fri, 29 Mar 2019 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1553871440; bh=eVfH1noZhLgu0zqytGrwa2D+CckPexx9xsrj6nK9TiI=;
        h=From:To:Cc:Subject:Date:From;
        b=jOmu2KxlgKkoS/31GrGDRew57zPfmpx3nsVkEjBpi1//Cc7HZc8ty534qTRc/lj2s
         UQr7D+l7qJjMn0YlDoMlC980mBXjTHXuwMfZFJ3XxFFHVvdWMe3jEPK/GZKH6jn7z/
         kkc0jhVvpNcrWXBwqSiUcJjCybR21rFtYo6en0IE0lp5cfeZ9g/Zj86PjRCvKL5+Va
         OuN/xqClwvonmTrcw71J1s9C/tmnnBryNhzBPjWHV7sG7uIXbc9YyI18WeFgNcHafQ
         9IF5vjaPGWAykWwmWGAqwN83MFN1ot3Mg61OdXrpaFskKNHHuSu3aEuAP6NkzRBgwy
         WaGVNeiG2FvZQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id E96E5A006A;
        Fri, 29 Mar 2019 14:57:12 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joe Perches <joe@perches.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH] trivial: MAINTAINERS: fix bad file pattern
Date:   Fri, 29 Mar 2019 17:57:02 +0300
Message-Id: <20190329145702.1894-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bad file pattern in MAINTAINERS section 'SYNOPSYS DESIGNWARE
AXI DMAC DRIVER'

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e5a5d263f29..30f5156336ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14987,7 +14987,7 @@ F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-F:	drivers/dma/dwi-axi-dmac/
+F:	drivers/dma/dwi-axi-dmac/*
 F:	Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.txt
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
-- 
2.14.5

