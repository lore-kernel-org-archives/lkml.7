Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FF0C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592E12147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XbKEBJ/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbfHFHH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:07:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:34262 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731734AbfHFHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:07:58 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x7677hZE022667;
        Tue, 6 Aug 2019 16:07:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x7677hZE022667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565075264;
        bh=u3fceE5mZHscEMTwnfxCbpU9SDqg4BEi8R5/DZ+yDSI=;
        h=From:To:Cc:Subject:Date:From;
        b=XbKEBJ/omh4OBu+B9K2CTKBKMcw71k8DHd3a6oQ02RMC5D2wyENrsDZZiBn1g+G7U
         LWnBx8NG6cPLkV2PRe5XXKG5eUMunpDcTfjaDqahjPPCeXm2BMiy8M7QXhXWvE1zWG
         Z5kNwcOa3ZMnMAs6MPyMh6chTekWsG/HK3ANLXpbPV23AdYcMFtPK+50WajUF0xliK
         gAbLgdao2SRh8aXuBeJ9x0vt3VRFshUGeUWrWmAOI8uGRN3hetLRxwF/XD0X1LPLLN
         aFkk2m+TwckLkIPRQ0ZXsg03yo6uoP/z6O2GyxrWoB9UnnGDobnLoYQYB27li5UpCs
         SmT+3Pf13FUUg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: rc: add include guard to rc-map.h
Date:   Tue,  6 Aug 2019 16:07:38 +0900
Message-Id: <20190806070739.2944-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/media/rc-map.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index bebd3c4c6338..4e0873f6e853 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -5,6 +5,9 @@
  * Copyright (c) 2010 by Mauro Carvalho Chehab
  */
 
+#ifndef _MEDIA_RC_MAP_H
+#define _MEDIA_RC_MAP_H
+
 #include <linux/input.h>
 #include <uapi/linux/lirc.h>
 
@@ -290,3 +293,5 @@ struct rc_map *rc_map_get(const char *name);
  * Please, do not just append newer Remote Controller names at the end.
  * The names should be ordered in alphabetical order
  */
+
+#endif /* _MEDIA_RC_MAP_H */
-- 
2.17.1

