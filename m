Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CB122529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257069;
	bh=hazMNUg9PRvxksU8yeX4lRwxGM728y08V0zP20EqwiM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PlIvlmmhRT6q1r5f7EQJ9RkYrBM5y6YO4C/+Qx+kf8ypU8iPoyVNnbdLE4dxPGp8M
	 h0pv0PN57RE2cl3x66QnzPeHfz78C3EATFSxGtChXsvl/wWG5EnK5VsBVYBBHP4Ek5
	 +1RdW8BLs535qDNcQzxr+ufvkNqXWFYudRzUO8eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbfKTNhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbfKTNhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:37:46 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4053E224D2;
        Wed, 20 Nov 2019 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257065;
        bh=hazMNUg9PRvxksU8yeX4lRwxGM728y08V0zP20EqwiM=;
        h=From:To:Cc:Subject:Date:From;
        b=L8bfaAutRh+HtGrOOlh5aqi6KAWJkmTMhzdQX3PuZpORhh/dPqZIc7JmvFSnBrgi+
         DY4lCnnOWXQ6FK2XRYoJW9d6O1jMN+CJLUqWwgbPyCVeL0Fr5RnwVljOt24xvph05j
         ap2fk4WUqa1cPX/k///Q1XAeorY7+6OKT34n08xU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH] alpha: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:37:41 +0800
Message-Id: <20191120133741.12404-1-krzk@kernel.org>
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
 arch/alpha/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index ef179033a7c2..30a6291355cb 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -545,7 +545,7 @@ config NR_CPUS
 	default "4" if !ALPHA_GENERIC && !ALPHA_MARVEL
 	help
 	  MARVEL support can handle a maximum of 32 CPUs, all the others
-          with working support have a maximum of 4 CPUs.
+	  with working support have a maximum of 4 CPUs.
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous Memory Support"
-- 
2.17.1

