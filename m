Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D1C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F04821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Nb1Hlcef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442501AbfIYHKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:10:39 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:22257 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442476AbfIYHKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:10:39 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x8P7AXL0030367;
        Wed, 25 Sep 2019 16:10:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x8P7AXL0030367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569395434;
        bh=fXVBWyTKQl3lqIN66q63sn6BMovSvuXeoZWP7FmMqyw=;
        h=From:To:Cc:Subject:Date:From;
        b=Nb1HlcefId7UOTdAB1YIbZaKMdsjOoL2O795mTtJjYOz2i5H3BF54W4Wwjb4Zpy/b
         AvaZIO8hfbM3GAyFiRUAxJZWYZ5wFdCgkXBVMIJpDwcXanV69kqRcPH8Xor+oTf67y
         HaDl5Y306ESHBqqRgSg+mErgNY29AQSXfLe7UK1Y9Cisx/fepAp3ilH2VTDn79w8JJ
         hGlxGNoMAIPPuQZTsTSeOBMo5KrbttyFJGtxE4VNU9+HdZuAB0ExUpaHMOXkmnjzzb
         Van67J+C09X+lYvrpE9AmNAeU2+3edR9/ag1ZQd40SLdVfeq23xEJ/l3vFIYrii7q1
         h31BYfbyuD6JQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/3] kbuild: update compile-test header list for v5.4-rc1
Date:   Wed, 25 Sep 2019 16:10:30 +0900
Message-Id: <20190925071032.18354-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some build errors were fixed. Add more headers into the test coverage.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 usr/include/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 05c71ef42f51..4ef9946775ee 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -35,7 +35,6 @@ header-test- += linux/errqueue.h
 header-test- += linux/fsmap.h
 header-test- += linux/hdlc/ioctl.h
 header-test- += linux/ivtv.h
-header-test- += linux/jffs2.h
 header-test- += linux/kexec.h
 header-test- += linux/matroxfb.h
 header-test- += linux/netfilter_bridge/ebtables.h
@@ -56,20 +55,12 @@ header-test- += linux/v4l2-mediabus.h
 header-test- += linux/v4l2-subdev.h
 header-test- += linux/videodev2.h
 header-test- += linux/vm_sockets.h
-header-test- += scsi/scsi_bsg_fc.h
-header-test- += scsi/scsi_netlink.h
-header-test- += scsi/scsi_netlink_fc.h
 header-test- += sound/asequencer.h
 header-test- += sound/asoc.h
 header-test- += sound/asound.h
 header-test- += sound/compress_offload.h
 header-test- += sound/emu10k1.h
 header-test- += sound/sfnt_info.h
-header-test- += sound/sof/eq.h
-header-test- += sound/sof/fw.h
-header-test- += sound/sof/header.h
-header-test- += sound/sof/manifest.h
-header-test- += sound/sof/trace.h
 header-test- += xen/evtchn.h
 header-test- += xen/gntdev.h
 header-test- += xen/privcmd.h
-- 
2.17.1

