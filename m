Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAE2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B6A218C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368251;
	bh=NDKSxEnnePrUYInl6VTWCXx5s/T7AwVQK7EpIxAfIMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9KnZ/PZKGYNTwMiEWYxRJG/DXG6xMgXA8PHXnJBIEuxOnEAxSUOTmTxQ/AUrc+Yt
	 jjO4cW9hAp3yQ9ci2nS4yzYyrFQ4Gx8Yj9QZW6JtoN6zaKgGq7LgxWAOpIMJmz8dkG
	 CHXlmyW6oQmxxyUioz9YJNHz2ebswW4GGcLDF90c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfDDI5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbfDDI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:57:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1582186A;
        Thu,  4 Apr 2019 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368245;
        bh=NDKSxEnnePrUYInl6VTWCXx5s/T7AwVQK7EpIxAfIMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nej9SPyv9xs+gTWzJ5ZNTXYMjWrir1pVZoxa8yta06klxNOp1+ucL7+5IRm4jF4wI
         Vou2p5VbGPCjusnu00UL6DVjvPtIbiNSbA117jB4JL2VnB3AbHl1ZOyZa3DG3U3Rk/
         sRGBHrbdZ+p7+1tHwNu2/n4yTFEhr8xKihq7gPjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, Michael <ZeroBeat@gmx.de>
Subject: [PATCH 4.14 091/121] mt7601u: bump supported EEPROM version
Date:   Thu,  4 Apr 2019 10:47:59 +0200
Message-Id: <20190404084550.304626658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3bd1505fed71d834f45e87b32ff07157fdda47e0 ]

As reported by Michael eeprom 0d is supported and work with the driver.

Dump of /sys/kernel/debug/ieee80211/phy1/mt7601u/eeprom_param
with 0d EEPORM looks like this:

RSSI offset: 0 0
Reference temp: f9
LNA gain: 8
Reg channels: 1-14
Per rate power:
	 raw:05 bw20:05 bw40:05
	 raw:05 bw20:05 bw40:05
	 raw:03 bw20:03 bw40:03
	 raw:03 bw20:03 bw40:03
	 raw:04 bw20:04 bw40:04
	 raw:00 bw20:00 bw40:00
	 raw:00 bw20:00 bw40:00
	 raw:00 bw20:00 bw40:00
	 raw:02 bw20:02 bw40:02
	 raw:00 bw20:00 bw40:00
Per channel power:
	 tx_power  ch1:09 ch2:09
	 tx_power  ch3:0a ch4:0a
	 tx_power  ch5:0a ch6:0a
	 tx_power  ch7:0b ch8:0b
	 tx_power  ch9:0b ch10:0b
	 tx_power  ch11:0b ch12:0b
	 tx_power  ch13:0b ch14:0b

Reported-and-tested-by: Michael <ZeroBeat@gmx.de>
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/eeprom.h b/drivers/net/wireless/mediatek/mt7601u/eeprom.h
index 662d12703b69..57b503ae63f1 100644
--- a/drivers/net/wireless/mediatek/mt7601u/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt7601u/eeprom.h
@@ -17,7 +17,7 @@
 
 struct mt7601u_dev;
 
-#define MT7601U_EE_MAX_VER			0x0c
+#define MT7601U_EE_MAX_VER			0x0d
 #define MT7601U_EEPROM_SIZE			256
 
 #define MT7601U_DEFAULT_TX_POWER		6
-- 
2.19.1



