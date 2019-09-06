Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A33C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DC4207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="L3OOwEaZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KtfJ+x+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405323AbfIFTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:02:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbfIFTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:02:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 711C36115D; Fri,  6 Sep 2019 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567796526;
        bh=fHlSdGoTTdUuPm+ZMeSUpg6AMfOrhFJdRH0w4GFu9Gc=;
        h=From:To:Cc:Subject:Date:From;
        b=L3OOwEaZgKQRgFZCzGd74o4Yub9X9Oy+XviqQOq+p4nQRbc5fFpx7fEXAy+6C+z1V
         E3VVV6gS+q8y3EM6ZvOiaAprr4+hEk4RkD/4w6x72mGr3Lvu65MT3PlqD4JnodIQVZ
         kYmlEdSC0tTonETyuQuGINM6dmnyqQFQOMeMHK1U=
Received: from tsoni-linux1.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tsoni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A7D8602DC;
        Fri,  6 Sep 2019 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567796525;
        bh=fHlSdGoTTdUuPm+ZMeSUpg6AMfOrhFJdRH0w4GFu9Gc=;
        h=From:To:Cc:Subject:Date:From;
        b=KtfJ+x+ZRwWOIbRQpROvYVrVDWjYHV43rHrna8mA54tOkAthogDyPba8/Bw9PrH0z
         rS8r32ovlsV14JCAX9YJLJp4AozEJzccyNaJhwPWJKZbxo6Fe1Cf2A02JqGTnS8hHd
         6eZH3/jdheyCJyA54vktSlOOwl+4p7bMMwhJhjiI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A7D8602DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tsoni@codeaurora.org
From:   Trilok Soni <tsoni@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tyhicks@canonical.com, jkosina@suse.cz,
        konrad.wilk@oracle.com, labbott@redhat.com, tglx@linutronix.de,
        tsoni@quicinc.com, Trilok Soni <tsoni@codeaurora.org>
Subject: [PATCH] Documentation/process: Add Qualcomm process ambassador for hardware security issues
Date:   Fri,  6 Sep 2019 12:01:57 -0700
Message-Id: <1567796517-8964-1-git-send-email-tsoni@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Trilok Soni as process ambassador for hardware security issues
from Qualcomm.

Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
---
 Documentation/process/embargoed-hardware-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index d37cbc5..0416751 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -217,7 +217,7 @@ an involved disclosed party. The current ambassadors list:
   AMD
   IBM
   Intel
-  Qualcomm
+  Qualcomm	Trilok Soni <tsoni@codeaurora.org>
 
   Microsoft
   VMware
-- 
1.9.1

