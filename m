Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD41020821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfEVUvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:49340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfEVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:58 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 47B461321;
        Wed, 22 May 2019 20:50:58 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 5/8] docs: fix multiple doc build warnings in enumeration.rst
Date:   Wed, 22 May 2019 14:50:31 -0600
Message-Id: <20190522205034.25724-6-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion of acpi/enumeration.txt to RST included one markup error,
leading to many warnings like:

  .../firmware-guide/acpi/enumeration.rst:430: WARNING: Unexpected indentation.

Add the missing colon and create some peace.

Fixes: c24bc66e8157 ("Documentation: ACPI: move enumeration.txt to firmware-guide/acpi and convert to reST")
Cc: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 6b32b7be8c85..850be9696931 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -423,7 +423,7 @@ will be enumerated to depends on the device ID returned by _HID.
 
 For example, the following ACPI sample might be used to enumerate an lm75-type
 I2C temperature sensor and match it to the driver using the Device Tree
-namespace link:
+namespace link::
 
 	Device (TMP0)
 	{
-- 
2.21.0

