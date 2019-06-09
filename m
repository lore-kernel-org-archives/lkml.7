Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A5C28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162CF214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 02:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560047393;
	bh=j3FHrglBK3ElzFAtaKKCdxepOVkIjQNLuGnT28xuhAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KURH0x/ZegUEm4KXCQ36WyM+k020BQrjujusBlZ+LVcp+1CBXRjTNt2s1iaVLd8mC
	 Ty8F4RE8ToygBZfu/cdrLkpScxkTSEVXweaEKo5CKUHYwiLjyGl1GEdge6djEsvd3b
	 xvJ86d0JY/+cbgP4/Wd7fEhfMXaqbkVahOL2DmqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfFIC3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 22:29:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfFIC1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HSCm9fmHq45iKXWvH1z71kgLM8Zr/K08UPBWZ48G3rQ=; b=uEXex3bzRE7TtZEhdIcrgqO2/F
        UUAWu2jvNFKVpxGz0N/V+MDqaVTTbVhMTt1HSEheJkj1I4BRZlaJoXIbCrLo7og9XvTccvNrDCJDT
        xP1wXtLBM7hZpnmtWMLFQ45AJ0jwKOb3hjO9iaN78I3F/MblqNCnwxtYB5g1f+dZ8nfai8GkCA6ly
        r5lRWx9cEcIPXkGXyiTwkNkw9uDOVwaSM8QGaf+7YC5BZul68TcQPJuIkJq4iMWpJHD1X4XV+83yt
        71u5+9gjCI5N+wZO1SfckZRnsYSvMYUVmR1rWjgtxluMYREdO4Zg0A01m2cp8ZEJhDZz+86+YTjFH
        ZhiY92VQ==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hZnYS-0001mu-84; Sun, 09 Jun 2019 02:27:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hZnYL-0000JV-9D; Sat, 08 Jun 2019 23:27:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v3 17/33] docs: mic: convert docs to ReST and rename to *.rst
Date:   Sat,  8 Jun 2019 23:27:07 -0300
Message-Id: <bfb9f5bd5c6278f167f15301df435008d4308830.1560045490.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560045490.git.mchehab+samsung@kernel.org>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
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

