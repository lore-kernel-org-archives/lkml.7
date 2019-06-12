Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D780C31E47
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461F5206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560364770;
	bh=h7l+k/bcQEAMC3at0ERwHPd7g3z3MOmRUpHoIL/NX2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASREsICm4tW9srTgVoKblHUdPo6WrznH6FSqryw/twnghap7J94dF39fAu9tbO5MV
	 6gx91D24fg3uGio/hFp6Dac9QbrqM1E5IAFelO1HR4dkXLIPFiiWttWV3dYGTCBJGR
	 9yNl+lFb8Rx9PChgc2lFJMQXFmi0StgLMcnWYW68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfFLSi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:38:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfFLSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wrhHYkVqalJudClQ5Slfu9mOYqnzTc7imFqa6mcZE60=; b=NZvStiRhsFYYa9NRYUbzGLyLCB
        e+ys6z2hiMJTmmGtBJqfbhG0THHhP9Y6Hlzunfv69+vaMhoYuuY5pyXyOLFvVE/wdeYB097J+GN1E
        GRFbivq15S18qlpvoGc2+3WjQjR9JBGja3e5zBfn/tHi5MzQVuqiOLfLJIjud1DzVCNCc/AMrAoE5
        CObmytyxgRP/a79NBOm6dvic5citOWy+EdrxaGcQhHgwLtEdl+qwh2SQApmCeJJFU53OXRNsGjPQX
        OLxOqyx43nbOPbhLvgEwm9wxMmah4UI7BVJXe8GD5BGae+5j04yNwgfhHUZjy1JdgPr6tYV8Z9lK+
        zu2aAQWg==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb88s-0006Y9-NV; Wed, 12 Jun 2019 18:38:38 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb88q-0002B5-4M; Wed, 12 Jun 2019 15:38:36 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 13/31] docs: bus-devices: ti-gpmc.rst: convert it to ReST
Date:   Wed, 12 Jun 2019 15:38:16 -0300
Message-Id: <7ed15ccc94d3eacefc9b9951daf6701fbcde2b90.1560364494.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560364493.git.mchehab+samsung@kernel.org>
References: <cover.1560364493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to add this file to a book, it needs
first to be converted to ReST and renamed.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../bus-devices/{ti-gpmc.txt => ti-gpmc.rst}  | 159 ++++++++++++------
 1 file changed, 108 insertions(+), 51 deletions(-)
 rename Documentation/bus-devices/{ti-gpmc.txt => ti-gpmc.rst} (58%)

diff --git a/Documentation/bus-devices/ti-gpmc.txt b/Documentation/bus-devices/ti-gpmc.rst
similarity index 58%
rename from Documentation/bus-devices/ti-gpmc.txt
rename to Documentation/bus-devices/ti-gpmc.rst
index cc9ce57e0a26..87c366e418be 100644
--- a/Documentation/bus-devices/ti-gpmc.txt
+++ b/Documentation/bus-devices/ti-gpmc.rst
@@ -1,8 +1,12 @@
-GPMC (General Purpose Memory Controller):
-=========================================
+:orphan:
+
+========================================
+GPMC (General Purpose Memory Controller)
+========================================
 
 GPMC is an unified memory controller dedicated to interfacing external
 memory devices like
+
  * Asynchronous SRAM like memories and application specific integrated
    circuit devices.
  * Asynchronous, synchronous, and page mode burst NOR flash devices
@@ -48,75 +52,128 @@ most of the datasheets & hardware (to be exact none of those supported
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
2.21.0

