Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9383BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC92252D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257114;
	bh=G9PzUqw1T/+8vNPt+Nsu3iMbzun+ZSZJWMpTWmAM/+o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tPXi9nLGDCqr/svl84/RFaV9Ec3amjIn9Sz/MkrfNNK4iDZb2w3E02F8qURYvj/Vw
	 c/e4j1mVZM3BMRIZLHYzB3I0bHjyk6W61G0Lh0lejoIL3Eh38mwBG4QF98/1QOWkR5
	 ye9rAttxHSxFBtrZEltB1sUSy+JGag5oFrQ45+Gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfKTNid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729792AbfKTNia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:30 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1895522528;
        Wed, 20 Nov 2019 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257109;
        bh=G9PzUqw1T/+8vNPt+Nsu3iMbzun+ZSZJWMpTWmAM/+o=;
        h=From:To:Cc:Subject:Date:From;
        b=JtrIKfBOrr1/LGEzRpdB2y90AMiS3EgtmjvEIi7orMhUciWU/2XVNOpkkLzVtEz0L
         G6cTTxmbXadqUThLb3wMPh+8D+bGEXPbzDDuFUNkKYA5uiFz8S4q3eGAqJ1aGGYpZK
         uJiLosc572wfUZ0ch85vcxqKwVCOC6hD/iEfDdCQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH] w1: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:26 +0800
Message-Id: <20191120133826.12964-1-krzk@kernel.org>
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
 drivers/w1/slaves/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index 687753889c34..32b8a757744e 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -71,8 +71,8 @@ config W1_SLAVE_DS2805
 	help
 	  Say Y here if you want to use a 1-wire
 	  is a 112-byte user-programmable EEPROM is
-          organized as 7 pages of 16 bytes each with 64bit
-          unique number. Requires OverDrive Speed to talk to.
+	  organized as 7 pages of 16 bytes each with 64bit
+	  unique number. Requires OverDrive Speed to talk to.
 
 config W1_SLAVE_DS2430
 	tristate "256b EEPROM family support (DS2430)"
-- 
2.17.1

