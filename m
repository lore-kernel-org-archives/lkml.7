Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB20C468BF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6021216C4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560047340;
	bh=aDuCU3aaGAjFnCy4AsvirIwWKl9KElgVCpqLWASKPy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFzFGxY6es9Z72ansRx6Kbw73wQoqFRc2E4iQtEkZ9aFTCuBl7NzxV2iiPqb/oZj0
	 QYv2Nzw+1+nlSinRNRxh93FihVbdecZbjdvBT8fm9Z2tMWSRCk6muvyhi1U8xMOjdN
	 Z85qx8nk9OSxAGy36bjkurj73KQbZ6ZiqMpyAMYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfFIC2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:28:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfFIC1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JGHmLGAcdvDuLmjQSH5brRnA4InBvQap8OoIg0IyhA0=; b=sfj9nOnlQ14vsAIFOz/JhITlgE
        Vf9+O6pQl0gCEJ7UGOz5dopHZo3vaKrVKm7mwhloZatecAXWUEVo83GKXQdkuJ4SEibfj7z5ZPqhR
        0Sq81td1+wAtsdElfioQYLuuAuQQlOChUXqUoVBb2jAtnis5hbGPjOJB1nF7/AWs/rwICkd1I5UaL
        CYZZjDBrNz18zxQXWrzxHX6AtI4YxLEDSVZuaoK5YBE1b/jUaH2UqLVembArgzwWrq30WT5pOKZuT
        odcBDeLqs17yN5MnwkOMNPvRFYg7Dv1fopuu9R8xYqtZThWO6Iiueq7xDQetYl137kmiQadwjiFsC
        oWaMTk3A==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYS-0001nB-MO; Sun, 09 Jun 2019 02:27:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000Kd-NK; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 31/33] docs: xilinx: convert eemi.txt to eemi.rst
Date:   Sat,  8 Jun 2019 23:27:21 -0300
Message-Id: <1f3dfdcaa06e339791a86cf99918d7d0a2b52a67.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very trivial conversion: adjust the title markup
and add a few literal block markups to produce a better
visual when parsed and avoid warnings.

As newer documents related to xilinx could be added in the future,
create a new index file for it.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/xilinx/{eemi.txt => eemi.rst} |  8 ++++----
 Documentation/xilinx/index.rst              | 17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)
 rename Documentation/xilinx/{eemi.txt => eemi.rst} (92%)
 create mode 100644 Documentation/xilinx/index.rst

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.rst
similarity index 92%
rename from Documentation/xilinx/eemi.txt
rename to Documentation/xilinx/eemi.rst
index 5f39b4ffdcd4..9dcbc6f18d75 100644
--- a/Documentation/xilinx/eemi.txt
+++ b/Documentation/xilinx/eemi.rst
@@ -1,6 +1,6 @@
----------------------------------------------------------------------
+====================================
 Xilinx Zynq MPSoC EEMI Documentation
----------------------------------------------------------------------
+====================================
 
 Xilinx Zynq MPSoC Firmware Interface
 -------------------------------------
@@ -21,7 +21,7 @@ The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
 structure. Any driver who want to communicate with PMC using EEMI APIs
 can call zynqmp_pm_get_eemi_ops().
 
-Example of EEMI ops:
+Example of EEMI ops::
 
 	/* zynqmp-firmware driver maintain all EEMI APIs */
 	struct zynqmp_eemi_ops {
@@ -34,7 +34,7 @@ Example of EEMI ops:
 		.query_data = zynqmp_pm_query_data,
 	};
 
-Example of EEMI ops usage:
+Example of EEMI ops usage::
 
 	static const struct zynqmp_eemi_ops *eemi_ops;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
diff --git a/Documentation/xilinx/index.rst b/Documentation/xilinx/index.rst
new file mode 100644
index 000000000000..01cc1a0714df
--- /dev/null
+++ b/Documentation/xilinx/index.rst
@@ -0,0 +1,17 @@
+:orphan:
+
+===========
+Xilinx FPGA
+===========
+
+.. toctree::
+    :maxdepth: 1
+
+    eemi
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
-- 
2.21.0

