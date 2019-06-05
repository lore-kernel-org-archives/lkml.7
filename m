Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569E8C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379962075B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFEUaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:30:39 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:58308 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:30:38 -0400
Received: from svr-orw-mbx-01.mgc.mentorg.com ([147.34.90.201])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hYcYK-0007fr-Kt from George_Davis@mentor.com ; Wed, 05 Jun 2019 13:30:32 -0700
Received: from localhost (147.34.91.1) by svr-orw-mbx-01.mgc.mentorg.com
 (147.34.90.201) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 5 Jun
 2019 13:30:30 -0700
From:   "George G. Davis" <george_davis@mentor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Kosina <trivial@kernel.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] staging: most: trivial: fix a couple of typos
Date:   Wed, 5 Jun 2019 16:30:11 -0400
Message-ID: <1559766612-12178-3-git-send-email-george_davis@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
References: <1559766612-12178-1-git-send-email-george_davis@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following typos:

	"comoponent" -> "component"
	"communiction" -> "communication"

Cc: Jiri Kosina <trivial@kernel.org>
Signed-off-by: George G. Davis <george_davis@mentor.com>
---
 drivers/staging/most/Documentation/ABI/configfs-most.txt | 16 ++++++++--------
 drivers/staging/most/Documentation/driver_usage.txt      |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/most/Documentation/ABI/configfs-most.txt b/drivers/staging/most/Documentation/ABI/configfs-most.txt
index 25b3e18c4d91..2bf811449b0b 100644
--- a/drivers/staging/most/Documentation/ABI/configfs-most.txt
+++ b/drivers/staging/most/Documentation/ABI/configfs-most.txt
@@ -31,13 +31,13 @@ Description:
 				or output
 
 		dbr_size	configure DBR data buffer size (this is used
-				for MediaLB communiction only)
+				for MediaLB communication only)
 
 		packets_per_xact
 				configure the number of packets that will be
 				collected from the network before being
 				transmitted via USB (this is used for USB
-				communiction only)
+				communication only)
 
 		device		name of the device the link is to be attached to
 
@@ -75,13 +75,13 @@ Description:
 				or output
 
 		dbr_size	configure DBR data buffer size (this is used
-				for MediaLB communiction only)
+				for MediaLB communication only)
 
 		packets_per_xact
 				configure the number of packets that will be
 				collected from the network before being
 				transmitted via USB (this is used for USB
-				communiction only)
+				communication only)
 
 		device		name of the device the link is to be attached to
 
@@ -119,13 +119,13 @@ Description:
 				or output
 
 		dbr_size	configure DBR data buffer size (this is used
-				for MediaLB communiction only)
+				for MediaLB communication only)
 
 		packets_per_xact
 				configure the number of packets that will be
 				collected from the network before being
 				transmitted via USB (this is used for USB
-				communiction only)
+				communication only)
 
 		device		name of the device the link is to be attached to
 
@@ -173,13 +173,13 @@ Description:
 				or output
 
 		dbr_size	configure DBR data buffer size (this is used
-				for MediaLB communiction only)
+				for MediaLB communication only)
 
 		packets_per_xact
 				configure the number of packets that will be
 				collected from the network before being
 				transmitted via USB (this is used for USB
-				communiction only)
+				communication only)
 
 		device		name of the device the link is to be attached to
 
diff --git a/drivers/staging/most/Documentation/driver_usage.txt b/drivers/staging/most/Documentation/driver_usage.txt
index 56d79195bb3c..2fa8dea1da4d 100644
--- a/drivers/staging/most/Documentation/driver_usage.txt
+++ b/drivers/staging/most/Documentation/driver_usage.txt
@@ -42,7 +42,7 @@ the attached network interface controller hardware. Hence, a given module
 of this layer is designed to handle exactly one of the peripheral
 interfaces (e.g. USB, MediaLB, I2C) the hardware provides.
 
-A module of the application layer is referred to as a core comoponent,
+A module of the application layer is referred to as a core component,
 which kind of extends the core by providing connectivity to the user space.
 Applications, then, can access a MOST network via character devices, an
 ALSA soundcard, a Network adapter or a V4L2 capture device.
@@ -119,7 +119,7 @@ following components are available
 
 The driver is to be configured via configfs. Each loaded component kernel
 object (see section 1.3) registers a subsystem with configfs, which is used to
-configure and establish communiction pathways (links) to attached devices on
+configure and establish communication pathways (links) to attached devices on
 the bus. To do so, the user has to descend into the component's configuration
 directory and create a new directory (child config itmes). The name of this
 directory will be used as a reference for the link and it will contain the
@@ -137,12 +137,12 @@ following attributes:
 	- direction
 	  configure whether this link will be an input or output
 	- dbr_size
-	  configure DBR data buffer size (this is used for MediaLB communiction
+	  configure DBR data buffer size (this is used for MediaLB communication
 	  only)
 	- packets_per_xact
 	  configure the number of packets that will be collected from the
 	  network before being transmitted via USB (this is used for USB
-	  communiction only)
+	  communication only)
 	- device
 	  name of the device the link is to be attached to
 	- channel
-- 
2.7.4

