Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C01C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015DF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383476;
	bh=x7Ft9vzAlnhMI8ZeQ24BPRsbn3GTq1FhyAAOJsrvDiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O4r7SI/8TGYTToTqfXmxje7yxoSmOzhEEY2yBX3EG/L0UsR2iRaVGVWUtR9xpt730
	 5ze/2d6VnlHa/xOiKjTBukxYZt1/DHvflvOe6HM0Y8H0zm1VIi/VMw5XpqiM/cAeFU
	 4DIa9qZ2HxCOp/Ixle8AJtd3Ov/ky/3Kfitnsx6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfDPC5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:57:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfDPC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CZuB5hyd41KNTkULPN/z9fb4YmP20QJrbGcZaK5HgTI=; b=XzUHp5kka9oxVj3wNgBdFRNtn+
        ulicsIeSAXka8HItQHAGGhkJAsS4SQiL7+iwAC0fMHmlAb7CVsEMgZ5Zrohwsk4CW6zgz8D+X/RwP
        TUFLa0HOYXDMJZ3P4YLL86+h26Oex6h7HFXn8zunLybfq2l7v3ZPUkFsWtVCmYFW8LmUix+X8JQTC
        F5vu4ymsiNngfvClCJbT/6jbJJmXp1HA57cxDvv05RrcFXTiqp07cYJ8CFUrH/JeS3Nnwt4fHt8CM
        mmtSY4YIUcEvJQzqBPbOaOW7a733cin3fIVKoeQtI1Oi7CevZljW7u/BC6qWZRW2C7JA0oGeBiCOB
        wjMlCjVw==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGw-0007aR-L5; Tue, 16 Apr 2019 02:56:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001ow-W4; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 39/57] docs: xilinx: convert eemi.txt to ReST
Date:   Mon, 15 Apr 2019 23:56:04 -0300
Message-Id: <b18a80494ce228bc6980b4e38541781a24e52740.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very trivial conversion: adjust the title markup
and add a few literal block markups to produce a better
visual when parsed and avoid warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/xilinx/eemi.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/xilinx/eemi.txt b/Documentation/xilinx/eemi.txt
index 0ab686c173be..8ca82c782ba6 100644
--- a/Documentation/xilinx/eemi.txt
+++ b/Documentation/xilinx/eemi.txt
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
-- 
2.20.1

