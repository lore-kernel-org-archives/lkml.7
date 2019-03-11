Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14127C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4272084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfCKNUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47701 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbfCKNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:38 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPGJf-1hQfeX4021-00Pg6Y for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 071/114] drivers: isdn: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:23 +0100
Message-Id: <1552310346-7629-72-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:UrfVC7xyItrqYzAqIVoHIMTLboKIDjoKBqMBwlq68bb1qSGRyDp
 pdGfLHoB2br7ClVvIGZt0N7nnobENKg3X/ntFKOXU1dnUDqD7LX6mDsxVeQaOuUqgp5LO/g
 4od6IZBdsLzr0IIzRwO2aBTFe06n1TkthGhmW1EqU2rmAupUOoQ035y+5T38YbX7Inpj8zn
 UJYM95ZByZjva8RTeL6Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6GEvPOk6EXM=:xx8YMxk7BAQNQr99k+wQ5W
 h+z4YL5DQD6vl32qD2/X8wrT/iIm+wduDbdPiX28FYQRodEi4dtn/rjiAKM0XCfYevax5gEdj
 GU6IRvddKvHtB3I0OjlBbrB2UfbExBSfglAl18q4mkRjRrWGbERJXpGqmPJCOQ5RebmtCqJ3w
 sbbBtAuFT/i3F29/XfdrPPfJTmjHJv9ngcM//bWmebuGdoLDX0vYCs1j164++pkz8a1Lqm9rB
 re0B6O8bvYKd/hUU3PS4aGjQAl6h1GhTp4n2rpT+EY+jNY7oA7iozPyldKbrdk0anUxTX7Ej2
 r/ofLIbyDdwUbEKHRdpiG2kqQv8TmNDuc0NlXt5VPOzjbQw2giXqJgtO5yvFCLawa0WeYSs9J
 uxkQBIdtCwjwEC5CTR1lbLH+VKagfnZNQWd/33ArW5doaj8IoqwbNL9ow0nXS/CHQr8Sf8BoU
 PRoJc51VLM37en5bNPLY7Dsp9kWMB1X/TNa1L7ta9DHJGj3ZYpUXAKxjeD9OT91HTL+9eV/lm
 tQ2uZatD3bpAGmx9zh0DTNClvZkPK8d/KL6wwAGJllDhJZglQO9JfcL4FYTimzmMxMKpH4S4S
 1iT1YYSPSdqM/lwYxBQp8rhvZetV7dLmi7zSsY84LqNv29t5n6pUhJU1L1OjmGukUMql0EkPv
 WDXRTuiUUJjqQHrPZP0bXqnZFdwukqILCPduA82XpqizYZPQoowVYhs2YVuCAfHT18jZm/aUF
 u3qDVjUrRXXYqODvPlLsy6R7YzTKCH+fomU52w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/isdn/hardware/mISDN/Kconfig | 2 +-
 drivers/isdn/hisax/Kconfig          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/hardware/mISDN/Kconfig b/drivers/isdn/hardware/mISDN/Kconfig
index fda912b..9c6c220 100644
--- a/drivers/isdn/hardware/mISDN/Kconfig
+++ b/drivers/isdn/hardware/mISDN/Kconfig
@@ -9,7 +9,7 @@ config MISDN_HFCPCI
 	depends on PCI
 	help
 	  Enable support for cards with Cologne Chip AG's
-          HFC PCI chip.
+	  HFC PCI chip.
 
 config MISDN_HFCMULTI
 	tristate "Support for HFC multiport cards (HFC-4S/8S/E1)"
diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index 38cfc8b..8a85772 100644
--- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -82,7 +82,7 @@ config HISAX_MAX_CARDS
 	default "8"
 	help
 	  This option allows you to specify the maximum number of cards which
-	  the HiSax driver will be able to handle.  
+	  the HiSax driver will be able to handle.
 
 comment "HiSax supported cards"
 
@@ -352,7 +352,7 @@ config HISAX_DEBUG
 	bool "HiSax debugging"
 	help
 	  This enables debugging code in the new-style HiSax drivers, i.e.
-	  the ST5481 USB driver currently. 
+	  the ST5481 USB driver currently.
 	  If in doubt, say yes.
 
 comment "HiSax PCMCIA card service modules"
-- 
1.9.1

