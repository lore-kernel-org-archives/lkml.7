Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E081C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7012166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 04:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KXhQ5tft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfGIEZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 00:25:44 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:42160 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfGIEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:25:41 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x694OqVn009969;
        Tue, 9 Jul 2019 13:24:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x694OqVn009969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562646296;
        bh=5nWs7/nqfQz6GjAJbPPMqdQM8R/kzVjvDPkmY/vF878=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXhQ5tftVYFpZ3lwtqgdh7MBeEKfaX9BSHQKGyw1DEnmO8OXtJTFbPqvG8/8hw5o5
         07xfbmZn5Ru+y04MCFDJB8tlsHrbhZN0iCPXmrjmGURx00kvqohJ7/7eIrP8kNmg9W
         8RxmYnir1mJi5/opP23NRm7sIfg83gXdQ0M4dJQ9MosSMKCdaH39mKfqPydkVCIQlN
         1SNhq5KfdG9ZJHiPLwYU87xZv+xycc6mOD0OAc7TJKsuJGFqz6UaZsbsORU0UJh3gw
         BZeDj+19fnAPk+GANqVdnaIaNPVzojMMwr3Vft1pS8UP76cnUw2+AK5qkvk5srVJ6x
         qzMkAOfa2WTSQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Nicolas Pitre <nico@fluxnic.net>, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] scsi: remove pointless $(MODVERDIR)/$(obj)/53c700.ver
Date:   Tue,  9 Jul 2019 13:24:08 +0900
Message-Id: <20190709042416.27554-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190709042416.27554-1-yamada.masahiro@socionext.com>
References: <20190709042416.27554-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing depends on this, so it is dead code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will apply this to kbuild tree since it is trivial.


 drivers/scsi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 8826111fdf4a..acdd57e647f8 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -183,7 +183,7 @@ zalon7xx-objs	:= zalon.o ncr53c8xx.o
 # Files generated that shall be removed upon make clean
 clean-files :=	53c700_d.h 53c700_u.h scsi_devinfo_tbl.c
 
-$(obj)/53c700.o $(MODVERDIR)/$(obj)/53c700.ver: $(obj)/53c700_d.h
+$(obj)/53c700.o: $(obj)/53c700_d.h
 
 $(obj)/scsi_sysfs.o: $(obj)/scsi_devinfo_tbl.c
 
-- 
2.17.1

