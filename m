Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5CDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6AD22506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257281;
	bh=QMt/9sM/Cr69KFoh7gNUZgDY5vce/DxM6f8X5cqS0Fs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iNgUwE7AoX0ZBLZqUWVvz5yXQWaFsY0CZevk0v2elbOejpJFHHmfNtiwce1PHSThn
	 FGbFQelz+cZCF0XSoZEYPjPB5qmsqn/0q3cJG9qNjHEh4ISzBo1V2GGL0cbO+k3lM7
	 TeAQZwGFM//frLCJJYWYvRlx4nGa8hKhjdlCx0Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbfKTNlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731345AbfKTNlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:16 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD670224FC;
        Wed, 20 Nov 2019 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257274;
        bh=QMt/9sM/Cr69KFoh7gNUZgDY5vce/DxM6f8X5cqS0Fs=;
        h=From:To:Cc:Subject:Date:From;
        b=GpUgyiz/QkIj7LHGXOHz+iU2cAIlFYgHvgFy3wGEIlk4Y4UdPi2yH64R6xgyl+CWp
         UQtLBNqWHNx9Gz71uiRl/QAW3ktOZ63KvxyIDRNVH4/0aTt6VDK0KVT8fqJOaUUxag
         KLJF8rDSqBKO+dmBFmabRsIQhSDnLoc+ph5UYCv0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH] md: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:10 +0800
Message-Id: <20191120134110.14859-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/md/Kconfig | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index aa98953f4462..d6d5ab23c088 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -38,9 +38,9 @@ config MD_AUTODETECT
 	default y
 	---help---
 	  If you say Y here, then the kernel will try to autodetect raid
-	  arrays as part of its boot process. 
+	  arrays as part of its boot process.
 
-	  If you don't use raid and say Y, this autodetection can cause 
+	  If you don't use raid and say Y, this autodetection can cause
 	  a several-second delay in the boot time due to various
 	  synchronisation steps that are part of this step.
 
@@ -290,7 +290,7 @@ config DM_SNAPSHOT
        depends on BLK_DEV_DM
        select DM_BUFIO
        ---help---
-         Allow volume managers to take writable snapshots of a device.
+	 Allow volume managers to take writable snapshots of a device.
 
 config DM_THIN_PROVISIONING
        tristate "Thin provisioning target"
@@ -298,7 +298,7 @@ config DM_THIN_PROVISIONING
        select DM_PERSISTENT_DATA
        select DM_BIO_PRISON
        ---help---
-         Provides thin provisioning and snapshots that share a data store.
+	 Provides thin provisioning and snapshots that share a data store.
 
 config DM_CACHE
        tristate "Cache target (EXPERIMENTAL)"
@@ -307,23 +307,23 @@ config DM_CACHE
        select DM_PERSISTENT_DATA
        select DM_BIO_PRISON
        ---help---
-         dm-cache attempts to improve performance of a block device by
-         moving frequently used data to a smaller, higher performance
-         device.  Different 'policy' plugins can be used to change the
-         algorithms used to select which blocks are promoted, demoted,
-         cleaned etc.  It supports writeback and writethrough modes.
+	 dm-cache attempts to improve performance of a block device by
+	 moving frequently used data to a smaller, higher performance
+	 device.  Different 'policy' plugins can be used to change the
+	 algorithms used to select which blocks are promoted, demoted,
+	 cleaned etc.  It supports writeback and writethrough modes.
 
 config DM_CACHE_SMQ
        tristate "Stochastic MQ Cache Policy (EXPERIMENTAL)"
        depends on DM_CACHE
        default y
        ---help---
-         A cache policy that uses a multiqueue ordered by recent hits
-         to select which blocks should be promoted and demoted.
-         This is meant to be a general purpose policy.  It prioritises
-         reads over writes.  This SMQ policy (vs MQ) offers the promise
-         of less memory utilization, improved performance and increased
-         adaptability in the face of changing workloads.
+	 A cache policy that uses a multiqueue ordered by recent hits
+	 to select which blocks should be promoted and demoted.
+	 This is meant to be a general purpose policy.  It prioritises
+	 reads over writes.  This SMQ policy (vs MQ) offers the promise
+	 of less memory utilization, improved performance and increased
+	 adaptability in the face of changing workloads.
 
 config DM_WRITECACHE
 	tristate "Writecache target"
@@ -343,9 +343,9 @@ config DM_ERA
        select DM_PERSISTENT_DATA
        select DM_BIO_PRISON
        ---help---
-         dm-era tracks which parts of a block device are written to
-         over time.  Useful for maintaining cache coherency when using
-         vendor snapshots.
+	 dm-era tracks which parts of a block device are written to
+	 over time.  Useful for maintaining cache coherency when using
+	 vendor snapshots.
 
 config DM_CLONE
        tristate "Clone target (EXPERIMENTAL)"
@@ -353,20 +353,20 @@ config DM_CLONE
        default n
        select DM_PERSISTENT_DATA
        ---help---
-         dm-clone produces a one-to-one copy of an existing, read-only source
-         device into a writable destination device. The cloned device is
-         visible/mountable immediately and the copy of the source device to the
-         destination device happens in the background, in parallel with user
-         I/O.
+	 dm-clone produces a one-to-one copy of an existing, read-only source
+	 device into a writable destination device. The cloned device is
+	 visible/mountable immediately and the copy of the source device to the
+	 destination device happens in the background, in parallel with user
+	 I/O.
 
-         If unsure, say N.
+	 If unsure, say N.
 
 config DM_MIRROR
        tristate "Mirror target"
        depends on BLK_DEV_DM
        ---help---
-         Allow volume managers to mirror logical volumes, also
-         needed for live data migration tools such as 'pvmove'.
+	 Allow volume managers to mirror logical volumes, also
+	 needed for live data migration tools such as 'pvmove'.
 
 config DM_LOG_USERSPACE
 	tristate "Mirror userspace logging"
@@ -483,7 +483,7 @@ config DM_FLAKEY
        tristate "Flakey target"
        depends on BLK_DEV_DM
        ---help---
-         A target that intermittently fails I/O for debugging purposes.
+	 A target that intermittently fails I/O for debugging purposes.
 
 config DM_VERITY
 	tristate "Verity target support"
-- 
2.17.1

