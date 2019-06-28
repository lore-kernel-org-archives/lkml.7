Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A314EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725C208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725120;
	bh=N0fsQHhVmF2tCq31nS021QM3nvp4LytIYfM6wCU09Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GoIPwjOmlbf2xFbhx3wSh5+qEQy4Mk55GX+r8N5/Y2Tzn5yYbZ/sDtJHnrIqTXzNN
	 Qwg+EpPshMO2paFOHL+rS/bmsIxBRU+ZQyQ/wK8TNLfZjoxB0tzzB44rCjdqKLeHb7
	 hK87p3JeoaTGYmbI8ZpAxR5gN+6zYPafai6eFwLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfF1Mb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:31:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfF1Man (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EJUdOgYYhRNg3PSzAU+NRACcxM2cBl8nbqLie4JryyY=; b=rnl/LPueypsxwtFI2PAhEDAWgt
        5VJ440QuKHe3CdaCj/KsIVv4MQIH5jSiaYO8LGOmB03WdlitAkjxi7REoXUbiVwXtW9mhe5L2K0E0
        V0qtqeIlu5snZsWlPZhjbkP2JxnLfSS8j+z+kOayMMyIq1g3vEReWX2jKtC+myJ3lknYXFo2AYV+W
        MG+eH653+IpPmkCQQpvPTOxvRppngiLZ4FzBL/lisA9VBJRlGeFC1yTJ2S7q7I44bpFvelMaoOu5h
        TvrtXtzh2BZWThhnFpyDtScm9pmj97iA4yfcumJY4P6wK/W52dWZiythCtJLLF9NWwVNrGO91VuiG
        udJAbwHg==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055n-OX; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005TN-Oc; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH 31/39] docs: driver-api: add remaining converted dirs to it
Date:   Fri, 28 Jun 2019 09:30:24 -0300
Message-Id: <420d850e015101e5d7765909a16a741b629dda85.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of driver-specific descriptions that contain a
mix of userspace and kernelspace documentation. Just like we did
with other similar subsystems, add them at the driver-api
groupset, but don't move the directories.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst | 2 ++
 Documentation/driver-api/pps.rst   | 2 +-
 Documentation/driver-api/ptp.rst   | 2 +-
 Documentation/index.rst            | 3 +++
 Documentation/mic/index.rst        | 2 --
 Documentation/phy/samsung-usb2.rst | 2 --
 Documentation/scheduler/index.rst  | 2 --
 7 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 0bc5f2e3b98b..f44a3140f95d 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -83,6 +83,8 @@ available subsections can be seen below.
    ntb
    nvmem
    parport-lowlevel
+   pps
+   ptp
    pti_intel_mid
    pwm
    rfkill
diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 1456d2c32ebd..2d6b99766ee8 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ======================
 PPS - Pulse Per Second
diff --git a/Documentation/driver-api/ptp.rst b/Documentation/driver-api/ptp.rst
index b6e65d66d37a..a15192e32347 100644
--- a/Documentation/driver-api/ptp.rst
+++ b/Documentation/driver-api/ptp.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ===========================================
 PTP hardware clock infrastructure for Linux
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 879849b60c02..28e6b5ef17b4 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -111,6 +111,9 @@ needed).
    PCI/index
    usb/index
    misc-devices/index
+   mic/index
+   phy/samsung-usb2
+   scheduler/index
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/mic/index.rst b/Documentation/mic/index.rst
index 082fa8f6a260..3a8d06367ef1 100644
--- a/Documentation/mic/index.rst
+++ b/Documentation/mic/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 =============================================
 Intel Many Integrated Core (MIC) architecture
 =============================================
diff --git a/Documentation/phy/samsung-usb2.rst b/Documentation/phy/samsung-usb2.rst
index 98b5952fcb97..c48c8b9797b9 100644
--- a/Documentation/phy/samsung-usb2.rst
+++ b/Documentation/phy/samsung-usb2.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ====================================
 Samsung USB 2.0 PHY adaptation layer
 ====================================
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 058be77a4c34..69074e5de9c4 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ===============
 Linux Scheduler
 ===============
-- 
2.21.0

