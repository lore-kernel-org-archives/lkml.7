Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A81C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121ED22529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257193;
	bh=8IpINrqwcyYVNNgaoPjhzTg9UX2ShnQpxVLaIAYVeu0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hjRz/9FZd87pXadjB05D2wdbc4Loxj3/wfnyC4CqlaswTgSuASIV1s4Zm933FMfqI
	 B8Br2QIyNm1HDw2McTOFxs3nBgHevjxvp//de89QNwmzxH/csC7+NO+nBkZpyNJfK0
	 kGQBADTNJmr5AjxVKXGvTGisYqFrqMDVsaatU1sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfKTNjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbfKTNjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:49 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 832FA2251E;
        Wed, 20 Nov 2019 13:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257188;
        bh=8IpINrqwcyYVNNgaoPjhzTg9UX2ShnQpxVLaIAYVeu0=;
        h=From:To:Cc:Subject:Date:From;
        b=MUJnfRYQU4kAfT3G+xU9z80qQaS5q2BAxEvg+ArG0dYEjPZhZluv0l7kBAyjF6+pI
         ntaChlNi63Hb1cvgJ7F9tn+5ipSD6M+XrduzxfoJAwC5thllDITjA5z+Kw8XkZryAy
         /szVZ5Y+pzRckObTahRRmy0pFokQNjuA6CiFBq00=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] rpmsg: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:44 +0800
Message-Id: <20191120133945.13938-1-krzk@kernel.org>
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
 drivers/rpmsg/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b41eca5..709276540ef1 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -21,7 +21,7 @@ config RPMSG_QCOM_GLINK_NATIVE
 
 config RPMSG_QCOM_GLINK_RPM
 	tristate "Qualcomm RPM Glink driver"
-        select RPMSG_QCOM_GLINK_NATIVE
+	select RPMSG_QCOM_GLINK_NATIVE
 	depends on HAS_IOMEM
 	depends on MAILBOX
 	help
-- 
2.17.1

