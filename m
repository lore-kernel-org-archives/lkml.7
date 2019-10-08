Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5C8ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076720867
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 22:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfJGWLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 18:11:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:35933 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfJGWLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:11:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 15:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,269,1566889200"; 
   d="scan'208";a="193217368"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by fmsmga007.fm.intel.com with ESMTP; 07 Oct 2019 15:11:07 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: fix modalias documentation
Date:   Tue,  8 Oct 2019 03:57:34 +0300
Message-Id: <20191008005735.12707-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

mei client bus added the client protocol version to the device alias,
but ABI documentation was not updated.

Fixes: b26864cad1c9 (mei: bus: add client protocol version to the device alias)
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-mei | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-mei b/Documentation/ABI/testing/sysfs-bus-mei
index 6bd45346ac7e..3f8701e8fa24 100644
--- a/Documentation/ABI/testing/sysfs-bus-mei
+++ b/Documentation/ABI/testing/sysfs-bus-mei
@@ -4,7 +4,7 @@ KernelVersion:	3.10
 Contact:	Samuel Ortiz <sameo@linux.intel.com>
 		linux-mei@linux.intel.com
 Description:	Stores the same MODALIAS value emitted by uevent
-		Format: mei:<mei device name>:<device uuid>:
+		Format: mei:<mei device name>:<device uuid>:<protocol version>
 
 What:		/sys/bus/mei/devices/.../name
 Date:		May 2015
-- 
2.21.0

