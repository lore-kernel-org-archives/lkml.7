Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CB5C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E7020715
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 06:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfKPGwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 01:52:14 -0500
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:57115 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725978AbfKPGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 01:52:13 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 96FCD837F24D;
        Sat, 16 Nov 2019 06:52:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: waste86_1326b823dc90e
X-Filterd-Recvd-Size: 4109
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Nov 2019 06:52:11 +0000 (UTC)
Message-ID: <1b188286647007055e90565da47f562d303aa8e2.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8192u: fix indentation issue
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 22:51:52 -0800
In-Reply-To: <3fd995ebb9ec87b202942fa1f000755c2d3cc4cb.camel@perches.com>
References: <20191114095430.132120-1-colin.king@canonical.com>
         <3fd995ebb9ec87b202942fa1f000755c2d3cc4cb.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 22:45 -0800, Joe Perches wrote:
> This function might as well be deleted instead as
> rtl819xusb_beacon_tx is a noop function in
> drivers/staging/rtl8192u/r8192U_core.c

Perhaps:
---
 drivers/staging/rtl8192u/r8192U.h        |  1 -
 drivers/staging/rtl8192u/r8192U_core.c   |  7 -------
 drivers/staging/rtl8192u/r819xU_cmdpkt.c | 22 ----------------------
 3 files changed, 30 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index ec33fb9..0891db 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1111,7 +1111,6 @@ int rtl8192_up(struct net_device *dev);
 void rtl8192_commit(struct net_device *dev);
 void rtl8192_set_chan(struct net_device *dev, short ch);
 void rtl8192_set_rxconf(struct net_device *dev);
-void rtl819xusb_beacon_tx(struct net_device *dev, u16 tx_rate);
 
 void EnableHWSecurityConfig8192(struct net_device *dev);
 void setKey(struct net_device *dev, u8 EntryNo, u8 KeyIndex, u16 KeyType, u8 *MacAddr, u8 DefaultKey, u32 *KeyContent);
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 48f1591e..98705e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1163,13 +1163,6 @@ static void rtl8192_net_update(struct net_device *dev)
 	}
 }
 
-/* temporary hw beacon is not used any more.
- * open it when necessary
- */
-void rtl819xusb_beacon_tx(struct net_device *dev, u16  tx_rate)
-{
-}
-
 short rtl819xU_tx_cmd(struct net_device *dev, struct sk_buff *skb)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
index e064f4..83d1fc7 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -165,25 +165,6 @@ static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 	 */
 }
 
-static void cmdpkt_beacontimerinterrupt_819xusb(struct net_device *dev)
-{
-	struct r8192_priv *priv = ieee80211_priv(dev);
-	u16 tx_rate;
-		/* 87B have to S/W beacon for DTM encryption_cmn. */
-		if (priv->ieee80211->current_network.mode == IEEE_A ||
-		    priv->ieee80211->current_network.mode == IEEE_N_5G ||
-		    (priv->ieee80211->current_network.mode == IEEE_N_24G &&
-		     (!priv->ieee80211->pHTInfo->bCurSuppCCK))) {
-			tx_rate = 60;
-			DMESG("send beacon frame  tx rate is 6Mbpm\n");
-		} else {
-			tx_rate = 10;
-			DMESG("send beacon frame  tx rate is 1Mbpm\n");
-		}
-
-		rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
-}
-
 /*-----------------------------------------------------------------------------
  * Function:    cmpk_handle_interrupt_status()
  *
@@ -238,9 +219,6 @@ static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg)
 			priv->ieee80211->bibsscoordinator = false;
 			priv->stats.txbeaconerr++;
 		}
-
-		if (rx_intr_status.interrupt_status & ISR_BCN_TIMER_INTR)
-			cmdpkt_beacontimerinterrupt_819xusb(dev);
 	}
 
 	/* Other information in interrupt status we need? */


