Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D10C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40320224FC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257287;
	bh=Ix16peC/bFPfpJNFYk2KffAYTt/5+CNdwzHxME0+VSI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fWlTjC9cguYQ3vrYWeJe39E92nZN/ujgbXG/hc+3DPjNaFHd1ttzIdbSNcmk40zhm
	 m9Yq+bG5sc2NEw8Q0wOmILoZQ504kHuKDow/3bWLWTomFl68cXfKPXP9ETTVxIZmeP
	 31KcpLLl8F1PjLgyFf2Zpw1QQ/p173aLRZM9iFtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfKTNl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfKTNlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:24 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9EF22506;
        Wed, 20 Nov 2019 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257284;
        bh=Ix16peC/bFPfpJNFYk2KffAYTt/5+CNdwzHxME0+VSI=;
        h=From:To:Cc:Subject:Date:From;
        b=a2YBRWrp4Se06WzbQKybM7JcJJ+MTbd2BDX5UT9dTCIQC7nVlFse3CHJnlxoV82ch
         wMGKCM8rO3JY6+N7OGs2jC6gNJuQIP/QWraW2VcqebvlLrhI+DcZ6KZl1BNR6APvRv
         P5iOc6pmhLEWpcHs4cgGB4I+lVXFdjlt3IdOE8Fc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Karsten Keil <isdn@linux-pingi.de>, netdev@vger.kernel.org
Subject: [PATCH] isdn: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:20 +0800
Message-Id: <20191120134120.15009-1-krzk@kernel.org>
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
 drivers/isdn/hardware/mISDN/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/Kconfig b/drivers/isdn/hardware/mISDN/Kconfig
index 304f50c08da2..078eeadf707a 100644
--- a/drivers/isdn/hardware/mISDN/Kconfig
+++ b/drivers/isdn/hardware/mISDN/Kconfig
@@ -10,7 +10,7 @@ config MISDN_HFCPCI
 	depends on PCI
 	help
 	  Enable support for cards with Cologne Chip AG's
-          HFC PCI chip.
+	  HFC PCI chip.
 
 config MISDN_HFCMULTI
 	tristate "Support for HFC multiport cards (HFC-4S/8S/E1)"
-- 
2.17.1

