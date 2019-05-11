Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4033C04AB4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55AB2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 20:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="osvXv0Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEKU20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 16:28:26 -0400
Received: from narfation.org ([79.140.41.39]:34156 "EHLO v3-1039.vlinux.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfEKU20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 16:28:26 -0400
Received: from sven-desktop.home.narfation.org (unknown [IPv6:2a00:1ca0:1480:f1fc::4065])
        by v3-1039.vlinux.de (Postfix) with ESMTPSA id C6A3C11012A;
        Sat, 11 May 2019 22:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1557605972; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=d8Jl+aESyorlbKSD9+hm1B07d7adsmKXPXVlOeQAHlY=;
        b=osvXv0Imcz74BTqOBSQl7mfqJYJ3w8l1hnVLAacXo6XN0O9LXshy/nysO+Ft50BJHjhhvy
        0SS92rRPvNr8eXxJ1XOMVtCwmsOelc5zyRw7hzBt5og/rtiz2yz8mBg1SaCnhVocZq4ncN
        tsLEzzKqmeseO2m91nhrL5iMJZDVHYQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] scripts/spdxcheck.py: Add dual license subdirectory
Date:   Sat, 11 May 2019 22:19:17 +0200
Message-Id: <20190511201917.20828-2-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190511201917.20828-1-sven@narfation.org>
References: <20190511201917.20828-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1557605972; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:autocrypt;
        bh=d8Jl+aESyorlbKSD9+hm1B07d7adsmKXPXVlOeQAHlY=;
        b=lDugwnakkrXMNpsOpm+UuTkBRTN+Fnf2hk6UVazoCwwFrjvZRa9PBrVqYcAl1aEE7Svmfc
        2jR3VVnvmj48eIHjIe9QgRWBI43nZAYmhkLOHYP9LxBl2v83RlRnNcA0oo2uVNaGIQi95z
        kT7CKO8qPagtdQ1LwvKJbIVh5uNIY9Q=
ARC-Seal: i=1; s=20121; d=narfation.org; t=1557605972; a=rsa-sha256;
        cv=none;
        b=iT19LE3/sKcpgocZeRtPf/fCNwofhwreIMeEuHgAmxSvmxQZzFfiZthumVs9Fh4+lN596H
        juwQX6J8R49iHztnhOVbAsQT9Xjh7rpTrxYb0P10d0LYaigSo4L8oZ3yTGseL6XMm66SzU
        lbO4Qr8M33kOWp6NDlOZaJGmK2tRuQo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sven smtp.mailfrom=sven@narfation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The licenses from the other directory were partially moved to the dual
directory in commit 99871f2f9a4d ("scripts/spdxcheck.py: Fix path to
deprecated licenses"). checkpatch therefore rejected files like
drivers/staging/android/ashmem.h with

  WARNING: 'SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */' is not supported in LICENSES/...
  #1: FILE: drivers/staging/android/ashmem.h:1:
  +/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 99871f2f9a4d ("scripts/spdxcheck.py: Fix path to deprecated licenses")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 1a39b34588b7..33df646618e2 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -32,7 +32,7 @@ class SPDXdata(object):
 def read_spdxdata(repo):
 
     # The subdirectories of LICENSES in the kernel source
-    license_dirs = [ "preferred", "deprecated", "exceptions" ]
+    license_dirs = [ "preferred", "deprecated", "exceptions", "dual" ]
     lictree = repo.head.commit.tree['LICENSES']
 
     spdx = SPDXdata()
-- 
2.20.1

