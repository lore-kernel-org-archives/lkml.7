Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C67921874
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742721;
	bh=cJKEBdKmuVjuK4pvukiKgmEReBcIEGewkFl/fVneuEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJcDvfnIuR0jAVwMm86BdWwBKILwUch36rLyKU0C7aisjIxtMCrExJl3nXWGmIzJ1
	 Jkg9rq+71+Fl3P4AHGZNhHG3A7cuDBNwudOJA5BQBxDgPJGrDZdVCb1JBOE4cAG/TU
	 rb2tVo+s1+Fvi/saXiryk8Fa9WJ6AnNieza3UE60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfDHQ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58664 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbfDHQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uywpcar2BSwInr6Fjm6rS6TmPWkw/AvOUrwCmcbTPHw=; b=bVla8PP8aUhQJ63MiLT4wqcPiu
        M74LO/6F6c/aJLR4OOdoEhy8VzBLNY53CuvDHe2Ar6xAmV1Hb4B2xnWhb6wdIKOtPrXOZx0cwH4Ls
        5V1LWRHhldZf8S2wHC+ZD4i6UkEU0yq9sWh79aMMM3C6eJGcwUQeVLdmKlHF8nS6iaKpTK+//yyRr
        AN0RWp8JkPQemj/KIYIUWfk4KdHleuzhW1TW22k/2p5oXeTfVdZ4qHzNenV6mKgc2NXplqwabnbq0
        WbSpW8UP+e4x59m+rWVcqnycpl2bSS96Rdpl+Ft/pwjeyTy8sAbg7XMolxz+e7KjI2O98UUNp6to/
        UFItSH+A==;
Received: from [179.95.33.162] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDXbO-0005Sm-5u; Mon, 08 Apr 2019 16:58:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hDXbI-0005nL-9x; Mon, 08 Apr 2019 13:58:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 06/10] docs: video-output.txt: convert it to ReST format
Date:   Mon,  8 Apr 2019 13:58:22 -0300
Message-Id: <0a11af54345d0d8bc4e0664ab5b27ef0dddd267e.1554742526.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554742526.git.mchehab+samsung@kernel.org>
References: <cover.1554742526.git.mchehab+samsung@kernel.org>
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

