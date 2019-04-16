Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4194EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F8020830
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383407;
	bh=fw61vfk5gsO8JClSVsNdHk2IJ+5JMXvzoTk7o4c5+Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oyiz+VhbWQNwFvlPyv0ZYP2TkSrqbIro/2NQCNUM3J9pxZeiPOPRBxiHJJwxEvuUp
	 TrS8NhNQ7hHWpN62bLInwapgJyV4SJanxuQZmQKVH4hZOKkeHJ6w4CDfbxX6TFITk8
	 KMbo9hfOlcBQ1p/G7OU9vi+wBghzjET6j6ueg/GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfDPC4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:56:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfDPC4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0vxhtLwVYpxipdAQquovU+DdnELtgNHCMg7QkL23hiI=; b=R20+iM2hZVOlo4M2sVHvI4VVav
        b7aLCSCmXewGHNYZ2KoD94lX8O5wndL1RNiF2Fv2nj+pXwdY6ISTUhCAmXSHifSW2KYqhS1n0pE+r
        1OPiQHOxzIkJpZkRX4Onlao3AMr1VS78U4HnIHUgJJNer1TkFQj9svA17LRVJ2XMNbNpofEUPweAz
        GUyt+grXmDHvNaqO0M8xbZgSV9RBDGW6B2dMMrvke1Wogph/BObd/tcHgVz4jTssLyhClBowFf6Tw
        5MM9w1lUJXx6mG83Ta4+9EPgB6D+7bZhkxh3XMp9oTuOPrHRZjDBO3rB1qX8L/aMqakyPPufnjtyb
        oAKVBnVA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGv-0007as-Tb; Tue, 16 Apr 2019 02:56:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGo-0001qA-DN; Mon, 15 Apr 2019 23:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 54/57] docs: bus-devices: ti-gpmc.txt: convert it to ReST
Date:   Mon, 15 Apr 2019 23:56:19 -0300
Message-Id: <3a6d0bd359b267655c9e215bc8392015c379194d.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to add this file to a book, it needs
first to be converted to ReST.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/bus-devices/ti-gpmc.txt | 156 +++++++++++++++++---------
 1 file changed, 105 insertions(+), 51 deletions(-)

diff --git a/Documentation/bus-devices/ti-gpmc.txt b/Documentation/bus-devices/ti-gpmc.txt
index c434fcfc5e4c..afed53688904 100644
--- a/Documentation/bus-devices/ti-gpmc.txt
+++ b/Documentation/bus-devices/ti-gpmc.txt
@@ -1,5 +1,6 @@
-GPMC (General Purpose Memory Controller):
-=========================================
+========================================
+GPMC (General Purpose Memory Controller)
+========================================
 
 GPMC is an unified memory controller dedicated to interfacing external
 memory devices like
@@ -49,75 +50,128 @@ most of the datasheets & hardware (to be exact none of those supported
 in mainline having custom timing routine) and by simulation.
 
 gpmc timing dependency on peripheral timings:
+
 [<gpmc_timing>: <peripheral timing1>, <peripheral timing2> ...]
 
 1. common
-cs_on: t_ceasu
-adv_on: t_avdasu, t_ceavd
+
+cs_on:
+	t_ceasu
+adv_on:
+	t_avdasu, t_ceavd
 
 2. sync common
-sync_clk: clk
-page_burst_access: t_bacc
-clk_activation: t_ces, t_avds
+
+sync_clk:
+	clk
+page_burst_access:
+	t_bacc
+clk_activation:
+	t_ces, t_avds
 
 3. read async muxed
-adv_rd_off: t_avdp_r
-oe_on: t_oeasu, t_aavdh
-access: t_iaa, t_oe, t_ce, t_aa
-rd_cycle: t_rd_cycle, t_cez_r, t_oez
+
+adv_rd_off:
+	t_avdp_r
+oe_on:
+	t_oeasu, t_aavdh
+access:
+	t_iaa, t_oe, t_ce, t_aa
+rd_cycle:
+	t_rd_cycle, t_cez_r, t_oez
 
 4. read async non-muxed
-adv_rd_off: t_avdp_r
-oe_on: t_oeasu
-access: t_iaa, t_oe, t_ce, t_aa
-rd_cycle: t_rd_cycle, t_cez_r, t_oez
+
+adv_rd_off:
+	t_avdp_r
+oe_on:
+	t_oeasu
+access:
+	t_iaa, t_oe, t_ce, t_aa
+rd_cycle:
+	t_rd_cycle, t_cez_r, t_oez
 
 5. read sync muxed
-adv_rd_off: t_avdp_r, t_avdh
-oe_on: t_oeasu, t_ach, cyc_aavdh_oe
-access: t_iaa, cyc_iaa, cyc_oe
-rd_cycle: t_cez_r, t_oez, t_ce_rdyz
+
+adv_rd_off:
+	t_avdp_r, t_avdh
+oe_on:
+	t_oeasu, t_ach, cyc_aavdh_oe
+access:
+	t_iaa, cyc_iaa, cyc_oe
+rd_cycle:
+	t_cez_r, t_oez, t_ce_rdyz
 
 6. read sync non-muxed
-adv_rd_off: t_avdp_r
-oe_on: t_oeasu
-access: t_iaa, cyc_iaa, cyc_oe
-rd_cycle: t_cez_r, t_oez, t_ce_rdyz
+
+adv_rd_off:
+	t_avdp_r
+oe_on:
+	t_oeasu
+access:
+	t_iaa, cyc_iaa, cyc_oe
+rd_cycle:
+	t_cez_r, t_oez, t_ce_rdyz
 
 7. write async muxed
-adv_wr_off: t_avdp_w
-we_on, wr_data_mux_bus: t_weasu, t_aavdh, cyc_aavhd_we
-we_off: t_wpl
-cs_wr_off: t_wph
-wr_cycle: t_cez_w, t_wr_cycle
+
+adv_wr_off:
+	t_avdp_w
+we_on, wr_data_mux_bus:
+	t_weasu, t_aavdh, cyc_aavhd_we
+we_off:
+	t_wpl
+cs_wr_off:
+	t_wph
+wr_cycle:
+	t_cez_w, t_wr_cycle
 
 8. write async non-muxed
-adv_wr_off: t_avdp_w
-we_on, wr_data_mux_bus: t_weasu
-we_off: t_wpl
-cs_wr_off: t_wph
-wr_cycle: t_cez_w, t_wr_cycle
+
+adv_wr_off:
+	t_avdp_w
+we_on, wr_data_mux_bus:
+	t_weasu
+we_off:
+	t_wpl
+cs_wr_off:
+	t_wph
+wr_cycle:
+	t_cez_w, t_wr_cycle
 
 9. write sync muxed
-adv_wr_off: t_avdp_w, t_avdh
-we_on, wr_data_mux_bus: t_weasu, t_rdyo, t_aavdh, cyc_aavhd_we
-we_off: t_wpl, cyc_wpl
-cs_wr_off: t_wph
-wr_cycle: t_cez_w, t_ce_rdyz
+
+adv_wr_off:
+	t_avdp_w, t_avdh
+we_on, wr_data_mux_bus:
+	t_weasu, t_rdyo, t_aavdh, cyc_aavhd_we
+we_off:
+	t_wpl, cyc_wpl
+cs_wr_off:
+	t_wph
+wr_cycle:
+	t_cez_w, t_ce_rdyz
 
 10. write sync non-muxed
-adv_wr_off: t_avdp_w
-we_on, wr_data_mux_bus: t_weasu, t_rdyo
-we_off: t_wpl, cyc_wpl
-cs_wr_off: t_wph
-wr_cycle: t_cez_w, t_ce_rdyz
 
+adv_wr_off:
+	t_avdp_w
+we_on, wr_data_mux_bus:
+	t_weasu, t_rdyo
+we_off:
+	t_wpl, cyc_wpl
+cs_wr_off:
+	t_wph
+wr_cycle:
+	t_cez_w, t_ce_rdyz
 
-Note: Many of gpmc timings are dependent on other gpmc timings (a few
-gpmc timings purely dependent on other gpmc timings, a reason that
-some of the gpmc timings are missing above), and it will result in
-indirect dependency of peripheral timings to gpmc timings other than
-mentioned above, refer timing routine for more details. To know what
-these peripheral timings correspond to, please see explanations in
-struct gpmc_device_timings definition. And for gpmc timings refer
-IP details (link above).
+
+Note:
+  Many of gpmc timings are dependent on other gpmc timings (a few
+  gpmc timings purely dependent on other gpmc timings, a reason that
+  some of the gpmc timings are missing above), and it will result in
+  indirect dependency of peripheral timings to gpmc timings other than
+  mentioned above, refer timing routine for more details. To know what
+  these peripheral timings correspond to, please see explanations in
+  struct gpmc_device_timings definition. And for gpmc timings refer
+  IP details (link above).
-- 
2.20.1

