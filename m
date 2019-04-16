Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74DE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383633;
	bh=TF7X8rSB8usO5/F6NsN6QlXy2LON0XyBBA5OJUiaR3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpnnN9CepIvGkpR/CiuaO9KVDotgChYs+Eo+6AVhoMbrsnxcFAV2fZV1P5jsE4Y0s
	 R9Ch0/KqZwwFVbZHwgGsDktf8KbRajFcf5b++8LK+EmJIvghqLtIz0x0Ws2Cyah0SF
	 aA1uMDFNJCRIaCRKXSbQisRcU8RsVyD5PA3eE8rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfDPDAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:00:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfDPC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jXkdB0C3YC54scrOjj5bnKKgWfCNB6nvC4e9vjR9xpc=; b=uaIt6UabKVv8vlKA8HKuN6a6LW
        CSSsIrzqhVrDCAy1RX6Yf5ITGrQn9UVHBmKChhdl5gNbkuoVBjpcnMhO0U3NiLLm3g4tN26dlFaRq
        xVOGzIpn8SJZOsEvAE0+g7MLIjRY3Cy4JYik8tlXqQj+a2ytsrQpardLUc/LfDkYTKkNS6xoNeVmi
        U2CPElbxXHzcdNlZmNweKX2X7xo+7DTSfDuDvE65wRxMrtWlYUmY5JuURLQUK7VaA17bvccogMY8V
        i18gikBg/XPz5SB0WL8wc2OoVIJYlvp8LclU227q36ql1X5szTmGQJaussXXCJMsN3OaBJSdnrfI0
        0RNS/dJQ==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGu-0007ad-Ji; Tue, 16 Apr 2019 02:56:32 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001nI-Fj; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 22/57] docs: mic: convert it to ReST format
Date:   Mon, 15 Apr 2019 23:55:47 -0300
Message-Id: <a8d9e0dee8df3b8f369543ca23f4bd0a9c6e0271.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Intel Many Integrated Core architecture docs to ReST.

The conversion is trivial: just add title and literal block
markups, and adjust some identation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/mic/mic_overview.txt  |  6 ++-
 Documentation/mic/scif_overview.txt | 58 +++++++++++++++++------------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/Documentation/mic/mic_overview.txt b/Documentation/mic/mic_overview.txt
index 074adbdf83a4..17d956bdaf7c 100644
--- a/Documentation/mic/mic_overview.txt
+++ b/Documentation/mic/mic_overview.txt
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
diff --git a/Documentation/mic/scif_overview.txt b/Documentation/mic/scif_overview.txt
index 0a280d986731..4c8ad9e43706 100644
--- a/Documentation/mic/scif_overview.txt
+++ b/Documentation/mic/scif_overview.txt
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
2.20.1

