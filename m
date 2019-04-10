Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257D6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EE92133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554890214;
	bh=cJKEBdKmuVjuK4pvukiKgmEReBcIEGewkFl/fVneuEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FiXyCoTskNA59MZhPoYWp8nk6xehFabqreUh4H4utJlbk/bnZqqtAxXMQjn0tcnk8
	 wFlaGv4HTxZmCHFMnR0j6Phf0Su2tY1FoHfOQs2iJUVa/cQcT/X1akWGvuXjrdYxhT
	 yM1TvJoOcfMfcQFTqFIDhkzDkijtiQMcd8yx8e1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfDJJ4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:56:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbfDJJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uywpcar2BSwInr6Fjm6rS6TmPWkw/AvOUrwCmcbTPHw=; b=PWSUvsFhIYm2KE3owr/HJGiKMs
        EcujZE9nZ0W2vNE4vvFyFnMJImElpTx5dfRJ05Quw1QjbL/wIgi3G9r2YW9r4HiRQoxaYt+QL/5rG
        I189DNNQbgq2wZkg4Xzccy0LqOpmarIJ0e9EN1BqEMn64N7MtEoaUpeHuekJFrVIYX/Pcs6R6Ysg7
        A0NfR48s2WxmZGnahm3U8g0I7WvTubwvrPbgWpcT1WBj5E0s4OU1wnPeAUoaTTVcVI6pYlFpWtXCd
        ygNKqRWqi9JyeweYyAV1DXICFTDU+KAdMRlck3pz16W68nthXuLUPjKEQlN1mYp54A9rhO8EkQbaY
        lFNhQ2Uw==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hE9yB-0003DQ-BD; Wed, 10 Apr 2019 09:56:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hE9y3-0000oH-RQ; Wed, 10 Apr 2019 06:56:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] docs: video-output.txt: convert it to ReST format
Date:   Wed, 10 Apr 2019 06:56:25 -0300
Message-Id: <0a11af54345d0d8bc4e0664ab5b27ef0dddd267e.1554889999.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554889999.git.mchehab+samsung@kernel.org>
References: <cover.1554889999.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This file doesn't follow the documentation style we use
within the Kernel. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/video-output.txt | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
index e517011be4f9..56d6fa2e2368 100644
--- a/Documentation/video-output.txt
+++ b/Documentation/video-output.txt
@@ -1,34 +1,34 @@
+Video Output Switcher Control
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-		Video Output Switcher Control
-		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-		2006 luming.yu@intel.com
+2006 luming.yu@intel.com
 
 The output sysfs class driver provides an abstract video output layer that
 can be used to hook platform specific methods to enable/disable video output
 device through common sysfs interface. For example, on my IBM ThinkPad T42
 laptop, The ACPI video driver registered its output devices and read/write
-method for 'state' with output sysfs class. The user interface under sysfs is:
+method for 'state' with output sysfs class. The user interface under sysfs is::
 
-linux:/sys/class/video_output # tree .
-.
-|-- CRT0
-|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
-|   |-- state
-|   |-- subsystem -> ../../../class/video_output
-|   `-- uevent
-|-- DVI0
-|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
-|   |-- state
-|   |-- subsystem -> ../../../class/video_output
-|   `-- uevent
-|-- LCD0
-|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
-|   |-- state
-|   |-- subsystem -> ../../../class/video_output
-|   `-- uevent
-`-- TV0
-   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
-   |-- state
-   |-- subsystem -> ../../../class/video_output
-   `-- uevent
+  linux:/sys/class/video_output # tree .
+  .
+  |-- CRT0
+  |   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+  |   |-- state
+  |   |-- subsystem -> ../../../class/video_output
+  |   `-- uevent
+  |-- DVI0
+  |   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+  |   |-- state
+  |   |-- subsystem -> ../../../class/video_output
+  |   `-- uevent
+  |-- LCD0
+  |   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+  |   |-- state
+  |   |-- subsystem -> ../../../class/video_output
+  |   `-- uevent
+  `-- TV0
+     |-- device -> ../../../devices/pci0000:00/0000:00:01.0
+     |-- state
+     |-- subsystem -> ../../../class/video_output
+     `-- uevent
 
-- 
2.20.1

