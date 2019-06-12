Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716A521721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560362208;
	bh=j3FHrglBK3ElzFAtaKKCdxepOVkIjQNLuGnT28xuhAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fwLsCT8fjkn4Lonbo+X25oUQK6f4QkAQ0asMAkvsRLAkgN5F+1KqFIfygrv5urK5s
	 Mhqmt8V1alzngEGiUPo6VbdD36g3G89fqlK5ksTorFPGWF1LNT3yg+IXQNNWRuUNH8
	 zJCtyDwMQcMHhy2nPoVZ6fH+wv+NgRyC1HLuOQGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfFLR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:56:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388381AbfFLRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HSCm9fmHq45iKXWvH1z71kgLM8Zr/K08UPBWZ48G3rQ=; b=kJCrYJnNRG+T/i8p0SFrwjrMkr
        19SZQRfn+IMOssbbwMr8p9eTJLbxQlE0CzEkxNP3MDXn4axwXKcIf7ZdtmsZmvd8UDdorMizZQ2+o
        5Rj6PaL+4gFRZ7u0/uaVsAWLvbuhA3GOf1+1zB8sPlBcWfuPL0JyiUeIMU+1IXtvQRQxtzCm+p8m4
        QCTAmLTM3n/h9lC+xGRm279b/s8RELcGxSL4O/B2FyCmN/bf2CaJUgrt9tO6dUHt/N9o77ZWrGn/I
        C26XwUhNCztYHr2ma86mt2WbUMhmhnKhTLNRp+OK5mhc9oJ2jcDnm4397XlflfOcy4E9bq0fBqP9l
        YWRznc0w==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb7Qt-0002Dg-23; Wed, 12 Jun 2019 17:53:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hb7Qq-0001gm-De; Wed, 12 Jun 2019 14:53:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v4 15/28] docs: mic: convert docs to ReST and rename to *.rst
Date:   Wed, 12 Jun 2019 14:52:51 -0300
Message-Id: <b2e5b38de65402453e48c6e0aa5cc362f1824e13.1560361364.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560361364.git.mchehab+samsung@kernel.org>
References: <cover.1560361364.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Intel Many Integrated Core architecture docs to ReST.

The conversion is trivial: just add title and literal block
markups, and adjust some identation.

At its new index.rst, let's add a :orphan: while this is not linked to
the main index.rst file, in order to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/mic/index.rst                   | 18 ++++++
 .../{mic_overview.txt => mic_overview.rst}    |  6 +-
 .../{scif_overview.txt => scif_overview.rst}  | 58 +++++++++++--------
 3 files changed, 57 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/mic/index.rst
 rename Documentation/mic/{mic_overview.txt => mic_overview.rst} (96%)
 rename Documentation/mic/{scif_overview.txt => scif_overview.rst} (76%)

diff --git a/Documentation/mic/index.rst b/Documentation/mic/index.rst
new file mode 100644
index 000000000000..082fa8f6a260
--- /dev/null
+++ b/Documentation/mic/index.rst
@@ -0,0 +1,18 @@
+:orphan:
+
+=============================================
+Intel Many Integrated Core (MIC) architecture
+=============================================
+
+.. toctree::
+    :maxdepth: 1
+
+    mic_overview
+    scif_overview
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/mic/mic_overview.txt b/Documentation/mic/mic_overview.rst
similarity index 96%
rename from Documentation/mic/mic_overview.txt
rename to Documentation/mic/mic_overview.rst
index 074adbdf83a4..17d956bdaf7c 100644
--- a/Documentation/mic/mic_overview.txt
+++ b/Documentation/mic/mic_overview.rst
@@ -1,3 +1,7 @@
+======================================================
+Intel Many Integrated Core (MIC) architecture overview
+======================================================
+
 An Intel MIC X100 device is a PCIe form factor add-in coprocessor
 card based on the Intel Many Integrated Core (MIC) architecture
 that runs a Linux OS. It is a PCIe endpoint in a platform and therefore
@@ -45,7 +49,7 @@ Here is a block diagram of the various components described above. The
 virtio backends are situated on the host rather than the card given better
 single threaded performance for the host compared to MIC, the ability of
 the host to initiate DMA's to/from the card using the MIC DMA engine and
-the fact that the virtio block storage backend can only be on the host.
+the fact that the virtio block storage backend can only be on the host::
 
                +----------+           |             +----------+
                | Card OS  |           |             | Host OS  |
diff --git a/Documentation/mic/scif_overview.txt b/Documentation/mic/scif_overview.rst
similarity index 76%
rename from Documentation/mic/scif_overview.txt
rename to Documentation/mic/scif_overview.rst
index 0a280d986731..4c8ad9e43706 100644
--- a/Documentation/mic/scif_overview.txt
+++ b/Documentation/mic/scif_overview.rst
@@ -1,3 +1,7 @@
+========================================
+Symmetric Communication Interface (SCIF)
+========================================
+
 The Symmetric Communication Interface (SCIF (pronounced as skiff)) is a low
 level communications API across PCIe currently implemented for MIC. Currently
 SCIF provides inter-node communication within a single host platform, where a
@@ -8,8 +12,11 @@ is to deliver the maximum possible performance given the communication
 abilities of the hardware. SCIF has been used to implement an offload compiler
 runtime and OFED support for MPI implementations for MIC coprocessors.
 
-==== SCIF API Components ====
+SCIF API Components
+===================
+
 The SCIF API has the following parts:
+
 1. Connection establishment using a client server model
 2. Byte stream messaging intended for short messages
 3. Node enumeration to determine online nodes
@@ -28,9 +35,12 @@ can also register local memory which is followed by data transfer using either
 DMA, CPU copies or remote memory mapping via mmap. SCIF supports both user and
 kernel mode clients which are functionally equivalent.
 
-==== SCIF Performance for MIC ====
+SCIF Performance for MIC
+========================
+
 DMA bandwidth comparison between the TCP (over ethernet over PCIe) stack versus
-SCIF shows the performance advantages of SCIF for HPC applications and runtimes.
+SCIF shows the performance advantages of SCIF for HPC applications and
+runtimes::
 
              Comparison of TCP and SCIF based BW
 
@@ -66,33 +76,33 @@ space API similar to the kernel API in scif.h. The SCIF user space library
 is distributed @ https://software.intel.com/en-us/mic-developer
 
 Here is some pseudo code for an example of how two applications on two PCIe
-nodes would typically use the SCIF API:
+nodes would typically use the SCIF API::
 
-Process A (on node A)			Process B (on node B)
+  Process A (on node A)			Process B (on node B)
 
-/* get online node information */
-scif_get_node_ids(..)			scif_get_node_ids(..)
-scif_open(..)				scif_open(..)
-scif_bind(..)				scif_bind(..)
-scif_listen(..)
-scif_accept(..)				scif_connect(..)
-/* SCIF connection established */
+  /* get online node information */
+  scif_get_node_ids(..)			scif_get_node_ids(..)
+  scif_open(..)				scif_open(..)
+  scif_bind(..)				scif_bind(..)
+  scif_listen(..)
+  scif_accept(..)				scif_connect(..)
+  /* SCIF connection established */
 
-/* Send and receive short messages */
-scif_send(..)/scif_recv(..)		scif_send(..)/scif_recv(..)
+  /* Send and receive short messages */
+  scif_send(..)/scif_recv(..)		scif_send(..)/scif_recv(..)
 
-/* Register memory */
-scif_register(..)			scif_register(..)
+  /* Register memory */
+  scif_register(..)			scif_register(..)
 
-/* RDMA */
-scif_readfrom(..)/scif_writeto(..)	scif_readfrom(..)/scif_writeto(..)
+  /* RDMA */
+  scif_readfrom(..)/scif_writeto(..)	scif_readfrom(..)/scif_writeto(..)
 
-/* Fence DMAs */
-scif_fence_signal(..)			scif_fence_signal(..)
+  /* Fence DMAs */
+  scif_fence_signal(..)			scif_fence_signal(..)
 
-mmap(..)				mmap(..)
+  mmap(..)				mmap(..)
 
-/* Access remote registered memory */
+  /* Access remote registered memory */
 
-/* Close the endpoints */
-scif_close(..)				scif_close(..)
+  /* Close the endpoints */
+  scif_close(..)				scif_close(..)
-- 
2.21.0

