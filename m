Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875CC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A146020867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570517146;
	bh=+iy0iNnaORXeD8ceZ/MbKdrxBQ8+A3y5zjlf2cHT0KM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GP+TtBpna/3sFY5FgiWNtR4+gbR5Hb3ApsCziJNCerkDzRaN5YVG777dnzC3gJnth
	 ox/AGe8SA4gxOvGsVSpv79k1JSru80dKfzPjh6lGZ5aZfaZjV6FbQ6gBoGR4/Iss7T
	 5buIMd/py6gwIkEjmZrQ5CzAk7pyw25y5UCDHLvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfJHGpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbfJHGpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:45:45 -0400
Received: from guoren-Inspiron-7460.lan (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFCE206C2;
        Tue,  8 Oct 2019 06:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570517144;
        bh=+iy0iNnaORXeD8ceZ/MbKdrxBQ8+A3y5zjlf2cHT0KM=;
        h=From:To:Cc:Subject:Date:From;
        b=jaxHpoDOHOvSDnPOdnTYHflDOXHFsoXNOgPbit5+XLU6to5EP7pzxTjPSlEyUxtzI
         pVUrR0WE5wN2T5L/P9mnlelzlTNqr2Eivo3tiuZakkjv9NEdxD7EolYIAAa3swojGB
         Vu4Lvzdcme6pIUkT8HSMhZZsEtyxk82zLSVEF4vk=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, robh@kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] MAINTAINERS: csky: Add mailing list for csky
Date:   Tue,  8 Oct 2019 14:45:08 +0800
Message-Id: <1570517108-29147-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add mailing list and it's convenient for maintain C-SKY
subsystem.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55199ef..d8fc16d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3556,6 +3556,7 @@ F:	sound/pci/oxygen/
 
 C-SKY ARCHITECTURE
 M:	Guo Ren <guoren@kernel.org>
+L:	linux-csky@vger.kernel.org
 T:	git https://github.com/c-sky/csky-linux.git
 S:	Supported
 F:	arch/csky/
-- 
2.7.4

