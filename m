Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F361C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C62206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578519060;
	bh=PzZ+8bR3pupPgpGmt4T5sjcqeTUgCH6G9dafvqVJ07g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V1xv8O9PM2ap5lAdXwUZc0HYV6zajPiBLrrbnzRr3pkVxvEJqddMffGq7gjjJNSSJ
	 8cVqmq7IrY/ty3L9F7KL5Zi3zUesF50M0qOdpS6MumiUwFfs0zB6RCcw+OYJ4xcjg2
	 Lynx8GsD65+tpmyxYeyS562S6dBq8Q3g6ntX+PhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgAHVa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHVa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:30:58 -0500
Received: from labbott-the-desktop.fios-router.home (pool-96-235-39-235.pitbpa.fios.verizon.net [96.235.39.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 922852053B;
        Wed,  8 Jan 2020 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578519057;
        bh=PzZ+8bR3pupPgpGmt4T5sjcqeTUgCH6G9dafvqVJ07g=;
        h=From:To:Cc:Subject:Date:From;
        b=tyq9YdC024oJTM+SlDbVTTtpveA9i6G3dlYCqHZv+uI3wBrHABT/ipXjwDrpEp7/Z
         Zh33xkwaW6KQQpqiLxyNIOBVQmDJsUH7WZwrk/jbwnPR4R4V7JpZNt5QnZe8wYAVbQ
         IHjSiIqR5SaSDdRDtMcjJQiyqdl9DN+gAnmp66Ns=
From:   labbott@kernel.org
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     Laura Abbott <labbott@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] MAINTAINERS: Update e-mail addresses for Laura Abbott
Date:   Wed,  8 Jan 2020 16:30:55 -0500
Message-Id: <20200108213055.38449-1-labbott@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Abbott <labbott@kernel.org>

Consolodate everything under an @kernel.org address.

Signed-off-by: Laura Abbott <labbott@kernel.org>
---
Sumit, would you be willing to take this through your tree/drm-misc?
---
 .mailmap    | 3 +++
 MAINTAINERS | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a7bc8cabd157..1b67591657fc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -144,6 +144,9 @@ Koushik <raghavendra.koushik@neterion.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+Laura Abbott <labbott@kernel.org> <lauraa@codeaurora.org>
+Laura Abbott <labbott@kernel.org> <labbott@redhat.com>
+Laura Abbott <labobtt@kernel.org> <laura@labbott.name>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..35b30e355f2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,7 +1098,7 @@ F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
 
 ANDROID ION DRIVER
-M:	Laura Abbott <labbott@redhat.com>
+M:	Laura Abbott <labbott@kernel.org>
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 L:	devel@driverdev.osuosl.org
 L:	dri-devel@lists.freedesktop.org
-- 
2.24.1

