Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06515C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09E927FF0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfFCJY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:51526 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfFCJY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096400"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:22 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 7/7] mei: docs: fix broken links in iamt documentation.
Date:   Mon,  3 Jun 2019 12:14:06 +0300
Message-Id: <20190603091406.28915-8-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iAMT documentation moved from http:// https://,
and LMS is moved to github.com

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/iamt.rst | 105 ++++++++++++--------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/Documentation/driver-api/mei/iamt.rst b/Documentation/driver-api/mei/iamt.rst
index 6dcf5b16e958..6ef3e613684b 100644
--- a/Documentation/driver-api/mei/iamt.rst
+++ b/Documentation/driver-api/mei/iamt.rst
@@ -27,62 +27,57 @@ starting with Release 6.0) over HTTP/S or WS-Management protocol over
 HTTP/S that are received from a remote management console application.
 
 For more information about Intel AMT:
-http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
+https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm
 
 
 Intel AMT Applications
-======================
-
-	1) Intel Local Management Service (Intel LMS)
-
-	   Applications running locally on the platform communicate with Intel AMT Release
-	   2.0 and later releases in the same way that network applications do via SOAP
-	   over HTTP (deprecated starting with Release 6.0) or with WS-Management over
-	   SOAP over HTTP. This means that some Intel AMT features can be accessed from a
-	   local application using the same network interface as a remote application
-	   communicating with Intel AMT over the network.
-
-	   When a local application sends a message addressed to the local Intel AMT host
-	   name, the Intel LMS, which listens for traffic directed to the host name,
-	   intercepts the message and routes it to the Intel MEI.
-	   For more information:
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "About Intel AMT" => "Local Access"
-
-	   For downloading Intel LMS:
-	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
-
-	   The Intel LMS opens a connection using the Intel MEI driver to the Intel LMS
-	   firmware feature using a defined UUID and then communicates with the feature
-	   using a protocol called Intel AMT Port Forwarding Protocol (Intel APF protocol).
-	   The protocol is used to maintain multiple sessions with Intel AMT from a
-	   single application.
-
-	   See the protocol specification in the Intel AMT Software Development Kit (SDK)
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
-	   => "Information for Intel(R) vPro(TM) Gateway Developers"
-	   => "Description of the Intel AMT Port Forwarding (APF) Protocol"
-
-	2) Intel AMT Remote configuration using a Local Agent
-
-	   A Local Agent enables IT personnel to configure Intel AMT out-of-the-box
-	   without requiring installing additional data to enable setup. The remote
-	   configuration process may involve an ISV-developed remote configuration
-	   agent that runs on the host.
-	   For more information:
-	   http://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide
-	   Under "Setup and Configuration of Intel AMT" =>
-	   "SDK Tools Supporting Setup and Configuration" =>
-	   "Using the Local Agent Sample"
-
-	   An open source Intel AMT configuration utility,	implementing a local agent
-	   that accesses the Intel MEI driver, can be found here:
-	   http://software.intel.com/en-us/articles/download-the-latest-intel-amt-open-source-drivers/
-
+----------------------
+
+    1) Intel Local Management Service (Intel LMS)
+
+       Applications running locally on the platform communicate with Intel AMT Release
+       2.0 and later releases in the same way that network applications do via SOAP
+       over HTTP (deprecated starting with Release 6.0) or with WS-Management over
+       SOAP over HTTP. This means that some Intel AMT features can be accessed from a
+       local application using the same network interface as a remote application
+       communicating with Intel AMT over the network.
+
+       When a local application sends a message addressed to the local Intel AMT host
+       name, the Intel LMS, which listens for traffic directed to the host name,
+       intercepts the message and routes it to the Intel MEI.
+       For more information:
+       https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm
+       Under "About Intel AMT" => "Local Access"
+
+       For downloading Intel LMS:
+       https://github.com/intel/lms
+
+       The Intel LMS opens a connection using the Intel MEI driver to the Intel LMS
+       firmware feature using a defined GUID and then communicates with the feature
+       using a protocol called Intel AMT Port Forwarding Protocol (Intel APF protocol).
+       The protocol is used to maintain multiple sessions with Intel AMT from a
+       single application.
+
+       See the protocol specification in the Intel AMT Software Development Kit (SDK)
+       https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm
+       Under "SDK Resources" => "Intel(R) vPro(TM) Gateway (MPS)"
+       => "Information for Intel(R) vPro(TM) Gateway Developers"
+       => "Description of the Intel AMT Port Forwarding (APF) Protocol"
+
+    2) Intel AMT Remote configuration using a Local Agent
+
+       A Local Agent enables IT personnel to configure Intel AMT out-of-the-box
+       without requiring installing additional data to enable setup. The remote
+       configuration process may involve an ISV-developed remote configuration
+       agent that runs on the host.
+       For more information:
+       https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/default.htm
+       Under "Setup and Configuration of Intel AMT" =>
+       "SDK Tools Supporting Setup and Configuration" =>
+       "Using the Local Agent Sample"
 
 Intel AMT OS Health Watchdog
-============================
+----------------------------
 
 The Intel AMT Watchdog is an OS Health (Hang/Crash) watchdog.
 Whenever the OS hangs or crashes, Intel AMT will send an event
@@ -90,10 +85,10 @@ to any subscriber to this event. This mechanism means that
 IT knows when a platform crashes even when there is a hard failure on the host.
 
 The Intel AMT Watchdog is composed of two parts:
-	1) Firmware feature - receives the heartbeats
-	   and sends an event when the heartbeats stop.
-	2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
-	   configures the watchdog and sends the heartbeats.
+    1) Firmware feature - receives the heartbeats
+       and sends an event when the heartbeats stop.
+    2) Intel MEI iAMT watchdog driver - connects to the watchdog feature,
+       configures the watchdog and sends the heartbeats.
 
 The Intel iAMT watchdog MEI driver uses the kernel watchdog API to configure
 the Intel AMT Watchdog and to send heartbeats to it. The default timeout of the
-- 
2.20.1

