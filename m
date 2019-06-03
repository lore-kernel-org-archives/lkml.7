Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA92C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6221280CB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZsTDU5ge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfFCMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:21:47 -0400
Received: from mout.web.de ([212.227.17.12]:39247 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFCMVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559564487;
        bh=FJt45LzprmG8E5/01UN42K4QP8qUJ0s1fotVkKdERQo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZsTDU5geXlP4ShdIjP99ka0enqZ2wfYkLutzP3EwEI56y/mBVCYfTNDREDCrDmDlp
         kQxOy+T/H72nuCj3Aho18HEifM4MRcdzf7aSHckIVqZTUOVcs8aQi0THHpOQp33a/E
         f4ySE+Jov8Gppru5vdk27Isq6EKpoWv/EgE908w0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M2dg1-1gfoOo0ffp-00sKYn; Mon, 03 Jun 2019 14:21:27 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 3/3] drivers/staging/rtl8192u: Fix of checkpatch-errors
Date:   Mon,  3 Jun 2019 14:21:04 +0200
Message-Id: <20190603122104.2564-4-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603122104.2564-1-muellerch-privat@web.de>
References: <20190603122104.2564-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:By9Fm88wNJf5cKmbZDWdjaWO3PAffXUDLYF83owXb/RaRY8DKvk
 9ceZFdsu+oaM+bYk83OzDWR7UEmNK5nZYsz+zlDGC7E2iCeSVOxsXtP3HDmlPMOq7JNbCPL
 y1W+uZerDkTet2FSpChF/ynu+J+NcO30GFnPBU/fu7EK6QF6azvWg8E7CNrF93IiZZTcfZX
 u5pVOWRVoRjFPiGIOlkCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ya5q0iDDUbg=:bWe2xdRIOtuDf9ZGXxfRfJ
 8IkX7hydTgVyXpCCoQ0hbF67SdOdKJyoDO1AjfRV8Eokc7Z7V9CMEIzSEeeoGuxXXBe+Cyt5D
 SnLkMfianNorYT4e2x3LkkizLc97rp5iABfDEd31h0YGVxOKt5XMXgMJEKutEMS6GoMvO0xXI
 7+KVnVV7l+w4DdfF24T95ZL6OW5W5QIHmgd4X7RK4K9DiRDv/J8ImmCmBaABio1uu2MUkPwrn
 ccwvi1/hK5QLY0DDr86BzoMrBym1Y8FVuLOF2/RtOSw+7S/WuJo4LGOYdpRppcz2EuD5KEeqh
 UgsAhJ7rzTEkxLe9j+LnjrfBBpFwx+Eo0qMlvWeJYTodFM7413IfKgVAd1AF0gULZckcifA/k
 K/OCPsbA6uKUvpqHt2BmsKZYs/mQ77lX/ZZxRQftTGiq8Pwmo1QA5QW9n5s9YzBJ1H0XDQnYM
 hrTBkxUrxM1kZWRwNOJa2PEwhCUNqoJi2k7puoRkfqkIruZ9u3r3mYr2hWx85S2c7inqp3JoI
 dh48jxGqorYZH5/Di51K4uxrxosE7Gh9SgwkWVhnthgN99eHYhKx527wgHbTk1D2M2QBWsEq1
 1rUl+pCp9FUKi+33TPKfYuNNdpl99yRttc5jNqUyoZA1yiJt5W0g/b9Gj8bduetpOh2McGfKq
 m95Iovu1vDhdoyxds+Uk6CRJHGOZ0R6zK51wDFe6UwNTehXbJMreN/05rOAzt+fl37O2Feez2
 9gSQ2B64M6gWxWH0nENoZ579dhFV99Yhsdkdoq8E/ZemwrCQQBzW5NfapiIzU6kfMdQRlh5NX
 Qpnu2zsXS0w7+a5wSn5pvLLRh/XFEBV2y4N4ayYY99dkbPr3xiEjp9/T/dfs1Pu7l8qdFSKM3
 e0ca+5wozFbqZNVPqwIV3jBnHO9YSSOiNRmQFAHngIMRpIINjGJTqyjZN6AfUvFdSfLtXbX6p
 SHTiQxXQM9VsWYOK75V7iY1sKVv3DtLYkOkZAn5ejHjfcZZepaAi/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues that lead to multiple checkpatch warnings and errors, most of
them regarding formatting of code and comments.
Comments that contain only commented out code are removed as well.

Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
=2D--
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  18 +-
 .../rtl8192u/ieee80211/ieee80211_module.c     |   1 +
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 651 ++++++++----------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    |  48 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 206 +++---
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  59 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  18 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  15 +-
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       |  16 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  14 +-
 drivers/staging/rtl8192u/r8192U_dm.c          |  53 +-
 drivers/staging/rtl8192u/r8192U_hw.h          |  16 +-
 drivers/staging/rtl8192u/r8192U_wx.c          |   3 +-
 drivers/staging/rtl8192u/r819xU_firmware.c    |   2 +-
 14 files changed, 480 insertions(+), 640 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stag=
ing/rtl8192u/ieee80211/ieee80211.h
index d110e9333799..bab975f96a09 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -446,26 +446,26 @@ typedef enum _InitialGainOpType {
 extern u32 ieee80211_debug_level;
 #define IEEE80211_DEBUG(level, fmt, args...) \
 do { if (ieee80211_debug_level & (level)) \
-  printk(KERN_DEBUG "ieee80211: " fmt, ## args); } while (0)
+	printk(KERN_DEBUG "ieee80211: " fmt, ## args); } while (0)
 /* wb added to debug out data buf */
 /* if you want print DATA buffer related BA, please set ieee80211_debug_l=
evel to DATA|BA */
 #define IEEE80211_DEBUG_DATA(level, data, datalen)	\
-	do { if ((ieee80211_debug_level & (level)) =3D=3D (level))	\
-		{	\
+	do { \
+		if ((ieee80211_debug_level & (level)) =3D=3D (level)) {	\
 			int i;					\
 			u8 *pdata =3D (u8 *) data;			\
 			printk(KERN_DEBUG "ieee80211: %s()\n", __func__);	\
-			for (i =3D 0; i < (int)(datalen); i++)			\
-			{						\
+			for (i =3D 0; i < (int)(datalen); i++) {		\
 				printk("%2x ", pdata[i]);		\
-				if ((i + 1) % 16 =3D=3D 0) printk("\n");	\
+				if ((i + 1) % 16 =3D=3D 0)	\
+					printk("\n");	\
 			}				\
 			printk("\n");			\
 		}					\
 	} while (0)
 #else
-#define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
-#define IEEE80211_DEBUG_DATA (level, data, datalen) do {} while(0)
+#define IEEE80211_DEBUG ((level, fmt, args...) do {} while (0))
+#define IEEE80211_DEBUG_DATA ((level, data, datalen) do {} while (0))
 #endif	/* CONFIG_IEEE80211_DEBUG */

 /* debug macros not dependent on CONFIG_IEEE80211_DEBUG */
@@ -1876,7 +1876,7 @@ struct ieee80211_device {
 	struct work_struct associate_procedure_wq;
 	struct delayed_work softmac_scan_wq;
 	struct delayed_work associate_retry_wq;
-	 struct delayed_work start_ibss_wq;
+	struct delayed_work start_ibss_wq;
 	struct work_struct wx_sync_scan_wq;
 	struct workqueue_struct *wq;
 	/* Qos related. Added by Annie, 2005-11-01. */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drive=
rs/staging/rtl8192u/ieee80211/ieee80211_module.c
index 954e43af494b..7cad5278b862 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -194,6 +194,7 @@ void free_ieee80211(struct net_device *dev)
 {
 	struct ieee80211_device *ieee =3D netdev_priv(dev);
 	int i;
+
 	kfree(ieee->pHTInfo);
 	ieee->pHTInfo =3D NULL;
 	RemoveAllTS(ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_rx.c
index af8546ad12af..be97ad93ecac 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -102,18 +102,18 @@ ieee80211_frag_cache_get(struct ieee80211_device *ie=
ee,
 	struct rtl_80211_hdr_4addrqos *hdr_4addrqos;
 	u8 tid;

-	if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS)&&IEEE802=
11_QOS_HAS_SEQ(fc)) {
-	  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
-	  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+	if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE8=
0211_QOS_HAS_SEQ(fc)) {
+		hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
+		tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else if (IEEE80211_QOS_HAS_SEQ(fc)) {
-	  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
-	  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+		hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
+		tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else {
-	  tid =3D 0;
+		tid =3D 0;
 	}

 	if (frag =3D=3D 0) {
@@ -147,7 +147,7 @@ ieee80211_frag_cache_get(struct ieee80211_device *ieee=
,
 		 * received a fragment of a frame for which the head fragment
 		 * should have already been received
 		 */
-		entry =3D ieee80211_frag_cache_find(ieee, seq, frag, tid,hdr->addr2,
+		entry =3D ieee80211_frag_cache_find(ieee, seq, frag, tid, hdr->addr2,
 						  hdr->addr1);
 		if (entry) {
 			entry->last_frag =3D frag;
@@ -171,18 +171,18 @@ static int ieee80211_frag_cache_invalidate(struct ie=
ee80211_device *ieee,
 	struct rtl_80211_hdr_4addrqos *hdr_4addrqos;
 	u8 tid;

-	if(((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS)&&IEEE8021=
1_QOS_HAS_SEQ(fc)) {
-	  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
-	  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+	if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE8=
0211_QOS_HAS_SEQ(fc)) {
+		hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
+		tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else if (IEEE80211_QOS_HAS_SEQ(fc)) {
-	  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
-	  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+		hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
+		tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else {
-	  tid =3D 0;
+		tid =3D 0;
 	}

 	entry =3D ieee80211_frag_cache_find(ieee, seq, -1, tid, hdr->addr2,
@@ -221,10 +221,10 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *iee=
e, struct sk_buff *skb,
 	struct rtl_80211_hdr_3addr *hdr =3D (struct rtl_80211_hdr_3addr *)skb->d=
ata;

 	rx_stats->len =3D skb->len;
-	ieee80211_rx_mgt(ieee,(struct rtl_80211_hdr_4addr *)skb->data,rx_stats);
-	/* if ((ieee->state =3D=3D IEEE80211_LINKED) && (memcmp(hdr->addr3, ieee=
->current_network.bssid, ETH_ALEN))) */
-	if ((memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN)))/* use ADDR1 to =
perform address matching for Management frames */
-	{
+	ieee80211_rx_mgt(ieee, (struct rtl_80211_hdr_4addr *)skb->data, rx_stats=
);
+
+	/* use ADDR1 to perform address matching for Management frames */
+	if ((memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN))) {
 		dev_kfree_skb_any(skb);
 		return 0;
 	}
@@ -240,9 +240,6 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee,=
 struct sk_buff *skb,
 		printk(KERN_DEBUG "%s: Master mode not yet supported.\n",
 		       ieee->dev->name);
 		return 0;
-/*
-  hostap_update_sta_ps(ieee, (struct hostap_ieee80211_hdr_4addr *)
-  skb->data);*/
 	}

 	if (ieee->hostapd && type =3D=3D IEEE80211_TYPE_MGMT) {
@@ -268,7 +265,7 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee,=
 struct sk_buff *skb,
 		return 0;
 	}

-	    if (ieee->iw_mode =3D=3D IW_MODE_MASTER) {
+	if (ieee->iw_mode =3D=3D IW_MODE_MASTER) {
 		if (type !=3D WLAN_FC_TYPE_MGMT && type !=3D WLAN_FC_TYPE_CTRL) {
 			printk(KERN_DEBUG "%s: unknown management frame "
 			       "(type=3D0x%02x, stype=3D0x%02x) dropped\n",
@@ -290,11 +287,9 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee=
, struct sk_buff *skb,

 /* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
 /* Ethernet-II snap header (RFC1042 for most EtherTypes) */
-static unsigned char rfc1042_header[] =3D
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
+static unsigned char rfc1042_header[] =3D {0xaa, 0xaa, 0x03, 0x00, 0x00, =
0x00};
 /* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static unsigned char bridge_tunnel_header[] =3D
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
+static unsigned char bridge_tunnel_header[] =3D {0xaa, 0xaa, 0x03, 0x00, =
0x00, 0xf8};
 /* No encapsulation header if EtherType < 0x600 (=3Dlength) */

 /* Called by ieee80211_rx_frame_decrypt */
@@ -347,9 +342,8 @@ ieee80211_rx_frame_decrypt(struct ieee80211_device *ie=
ee, struct sk_buff *skb,

 	if (!crypt || !crypt->ops->decrypt_mpdu)
 		return 0;
-	if (ieee->hwsec_active)
-	{
-		struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb+ MAX_DEV_ADDR_S=
IZE);
+	if (ieee->hwsec_active) {
+		struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_=
SIZE);
 		tcb_desc->bHwSec =3D 1;
 	}
 	hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
@@ -394,9 +388,8 @@ ieee80211_rx_frame_decrypt_msdu(struct ieee80211_devic=
e *ieee, struct sk_buff *s

 	if (!crypt || !crypt->ops->decrypt_msdu)
 		return 0;
-	if (ieee->hwsec_active)
-	{
-		struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb+ MAX_DEV_ADDR_S=
IZE);
+	if (ieee->hwsec_active) {
+		struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_ADDR_=
SIZE);
 		tcb_desc->bHwSec =3D 1;
 	}

@@ -434,18 +427,18 @@ static int is_duplicate_packet(struct ieee80211_devi=
ce *ieee,


 	/* TO2DS and QoS */
-	if(((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS)&&IEEE8021=
1_QOS_HAS_SEQ(fc)) {
-	  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
-	  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+	if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE8=
0211_QOS_HAS_SEQ(fc)) {
+		hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
+		tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else if (IEEE80211_QOS_HAS_SEQ(fc)) { /* QoS */
-	  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
-	  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-	  tid =3D UP2AC(tid);
-	  tid++;
+		hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
+		tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+		tid =3D UP2AC(tid);
+		tid++;
 	} else { /* no QoS */
-	  tid =3D 0;
+		tid =3D 0;
 	}

 	switch (ieee->iw_mode) {
@@ -461,7 +454,7 @@ static int is_duplicate_packet(struct ieee80211_device=
 *ieee,
 			if (!memcmp(entry->mac, mac, ETH_ALEN))
 				break;
 		}
-	//	if (memcmp(entry->mac, mac, ETH_ALEN)){
+	//	if (memcmp(entry->mac, mac, ETH_ALEN)) {
 		if (p =3D=3D &ieee->ibss_mac_hash[index]) {
 			entry =3D kmalloc(sizeof(struct ieee_ibss_seq), GFP_ATOMIC);
 			if (!entry)
@@ -510,8 +503,7 @@ static int is_duplicate_packet(struct ieee80211_device=
 *ieee,
 static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_e=
ntry *pReorderEntry)
 {
 	struct list_head *pList =3D &pTS->rx_pending_pkt_list;
-	while(pList->next !=3D &pTS->rx_pending_pkt_list)
-	{
+	while (pList->next !=3D &pTS->rx_pending_pkt_list) {
 		if (SN_LESS(pReorderEntry->SeqNum, list_entry(pList->next, struct rx_re=
order_entry, List)->SeqNum))
 			pList =3D pList->next;
 		else if (SN_EQUAL(pReorderEntry->SeqNum, list_entry(pList->next, struct=
 rx_reorder_entry, List)->SeqNum))
@@ -527,15 +519,16 @@ static bool AddReorderEntry(struct rx_ts_record *pTS=
, struct rx_reorder_entry *p
 	return true;
 }

-void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct iee=
e80211_rxb **prxbIndicateArray,u8  index)
+void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct iee=
e80211_rxb **prxbIndicateArray, u8 index)
 {
-	u8 i =3D 0 , j=3D0;
+	u8 i =3D 0, j =3D 0;
 	u16 ethertype;
-	for(j =3D 0; j<index; j++)
-	{
-/* added by amy for reorder */
+
+	for (j =3D 0; j < index; j++) {
+		/* added by amy for reorder */
 		struct ieee80211_rxb *prxb =3D prxbIndicateArray[j];
-		for(i =3D 0; i<prxb->nr_subframes; i++) {
+
+		for (i =3D 0; i < prxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb =3D prxb->subframes[i];

 		/* convert hdr + possible LLC headers into Ethernet header */
@@ -586,7 +579,7 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 	u16			WinEnd =3D (pTS->rx_indicate_seq + WinSize - 1) % 4096;
 	u8			index =3D 0;
 	bool			bMatchWinStart =3D false, bPktInBuf =3D false;
-	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): Seq is %d,pTS->rx_indicate_s=
eq is %d, WinSize is %d\n",__func__,SeqNum,pTS->rx_indicate_seq,WinSize);
+	IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Seq is %d,pTS->rx_indicate_=
seq is %d, WinSize is %d\n", __func__, SeqNum, pTS->rx_indicate_seq, WinSi=
ze);

 	prxbIndicateArray =3D kmalloc_array(REORDER_WIN_SIZE,
 					  sizeof(struct ieee80211_rxb *),
@@ -600,12 +593,12 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,

 	/* Drop out the packet which SeqNum is smaller than WinStart */
 	if (SN_LESS(SeqNum, pTS->rx_indicate_seq)) {
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packet Drop! IndicateSeq: %d, New=
Seq: %d\n",
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packet Drop! IndicateSeq: %d, Ne=
wSeq: %d\n",
 				 pTS->rx_indicate_seq, SeqNum);
 		pHTInfo->RxReorderDropCounter++;
 		{
 			int i;
-			for(i =3D0; i < prxb->nr_subframes; i++) {
+			for (i =3D 0; i < prxb->nr_subframes; i++) {
 				dev_kfree_skb(prxb->subframes[i]);
 			}
 			kfree(prxb);
@@ -621,16 +614,16 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,
 	 * 1. Incoming SeqNum is equal to WinStart =3D>Window shift 1
 	 * 2. Incoming SeqNum is larger than the WinEnd =3D> Window shift N
 	 */
-	if(SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
+	if (SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
 		pTS->rx_indicate_seq =3D (pTS->rx_indicate_seq + 1) % 4096;
 		bMatchWinStart =3D true;
-	} else if(SN_LESS(WinEnd, SeqNum)) {
-		if(SeqNum >=3D (WinSize - 1)) {
-			pTS->rx_indicate_seq =3D SeqNum + 1 -WinSize;
+	} else if (SN_LESS(WinEnd, SeqNum)) {
+		if (SeqNum >=3D (WinSize - 1)) {
+			pTS->rx_indicate_seq =3D SeqNum + 1 - WinSize;
 		} else {
 			pTS->rx_indicate_seq =3D 4095 - (WinSize - (SeqNum + 1)) + 1;
 		}
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d, N=
ewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d, N=
ewSeq: %d\n", pTS->rx_indicate_seq, SeqNum);
 	}

 	/*
@@ -643,15 +636,15 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,
 	 * 1. All packets with SeqNum smaller than WinStart =3D> Indicate
 	 * 2. All packets with SeqNum larger than or equal to WinStart =3D> Buff=
er it.
 	 */
-	if(bMatchWinStart) {
+	if (bMatchWinStart) {
 		/* Current packet is going to be indicated.*/
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! IndicateSeq=
: %d, NewSeq: %d\n",\
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! IndicateSeq=
: %d, NewSeq: %d\n",
 				pTS->rx_indicate_seq, SeqNum);
 		prxbIndicateArray[0] =3D prxb;
 		index =3D 1;
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
-		if(!list_empty(&ieee->RxReorder_Unused_List)) {
+		if (!list_empty(&ieee->RxReorder_Unused_List)) {
 			pReorderEntry =3D list_entry(ieee->RxReorder_Unused_List.next, struct =
rx_reorder_entry, List);
 			list_del_init(&pReorderEntry->List);

@@ -659,13 +652,14 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,
 			pReorderEntry->SeqNum =3D SeqNum;
 			pReorderEntry->prxb =3D prxb;

-			if(!AddReorderEntry(pTS, pReorderEntry)) {
+			if (!AddReorderEntry(pTS, pReorderEntry)) {
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Duplicate packet is drop=
ped!! IndicateSeq: %d, NewSeq: %d\n",
 					__func__, pTS->rx_indicate_seq, SeqNum);
-				list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_List);
+				list_add_tail(&pReorderEntry->List, &ieee->RxReorder_Unused_List);
 				{
 					int i;
-					for(i =3D0; i < prxb->nr_subframes; i++) {
+
+					for (i =3D 0; i < prxb->nr_subframes; i++) {
 						dev_kfree_skb(prxb->subframes[i]);
 					}
 					kfree(prxb);
@@ -673,10 +667,9 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
 				}
 			} else {
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER,
-					 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n",pTS->rx_in=
dicate_seq, SeqNum);
+					 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n", pTS->rx_i=
ndicate_seq, SeqNum);
 			}
-		}
-		else {
+		} else {
 			/*
 			 * Packets are dropped if there is not enough reorder entries.
 			 * This part shall be modified!! We can just indicate all the
@@ -685,7 +678,8 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): There is=
 no reorder entry!! Packet is dropped!!\n");
 			{
 				int i;
-				for(i =3D0; i < prxb->nr_subframes; i++) {
+
+				for (i =3D 0; i < prxb->nr_subframes; i++) {
 					dev_kfree_skb(prxb->subframes[i]);
 				}
 				kfree(prxb);
@@ -695,29 +689,28 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,
 	}

 	/* Check if there is any packet need indicate.*/
-	while(!list_empty(&pTS->rx_pending_pkt_list)) {
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): start RREORDER indicate\n",=
__func__);
+	while (!list_empty(&pTS->rx_pending_pkt_list)) {
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): start RREORDER indicate\n"=
, __func__);
 		pReorderEntry =3D list_entry(pTS->rx_pending_pkt_list.prev, struct rx_r=
eorder_entry, List);
 		if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
-		    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
-		{
+			SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq)) {
 			/* This protect buffer from overflow. */
 			if (index >=3D REORDER_WIN_SIZE) {
-				IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Buffer =
overflow!! \n");
+				IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Buffer =
overflow!!\n");
 				bPktInBuf =3D true;
 				break;
 			}

 			list_del_init(&pReorderEntry->List);

-			if(SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
+			if (SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
 				pTS->rx_indicate_seq =3D (pTS->rx_indicate_seq + 1) % 4096;

-			IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packets indication!! IndicateSeq=
: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
+			IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! IndicateSe=
q: %d, NewSeq: %d\n", pTS->rx_indicate_seq, SeqNum);
 			prxbIndicateArray[index] =3D pReorderEntry->prxb;
 			index++;

-			list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_List);
+			list_add_tail(&pReorderEntry->List, &ieee->RxReorder_Unused_List);
 		} else {
 			bPktInBuf =3D true;
 			break;
@@ -725,13 +718,13 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,
 	}

 	/* Handling pending timer. Set this timer to prevent from long time Rx b=
uffering.*/
-	if (index>0) {
+	if (index > 0) {
 		/* Cancel previous pending timer. */
 		pTS->rx_timeout_indicate_seq =3D 0xffff;

 		/* Indicate packets */
-		if(index>REORDER_WIN_SIZE){
-			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!! \n");
+		if (index > REORDER_WIN_SIZE) {
+			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!!\n");
 			kfree(prxbIndicateArray);
 			return;
 		}
@@ -740,9 +733,9 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,

 	if (bPktInBuf && pTS->rx_timeout_indicate_seq =3D=3D 0xffff) {
 		/* Set new pending timer. */
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n", __=
func__);
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): SET rx timeout timer\n", _=
_func__);
 		pTS->rx_timeout_indicate_seq =3D pTS->rx_indicate_seq;
-		if(timer_pending(&pTS->rx_pkt_pending_timer))
+		if (timer_pending(&pTS->rx_pkt_pending_timer))
 			del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_pkt_pending_timer.expires =3D jiffies +
 				msecs_to_jiffies(pHTInfo->RxReorderPendingTime);
@@ -759,18 +752,18 @@ static u8 parse_subframe(struct sk_buff *skb,
 	struct rtl_80211_hdr_3addr  *hdr =3D (struct rtl_80211_hdr_3addr *)skb->=
data;
 	u16		fc =3D le16_to_cpu(hdr->frame_ctl);

-	u16		LLCOffset=3D sizeof(struct rtl_80211_hdr_3addr);
+	u16		LLCOffset =3D sizeof(struct rtl_80211_hdr_3addr);
 	u16		ChkLength;
 	bool		bIsAggregateFrame =3D false;
 	u16		nSubframe_Length;
 	u8		nPadding_Length =3D 0;
-	u16		SeqNum=3D0;
+	u16		SeqNum =3D 0;

 	struct sk_buff *sub_skb;
 	/* just for debug purpose */
 	SeqNum =3D WLAN_GET_SEQ_SEQ(le16_to_cpu(hdr->seq_ctl));

-	if ((IEEE80211_QOS_HAS_SEQ(fc))&&\
+	if ((IEEE80211_QOS_HAS_SEQ(fc)) && \
 			(((frameqos *)(skb->data + IEEE80211_3ADDR_LEN))->field.reserved)) {
 		bIsAggregateFrame =3D true;
 	}
@@ -790,7 +783,7 @@ static u8 parse_subframe(struct sk_buff *skb,

 	skb_pull(skb, LLCOffset);

-	if(!bIsAggregateFrame) {
+	if (!bIsAggregateFrame) {
 		rxb->nr_subframes =3D 1;
 #ifdef JOHN_NOCPY
 		rxb->subframes[0] =3D skb;
@@ -798,25 +791,25 @@ static u8 parse_subframe(struct sk_buff *skb,
 		rxb->subframes[0] =3D skb_copy(skb, GFP_ATOMIC);
 #endif

-		memcpy(rxb->src,src,ETH_ALEN);
-		memcpy(rxb->dst,dst,ETH_ALEN);
+		memcpy(rxb->src, src, ETH_ALEN);
+		memcpy(rxb->dst, dst, ETH_ALEN);
 		return 1;
 	} else {
 		rxb->nr_subframes =3D 0;
-		memcpy(rxb->src,src,ETH_ALEN);
-		memcpy(rxb->dst,dst,ETH_ALEN);
-		while(skb->len > ETHERNET_HEADER_SIZE) {
+		memcpy(rxb->src, src, ETH_ALEN);
+		memcpy(rxb->dst, dst, ETH_ALEN);
+		while (skb->len > ETHERNET_HEADER_SIZE) {
 			/* Offset 12 denote 2 mac address */
 			nSubframe_Length =3D *((u16 *)(skb->data + 12));
 			/* =3D=3Dm=3D=3D>change the length order */
 			nSubframe_Length =3D (nSubframe_Length>>8) + (nSubframe_Length<<8);

-			if (skb->len<(ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+			if (skb->len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
 				printk("%s: A-MSDU parse error!! pRfd->nTotalSubframe : %d\n",\
 						__func__, rxb->nr_subframes);
-				printk("%s: A-MSDU parse error!! Subframe Length: %d\n",__func__, nSu=
bframe_Length);
-				printk("nRemain_Length is %d and nSubframe_Length is : %d\n",skb->len=
,nSubframe_Length);
-				printk("The Packet SeqNum is %d\n",SeqNum);
+				printk("%s: A-MSDU parse error!! Subframe Length: %d\n", __func__, nS=
ubframe_Length);
+				printk("nRemain_Length is %d and nSubframe_Length is : %d\n", skb->le=
n, nSubframe_Length);
+				printk("The Packet SeqNum is %d\n", SeqNum);
 				return 0;
 			}

@@ -918,9 +911,8 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 	frag =3D WLAN_GET_SEQ_FRAG(sc);
 	hdrlen =3D ieee80211_get_hdrlen(fc);

-	if (HTCCheck(ieee, skb->data))
-	{
-		if(net_ratelimit())
+	if (HTCCheck(ieee, skb->data)) {
+		if (net_ratelimit())
 			printk("find HTCControl\n");
 		hdrlen +=3D 4;
 		rx_stats->bContainHTC =3D true;
@@ -935,6 +927,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 	/* If spy monitoring on */
 	if (iface->spy_data.spy_number > 0) {
 		struct iw_quality wstats;
+
 		wstats.level =3D rx_stats->rssi;
 		wstats.noise =3D rx_stats->noise;
 		wstats.updated =3D 6;	/* No qual value */
@@ -954,6 +947,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,

 	if (ieee->host_decrypt) {
 		int idx =3D 0;
+
 		if (skb->len >=3D hdrlen + 3)
 			idx =3D skb->data[hdrlen + 3] >> 6;
 		crypt =3D ieee->crypt[idx];
@@ -1000,43 +994,35 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 		goto rx_dropped;

 	/* if QoS enabled, should check the sequence for each of the AC */
-	if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos_=
data.active|| !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
+	if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos_=
data.active || !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
 		if (is_duplicate_packet(ieee, hdr))
 		goto rx_dropped;

-	}
-	else
-	{
+	} else {
 		struct rx_ts_record *pRxTS =3D NULL;
-		if(GetTs(
+
+		if (GetTs(
 				ieee,
 				(struct ts_common_info **) &pRxTS,
 				hdr->addr2,
 				Frame_QoSTID((u8 *)(skb->data)),
 				RX_DIR,
-				true))
-		{
-
+				true)) {
 			if ((fc & (1<<11)) &&
 			    (frag =3D=3D pRxTS->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) =3D=3D pRxTS->rx_last_seq_num)) {
 				goto rx_dropped;
-			}
-			else
-			{
+			} else {
 				pRxTS->rx_last_frag_num =3D frag;
 				pRxTS->rx_last_seq_num =3D WLAN_GET_SEQ_SEQ(sc);
 			}
-		}
-		else
-		{
-			IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s(): No TS!! Skip the check!!\n",_=
_func__);
+		} else {
+			IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s(): No TS!! Skip the check!!\n", =
__func__);
 			goto rx_dropped;
 		}
 	}
 	if (type =3D=3D IEEE80211_FTYPE_MGMT) {

-
 		if (ieee80211_rx_frame_mgmt(ieee, skb, rx_stats, type, stype))
 			goto rx_dropped;
 		else
@@ -1109,7 +1095,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	if (stype !=3D IEEE80211_STYPE_DATA &&
 	    stype !=3D IEEE80211_STYPE_DATA_CFACK &&
 	    stype !=3D IEEE80211_STYPE_DATA_CFPOLL &&
-	    stype !=3D IEEE80211_STYPE_DATA_CFACKPOLL&&
+	    stype !=3D IEEE80211_STYPE_DATA_CFACKPOLL &&
 	    stype !=3D IEEE80211_STYPE_QOS_DATA/* add by David,2006.8.4 */
 	    ) {
 		if (stype !=3D IEEE80211_STYPE_NULLFUNC)
@@ -1125,9 +1111,8 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,

 	/* skb: hdr + (possibly fragmented, possibly encrypted) payload */

-	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
-	    (keyidx =3D ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0)
-	{
+	keyidx =3D ieee80211_rx_frame_decrypt(ieee, skb, crypt);
+	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) && keyidx < 0) {
 		printk("decrypt frame error\n");
 		goto rx_dropped;
 	}
@@ -1137,10 +1122,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, st=
ruct sk_buff *skb,

 	/* skb: hdr + (possibly fragmented) plaintext payload */
 	/* PR: FIXME: hostap has additional conditions in the "if" below: */
-	// ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
 	if ((frag !=3D 0 || (fc & IEEE80211_FCTL_MOREFRAGS))) {
 		int flen;
 		struct sk_buff *frag_skb =3D ieee80211_frag_cache_get(ieee, hdr);
+
 		IEEE80211_DEBUG_FRAG("Rx Fragment received (%u)\n", frag);

 		if (!frag_skb) {
@@ -1202,8 +1187,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	 * encrypted/authenticated
 	 */
 	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
-	    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt))
-	{
+	    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 		printk("=3D=3D>decrypt msdu error\n");
 		goto rx_dropped;
 	}
@@ -1255,20 +1239,14 @@ int ieee80211_rx(struct ieee80211_device *ieee, st=
ruct sk_buff *skb,
 			hdr->addr2);
 		goto rx_dropped;
 	}
-/*
-	if(ieee80211_is_eapol_frame(ieee, skb, hdrlen)) {
-		printk(KERN_WARNING "RX: IEEE802.1X EPAOL frame!\n");
-	}
-*/
-/* added by amy for reorder */
+
+	/* added by amy for reorder */
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
-		&& !is_multicast_ether_addr(hdr->addr1))
-	{
+		&& !is_multicast_ether_addr(hdr->addr1)) {
 		TID =3D Frame_QoSTID(skb->data);
 		SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
-		GetTs(ieee,(struct ts_common_info **) &pTS,hdr->addr2,TID,RX_DIR,true);
-		if (TID !=3D0 && TID !=3D3)
-		{
+		GetTs(ieee, (struct ts_common_info **) &pTS, hdr->addr2, TID, RX_DIR, t=
rue);
+		if (TID !=3D 0 && TID !=3D 3) {
 			ieee->bis_any_nonbepkts =3D true;
 		}
 	}
@@ -1282,7 +1260,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	/* qos data packets & reserved bit is 1 */
 	if (parse_subframe(skb, rx_stats, rxb, src, dst) =3D=3D 0) {
 		/* only to free rxb, and not submit the packets to upper layer */
-		for(i =3D0; i < rxb->nr_subframes; i++) {
+		for (i =3D 0; i < rxb->nr_subframes; i++) {
 			dev_kfree_skb(rxb->subframes[i]);
 		}
 		kfree(rxb);
@@ -1293,7 +1271,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 /* added by amy for reorder */
 	if (!ieee->pHTInfo->bCurRxReorderEnable || !pTS) {
 /* added by amy for reorder */
-		for(i =3D 0; i<rxb->nr_subframes; i++) {
+		for (i =3D 0; i < rxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb =3D rxb->subframes[i];

 			if (sub_skb) {
@@ -1338,10 +1316,8 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 		kfree(rxb);
 		rxb =3D NULL;

-	}
-	else
-	{
-		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): REORDER ENABLE AND PTS not =
NULL, and we will enter RxReorderIndicatePacket()\n",__func__);
+	} else {
+		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): REORDER ENABLE AND PTS not=
 NULL, and we will enter RxReorderIndicatePacket()\n", __func__);
 		RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
 	}
 #ifndef JOHN_NOCPY
@@ -1374,9 +1350,9 @@ EXPORT_SYMBOL(ieee80211_rx);
 static u8 qos_oui[QOS_OUI_LEN] =3D { 0x00, 0x50, 0xF2 };

 /*
-* Make the structure we read from the beacon packet to have
-* the right values
-*/
+ * Make the structure we read from the beacon packet to have
+ * the right values
+ */
 static int ieee80211_verify_qos_info(struct ieee80211_qos_information_ele=
ment
 				     *info_element, int sub_type)
 {
@@ -1469,12 +1445,12 @@ static int ieee80211_qos_convert_ac_to_parameters(=
struct

 		aci =3D (ac_params->aci_aifsn & 0x60) >> 5;

-		if(aci >=3D QOS_QUEUE_NUM)
+		if (aci >=3D QOS_QUEUE_NUM)
 			continue;
 		qos_param->aifs[aci] =3D (ac_params->aci_aifsn) & 0x0f;

 		/* WMM spec P.11: The minimum value for AIFSN shall be 2 */
-		qos_param->aifs[aci] =3D (qos_param->aifs[aci] < 2) ? 2:qos_param->aifs=
[aci];
+		qos_param->aifs[aci] =3D (qos_param->aifs[aci] < 2) ? 2 : qos_param->ai=
fs[aci];

 		qos_param->cw_min[aci] =3D
 		    cpu_to_le16(ac_params->ecw_min_max & 0x0F);
@@ -1574,15 +1550,12 @@ static inline void ieee80211_extract_country_ie(
 	u8 *addr2
 )
 {
-	if (IS_DOT11D_ENABLE(ieee))
-	{
-		if (info_element->len!=3D 0)
-		{
+	if (IS_DOT11D_ENABLE(ieee)) {
+		if (info_element->len !=3D 0) {
 			memcpy(network->CountryIeBuf, info_element->data, info_element->len);
 			network->CountryIeLen =3D info_element->len;

-			if (!IS_COUNTRY_IE_VALID(ieee))
-			{
+			if (!IS_COUNTRY_IE_VALID(ieee)) {
 				dot11d_update_country_ie(ieee, addr2, info_element->len, info_element=
->data);
 			}
 		}
@@ -1592,8 +1565,7 @@ static inline void ieee80211_extract_country_ie(
 		 * some AP (e.g. Cisco 1242) don't include country IE in their
 		 * probe response frame.
 		 */
-		if (IS_EQUAL_CIE_SRC(ieee, addr2) )
-		{
+		if (IS_EQUAL_CIE_SRC(ieee, addr2)) {
 			UPDATE_CIE_WATCHDOG(ieee);
 		}
 	}
@@ -1608,9 +1580,9 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 {
 	u8 i;
 	short offset;
-	u16	tmp_htcap_len=3D0;
-	u16	tmp_htinfo_len=3D0;
-	u16 ht_realtek_agg_len=3D0;
+	u16	tmp_htcap_len =3D 0;
+	u16	tmp_htinfo_len =3D 0;
+	u16 ht_realtek_agg_len =3D 0;
 	u8  ht_realtek_agg_buf[MAX_IE_LEN];
 #ifdef CONFIG_IEEE80211_DEBUG
 	char rates_str[64];
@@ -1721,14 +1693,14 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 			break;

 		case MFIE_TYPE_TIM:
-			if(info_element->len < 4)
+			if (info_element->len < 4)
 				break;

 			network->tim.tim_count =3D info_element->data[0];
 			network->tim.tim_period =3D info_element->data[1];

 			network->dtim_period =3D info_element->data[1];
-			if(ieee->state !=3D IEEE80211_LINKED)
+			if (ieee->state !=3D IEEE80211_LINKED)
 				break;

 			network->last_dtim_sta_time[0] =3D stats->mac_time[0];
@@ -1736,22 +1708,22 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,

 			network->dtim_data =3D IEEE80211_DTIM_VALID;

-			if(info_element->data[0] !=3D 0)
+			if (info_element->data[0] !=3D 0)
 				break;

-			if(info_element->data[2] & 1)
+			if (info_element->data[2] & 1)
 				network->dtim_data |=3D IEEE80211_DTIM_MBCAST;

 			offset =3D (info_element->data[2] >> 1)*2;

-			if(ieee->assoc_id < 8*offset ||
-				ieee->assoc_id > 8*(offset + info_element->len -3))
+			if (ieee->assoc_id < 8*offset ||
+				ieee->assoc_id > 8*(offset + info_element->len - 3))

 				break;

 			offset =3D (ieee->assoc_id / 8) - offset;

-			if(info_element->data[3+offset] & (1<<(ieee->assoc_id%8)))
+			if (info_element->data[3+offset] & (1<<(ieee->assoc_id%8)))
 				network->dtim_data |=3D IEEE80211_DTIM_UCAST;

 			break;
@@ -1793,52 +1765,52 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,

 #ifdef THOMAS_TURBO
 			if (info_element->len =3D=3D 7 &&
-			    info_element->data[0] =3D=3D 0x00 &&
-			    info_element->data[1] =3D=3D 0xe0 &&
-			    info_element->data[2] =3D=3D 0x4c &&
-			    info_element->data[3] =3D=3D 0x01 &&
-			    info_element->data[4] =3D=3D 0x02) {
-				network->Turbo_Enable =3D 1;
+				info_element->data[0] =3D=3D 0x00 &&
+				info_element->data[1] =3D=3D 0xe0 &&
+				info_element->data[2] =3D=3D 0x4c &&
+				info_element->data[3] =3D=3D 0x01 &&
+				info_element->data[4] =3D=3D 0x02) {
+					network->Turbo_Enable =3D 1;
 			}
 #endif

 			/* for HTcap and HTinfo parameters */
-			if(tmp_htcap_len =3D=3D 0){
-				if(info_element->len >=3D 4 &&
-				   info_element->data[0] =3D=3D 0x00 &&
-				   info_element->data[1] =3D=3D 0x90 &&
-				   info_element->data[2] =3D=3D 0x4c &&
-				   info_element->data[3] =3D=3D 0x033){
-
-						tmp_htcap_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-						if(tmp_htcap_len !=3D 0){
+			if (tmp_htcap_len =3D=3D 0) {
+				if (info_element->len >=3D 4 &&
+					info_element->data[0] =3D=3D 0x00 &&
+					info_element->data[1] =3D=3D 0x90 &&
+					info_element->data[2] =3D=3D 0x4c &&
+					info_element->data[3] =3D=3D 0x033) {
+
+						tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+						if (tmp_htcap_len !=3D 0) {
 							network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-							network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->bssh=
t.bdHTCapBuf)?\
+							network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->bssh=
t.bdHTCapBuf) ? \
 								sizeof(network->bssht.bdHTCapBuf):tmp_htcap_len;
-							memcpy(network->bssht.bdHTCapBuf,info_element->data,network->bssht=
.bdHTCapLen);
+							memcpy(network->bssht.bdHTCapBuf, info_element->data, network->bss=
ht.bdHTCapLen);
 						}
 				}
-				if(tmp_htcap_len !=3D 0)
+				if (tmp_htcap_len !=3D 0)
 					network->bssht.bdSupportHT =3D true;
 				else
 					network->bssht.bdSupportHT =3D false;
 			}


-			if(tmp_htinfo_len =3D=3D 0){
-				if(info_element->len >=3D 4 &&
+			if (tmp_htinfo_len =3D=3D 0) {
+				if (info_element->len >=3D 4 &&
 					info_element->data[0] =3D=3D 0x00 &&
 					info_element->data[1] =3D=3D 0x90 &&
 					info_element->data[2] =3D=3D 0x4c &&
-					info_element->data[3] =3D=3D 0x034){
+					info_element->data[3] =3D=3D 0x034) {

-						tmp_htinfo_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-						if(tmp_htinfo_len !=3D 0){
+						tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+						if (tmp_htinfo_len !=3D 0) {
 							network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-							if(tmp_htinfo_len){
-								network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network->b=
ssht.bdHTInfoBuf)?\
+							if (tmp_htinfo_len) {
+								network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network->b=
ssht.bdHTInfoBuf) ? \
 									sizeof(network->bssht.bdHTInfoBuf):tmp_htinfo_len;
-								memcpy(network->bssht.bdHTInfoBuf,info_element->data,network->bss=
ht.bdHTInfoLen);
+								memcpy(network->bssht.bdHTInfoBuf, info_element->data, network->b=
ssht.bdHTInfoLen);
 							}

 						}
@@ -1846,29 +1818,29 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 				}
 			}

-			if(ieee->aggregation){
-				if(network->bssht.bdSupportHT){
-					if(info_element->len >=3D 4 &&
+			if (ieee->aggregation) {
+				if (network->bssht.bdSupportHT) {
+					if (info_element->len >=3D 4 &&
 						info_element->data[0] =3D=3D 0x00 &&
 						info_element->data[1] =3D=3D 0xe0 &&
 						info_element->data[2] =3D=3D 0x4c &&
-						info_element->data[3] =3D=3D 0x02){
+						info_element->data[3] =3D=3D 0x02) {

-						ht_realtek_agg_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-						memcpy(ht_realtek_agg_buf,info_element->data,info_element->len);
+						ht_realtek_agg_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+						memcpy(ht_realtek_agg_buf, info_element->data, info_element->len);

 					}
-					if(ht_realtek_agg_len >=3D 5){
+					if (ht_realtek_agg_len >=3D 5) {
 						network->bssht.bdRT2RTAggregation =3D true;

-						if((ht_realtek_agg_buf[4] =3D=3D 1) && (ht_realtek_agg_buf[5] & 0x0=
2))
+						if ((ht_realtek_agg_buf[4] =3D=3D 1) && (ht_realtek_agg_buf[5] & 0x=
02))
 						network->bssht.bdRT2RTLongSlotTime =3D true;
 					}
 				}

 			}

-			//if(tmp_htcap_len !=3D0  ||  tmp_htinfo_len !=3D 0)
+			//if (tmp_htcap_len !=3D0  ||  tmp_htinfo_len !=3D 0)
 			{
 				if ((info_element->len >=3D 3 &&
 					 info_element->data[0] =3D=3D 0x00 &&
@@ -1881,80 +1853,65 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 					 (info_element->len >=3D 3 &&
 					 info_element->data[0] =3D=3D 0x00 &&
 					 info_element->data[1] =3D=3D 0x10 &&
-					 info_element->data[2] =3D=3D 0x18)){
+					 info_element->data[2] =3D=3D 0x18)) {

 						network->broadcom_cap_exist =3D true;

 				}
 			}
-			if(info_element->len >=3D 3 &&
+			if (info_element->len >=3D 3 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x0c &&
-				info_element->data[2] =3D=3D 0x43)
-			{
+				info_element->data[2] =3D=3D 0x43) {
 				network->ralink_cap_exist =3D true;
-			}
-			else
+			} else
 				network->ralink_cap_exist =3D false;
 			/* added by amy for atheros AP */
-			if((info_element->len >=3D 3 &&
+			if ((info_element->len >=3D 3 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x03 &&
 				info_element->data[2] =3D=3D 0x7f) ||
 				(info_element->len >=3D 3 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x13 &&
-				info_element->data[2] =3D=3D 0x74))
-			{
-				printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s(): athros AP is exist\n",__func__=
);
+				info_element->data[2] =3D=3D 0x74)) {
+				printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s(): athros AP is exist\n", __func_=
_);
 				network->atheros_cap_exist =3D true;
-			}
-			else
+			} else
 				network->atheros_cap_exist =3D false;

-			if(info_element->len >=3D 3 &&
+			if (info_element->len >=3D 3 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x40 &&
-				info_element->data[2] =3D=3D 0x96)
-			{
+				info_element->data[2] =3D=3D 0x96) {
 				network->cisco_cap_exist =3D true;
-			}
-			else
+			} else
 				network->cisco_cap_exist =3D false;
 			/* added by amy for LEAP of cisco */
 			if (info_element->len > 4 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x40 &&
 				info_element->data[2] =3D=3D 0x96 &&
-				info_element->data[3] =3D=3D 0x01)
-			{
-				if(info_element->len =3D=3D 6)
-				{
+				info_element->data[3] =3D=3D 0x01) {
+				if (info_element->len =3D=3D 6) {
 					memcpy(network->CcxRmState, &info_element[4], 2);
-					if(network->CcxRmState[0] !=3D 0)
-					{
+					if (network->CcxRmState[0] !=3D 0) {
 						network->bCcxRmEnable =3D true;
-					}
-					else
+					} else
 						network->bCcxRmEnable =3D false;
 					/*
 					 * CCXv4 Table 59-1 MBSSID Masks.
 					 */
 					network->MBssidMask =3D network->CcxRmState[1] & 0x07;
-					if(network->MBssidMask !=3D 0)
-					{
+					if (network->MBssidMask !=3D 0) {
 						network->bMBssidValid =3D true;
 						network->MBssidMask =3D 0xff << (network->MBssidMask);
 						ether_addr_copy(network->MBssid, network->bssid);
 						network->MBssid[5] &=3D network->MBssidMask;
-					}
-					else
-					{
+					} else {
 						network->bMBssidValid =3D false;
 					}
-				}
-				else
-				{
+				} else {
 					network->bCcxRmEnable =3D false;
 				}
 			}
@@ -1962,15 +1919,11 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x40 &&
 				info_element->data[2] =3D=3D 0x96 &&
-				info_element->data[3] =3D=3D 0x03)
-			{
-				if(info_element->len =3D=3D 5)
-				{
+				info_element->data[3] =3D=3D 0x03) {
+				if (info_element->len =3D=3D 5) {
 					network->bWithCcxVerNum =3D true;
 					network->BssCcxVerNumber =3D info_element->data[4];
-				}
-				else
-				{
+				} else {
 					network->bWithCcxVerNum =3D false;
 					network->BssCcxVerNumber =3D 0;
 				}
@@ -1990,12 +1943,12 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 		case MFIE_TYPE_HT_CAP:
 			IEEE80211_DEBUG_SCAN("MFIE_TYPE_HT_CAP: %d bytes\n",
 					     info_element->len);
-			tmp_htcap_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-			if(tmp_htcap_len !=3D 0){
+			tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+			if (tmp_htcap_len !=3D 0) {
 				network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-				network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->bssht.b=
dHTCapBuf)?\
+				network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->bssht.b=
dHTCapBuf) ? \
 					sizeof(network->bssht.bdHTCapBuf):tmp_htcap_len;
-				memcpy(network->bssht.bdHTCapBuf,info_element->data,network->bssht.bd=
HTCapLen);
+				memcpy(network->bssht.bdHTCapBuf, info_element->data, network->bssht.=
bdHTCapLen);

 				/*
 				 * If peer is HT, but not WMM, call QosSetLegacyWMMParamWithHT()
@@ -2003,8 +1956,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 				 * Linux driver is a bit different.
 				 */
 				network->bssht.bdSupportHT =3D true;
-			}
-			else
+			} else
 				network->bssht.bdSupportHT =3D false;
 			break;

@@ -2012,20 +1964,19 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 		case MFIE_TYPE_HT_INFO:
 			IEEE80211_DEBUG_SCAN("MFIE_TYPE_HT_INFO: %d bytes\n",
 					     info_element->len);
-			tmp_htinfo_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-			if(tmp_htinfo_len){
+			tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+			if (tmp_htinfo_len) {
 				network->bssht.bdHTSpecVer =3D HT_SPEC_VER_IEEE;
-				network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network->bssht=
.bdHTInfoBuf)?\
+				network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network->bssht=
.bdHTInfoBuf) ? \
 					sizeof(network->bssht.bdHTInfoBuf):tmp_htinfo_len;
-				memcpy(network->bssht.bdHTInfoBuf,info_element->data,network->bssht.b=
dHTInfoLen);
+				memcpy(network->bssht.bdHTInfoBuf, info_element->data, network->bssht=
.bdHTInfoLen);
 			}
 			break;

 		case MFIE_TYPE_AIRONET:
 			IEEE80211_DEBUG_SCAN("MFIE_TYPE_AIRONET: %d bytes\n",
 					     info_element->len);
-			if(info_element->len >IE_CISCO_FLAG_POSITION)
-			{
+			if (info_element->len > IE_CISCO_FLAG_POSITION) {
 				network->bWithAironetIE =3D true;

 				/*
@@ -2033,18 +1984,13 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 				 * "A Cisco access point advertises support for CKIP in beacon and pr=
obe response packets,
 				 * by adding an Aironet element and setting one or both of the CKIP n=
egotiation bits."
 				 */
-				if(	(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_MIC)	||
-					(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_PK)	)
-				{
+				if ((info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_MIC) ||
+					(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_PK)) {
 					network->bCkipSupported =3D true;
-				}
-				else
-				{
+				} else {
 					network->bCkipSupported =3D false;
 				}
-			}
-			else
-			{
+			} else {
 				network->bWithAironetIE =3D false;
 				network->bCkipSupported =3D false;
 			}
@@ -2069,68 +2015,42 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,
 		}

 		length -=3D sizeof(*info_element) + info_element->len;
-		info_element =3D
-		    (struct ieee80211_info_element *)&info_element->
-		    data[info_element->len];
+		info_element =3D (struct ieee80211_info_element *)&info_element->data[i=
nfo_element->len];
 	}

-	if(!network->atheros_cap_exist && !network->broadcom_cap_exist &&
-		!network->cisco_cap_exist && !network->ralink_cap_exist && !network->bs=
sht.bdRT2RTAggregation)
-	{
+	if (!network->atheros_cap_exist && !network->broadcom_cap_exist &&
+		!network->cisco_cap_exist && !network->ralink_cap_exist && !network->bs=
sht.bdRT2RTAggregation) {
 		network->unknown_cap_exist =3D true;
-	}
-	else
-	{
+	} else {
 		network->unknown_cap_exist =3D false;
 	}
 	return 0;
 }

-static inline u8 ieee80211_SignalStrengthTranslate(
-	u8  CurrSS
-	)
+static inline u8 ieee80211_SignalStrengthTranslate(u8 CurrSS)
 {
 	u8 RetSS;

 	/* Step 1. Scale mapping. */
-	if(CurrSS >=3D 71 && CurrSS <=3D 100)
-	{
+	if (CurrSS >=3D 71 && CurrSS <=3D 100) {
 		RetSS =3D 90 + ((CurrSS - 70) / 3);
-	}
-	else if(CurrSS >=3D 41 && CurrSS <=3D 70)
-	{
+	} else if (CurrSS >=3D 41 && CurrSS <=3D 70) {
 		RetSS =3D 78 + ((CurrSS - 40) / 3);
-	}
-	else if(CurrSS >=3D 31 && CurrSS <=3D 40)
-	{
+	} else if (CurrSS >=3D 31 && CurrSS <=3D 40) {
 		RetSS =3D 66 + (CurrSS - 30);
-	}
-	else if(CurrSS >=3D 21 && CurrSS <=3D 30)
-	{
+	} else if (CurrSS >=3D 21 && CurrSS <=3D 30) {
 		RetSS =3D 54 + (CurrSS - 20);
-	}
-	else if(CurrSS >=3D 5 && CurrSS <=3D 20)
-	{
+	} else if (CurrSS >=3D 5 && CurrSS <=3D 20) {
 		RetSS =3D 42 + (((CurrSS - 5) * 2) / 3);
-	}
-	else if(CurrSS =3D=3D 4)
-	{
+	} else if (CurrSS =3D=3D 4) {
 		RetSS =3D 36;
-	}
-	else if(CurrSS =3D=3D 3)
-	{
+	} else if (CurrSS =3D=3D 3) {
 		RetSS =3D 27;
-	}
-	else if(CurrSS =3D=3D 2)
-	{
+	} else if (CurrSS =3D=3D 2) {
 		RetSS =3D 18;
-	}
-	else if(CurrSS =3D=3D 1)
-	{
+	} else if (CurrSS =3D=3D 1) {
 		RetSS =3D 9;
-	}
-	else
-	{
+	} else {
 		RetSS =3D CurrSS;
 	}

@@ -2142,7 +2062,7 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 /* 0-100 index */
 static long ieee80211_translate_todbm(u8 signal_strength_index)
 {
-	long	signal_power; /* in dBm. */
+	long signal_power; /* in dBm. */

 	/* Translate to dBm (x=3D0.5y-95). */
 	signal_power =3D (long)((signal_strength_index + 1) >> 1);
@@ -2202,7 +2122,7 @@ static inline int ieee80211_network_init(
 	network->rsn_ie_len =3D 0;

 	if (ieee80211_parse_info_param
-	    (ieee,beacon->info_element, stats->len - sizeof(*beacon), network, s=
tats))
+	    (ieee, beacon->info_element, stats->len - sizeof(*beacon), network, =
stats))
 		return 1;

 	network->mode =3D 0;
@@ -2224,17 +2144,17 @@ static inline int ieee80211_network_init(
 		return 1;
 	}

-	if(network->bssht.bdSupportHT){
-		if(network->mode =3D=3D IEEE_A)
+	if (network->bssht.bdSupportHT) {
+		if (network->mode =3D=3D IEEE_A)
 			network->mode =3D IEEE_N_5G;
-		else if(network->mode & (IEEE_G | IEEE_B))
+		else if (network->mode & (IEEE_G | IEEE_B))
 			network->mode =3D IEEE_N_24G;
 	}
 	if (ieee80211_is_empty_essid(network->ssid, network->ssid_len))
 		network->flags |=3D NETWORK_EMPTY_ESSID;

 	stats->signal =3D 30 + (stats->SignalStrength * 70) / 100;
-	stats->noise =3D ieee80211_translate_todbm((u8)(100-stats->signal)) -25;
+	stats->noise =3D ieee80211_translate_todbm((u8)(100-stats->signal)) - 25=
;

 	memcpy(&network->stats, stats, sizeof(network->stats));

@@ -2242,19 +2162,17 @@ static inline int ieee80211_network_init(
 }

 static inline int is_same_network(struct ieee80211_network *src,
-				  struct ieee80211_network *dst, struct ieee80211_device *ieee)
-{
+				  struct ieee80211_network *dst, struct ieee80211_device *ieee) {
 	/*
 	 * A network is only a duplicate if the channel, BSSID, ESSID
 	 * and the capability field (in particular IBSS and BSS) all match.
 	 * We treat all <hidden> with the same BSSID and channel
 	 * as one network
 	 */
-	return //((src->ssid_len =3D=3D dst->ssid_len) &&
+	return
 		(((src->ssid_len =3D=3D dst->ssid_len) || (ieee->iw_mode =3D=3D IW_MODE=
_INFRA)) &&
 		(src->channel =3D=3D dst->channel) &&
 		!memcmp(src->bssid, dst->bssid, ETH_ALEN) &&
-		//!memcmp(src->ssid, dst->ssid, src->ssid_len) &&
 		(!memcmp(src->ssid, dst->ssid, src->ssid_len) || (ieee->iw_mode =3D=3D =
IW_MODE_INFRA)) &&
 		((src->capability & WLAN_CAPABILITY_IBSS) =3D=3D
 		(dst->capability & WLAN_CAPABILITY_IBSS)) &&
@@ -2263,8 +2181,7 @@ static inline int is_same_network(struct ieee80211_n=
etwork *src,
 }

 static inline void update_network(struct ieee80211_network *dst,
-				  struct ieee80211_network *src)
-{
+				  struct ieee80211_network *src) {
 	int qos_active;
 	u8 old_param;

@@ -2274,8 +2191,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	dst->rates_len =3D src->rates_len;
 	memcpy(dst->rates_ex, src->rates_ex, src->rates_ex_len);
 	dst->rates_ex_len =3D src->rates_ex_len;
-	if (src->ssid_len > 0)
-	{
+	if (src->ssid_len > 0) {
 		memset(dst->ssid, 0, dst->ssid_len);
 		dst->ssid_len =3D src->ssid_len;
 		memcpy(dst->ssid, src->ssid, src->ssid_len);
@@ -2284,8 +2200,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	dst->flags =3D src->flags;
 	dst->time_stamp[0] =3D src->time_stamp[0];
 	dst->time_stamp[1] =3D src->time_stamp[1];
-	if (src->flags & NETWORK_HAS_ERP_VALUE)
-	{
+	if (src->flags & NETWORK_HAS_ERP_VALUE) {
 		dst->erp_value =3D src->erp_value;
 		dst->berp_info_valid =3D src->berp_info_valid =3D true;
 	}
@@ -2300,10 +2215,10 @@ static inline void update_network(struct ieee80211=
_network *dst,

 	dst->bssht.bdSupportHT =3D src->bssht.bdSupportHT;
 	dst->bssht.bdRT2RTAggregation =3D src->bssht.bdRT2RTAggregation;
-	dst->bssht.bdHTCapLen=3D src->bssht.bdHTCapLen;
-	memcpy(dst->bssht.bdHTCapBuf,src->bssht.bdHTCapBuf,src->bssht.bdHTCapLen=
);
-	dst->bssht.bdHTInfoLen=3D src->bssht.bdHTInfoLen;
-	memcpy(dst->bssht.bdHTInfoBuf,src->bssht.bdHTInfoBuf,src->bssht.bdHTInfo=
Len);
+	dst->bssht.bdHTCapLen =3D src->bssht.bdHTCapLen;
+	memcpy(dst->bssht.bdHTCapBuf, src->bssht.bdHTCapBuf, src->bssht.bdHTCapL=
en);
+	dst->bssht.bdHTInfoLen =3D src->bssht.bdHTInfoLen;
+	memcpy(dst->bssht.bdHTInfoBuf, src->bssht.bdHTInfoBuf, src->bssht.bdHTIn=
foLen);
 	dst->bssht.bdHTSpecVer =3D src->bssht.bdHTSpecVer;
 	dst->bssht.bdRT2RTLongSlotTime =3D src->bssht.bdRT2RTLongSlotTime;
 	dst->broadcom_cap_exist =3D src->broadcom_cap_exist;
@@ -2320,7 +2235,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	/* qos related parameters */
 	qos_active =3D dst->qos_data.active;
 	old_param =3D dst->qos_data.param_count;
-	if(dst->flags & NETWORK_HAS_QOS_MASK)
+	if (dst->flags & NETWORK_HAS_QOS_MASK)
 		memcpy(&dst->qos_data, &src->qos_data,
 			sizeof(struct ieee80211_qos_data));
 	else {
@@ -2330,7 +2245,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,

 	if (dst->qos_data.supported =3D=3D 1) {
 		dst->QoS_Enable =3D 1;
-		if(dst->ssid_len)
+		if (dst->ssid_len)
 			IEEE80211_DEBUG_QOS
 				("QoS the network %s is QoS supported\n",
 				dst->ssid);
@@ -2343,11 +2258,11 @@ static inline void update_network(struct ieee80211=
_network *dst,

 	/* dst->last_associate is not overwritten */
 	dst->wmm_info =3D src->wmm_info; /* sure to exist in beacon or probe res=
ponse frame. */
-	if (src->wmm_param[0].aci_aifsn|| \
-	   src->wmm_param[1].aci_aifsn|| \
-	   src->wmm_param[2].aci_aifsn|| \
+	if (src->wmm_param[0].aci_aifsn || \
+	   src->wmm_param[1].aci_aifsn || \
+	   src->wmm_param[2].aci_aifsn || \
 	   src->wmm_param[3].aci_aifsn) {
-	  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
+		memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 	}
 #ifdef THOMAS_TURBO
 	dst->Turbo_Enable =3D src->Turbo_Enable;
@@ -2437,46 +2352,36 @@ static inline void ieee80211_process_probe_respons=
e(

 	if (!is_legal_channel(ieee, network->channel))
 		goto out;
-	if (ieee->bGlobalDomain)
-	{
-		if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP)
-		{
+	if (ieee->bGlobalDomain) {
+		if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP) {
 			/* Case 1: Country code */
-			if(IS_COUNTRY_IE_VALID(ieee) )
-			{
+			if (IS_COUNTRY_IE_VALID(ieee)) {
 				if (!is_legal_channel(ieee, network->channel)) {
 					printk("GetScanInfo(): For Country code, filter probe response at ch=
annel(%d).\n", network->channel);
 					goto out;
 				}
 			}
 			/* Case 2: No any country code. */
-			else
-			{
+			else {
 				/* Filter over channel ch12~14 */
-				if (network->channel > 11)
-				{
+				if (network->channel > 11) {
 					printk("GetScanInfo(): For Global Domain, filter probe response at c=
hannel(%d).\n", network->channel);
 					goto out;
 				}
 			}
-		}
-		else
-		{
+		} else {
 			/* Case 1: Country code */
-			if(IS_COUNTRY_IE_VALID(ieee) )
-			{
+			if (IS_COUNTRY_IE_VALID(ieee)) {
 				if (!is_legal_channel(ieee, network->channel)) {
-					printk("GetScanInfo(): For Country code, filter beacon at channel(%d=
).\n",network->channel);
+					printk("GetScanInfo(): For Country code, filter beacon at channel(%d=
).\n", network->channel);
 					goto out;
 				}
 			}
 			/* Case 2: No any country code. */
-			else
-			{
+			else {
 				/* Filter over channel ch12~14 */
-				if (network->channel > 14)
-				{
-					printk("GetScanInfo(): For Global Domain, filter beacon at channel(%=
d).\n",network->channel);
+				if (network->channel > 14) {
+					printk("GetScanInfo(): For Global Domain, filter beacon at channel(%=
d).\n", network->channel);
 					goto out;
 				}
 			}
@@ -2502,15 +2407,14 @@ static inline void ieee80211_process_probe_respons=
e(
 	if (is_same_network(&ieee->current_network, network, ieee)) {
 		update_network(&ieee->current_network, network);
 		if ((ieee->current_network.mode =3D=3D IEEE_N_24G || ieee->current_netw=
ork.mode =3D=3D IEEE_G)
-		&& ieee->current_network.berp_info_valid){
-		if(ieee->current_network.erp_value& ERP_UseProtection)
-			ieee->current_network.buseprotection =3D true;
-		else
-			ieee->current_network.buseprotection =3D false;
-		}
-		if(is_beacon(beacon->header.frame_ctl))
-		{
-			if(ieee->state =3D=3D IEEE80211_LINKED)
+		&& ieee->current_network.berp_info_valid) {
+			if (ieee->current_network.erp_value & ERP_UseProtection)
+				ieee->current_network.buseprotection =3D true;
+			else
+				ieee->current_network.buseprotection =3D false;
+			}
+		if (is_beacon(beacon->header.frame_ctl)) {
+			if (ieee->state =3D=3D IEEE80211_LINKED)
 				ieee->LinkDetectInfo.NumRecvBcnInPeriod++;
 		} else /* hidden AP */
 			network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWORK_EM=
PTY_ESSID & ieee->current_network.flags);
@@ -2556,8 +2460,8 @@ static inline void ieee80211_process_probe_response(
 #endif
 		memcpy(target, network, sizeof(*target));
 		list_add_tail(&target->list, &ieee->network_list);
-		if(ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE)
-			ieee80211_softmac_new_net(ieee,network);
+		if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE)
+			ieee80211_softmac_new_net(ieee, network);
 	} else {
 		IEEE80211_DEBUG_SCAN("Updating '%s' (%pM) via %s.\n",
 				     escape_essid(target->ssid,
@@ -2573,24 +2477,27 @@ static inline void ieee80211_process_probe_respons=
e(
 		 */
 		renew =3D !time_after(target->last_scanned + ieee->scan_age, jiffies);
 		/* YJ,add,080819,for hidden ap */
-		if(is_beacon(beacon->header.frame_ctl) =3D=3D 0)
+		if (is_beacon(beacon->header.frame_ctl) =3D=3D 0)
 			network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWORK_EM=
PTY_ESSID & target->flags);
-		if(((network->flags & NETWORK_EMPTY_ESSID) =3D=3D NETWORK_EMPTY_ESSID) =
\
-		    && (((network->ssid_len > 0) && (strncmp(target->ssid, network->ssi=
d, network->ssid_len)))\
-		    ||((ieee->current_network.ssid_len =3D=3D network->ssid_len)&&(strn=
cmp(ieee->current_network.ssid, network->ssid, network->ssid_len) =3D=3D 0=
)&&(ieee->state =3D=3D IEEE80211_NOLINK))))
-			renew =3D 1;
+		if (((network->flags & NETWORK_EMPTY_ESSID) =3D=3D NETWORK_EMPTY_ESSID)=
 &&
+			(((network->ssid_len > 0) &&
+			(strncmp(target->ssid, network->ssid, network->ssid_len))) ||
+			((ieee->current_network.ssid_len =3D=3D network->ssid_len) &&
+			(strncmp(ieee->current_network.ssid, network->ssid, network->ssid_len)=
 =3D=3D 0) &&
+			(ieee->state =3D=3D IEEE80211_NOLINK))))
+				renew =3D 1;
 		/* YJ,add,080819,for hidden ap,end */

 		update_network(target, network);
-		if(renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
-			ieee80211_softmac_new_net(ieee,network);
+		if (renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
+			ieee80211_softmac_new_net(ieee, network);
 	}

 	spin_unlock_irqrestore(&ieee->lock, flags);
-	if (is_beacon(beacon->header.frame_ctl)&&is_same_network(&ieee->current_=
network, network, ieee)&&\
+	if (is_beacon(beacon->header.frame_ctl) && is_same_network(&ieee->curren=
t_network, network, ieee) &&
 		(ieee->state =3D=3D IEEE80211_LINKED)) {
 		if (ieee->handle_beacon !=3D NULL) {
-			ieee->handle_beacon(ieee->dev,beacon,&ieee->current_network);
+			ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 		}
 	}

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/driv=
ers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 4f649fcc7c1d..7e380e93e7b9 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -196,15 +196,6 @@ static u8 MgntQuery_MgntFrameTxRate(struct ieee80211_=
device *ieee)
 			rate =3D 0x02;
 	}

-	/*
-	// Data rate of ProbeReq is already decided. Annie, 2005-03-31
-	if( pMgntInfo->bScanInProgress || (pMgntInfo->bDualModeScanStep!=3D0) ) =
{
-	if(pMgntInfo->dot11CurrentWirelessMode=3D=3DWIRELESS_MODE_A)
-	rate =3D 0x0c;
-	else
-	rate =3D 0x02;
-	}
-	 */
 	return rate;
 }

@@ -506,6 +497,7 @@ static void ieee80211_softmac_scan_wq(struct work_stru=
ct *work)
 static void ieee80211_beacons_start(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
+
 	spin_lock_irqsave(&ieee->beacon_lock, flags);

 	ieee->beacon_txing =3D 1;
@@ -681,7 +673,7 @@ static struct sk_buff *ieee80211_probe_resp(struct iee=
e80211_device *ieee, u8 *d
 	crypt =3D ieee->crypt[ieee->tx_keyidx];

 	encrypt =3D ieee->host_encrypt && crypt && crypt->ops &&
-		((0 =3D=3D strcmp(crypt->ops->name, "WEP") || wpa_ie_len));
+		((strcmp(crypt->ops->name, "WEP") =3D=3D 0 || wpa_ie_len));
 	/* HT ralated element */
 	tmp_ht_cap_buf =3D (u8 *)&ieee->pHTInfo->SelfHTCap;
 	tmp_ht_cap_len =3D sizeof(ieee->pHTInfo->SelfHTCap);
@@ -912,6 +904,7 @@ static void ieee80211_resp_to_auth(struct ieee80211_de=
vice *ieee, int s,
 static void ieee80211_resp_to_probe(struct ieee80211_device *ieee, u8 *de=
st)
 {
 	struct sk_buff *buf =3D ieee80211_probe_resp(ieee, dest);
+
 	if (buf)
 		softmac_mgmt_xmit(buf, ieee);
 }
@@ -945,7 +938,7 @@ ieee80211_association_req(struct ieee80211_network *be=
acon,
 	int len =3D 0;

 	crypt =3D ieee->crypt[ieee->tx_keyidx];
-	encrypt =3D ieee->host_encrypt && crypt && crypt->ops && ((0 =3D=3D strc=
mp(crypt->ops->name, "WEP") || wpa_ie_len));
+	encrypt =3D ieee->host_encrypt && crypt && crypt->ops && ((strcmp(crypt-=
>ops->name, "WEP") =3D=3D 0 || wpa_ie_len));

 	/* Include High Throuput capability && Realtek proprietary */
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
@@ -1080,6 +1073,7 @@ ieee80211_association_req(struct ieee80211_network *=
beacon,
 	if (beacon->BssCcxVerNumber >=3D 2) {
 		u8			CcxVerNumBuf[] =3D {0x00, 0x40, 0x96, 0x03, 0x00};
 		struct octet_string	osCcxVerNum;
+
 		CcxVerNumBuf[4] =3D beacon->BssCcxVerNumber;
 		osCcxVerNum.octet =3D CcxVerNumBuf;
 		osCcxVerNum.length =3D sizeof(CcxVerNumBuf);
@@ -1159,7 +1153,7 @@ void ieee80211_associate_abort(struct ieee80211_devi=
ce *ieee)

 	ieee->state =3D IEEE80211_ASSOCIATING_RETRY;

-	schedule_delayed_work(&ieee->associate_retry_wq, \
+	schedule_delayed_work(&ieee->associate_retry_wq,
 			      IEEE80211_SOFTMAC_ASSOC_RETRY_TIME);

 	spin_unlock_irqrestore(&ieee->lock, flags);
@@ -1247,6 +1241,7 @@ static void ieee80211_associate_step2(struct ieee802=
11_device *ieee)
 static void ieee80211_associate_complete_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee =3D container_of(work, struct ieee80211_de=
vice, associate_complete_wq);
+
 	printk(KERN_INFO "Associated successfully\n");
 	if (ieee80211_is_54g(&ieee->current_network) &&
 	    (ieee->modulation & IEEE80211_OFDM_MODULATION)) {
@@ -1294,6 +1289,7 @@ static void ieee80211_associate_complete(struct ieee=
80211_device *ieee)
 static void ieee80211_associate_procedure_wq(struct work_struct *work)
 {
 	struct ieee80211_device *ieee =3D container_of(work, struct ieee80211_de=
vice, associate_procedure_wq);
+
 	ieee->sync_scan_hurryup =3D 1;
 	mutex_lock(&ieee->wx_mutex);

@@ -1442,6 +1438,7 @@ static inline u16 auth_parse(struct sk_buff *skb, u8=
 **challenge, int *chlen)
 {
 	struct ieee80211_authentication *a;
 	u8 *t;
+
 	if (skb->len < (sizeof(struct ieee80211_authentication) - sizeof(struct =
ieee80211_info_element))) {
 		IEEE80211_DEBUG_MGMT("invalid len in auth resp: %d\n", skb->len);
 		return 0xcafe;
@@ -1525,7 +1522,7 @@ static int assoc_rq_parse(struct sk_buff *skb, u8 *d=
est)

 	if (skb->len < (sizeof(struct ieee80211_assoc_request_frame) -
 		sizeof(struct ieee80211_info_element))) {
-		IEEE80211_DEBUG_MGMT("invalid len in auth request:%d \n", skb->len);
+		IEEE80211_DEBUG_MGMT("invalid len in auth request:%d\n", skb->len);
 		return -1;
 	}

@@ -1580,6 +1577,7 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee, =
struct sk_buff *skb)
 {
 	u8 dest[ETH_ALEN];
 	int status;
+
 	ieee->softmac_stats.rx_auth_rq++;

 	status =3D auth_rq_parse(skb, dest);
@@ -1664,7 +1662,7 @@ static inline void ieee80211_sta_ps(struct ieee80211=
_device *ieee)
 	if ((ieee->ps =3D=3D IEEE80211_PS_DISABLED ||
 	     ieee->iw_mode !=3D IW_MODE_INFRA ||
 	     ieee->state !=3D IEEE80211_LINKED)) {
-		/* 	#warning CHECK_LOCK_HERE */
+		/* #warning CHECK_LOCK_HERE */
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);

 		ieee80211_sta_wakeup(ieee, 1);
@@ -1763,6 +1761,7 @@ static void ieee80211_process_action(struct ieee8021=
1_device *ieee,
 	struct rtl_80211_hdr *header =3D (struct rtl_80211_hdr *)skb->data;
 	u8 *act =3D ieee80211_get_payload(header);
 	u8 tmp =3D 0;
+
 	if (act =3D=3D NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "error to get payload of action frame=
\n");
 		return;
@@ -1781,7 +1780,6 @@ static void ieee80211_process_action(struct ieee8021=
1_device *ieee,
 	default:
 		break;
 	}
-	return;
 }

 static void ieee80211_check_auth_response(struct ieee80211_device *ieee,
@@ -1886,8 +1884,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 				if (ieee->qos_support) {
 					assoc_resp =3D (struct ieee80211_assoc_response_frame *)skb->data;
 					memset(network, 0, sizeof(*network));
-					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,\
-								       rx_stats->len - sizeof(*assoc_resp), \
+					if (ieee80211_parse_info_param(ieee, assoc_resp->info_element,
+								       rx_stats->len - sizeof(*assoc_resp),
 								       network, rx_stats)) {
 						return 1;
 					} else {
@@ -2014,15 +2012,15 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *=
txb, struct ieee80211_device *
 #else
 		if ((skb_queue_len(&ieee->skb_waitQ[queue_index]) !=3D 0) ||
 #endif
-		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
+		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) ||
 		    (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
 			/*
 			 * as for the completion function, it does not need
 			 * to check it any more.
-			 * */
-			//printk("error:no descriptor left@queue_index %d\n", queue_index);
-			//ieee80211_stop_queue(ieee);
+			 */
+			/* printk("error:no descriptor left@queue_index %d\n", queue_index); *=
/
+			/* ieee80211_stop_queue(ieee); */
 #ifdef USB_TX_DRIVER_AGGREGATION_ENABLE
 			skb_queue_tail(&ieee->skb_drv_aggQ[queue_index], txb->fragments[i]);
 #else
@@ -2044,6 +2042,7 @@ EXPORT_SYMBOL(ieee80211_softmac_xmit);
 static void ieee80211_resume_tx(struct ieee80211_device *ieee)
 {
 	int i;
+
 	for (i =3D ieee->tx_pending.frag; i < ieee->tx_pending.txb->nr_frags; i+=
+) {
 		if (ieee->queue_stop) {
 			ieee->tx_pending.frag =3D i;
@@ -2496,6 +2495,7 @@ void ieee80211_start_protocol(struct ieee80211_devic=
e *ieee)
 void ieee80211_softmac_init(struct ieee80211_device *ieee)
 {
 	int i;
+
 	memset(&ieee->current_network, 0, sizeof(struct ieee80211_network));

 	ieee->state =3D IEEE80211_NOLINK;
@@ -2579,8 +2579,10 @@ void ieee80211_softmac_free(struct ieee80211_device=
 *ieee)
  ********************************************************/
 static int ieee80211_wpa_enable(struct ieee80211_device *ieee, int value)
 {
-	/* This is called when wpa_supplicant loads and closes the driver
-	 * interface. */
+	/*
+	 * This is called when wpa_supplicant loads and closes the driver
+	 * interface.
+	 */
 	printk("%s WPA\n", value ? "enabling" : "disabling");
 	ieee->wpa_enabled =3D value;
 	return 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_tx.c
index 320021752f28..d807ea03a772 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -169,8 +169,7 @@ int ieee80211_encrypt_fragment(
 	struct ieee80211_crypt_data *crypt =3D ieee->crypt[ieee->tx_keyidx];
 	int res;

-	if (!(crypt && crypt->ops))
-	{
+	if (!(crypt && crypt->ops)) {
 		printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D>%s(), crypt is null\n", __func__);
 		return -1;
 	}
@@ -217,7 +216,8 @@ int ieee80211_encrypt_fragment(
 }


-void ieee80211_txb_free(struct ieee80211_txb *txb) {
+void ieee80211_txb_free(struct ieee80211_txb *txb)
+{
 	if (unlikely(!txb))
 		return;
 	kfree(txb);
@@ -229,6 +229,7 @@ static struct ieee80211_txb *ieee80211_alloc_txb(int n=
r_frags, int txb_size,
 {
 	struct ieee80211_txb *txb;
 	int i;
+
 	txb =3D kmalloc(
 		sizeof(struct ieee80211_txb) + (sizeof(u8 *) * nr_frags),
 		gfp_mask);
@@ -263,6 +264,7 @@ ieee80211_classify(struct sk_buff *skb, struct ieee802=
11_network *network)
 {
 	struct ethhdr *eth;
 	struct iphdr *ip;
+
 	eth =3D (struct ethhdr *)skb->data;
 	if (eth->h_proto !=3D htons(ETH_P_IP))
 		return 0;
@@ -295,7 +297,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee8021=
1_device *ieee,
 	struct tx_ts_record        *pTxTs =3D NULL;
 	struct rtl_80211_hdr_1addr *hdr =3D (struct rtl_80211_hdr_1addr *)skb->d=
ata;

-	if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 		return;
 	if (!IsQoSDataFrame(skb->data))
 		return;
@@ -310,69 +312,58 @@ static void ieee80211_tx_query_agg_cap(struct ieee80=
211_device *ieee,
 	if (!Adapter->HalFunc.GetNmodeSupportBySecCfgHandler(Adapter))
 		return;
 #endif
-	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev))
-	{
+	if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
 		return;
 	}
-	if (pHTInfo->bCurrentAMPDUEnable)
-	{
-		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1, skb->p=
riority, TX_DIR, true))
-		{
+	if (pHTInfo->bCurrentAMPDUEnable) {
+		if (!GetTs(ieee, (struct ts_common_info **)(&pTxTs), hdr->addr1, skb->p=
riority, TX_DIR, true)) {
 			printk("=3D=3D=3D>can't get TS\n");
 			return;
 		}
-		if (!pTxTs->tx_admitted_ba_record.valid)
-		{
+		if (!pTxTs->tx_admitted_ba_record.valid) {
 			TsStartAddBaProcess(ieee, pTxTs);
 			goto FORCED_AGG_SETTING;
-		}
-		else if (!pTxTs->using_ba)
-		{
+		} else if (!pTxTs->using_ba) {
 			if (SN_LESS(pTxTs->tx_admitted_ba_record.start_seq_ctrl.field.seq_num,=
 (pTxTs->tx_cur_seq + 1) % 4096))
 				pTxTs->using_ba =3D true;
 			else
 				goto FORCED_AGG_SETTING;
 		}

-		if (ieee->iw_mode =3D=3D IW_MODE_INFRA)
-		{
+		if (ieee->iw_mode =3D=3D IW_MODE_INFRA) {
 			tcb_desc->bAMPDUEnable =3D true;
 			tcb_desc->ampdu_factor =3D pHTInfo->CurrentAMPDUFactor;
 			tcb_desc->ampdu_density =3D pHTInfo->CurrentMPDUDensity;
 		}
 	}
 FORCED_AGG_SETTING:
-	switch (pHTInfo->ForcedAMPDUMode )
-	{
-		case HT_AGG_AUTO:
-			break;
-
-		case HT_AGG_FORCE_ENABLE:
-			tcb_desc->bAMPDUEnable =3D true;
-			tcb_desc->ampdu_density =3D pHTInfo->ForcedMPDUDensity;
-			tcb_desc->ampdu_factor =3D pHTInfo->ForcedAMPDUFactor;
-			break;
-
-		case HT_AGG_FORCE_DISABLE:
-			tcb_desc->bAMPDUEnable =3D false;
-			tcb_desc->ampdu_density =3D 0;
-			tcb_desc->ampdu_factor =3D 0;
-			break;
+	switch (pHTInfo->ForcedAMPDUMode) {
+	case HT_AGG_AUTO:
+		break;
+
+	case HT_AGG_FORCE_ENABLE:
+		tcb_desc->bAMPDUEnable =3D true;
+		tcb_desc->ampdu_density =3D pHTInfo->ForcedMPDUDensity;
+		tcb_desc->ampdu_factor =3D pHTInfo->ForcedAMPDUFactor;
+		break;
+
+	case HT_AGG_FORCE_DISABLE:
+		tcb_desc->bAMPDUEnable =3D false;
+		tcb_desc->ampdu_density =3D 0;
+		tcb_desc->ampdu_factor =3D 0;
+		break;

 	}
-		return;
+	return;
 }

 static void ieee80211_qurey_ShortPreambleMode(struct ieee80211_device *ie=
ee,
 					      struct cb_desc *tcb_desc)
 {
 	tcb_desc->bUseShortPreamble =3D false;
-	if (tcb_desc->data_rate =3D=3D 2) {
-	/* 1M can only use Long Preamble. 11B spec */
+	if (tcb_desc->data_rate =3D=3D 2) {/* 1M can only use Long Preamble. 11B=
 spec */
 		return;
-	}
-	else if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMB=
LE)
-	{
+	} else if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREA=
MBLE) {
 		tcb_desc->bUseShortPreamble =3D true;
 	}
 	return;
@@ -384,18 +375,17 @@ ieee80211_query_HTCapShortGI(struct ieee80211_device=
 *ieee, struct cb_desc *tcb_

 	tcb_desc->bUseShortGI		=3D false;

-	if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 		return;

-	if (pHTInfo->bForcedShortGI)
-	{
+	if (pHTInfo->bForcedShortGI) {
 		tcb_desc->bUseShortGI =3D true;
 		return;
 	}

-	if ((pHTInfo->bCurBW40MHz=3D=3Dtrue) && pHTInfo->bCurShortGI40MHz)
+	if ((pHTInfo->bCurBW40MHz =3D=3D true) && pHTInfo->bCurShortGI40MHz)
 		tcb_desc->bUseShortGI =3D true;
-	else if ((pHTInfo->bCurBW40MHz=3D=3Dfalse) && pHTInfo->bCurShortGI20MHz)
+	else if ((pHTInfo->bCurBW40MHz =3D=3D false) && pHTInfo->bCurShortGI20MH=
z)
 		tcb_desc->bUseShortGI =3D true;
 }

@@ -406,7 +396,7 @@ static void ieee80211_query_BandwidthMode(struct ieee8=
0211_device *ieee,

 	tcb_desc->bPacketBW =3D false;

-	if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+	if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 		return;

 	if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
@@ -415,7 +405,7 @@ static void ieee80211_query_BandwidthMode(struct ieee8=
0211_device *ieee,
 	if ((tcb_desc->data_rate & 0x80) =3D=3D 0) /* If using legacy rate, it s=
hall use 20MHz channel. */
 		return;
 	/* BandWidthAutoSwitch is for auto switch to 20 or 40 in long distance *=
/
-	if(pHTInfo->bCurBW40MHz && pHTInfo->bCurTxBW40MHz && !ieee->bandwidth_au=
to_switch.bforced_tx20Mhz)
+	if (pHTInfo->bCurBW40MHz && pHTInfo->bCurTxBW40MHz && !ieee->bandwidth_a=
uto_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW =3D true;
 	return;
 }
@@ -434,24 +424,20 @@ static void ieee80211_query_protectionmode(struct ie=
ee80211_device *ieee,
 	if (tcb_desc->bBroadcast || tcb_desc->bMulticast)/* only unicast frame w=
ill use rts/cts */
 		return;

-	if (is_broadcast_ether_addr(skb->data+16))  /* check addr3 as infrastruc=
ture add3 is DA. */
+	if (is_broadcast_ether_addr(skb->data + 16))  /* check addr3 as infrastr=
ucture add3 is DA. */
 		return;

-	if (ieee->mode < IEEE_N_24G) /* b, g mode */
-	{
-			/*
-			 * (1) RTS_Threshold is compared to the MPDU, not MSDU.
-			 * (2) If there are more than one frag in  this MSDU, only the first f=
rag uses protection frame.
-			 * 	Other fragments are protected by previous fragment.
-			 * 	So we only need to check the length of first fragment.
-			 */
-		if (skb->len > ieee->rts)
-		{
+	if (ieee->mode < IEEE_N_24G) {/* b, g mode */
+		/*
+		 * (1) RTS_Threshold is compared to the MPDU, not MSDU.
+		 * (2) If there are more than one frag in  this MSDU, only the first fr=
ag uses protection frame.
+		 * 	Other fragments are protected by previous fragment.
+		 * 	So we only need to check the length of first fragment.
+		 */
+		if (skb->len > ieee->rts) {
 			tcb_desc->bRTSEnable =3D true;
 			tcb_desc->rts_rate =3D MGN_24M;
-		}
-		else if (ieee->current_network.buseprotection)
-		{
+		} else if (ieee->current_network.buseprotection) {
 			/* Use CTS-to-SELF in protection mode. */
 			tcb_desc->bRTSEnable =3D true;
 			tcb_desc->bCTSEnable =3D true;
@@ -461,8 +447,7 @@ static void ieee80211_query_protectionmode(struct ieee=
80211_device *ieee,
 		return;
 	} else {/* 11n High throughput case. */
 		PRT_HIGH_THROUGHPUT pHTInfo =3D ieee->pHTInfo;
-		while (true)
-		{
+		while (true) {
 			/* check ERP protection */
 			if (ieee->current_network.buseprotection) {/* CTS-to-SELF */
 				tcb_desc->bRTSEnable =3D true;
@@ -471,28 +456,24 @@ static void ieee80211_query_protectionmode(struct ie=
ee80211_device *ieee,
 				break;
 			}
 			/* check HT op mode */
-			if(pHTInfo->bCurrentHTSupport  && pHTInfo->bEnableHT)
-			{
+			if (pHTInfo->bCurrentHTSupport && pHTInfo->bEnableHT) {
 				u8 HTOpMode =3D pHTInfo->CurrentOpMode;
-				if((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =3D=3D 3))=
 ||
-							(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3) )
-				{
+				if ((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =3D=3D 3)=
) ||
+							(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3)) {
 					tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
 					tcb_desc->bRTSEnable =3D true;
 					break;
 				}
 			}
 			/* check rts */
-			if (skb->len > ieee->rts)
-			{
+			if (skb->len > ieee->rts) {
 				tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
 				tcb_desc->bRTSEnable =3D true;
 				break;
 			}
 			/* to do list: check MIMO power save condition. */
 			/* check AMPDU aggregation for TXOP */
-			if(tcb_desc->bAMPDUEnable)
-			{
+			if (tcb_desc->bAMPDUEnable) {
 				tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
 				/* According to 8190 design, firmware sends CF-End only if RTS/CTS is=
 enabled. However, it degrads */
 				/* throughput around 10M, so we disable of this mechanism. 2007.08.03=
 by Emily */
@@ -500,8 +481,7 @@ static void ieee80211_query_protectionmode(struct ieee=
80211_device *ieee,
 				break;
 			}
 			/* check IOT action */
-			if(pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF)
-			{
+			if (pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF) {
 				tcb_desc->bCTSEnable	=3D true;
 				tcb_desc->rts_rate  =3D	MGN_24M;
 				tcb_desc->bRTSEnable =3D true;
@@ -520,7 +500,7 @@ static void ieee80211_query_protectionmode(struct ieee=
80211_device *ieee,
 	if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 		tcb_desc->bUseShortPreamble =3D true;
 	if (ieee->mode =3D=3D IW_MODE_MASTER)
-			goto NO_PROTECTION;
+		goto NO_PROTECTION;
 	return;
 NO_PROTECTION:
 	tcb_desc->bRTSEnable	=3D false;
@@ -535,28 +515,25 @@ static void ieee80211_txrate_selectmode(struct ieee8=
0211_device *ieee,
 					struct cb_desc *tcb_desc)
 {
 #ifdef TO_DO_LIST
-	if(!IsDataFrame(pFrame))
-	{
+	if (!IsDataFrame(pFrame)) {
 		pTcb->bTxDisableRateFallBack =3D true;
 		pTcb->bTxUseDriverAssingedRate =3D true;
 		pTcb->RATRIndex =3D 7;
 		return;
 	}

-	if(pMgntInfo->ForcedDataRate!=3D 0)
-	{
+	if (pMgntInfo->ForcedDataRate !=3D 0) {
 		pTcb->bTxDisableRateFallBack =3D true;
 		pTcb->bTxUseDriverAssingedRate =3D true;
 		return;
 	}
 #endif
-	if(ieee->bTxDisableRateFallBack)
+	if (ieee->bTxDisableRateFallBack)
 		tcb_desc->bTxDisableRateFallBack =3D true;

-	if(ieee->bTxUseDriverAssingedRate)
+	if (ieee->bTxUseDriverAssingedRate)
 		tcb_desc->bTxUseDriverAssingedRate =3D true;
-	if(!tcb_desc->bTxDisableRateFallBack || !tcb_desc->bTxUseDriverAssingedR=
ate)
-	{
+	if (!tcb_desc->bTxDisableRateFallBack || !tcb_desc->bTxUseDriverAssinged=
Rate) {
 		if (ieee->iw_mode =3D=3D IW_MODE_INFRA || ieee->iw_mode =3D=3D IW_MODE_=
ADHOC)
 			tcb_desc->RATRIndex =3D 0;
 	}
@@ -567,11 +544,10 @@ static void ieee80211_query_seqnum(struct ieee80211_=
device *ieee,
 {
 	if (is_multicast_ether_addr(dst))
 		return;
-	if (IsQoSDataFrame(skb->data)) /* we deal qos data only */
-	{
+	if (IsQoSDataFrame(skb->data)) {/* we deal qos data only */
 		struct tx_ts_record *pTS =3D NULL;
-		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priority, =
TX_DIR, true))
-		{
+
+		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priority, =
TX_DIR, true)) {
 			return;
 		}
 		pTS->tx_cur_seq =3D (pTS->tx_cur_seq + 1) % 4096;
@@ -607,15 +583,14 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
 	 * If there is no driver handler to take the TXB, dont' bother
 	 * creating it...
 	 */
-	if ((!ieee->hard_start_xmit && !(ieee->softmac_features & IEEE_SOFTMAC_T=
X_QUEUE))||
+	if ((!ieee->hard_start_xmit && !(ieee->softmac_features & IEEE_SOFTMAC_T=
X_QUEUE)) ||
 	   ((!ieee->softmac_data_hard_start_xmit && (ieee->softmac_features & IE=
EE_SOFTMAC_TX_QUEUE)))) {
-		printk(KERN_WARNING "%s: No xmit handler.\n",
-		       ieee->dev->name);
+		printk(KERN_WARNING "%s: No xmit handler.\n", ieee->dev->name);
 		goto success;
 	}


-	if(likely(ieee->raw_tx =3D=3D 0)){
+	if (likely(ieee->raw_tx =3D=3D 0)) {
 		if (unlikely(skb->len < SNAP_SIZE + sizeof(u16))) {
 			printk(KERN_WARNING "%s: skb too small (%d).\n",
 			ieee->dev->name, skb->len);
@@ -661,7 +636,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			fc =3D IEEE80211_FTYPE_DATA;

 		//if(ieee->current_network.QoS_Enable)
-		if(qos_actived)
+		if (qos_actived)
 			fc |=3D IEEE80211_STYPE_QOS_DATA;
 		else
 			fc |=3D IEEE80211_STYPE_DATA;
@@ -694,15 +669,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
 		if (is_multicast_ether_addr(header.addr1)) {
 			frag_size =3D MAX_FRAG_THRESHOLD;
 			qos_ctl |=3D QOS_CTL_NOTCONTAIN_ACK;
-		}
-		else {
+		} else {
 			frag_size =3D ieee->fts;/* default:392 */
 			qos_ctl =3D 0;
 		}

 		//if (ieee->current_network.QoS_Enable)
-		if(qos_actived)
-		{
+		if (qos_actived) {
 			hdr_len =3D IEEE80211_3ADDR_LEN + 2;

 			skb->priority =3D ieee80211_classify(skb, &ieee->current_network);
@@ -753,8 +726,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 		txb->payload_size =3D __cpu_to_le16(bytes);

 		//if (ieee->current_network.QoS_Enable)
-		if(qos_actived)
-		{
+		if (qos_actived) {
 			txb->queue_index =3D UP2AC(skb->priority);
 		} else {
 			txb->queue_index =3D WME_AC_BK;
@@ -765,7 +737,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 		for (i =3D 0; i < nr_frags; i++) {
 			skb_frag =3D txb->fragments[i];
 			tcb_desc =3D (struct cb_desc *)(skb_frag->cb + MAX_DEV_ADDR_SIZE);
-			if(qos_actived){
+			if (qos_actived) {
 				skb_frag->priority =3D skb->priority;
 				tcb_desc->queue_index =3D  UP2AC(skb->priority);
 			} else {
@@ -774,15 +746,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
 			}
 			skb_reserve(skb_frag, ieee->tx_headroom);

-			if (encrypt){
+			if (encrypt) {
 				if (ieee->hwsec_active)
 					tcb_desc->bHwSec =3D 1;
 				else
 					tcb_desc->bHwSec =3D 0;
 				skb_reserve(skb_frag, crypt->ops->extra_prefix_len);
-			}
-			else
-			{
+			} else {
 				tcb_desc->bHwSec =3D 0;
 			}
 			frag_hdr =3D skb_put_data(skb_frag, &header, hdr_len);
@@ -801,8 +771,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 				bytes =3D bytes_last_frag;
 			}
 			//if(ieee->current_network.QoS_Enable)
-			if(qos_actived)
-			{
+			if (qos_actived) {
 				/* add 1 only indicate to corresponding seq number control 2006/7/12 =
*/
 				frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[UP2AC(skb->priority)=
+1]<<4 | i);
 			} else {
@@ -833,17 +802,16 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
 				skb_put(skb_frag, 4);
 		}

-		if(qos_actived)
-		{
-		  if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
-			ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
-		  else
-			ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
+		if (qos_actived) {
+			if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
+				ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
+			else
+				ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
 		} else {
-		  if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
-			ieee->seq_ctrl[0] =3D 0;
-		  else
-			ieee->seq_ctrl[0]++;
+			if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
+				ieee->seq_ctrl[0] =3D 0;
+			else
+				ieee->seq_ctrl[0]++;
 		}
 	} else {
 		if (unlikely(skb->len < sizeof(struct rtl_80211_hdr_3addr))) {
@@ -853,7 +821,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 		}

 		txb =3D ieee80211_alloc_txb(1, skb->len, GFP_ATOMIC);
-		if(!txb){
+		if (!txb) {
 			printk(KERN_WARNING "%s: Could not allocate TXB\n",
 			ieee->dev->name);
 			goto failed;
@@ -866,9 +834,9 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)

  success:
 /* WB add to fill data tcb_desc here. only first fragment is considered, =
need to change, and you may remove to other place. */
-	if (txb)
-	{
+	if (txb) {
 		struct cb_desc *tcb_desc =3D (struct cb_desc *)(txb->fragments[0]->cb +=
 MAX_DEV_ADDR_SIZE);
+
 		tcb_desc->bTxEnableFwCalcDur =3D 1;
 		if (is_multicast_ether_addr(header.addr1))
 			tcb_desc->bMulticast =3D 1;
@@ -889,9 +857,9 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 	spin_unlock_irqrestore(&ieee->lock, flags);
 	dev_kfree_skb_any(skb);
 	if (txb) {
-		if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE){
+		if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE) {
 			ieee80211_softmac_xmit(txb, ieee);
-		}else{
+		} else {
 			if ((*ieee->hard_start_xmit)(txb, dev) =3D=3D 0) {
 				stats->tx_packets++;
 				stats->tx_bytes +=3D __le16_to_cpu(txb->payload_size);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_wx.c
index b09fd717b760..a1ef752a9636 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -69,10 +69,10 @@ static inline char *rtl819x_translate_scan(struct ieee=
80211_device *ieee,
 	}
 	/* Add the protocol name */
 	iwe.cmd =3D SIOCGIWNAME;
-	for(i=3D0; i<ARRAY_SIZE(ieee80211_modes); i++) {
+	for (i =3D 0; i < ARRAY_SIZE(ieee80211_modes); i++) {
 		if (network->mode & BIT(i)) {
-			sprintf(pname,ieee80211_modes[i].mode_string,ieee80211_modes[i].mode_s=
ize);
-			pname +=3Dieee80211_modes[i].mode_size;
+			sprintf(pname, ieee80211_modes[i].mode_string, ieee80211_modes[i].mode=
_size);
+			pname +=3D ieee80211_modes[i].mode_size;
 		}
 	}
 	*pname =3D '\0';
@@ -127,19 +127,19 @@ static inline char *rtl819x_translate_scan(struct ie=
ee80211_device *ieee,
 			max_rate =3D rate;
 	}

-	if (network->mode >=3D IEEE_N_24G)/* add N rate here; */
-	{
+	if (network->mode >=3D IEEE_N_24G) {/* add N rate here; */
 		struct ht_capability_ele *ht_cap =3D NULL;
 		bool is40M =3D false, isShortGI =3D false;
 		u8 max_mcs =3D 0;
+
 		if (!memcmp(network->bssht.bdHTCapBuf, EWC11NHTCap, 4))
 			ht_cap =3D (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[4];
 		else
 			ht_cap =3D (struct ht_capability_ele *)&network->bssht.bdHTCapBuf[0];
 		is40M =3D (ht_cap->ChlWidth)?1:0;
-		isShortGI =3D (ht_cap->ChlWidth)?
-						((ht_cap->ShortGI40Mhz)?1:0):
-						((ht_cap->ShortGI20Mhz)?1:0);
+		isShortGI =3D (ht_cap->ChlWidth) ?
+						((ht_cap->ShortGI40Mhz) ? 1 : 0) :
+						((ht_cap->ShortGI20Mhz) ? 1 : 0);

 		max_mcs =3D HTGetHighestMCSRate(ieee, ht_cap->MCS, MCS_FILTER_ALL);
 		rate =3D MCS_DATA_RATE[is40M][isShortGI][max_mcs&0x7f];
@@ -175,11 +175,12 @@ static inline char *rtl819x_translate_scan(struct ie=
ee80211_device *ieee,

 	iwe.u.data.length =3D p - custom;
 	if (iwe.u.data.length)
-	    start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
+		start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);

 	if (ieee->wpa_enabled && network->wpa_ie_len) {
 		char buf[MAX_WPA_IE_LEN * 2 + 30];
 		u8 *p =3D buf;
+
 		p +=3D sprintf(p, "wpa_ie=3D");
 		for (i =3D 0; i < network->wpa_ie_len; i++) {
 			p +=3D sprintf(p, "%02x", network->wpa_ie[i]);
@@ -193,8 +194,8 @@ static inline char *rtl819x_translate_scan(struct ieee=
80211_device *ieee,

 	if (ieee->wpa_enabled && network->rsn_ie_len) {
 		char buf[MAX_WPA_IE_LEN * 2 + 30];
-
 		u8 *p =3D buf;
+
 		p +=3D sprintf(p, "rsn_ie=3D");
 		for (i =3D 0; i < network->rsn_ie_len; i++) {
 			p +=3D sprintf(p, "%02x", network->rsn_ie[i]);
@@ -217,7 +218,7 @@ static inline char *rtl819x_translate_scan(struct ieee=
80211_device *ieee,
 		      " Last beacon: %lums ago", (jiffies - network->last_scanned) / (H=
Z / 100));
 	iwe.u.data.length =3D p - custom;
 	if (iwe.u.data.length)
-	    start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
+		start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);

 	return start;
 }
@@ -233,14 +234,14 @@ int ieee80211_wx_get_scan(struct ieee80211_device *i=
eee,
 	char *stop =3D ev + wrqu->data.length;/* IW_SCAN_MAX_DATA; */
 	int i =3D 0;
 	int err =3D 0;
+
 	IEEE80211_DEBUG_WX("Getting scan\n");
 	mutex_lock(&ieee->wx_mutex);
 	spin_lock_irqsave(&ieee->lock, flags);

 	list_for_each_entry(network, &ieee->network_list, list) {
 		i++;
-		if((stop-ev)<200)
-		{
+		if ((stop-ev) < 200) {
 			err =3D -E2BIG;
 			break;
 		}
@@ -460,7 +461,7 @@ int ieee80211_wx_get_encode(struct ieee80211_device *i=
eee,

 	IEEE80211_DEBUG_WX("GET_ENCODE\n");

-	if(ieee->iw_mode =3D=3D IW_MODE_MONITOR)
+	if (ieee->iw_mode =3D=3D IW_MODE_MONITOR)
 		return -1;

 	key =3D erq->flags & IW_ENCODE_INDEX;
@@ -575,7 +576,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_devic=
e *ieee,
 		ret =3D -EINVAL;
 		goto done;
 	}
-	printk("alg name:%s\n",alg);
+	printk("alg name:%s\n", alg);

 	ops =3D try_then_request_module(ieee80211_get_crypto_ops(alg), module);
 	if (!ops) {
@@ -683,12 +684,12 @@ int ieee80211_wx_get_encode_ext(struct ieee80211_dev=
ice *ieee,
 	encoding->flags =3D idx + 1;
 	memset(ext, 0, sizeof(*ext));

-	if (crypt =3D=3D NULL || crypt->ops =3D=3D NULL ) {
+	if (crypt =3D=3D NULL || crypt->ops =3D=3D NULL) {
 		ext->alg =3D IW_ENCODE_ALG_NONE;
 		ext->key_len =3D 0;
 		encoding->flags |=3D IW_ENCODE_DISABLED;
 	} else {
-		if (strcmp(crypt->ops->name, "WEP") =3D=3D 0 )
+		if (strcmp(crypt->ops->name, "WEP") =3D=3D 0)
 			ext->alg =3D IW_ENCODE_ALG_WEP;
 		else if (strcmp(crypt->ops->name, "TKIP"))
 			ext->alg =3D IW_ENCODE_ALG_TKIP;
@@ -713,6 +714,7 @@ int ieee80211_wx_set_mlme(struct ieee80211_device *iee=
e,
 			       union iwreq_data *wrqu, char *extra)
 {
 	struct iw_mlme *mlme =3D (struct iw_mlme *) extra;
+
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 	case IW_MLME_DISASSOC:
@@ -731,15 +733,15 @@ int ieee80211_wx_set_auth(struct ieee80211_device *i=
eee,
 {
 	switch (data->flags & IW_AUTH_INDEX) {
 	case IW_AUTH_WPA_VERSION:
-	     /*need to support wpa2 here*/
+	/*need to support wpa2 here*/
 		break;
 	case IW_AUTH_CIPHER_PAIRWISE:
 	case IW_AUTH_CIPHER_GROUP:
 	case IW_AUTH_KEY_MGMT:
 		/*
-		* Host AP driver does not use these parameters and allows
-		* wpa_supplicant to control them internally.
-		*/
+		 * Host AP driver does not use these parameters and allows
+		 * wpa_supplicant to control them internally.
+		 */
 		break;
 	case IW_AUTH_TKIP_COUNTERMEASURES:
 		ieee->tkip_countermeasures =3D data->value;
@@ -758,8 +760,7 @@ int ieee80211_wx_set_auth(struct ieee80211_device *iee=
e,
 		} else if (data->value & IW_AUTH_ALG_LEAP) {
 			ieee->open_wep =3D 1;
 			ieee->auth_mode =3D 2;
-		}
-		else
+		} else
 			return -EINVAL;
 		break;

@@ -784,16 +785,13 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device =
*ieee, u8 *ie, size_t len)
 {
 	u8 *buf;

-	if (len>MAX_WPA_IE_LEN || (len && ie =3D=3D NULL))
-	{
+	if (len > MAX_WPA_IE_LEN || (len && ie =3D=3D NULL)) {
 		return -EINVAL;
 	}


-	if (len)
-	{
-		if (len !=3D ie[1]+2)
-		{
+	if (len) {
+		if (len !=3D ie[1] + 2) {
 			printk("len:%zu, ie:%d\n", len, ie[1]);
 			return -EINVAL;
 		}
@@ -803,8 +801,7 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *i=
eee, u8 *ie, size_t len)
 		kfree(ieee->wpa_ie);
 		ieee->wpa_ie =3D buf;
 		ieee->wpa_ie_len =3D len;
-	}
-	else{
+	} else {
 		kfree(ieee->wpa_ie);
 		ieee->wpa_ie =3D NULL;
 		ieee->wpa_ie_len =3D 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index aed114573edb..5faf19381c08 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -140,7 +140,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee8021=
1_device *ieee, u8 *Dst, s
 	/* Dialog Token */
 	*tag++ =3D pBA->dialog_token;

-	if (ACT_ADDBARSP =3D=3D type) {
+	if (type =3D=3D ACT_ADDBARSP) {
 		/* Status Code */
 		netdev_info(ieee->dev, "=3D=3D=3D=3D=3D>to send ADDBARSP\n");

@@ -156,7 +156,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee8021=
1_device *ieee, u8 *Dst, s
 	put_unaligned_le16(pBA->timeout_value, tag);
 	tag +=3D 2;

-	if (ACT_ADDBAREQ =3D=3D type) {
+	if (type =3D=3D ACT_ADDBAREQ) {
 	/* BA Start SeqCtrl */
 		memcpy(tag, (u8 *)&(pBA->start_seq_ctrl), 2);
 		tag +=3D 2;
@@ -245,6 +245,7 @@ static void ieee80211_send_ADDBAReq(struct ieee80211_d=
evice *ieee,
 				    u8 *dst, struct ba_record *pBA)
 {
 	struct sk_buff *skb;
+
 	skb =3D ieee80211_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ); /* construct A=
CT_ADDBAREQ frames so set statuscode zero. */

 	if (skb) {
@@ -271,6 +272,7 @@ static void ieee80211_send_ADDBARsp(struct ieee80211_d=
evice *ieee, u8 *dst,
 				    struct ba_record *pBA, u16 StatusCode)
 {
 	struct sk_buff *skb;
+
 	skb =3D ieee80211_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP); /* co=
nstruct ACT_ADDBARSP frames */
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
@@ -297,6 +299,7 @@ static void ieee80211_send_DELBA(struct ieee80211_devi=
ce *ieee, u8 *dst,
 				 u16 ReasonCode)
 {
 	struct sk_buff *skb;
+
 	skb =3D ieee80211_DELBA(ieee, dst, pBA, TxRxSelect, ReasonCode); /* cons=
truct ACT_ADDBARSP frames */
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
@@ -396,6 +399,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 OnADDBAReq_Fail:
 	{
 		struct ba_record	BA;
+
 		BA.param_set =3D *pBaParamSet;
 		BA.timeout_value =3D *pBaTimeoutVal;
 		BA.dialog_token =3D *pDialogToken;
@@ -445,7 +449,8 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 	if (ieee->current_network.qos_data.active =3D=3D 0  ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR, "reject to ADDBA_RSP as some capabili=
ty is not ready(%d, %d, %d)\n", ieee->current_network.qos_data.active, iee=
e->pHTInfo->bCurrentHTSupport, ieee->pHTInfo->bCurrentAMPDUEnable);
+		IEEE80211_DEBUG(IEEE80211_DL_ERR, "reject to ADDBA_RSP as some capabili=
ty is not ready(%d, %d, %d)\n",
+			ieee->current_network.qos_data.active, ieee->pHTInfo->bCurrentHTSuppor=
t, ieee->pHTInfo->bCurrentAMPDUEnable);
 		ReasonCode =3D DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	}
@@ -478,10 +483,10 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 	 */
 	if (pAdmittedBA->valid) {
 		/* Since BA is already setup, we ignore all other ADDBA Response. */
-		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop be=
cause already admit it! \n");
+		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop be=
cause already admit it!\n");
 		return -1;
 	} else if ((!pPendingBA->valid) || (*pDialogToken !=3D pPendingBA->dialo=
g_token)) {
-		IEEE80211_DEBUG(IEEE80211_DL_ERR,  "OnADDBARsp(): Recv ADDBA Rsp. BA in=
valid, DELBA! \n");
+		IEEE80211_DEBUG(IEEE80211_DL_ERR,  "OnADDBARsp(): Recv ADDBA Rsp. BA in=
valid, DELBA!\n");
 		ReasonCode =3D DELBA_REASON_UNKNOWN_BA;
 		goto OnADDBARsp_Reject;
 	} else {
@@ -525,6 +530,7 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 OnADDBARsp_Reject:
 	{
 		struct ba_record	BA;
+
 		BA.param_set =3D *pBaParamSet;
 		ieee80211_send_DELBA(ieee, dst, &BA, TX_DIR, ReasonCode);
 		return 0;
@@ -649,6 +655,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_c=
ommon_info *pTsCommonInfo,
 				DELBA_REASON_END_BA);
 	} else if (TxRxSelect =3D=3D RX_DIR) {
 		struct rx_ts_record *pRxTs =3D (struct rx_ts_record *)pTsCommonInfo;
+
 		if (RxTsDeleteBA(ieee, pRxTs))
 			ieee80211_send_DELBA(
 				ieee,
@@ -677,6 +684,7 @@ void TxBaInactTimeout(struct timer_list *t)
 {
 	struct tx_ts_record *pTxTs =3D from_timer(pTxTs, t, tx_admitted_ba_recor=
d.timer);
 	struct ieee80211_device *ieee =3D container_of(pTxTs, struct ieee80211_d=
evice, TxTsRecord[pTxTs->num]);
+
 	TxTsDeleteBA(ieee, pTxTs);
 	ieee80211_send_DELBA(
 		ieee,
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/sta=
ging/rtl8192u/ieee80211/rtl819x_HT.h
index 71665b3da617..177513c8d63b 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -247,14 +247,14 @@ extern u8 MCS_FILTER_1SS[16];
  * to add a macro to judge wireless mode.
  */
 #define PICK_RATE(_nLegacyRate, _nMcsRate)	\
-		(_nMcsRate =3D=3D 0) ? (_nLegacyRate & 0x7f) : (_nMcsRate)
+		((_nMcsRate =3D=3D 0) ? (_nLegacyRate & 0x7f) : (_nMcsRate))
 /* 2007/07/12 MH We only define legacy and HT wireless mode now. */
 #define	LEGACY_WIRELESS_MODE	IEEE_MODE_MASK

 #define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)	\
-					((WirelessMode & (LEGACY_WIRELESS_MODE)) !=3D 0) ?\
+					(((WirelessMode & (LEGACY_WIRELESS_MODE)) !=3D 0) ?\
 						(LegacyRate) :\
-						(PICK_RATE(LegacyRate, HTRate))
+						(PICK_RATE(LegacyRate, HTRate)))

 /* MCS Bw 40 {1~7, 12~15,32} */
 #define	RATE_ADPT_1SS_MASK		0xFF
@@ -268,11 +268,10 @@ typedef enum _HT_AGGRE_SIZE {
 	HT_AGG_SIZE_16K =3D 1,
 	HT_AGG_SIZE_32K =3D 2,
 	HT_AGG_SIZE_64K =3D 3,
-}HT_AGGRE_SIZE_E, *PHT_AGGRE_SIZE_E;
+} HT_AGGRE_SIZE_E, *PHT_AGGRE_SIZE_E;

 /* Indicate different AP vendor for IOT issue */
-typedef enum _HT_IOT_PEER
-{
+typedef enum _HT_IOT_PEER {
 	HT_IOT_PEER_UNKNOWN =3D 0,
 	HT_IOT_PEER_REALTEK =3D 1,
 	HT_IOT_PEER_BROADCOM =3D 2,
@@ -280,7 +279,7 @@ typedef enum _HT_IOT_PEER
 	HT_IOT_PEER_ATHEROS =3D 4,
 	HT_IOT_PEER_CISCO =3D 5,
 	HT_IOT_PEER_MAX =3D 6
-}HT_IOT_PEER_E, *PHTIOT_PEER_E;
+} HT_IOT_PEER_E, *PHTIOT_PEER_E;

 /*
  * IOT Action for different AP
@@ -296,6 +295,6 @@ typedef enum _HT_IOT_ACTION {
 	HT_IOT_ACT_CDD_FSYNC =3D 0x00000080,
 	HT_IOT_ACT_PURE_N_MODE =3D 0x00000100,
 	HT_IOT_ACT_FORCED_CTS2SELF =3D 0x00000200,
-}HT_IOT_ACTION_E, *PHT_IOT_ACTION_E;
+} HT_IOT_ACTION_E, *PHT_IOT_ACTION_E;

 #endif /* _RTL819XU_HTTYPE_H_ */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c3b6687024cd..8476baaedf7f 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -146,7 +146,7 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupport CCK in 20/40 mode =3D %s\n"=
, (pCapELE->DssCCk) ? "YES" : "NO");
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMax AMPDU Factor =3D %d\n", pCapELE=
->MaxRxAMPDUFactor);
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMPDU Density =3D %d\n", pCapELE->MP=
DUDensity);
-	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set =3D [%x][%x][%x][%x][%=
x]\n", pCapELE->MCS[0],\
+	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tMCS Rate Set =3D [%x][%x][%x][%x][%=
x]\n", pCapELE->MCS[0],
 				pCapELE->MCS[1], pCapELE->MCS[2], pCapELE->MCS[3], pCapELE->MCS[4]);
 }

@@ -208,7 +208,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 		break;
 	}

-	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set =3D [%x][%x][%x][=
%x][%x]\n", pHTInfoEle->BasicMSC[0],\
+	IEEE80211_DEBUG(IEEE80211_DL_HT, "\tBasic MCS Rate Set =3D [%x][%x][%x][=
%x][%x]\n", pHTInfoEle->BasicMSC[0],
 				pHTInfoEle->BasicMSC[1], pHTInfoEle->BasicMSC[2], pHTInfoEle->BasicMS=
C[3], pHTInfoEle->BasicMSC[4]);
 }

@@ -654,13 +654,13 @@ void HTConstructRT2RTAggElement(struct ieee80211_dev=
ice *ieee, u8 *posRT2RTAgg,
 #ifdef TODO
 #if (HAL_CODE_BASE =3D=3D RTL8192 && DEV_BUS_TYPE =3D=3D USB_INTERFACE)
 	/*
-	//Emily. If it is required to Ask Realtek AP to send AMPDU during AES mo=
de, enable this
-	   section of code.
-	if(IS_UNDER_11N_AES_MODE(Adapter))
-	{
+	 * Emily. If it is required to Ask Realtek AP to send AMPDU during AES m=
ode, enable this
+	 * section of code.
+	 */
+	/*
+	if(IS_UNDER_11N_AES_MODE(Adapter)) {
 		posRT2RTAgg->octet[5] |=3D RT_HT_CAP_USE_AMPDU;
-	}else
-	{
+	} else {
 		posRT2RTAgg->octet[5] &=3D 0xfb;
 	}
 	*/
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 903373769464..b2614669f2d2 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -68,7 +68,7 @@ static void RxPktPendingTimeout(struct timer_list *t)

 		/* Indicate packets */
 		if (index > REORDER_WIN_SIZE) {
-			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!! \n");
+			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!!\n");
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 			return;
 		}
@@ -96,7 +96,7 @@ static void TsAddBaProcess(struct timer_list *t)
 	struct ieee80211_device *ieee =3D container_of(pTxTs, struct ieee80211_d=
evice, TxTsRecord[num]);

 	TsInitAddBA(ieee, pTxTs, BA_POLICY_IMMEDIATE, false);
-	IEEE80211_DEBUG(IEEE80211_DL_BA, "TsAddBaProcess(): ADDBA Req is started=
!! \n");
+	IEEE80211_DEBUG(IEEE80211_DL_BA, "TsAddBaProcess(): ADDBA Req is started=
!!\n");
 }


@@ -134,6 +134,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 	struct rx_ts_record     *pRxTS  =3D ieee->RxTsRecord;
 	struct rx_reorder_entry	*pRxReorderEntry =3D ieee->RxReorderEntry;
 	u8				count =3D 0;
+
 	IEEE80211_DEBUG(IEEE80211_DL_TS, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>%s()\n"=
, __func__);
 	/* Initialize Tx TS related info. */
 	INIT_LIST_HEAD(&ieee->Tx_TS_Admit_List);
@@ -206,6 +207,7 @@ static struct ts_common_info *SearchAdmitTRStream(stru=
ct ieee80211_device *ieee,
 	bool				search_dir[4] =3D {0};
 	struct list_head		*psearch_list; /* FIXME */
 	struct ts_common_info	*pRet =3D NULL;
+
 	if (ieee->iw_mode =3D=3D IW_MODE_MASTER) { /* ap mode */
 		if (TxRxSelect =3D=3D TX_DIR) {
 			search_dir[DIR_DOWN] =3D true;
@@ -251,7 +253,7 @@ static struct ts_common_info *SearchAdmitTRStream(stru=
ct ieee80211_device *ieee,
 	}

 	if (&pRet->list  !=3D psearch_list)
-		return pRet ;
+		return pRet;
 	else
 		return NULL;
 }
@@ -367,9 +369,11 @@ bool GetTs(
 				list_del_init(&(*ppTS)->list);
 				if (TxRxSelect =3D=3D TX_DIR) {
 					struct tx_ts_record *tmp =3D container_of(*ppTS, struct tx_ts_record=
, ts_common_info);
+
 					ResetTxTsEntry(tmp);
 				} else {
 					struct rx_ts_record *tmp =3D container_of(*ppTS, struct rx_ts_record=
, ts_common_info);
+
 					ResetRxTsEntry(tmp);
 				}

@@ -403,6 +407,7 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *
 			  enum tr_select TxRxSelect)
 {
 	unsigned long flags =3D 0;
+
 	del_timer_sync(&pTs->setup_timer);
 	del_timer_sync(&pTs->inact_timer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);
@@ -410,6 +415,7 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *
 	if (TxRxSelect =3D=3D RX_DIR) {
 		struct rx_reorder_entry	*pRxReorderEntry;
 		struct rx_ts_record     *pRxTS =3D (struct rx_ts_record *)pTs;
+
 		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
 			del_timer_sync(&pRxTS->rx_pkt_pending_timer);

@@ -420,6 +426,7 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *
 			{
 				int i =3D 0;
 				struct ieee80211_rxb *prxb =3D pRxReorderEntry->prxb;
+
 				if (unlikely(!prxb)) {
 					spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 					return;
@@ -436,6 +443,7 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *

 	} else {
 		struct tx_ts_record *pTxTS =3D (struct tx_ts_record *)pTs;
+
 		del_timer_sync(&pTxTS->ts_add_ba_timer);
 	}
 }
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index 51dab0863b86..2ce587e27f3c 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -142,21 +142,6 @@ void dm_CheckRxAggregation(struct net_device *dev)
 	unsigned long		curTxOkCnt =3D 0;
 	unsigned long		curRxOkCnt =3D 0;

-/*
-	if (pHalData->bForcedUsbRxAggr) {
-		if (pHalData->ForcedUsbRxAggrInfo =3D=3D 0) {
-			if (pHalData->bCurrentRxAggrEnable) {
-				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, FALSE);
-			}
-		} else {
-			if (!pHalData->bCurrentRxAggrEnable || (pHalData->ForcedUsbRxAggrInfo =
!=3D pHalData->LastUsbRxAggrInfoSetting)) {
-				Adapter->HalFunc.HalUsbRxAggrHandler(Adapter, TRUE);
-			}
-		}
-		return;
-	}
-
-*/
 	curTxOkCnt =3D priv->stats.txbytesunicast - lastTxOkCnt;
 	curRxOkCnt =3D priv->stats.rxbytesunicast - lastRxOkCnt;

@@ -333,7 +318,6 @@ static void dm_check_rate_adaptive(struct net_device *=
dev)
 		 * time to link with AP. We will not change upper/lower threshold. If
 		 * STA stay in high or low level, we must change two different threshol=
d
 		 * to prevent jumping frequently.
-		 *
 		 */
 		if (pra->ratr_state =3D=3D DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA	=3D pra->high2low_rssi_thresh_for_ra;
@@ -708,9 +692,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(st=
ruct net_device *dev)
 		}
 		tmpCCK40Mindex =3D 0;
 	}
-	/*DbgPrint("%ddb, tmpOFDMindex =3D %d, tmpCCK20Mindex =3D %d, tmpCCK40Mi=
ndex =3D %d",
-		((u1Byte)tmpRegA - pHalData->ThermalMeter[0]),
-		tmpOFDMindex, tmpCCK20Mindex, tmpCCK40Mindex);*/
 	if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20)	/* 40M */
 		tmpCCKindex =3D tmpCCK40Mindex;
 	else
@@ -1304,6 +1285,7 @@ static void dm_CheckTXPowerTracking_ThermalMeter(str=
uct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
 	static u8	TM_Trigger;
+
 	if (!priv->btxpower_tracking)
 		return;
 	if (priv->txpower_count  <=3D 2) {
@@ -1680,9 +1662,6 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	else
 		dm_digtable.cur_connect_state =3D DIG_DISCONNECT;

-	/*DbgPrint("DM_DigTable.PreConnectState =3D %d, DM_DigTable.CurConnectSt=
ate =3D %d\n",
-		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/
-
 	dm_digtable.rssi_val =3D priv->undecorated_smoothed_pwdb;
 	dm_initial_gain(dev);
 	dm_pd_th(dev);
@@ -1754,12 +1733,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alar=
m(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-			/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			else if (pAdapter->HardwareType =3D=3D HARDWARE_TYPE_RTL8192E)
-			else
-				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x40);
-			*/
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);

@@ -1814,13 +1787,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alar=
m(
 			 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 			 */
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-			/*
-			else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-			else if (pAdapter->HardwareType =3D=3D HARDWARE_TYPE_RTL8192E)
-			else
-				PlatformEFIOWrite1Byte(pAdapter, rOFDM0_RxDetector1, 0x42);
-			*/
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);

@@ -1887,10 +1853,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 		if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
 			write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);

-			/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-				write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-			*/
-
 		} else
 			write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 	} else {
@@ -1904,10 +1866,6 @@ static void dm_ctrl_initgain_byrssi_highpwr(
 			/*  3.2 Recover PD_TH for OFDM for normal power region. */
 			if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
 				write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-				/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-				*/
-
 			} else
 				write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 		}
@@ -2023,9 +1981,6 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x00);
-					/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x40);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
 			} else if (dm_digtable.curpd_thstate =3D=3D DIG_PD_AT_NORMAL_POWER) {
@@ -2036,18 +1991,12 @@ static void dm_pd_th(
 					 * 2008/02/05 MH SD3-Jerry 92U/92E PD_TH are the same.
 					 */
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x20);
-					/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x42);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x44);
 			} else if (dm_digtable.curpd_thstate =3D=3D DIG_PD_AT_HIGH_POWER) {
 				/* Higher PD_TH for OFDM for high power state. */
 				if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
 					write_nic_byte(dev, (rOFDM0_XATxAFE+3), 0x10);
-					/*else if (priv->card_8192 =3D=3D HARDWARE_TYPE_RTL8190P)
-						write_nic_byte(dev, rOFDM0_RxDetector1, 0x41);
-					*/
 				} else
 					write_nic_byte(dev, rOFDM0_RxDetector1, 0x43);
 			}
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl819=
2u/r8192U_hw.h
index 79d462894f1d..1e5a9c81788a 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -87,7 +87,7 @@ enum _RTL8192Usb_HW {
 #define RX_FIFO_THRESHOLD_MASK (BIT(13) | BIT(14) | BIT(15))
 #define RX_FIFO_THRESHOLD_SHIFT 13
 #define RX_FIFO_THRESHOLD_NONE 7
-#define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
+#define MAX_RX_DMA_MASK		(BIT(8) | BIT(9) | BIT(10))
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
 #define RCR_ONLYERLPKT		BIT(31)			/* Early Receiving based on Packet Size=
. */
@@ -225,13 +225,13 @@ enum _RTL8192Usb_HW {
 #define	RATR_MCS14		0x04000000
 #define	RATR_MCS15		0x08000000
 /* ALL CCK Rate */
-#define RATE_ALL_CCK		RATR_1M|RATR_2M|RATR_55M|RATR_11M
-#define RATE_ALL_OFDM_AG	RATR_6M|RATR_9M|RATR_12M|RATR_18M|RATR_24M\
-							|RATR_36M|RATR_48M|RATR_54M
-#define RATE_ALL_OFDM_1SS	RATR_MCS0|RATR_MCS1|RATR_MCS2|RATR_MCS3 | \
-							RATR_MCS4|RATR_MCS5|RATR_MCS6|RATR_MCS7
-#define RATE_ALL_OFDM_2SS	RATR_MCS8|RATR_MCS9	|RATR_MCS10|RATR_MCS11| \
-							RATR_MCS12|RATR_MCS13|RATR_MCS14|RATR_MCS15
+#define RATE_ALL_CCK		(RATR_1M|RATR_2M|RATR_55M|RATR_11M)
+#define RATE_ALL_OFDM_AG	(RATR_6M|RATR_9M|RATR_12M|RATR_18M|RATR_24M\
+						|RATR_36M|RATR_48M|RATR_54M)
+#define RATE_ALL_OFDM_1SS	(RATR_MCS0|RATR_MCS1|RATR_MCS2|RATR_MCS3\
+						|RATR_MCS4|RATR_MCS5|RATR_MCS6|RATR_MCS7)
+#define RATE_ALL_OFDM_2SS	(RATR_MCS8|RATR_MCS9|RATR_MCS10|RATR_MCS11\
+						|RATR_MCS12|RATR_MCS13|RATR_MCS14|RATR_MCS15)

 	EPROM_CMD		=3D 0xfe58,
 #define Cmd9346CR_9356SEL	BIT(4)
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl819=
2u/r8192U_wx.c
index 839671cc7f96..24c11976ea61 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -470,6 +470,7 @@ static int r8192_wx_set_wap(struct net_device *dev,

 	int ret;
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
+
 	mutex_lock(&priv->wx_mutex);

 	ret =3D ieee80211_wx_set_wap(priv->ieee80211, info, awrq, extra);
@@ -751,7 +752,7 @@ static int r8192_wx_set_enc_ext(struct net_device *dev=
,
 			idx--;
 		group =3D ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY;

-		if ((!group) || (IW_MODE_ADHOC =3D=3D ieee->iw_mode) || (alg =3D=3D  KE=
Y_TYPE_WEP40)) {
+		if ((!group) || (ieee->iw_mode =3D=3D IW_MODE_ADHOC) || (alg =3D=3D  KE=
Y_TYPE_WEP40)) {
 			if ((ext->key_len =3D=3D 13) && (alg =3D=3D KEY_TYPE_WEP40))
 				alg =3D KEY_TYPE_WEP104;
 			ieee->pairwise_key_type =3D alg;
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/=
rtl8192u/r819xU_firmware.c
index 0e47b5f75695..b16f1a102c89 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -232,7 +232,7 @@ bool init_firmware(struct net_device *dev)
 		rst_opt =3D OPT_FIRMWARE_RESET;
 		starting_state =3D FW_INIT_STEP2_DATA;
 	} else {
-		 RT_TRACE(COMP_FIRMWARE, "PlatformInitFirmware: undefined firmware stat=
e\n");
+		RT_TRACE(COMP_FIRMWARE, "PlatformInitFirmware: undefined firmware state=
\n");
 	}

 	/*
=2D-
2.17.1

