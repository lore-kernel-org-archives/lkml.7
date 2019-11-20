Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEAD2252D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257336;
	bh=mooLrNBe0qs/QqUCB7pF5WqTj37mt8k/Vno37Qxu/9g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BbCyvGAPtB7ws6qYwpvp8djtTd3Nt0VyOmJ8pNczQx+RjrMyQVJDRCQ6j+wuRYKOD
	 NCvNmDAAz4Ph4dPKqp073N3F3+VcqOd/ef3HWsuBJ2Tlz2dZBYQxS9z33es1TN2jiO
	 ocDRzWlKrhyXzgk7/Ka3gUxxaqT5v8PjZp1RPELk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfKTNmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfKTNmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:11 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A62EC22528;
        Wed, 20 Nov 2019 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257330;
        bh=mooLrNBe0qs/QqUCB7pF5WqTj37mt8k/Vno37Qxu/9g=;
        h=From:To:Cc:Subject:Date:From;
        b=lWzaKeXPu/9KDWU/poYZSqCvflmNzOHqnxcKGZJTcDAZUFWGsBKxSGXdJYT//mdiM
         15T6faUWXEMUq1EiIQnjG3H+1bdlXp9ZiUxYblvFH+2LwdFVcCKJW/uBFhjelGefBU
         0qpVsJBTRpzSyBKP3D/bVuWkl4Chx+Gxt7cP0n/4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH] edac: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:06 +0800
Message-Id: <20191120134206.15588-1-krzk@kernel.org>
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
 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad635526..c49f6bc39716 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -492,7 +492,7 @@ config EDAC_TI
 	depends on ARCH_KEYSTONE || SOC_DRA7XX
 	help
 	  Support for error detection and correction on the
-          TI SoCs.
+	  TI SoCs.
 
 config EDAC_QCOM
 	tristate "QCOM EDAC Controller"
-- 
2.17.1

