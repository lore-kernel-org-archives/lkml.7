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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46144C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B80280D3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gn6p7lJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfFCMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:22:05 -0400
Received: from mout.web.de ([217.72.192.78]:40881 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfFCMWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559564486;
        bh=4Ig1MLesNUJX/Py/2W8C82vany71oY884Fky/7ebFWQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gn6p7lJcucksy7P0eoXWGRBzN8fe+ZkA7VGf7hHBPvVNQ2976c5LBdKSlA9yfIA3g
         8xVBNFrpjFlVT4E1LkZq1PVRYlOBRNHGnrSMp0kK/CmAut87H3XXaBiPOi/rVi50bG
         UqbxTD6XZymPqXBNSp2dX4NvarWVkMoz1KZcgMvo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LeLWz-1gmMwN28uT-00qE3Z; Mon, 03 Jun 2019 14:21:26 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 1/3] drivers/staging/rtl8192u: Reformat comments
Date:   Mon,  3 Jun 2019 14:21:02 +0200
Message-Id: <20190603122104.2564-2-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603122104.2564-1-muellerch-privat@web.de>
References: <20190603122104.2564-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:igxNqR2AXDvQUI2W7009dcLCrvU3znM4ZmriRJq/tOYOncQN2X8
 vt8RCEIOVjaBZM4KGxDhWjMAAy3lC8w/apa03xR7PLxJV3k8GquNM7Dm0zCE8IYovIJIvtd
 +8KF+/hw5WDtxn0keJ3YsSrQvK9+BlzQW1OfY2u5d2af+YcN+BiJ3KSygjpsF0aCmTnbGKV
 5Y/BYXa3aW56JdU5nt3YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/7dLzcxjrl4=:gtrM4BWHYMnkXtXA3LRjbu
 pCPDDMVXvbPOuxoUATM37m9T+BQbg1+Uture55NjzAO53Zf5sxiibRm306H6vvPGhXvkh71w2
 7vCJMcTRzk+iD2Tq4WMQ+IFXHNflmcsESjek7z4/rIPAwrEaLhlBBsSYG2IzBCEPzFAu+Ugf8
 DPn3+eoQ+AFGbXEPt5Tk0ZDRNuFNN40GsV/Sn1fBKCkhJ5zZ6gnHhjlXQdo4ac73SDLv33i6i
 gVQlVvG/x/aRFwMqxHqOacetOLzi70SSlbtYdiOJSwwnXi8vZOD3E4vAq0b2BD3+QZ1NpL8wk
 EUZv6XDzGXYnn+V/owz1pVWGcIr3E2gREI9XSaYGoJ/PcxnACkHN9mTKSDS8QdOCq+wexrnNn
 c9grwX6XeJj6MNZqRPH+UcWF6pXnxBPuhPUOXoR+ft8QGByKBHR6jzl8yj0BL6XjFd9fhxsQq
 Rjdr26TfLtT3IYRKGFKoJS2njWSTFRrCHWqyja80QNU33K+pvUwPEvRGgOkpNuI+lyf/2vP+4
 stEwWgGwVIeH0JEKj+rCuueoobFK0Bodtt1TLxWqPBHSaoYJdi7tFJF8ix3v9sN2CWnl7zGjy
 9cf4wHOGvoFgm/KQea1Of++Nz+wEYb7JPU0QcD7Rm4oRPDkr9dTv5ONrLLPDn/+lnoYJ3jhfF
 uAuyYcUDZFsvgo2kFGUhyVSyDfN2UdgZsh1irfGcjXUivdFUm1kHMsg9zmZCqqFFWDGE+XGvQ
 k7qMzF2kFP1ortmuvvKcFzk6zIIFHrKIqh85qEVf9u9PV/tPEMforoJag24MiD/MTZsDfwTAa
 g8Od+pgzLTN7s+LmmJk843771SamTEgjNdVpuJTLcf3itg7d/XqWkbOHV9rg85uatU+WjbYxe
 ieWREdzXaj7TyAyaAH+ATUAQcFouq2R0/3n2WFlxY1lAX8YCjL/ZllymqbF98LTBSQUERcRqP
 qkvHIR9PihDT5gYY7AX31MMfgoEbuEGw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Trommer <felix.trommer@hotmail.de>

Replace C99-Style comments with C89-Style comments.

Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
=2D--
 drivers/staging/rtl8192u/ieee80211/dot11d.c   |   6 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 276 ++++++++---------
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |   3 +-
 .../rtl8192u/ieee80211/ieee80211_crypt.h      |  15 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   6 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  12 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |   9 +-
 .../rtl8192u/ieee80211/ieee80211_module.c     |   3 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 284 +++++++++++-------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 197 ++++++------
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c |   8 +-
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 124 ++++----
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |  45 +--
 .../staging/rtl8192u/ieee80211/rtl819x_BA.h   |   2 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 148 ++++-----
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  94 +++---
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 196 ++++++------
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  |  20 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       |  85 +++---
 drivers/staging/rtl8192u/r8180_93cx6.c        |   3 +-
 drivers/staging/rtl8192u/r8180_93cx6.h        |   4 +-
 drivers/staging/rtl8192u/r8190_rtl8256.c      |  33 +-
 drivers/staging/rtl8192u/r8192U.h             |  47 +--
 drivers/staging/rtl8192u/r8192U_core.c        | 154 ++++++----
 drivers/staging/rtl8192u/r8192U_dm.c          | 131 ++++----
 drivers/staging/rtl8192u/r8192U_dm.h          |  22 +-
 drivers/staging/rtl8192u/r8192U_hw.h          | 176 +++++------
 drivers/staging/rtl8192u/r8192U_wx.c          |  12 +-
 drivers/staging/rtl8192u/r819xU_cmdpkt.c      |  77 +++--
 drivers/staging/rtl8192u/r819xU_cmdpkt.h      |  14 +-
 drivers/staging/rtl8192u/r819xU_firmware.c    |   9 +-
 drivers/staging/rtl8192u/r819xU_phy.c         |  30 +-
 drivers/staging/rtl8192u/r819xU_phy.h         |   4 +-
 drivers/staging/rtl8192u/r819xU_phyreg.h      |   9 +-
 34 files changed, 1267 insertions(+), 991 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging=
/rtl8192u/ieee80211/dot11d.c
index 130ddfe9868f..bbb1014007a4 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -63,14 +63,16 @@ void dot11d_update_country_ie(struct ieee80211_device =
*dev, u8 *pTaddr,
 	pTriple =3D (struct chnl_txpower_triple *)(pCoutryIe + 3);
 	for (i =3D 0; i < NumTriples; i++) {
 		if (MaxChnlNum >=3D pTriple->first_channel) {
-			/* It is not in a monotonically increasing order, so
+			/*
+			 * It is not in a monotonically increasing order, so
 			 * stop processing.
 			 */
 			netdev_err(dev->dev, "dot11d_update_country_ie(): Invalid country IE, =
skip it........1\n");
 			return;
 		}
 		if (MAX_CHANNEL_NUMBER < (pTriple->first_channel + pTriple->num_channel=
s)) {
-			/* It is not a valid set of channel id, so stop
+			/*
+			 * It is not a valid set of channel id, so stop
 			 * processing.
 			 */
 			netdev_err(dev->dev, "dot11d_update_country_ie(): Invalid country IE, =
skip it........2\n");
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stag=
ing/rtl8192u/ieee80211/ieee80211.h
index d36963469015..8be8a94a2253 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -54,9 +54,7 @@
 /* added for rtl819x tx procedure */
 #define MAX_QUEUE_SIZE		0x10

-//
-// 8190 queue mapping
-//
+/* 8190 queue mapping */
 #define BK_QUEUE                               0
 #define BE_QUEUE                               1
 #define VI_QUEUE                               2
@@ -70,13 +68,13 @@
 #define LOW_QUEUE                              BE_QUEUE
 #define NORMAL_QUEUE                           MGNT_QUEUE

-//added by amy for ps
+/* added by amy for ps */
 #define SWRF_TIMEOUT				50

-//added by amy for LEAP related
-#define IE_CISCO_FLAG_POSITION		0x08	// Flag byte: byte 8, numbered from =
0.
-#define SUPPORT_CKIP_MIC			0x08	// bit3
-#define SUPPORT_CKIP_PK			0x10	// bit4
+/* added by amy for LEAP related */
+#define IE_CISCO_FLAG_POSITION		0x08	/* Flag byte: byte 8, numbered from =
0. */
+#define SUPPORT_CKIP_MIC			0x08	/* bit3 */
+#define SUPPORT_CKIP_PK			0x10	/* bit4 */
 /* defined for skb cb field */
 /* At most 28 byte */
 struct cb_desc {
@@ -88,7 +86,7 @@ struct cb_desc {
 	u8 bEncrypt:1;
 	u8 bTxDisableRateFallBack:1;
 	u8 bTxUseDriverAssingedRate:1;
-	u8 bHwSec:1; //indicate whether use Hw security. WB
+	u8 bHwSec:1; /* indicate whether use Hw security. WB */

 	u8 reserved1;

@@ -108,17 +106,17 @@ struct cb_desc {
 	u8 bRTSUseShortGI:1;
 	u8 bMulticast:1;
 	u8 bBroadcast:1;
-	//u8 reserved2:2;
+	/* u8 reserved2:2; */
 	u8 drv_agg_enable:1;
 	u8 reserved2:1;

 	/* Tx Desc related element(12-19) */
 	u8 rata_index;
 	u8 queue_index;
-	//u8 reserved3;
-	//u8 reserved4;
+	/* u8 reserved3; */
+	/* u8 reserved4; */
 	u16 txbuf_size;
-	//u8 reserved5;
+	/* u8 reserved5; */
 	u8 RATRIndex;
 	u8 reserved6;
 	u8 reserved7;
@@ -129,9 +127,9 @@ struct cb_desc {
 	u8 rts_rate;
 	u8 ampdu_factor;
 	u8 ampdu_density;
-	//u8 reserved9;
-	//u8 reserved10;
-	//u8 reserved11;
+	/* u8 reserved9; */
+	/* u8 reserved10; */
+	/* u8 reserved11; */
 	u8 DrvAggrNum;
 	u16 pkt_size;
 	u8 reserved12;
@@ -187,15 +185,21 @@ struct cb_desc {
 #define IEEE_PARAM_PRIVACY_INVOKED		4
 #define IEEE_PARAM_AUTH_ALGS			5
 #define IEEE_PARAM_IEEE_802_1X			6
-//It should consistent with the driver_XXX.c
-//   David, 2006.9.26
+/*
+ * It should consistent with the driver_XXX.c
+ * David, 2006.9.26
+ */
 #define IEEE_PARAM_WPAX_SELECT			7
-//Added for notify the encryption type selection
-//   David, 2006.9.26
+/*
+ * Added for notify the encryption type selection
+ * David, 2006.9.26
+ */
 #define IEEE_PROTO_WPA				1
 #define IEEE_PROTO_RSN				2
-//Added for notify the encryption type selection
-//   David, 2006.9.26
+/*
+ * Added for notify the encryption type selection
+ * David, 2006.9.26
+ */
 #define IEEE_WPAX_USEGROUP			0
 #define IEEE_WPAX_WEP40				1
 #define IEEE_WPAX_TKIP				2
@@ -222,7 +226,7 @@ struct cb_desc {

 #define MAX_IE_LEN  0xff

-// added for kernel conflict
+/* added for kernel conflict */
 #define ieee80211_crypt_deinit_entries	ieee80211_crypt_deinit_entries_rsl
 #define ieee80211_crypt_deinit_handler	ieee80211_crypt_deinit_handler_rsl
 #define ieee80211_crypt_delayed_deinit	ieee80211_crypt_delayed_deinit_rsl
@@ -322,7 +326,7 @@ struct ieee_param {
 };


-// linux under 2.6.9 release may not support it, so modify it for common =
use
+/* linux under 2.6.9 release may not support it, so modify it for common =
use */
 #define IEEE80211_DATA_LEN		2304
 /* Maximum size for the MA-UNITDATA primitive, 802.11 standard section
  *   6.2.1.1.2.
@@ -354,7 +358,7 @@ struct ieee_param {
 #define IEEE80211_FCTL_FRAMETYPE	0x00fc
 #define IEEE80211_FCTL_TODS		0x0100
 #define IEEE80211_FCTL_FROMDS		0x0200
-#define IEEE80211_FCTL_DSTODS		0x0300 //added by david
+#define IEEE80211_FCTL_DSTODS		0x0300 /* added by david */
 #define IEEE80211_FCTL_MOREFRAGS	0x0400
 #define IEEE80211_FCTL_RETRY		0x0800
 #define IEEE80211_FCTL_PM		0x1000
@@ -398,7 +402,7 @@ struct ieee_param {
 #define IEEE80211_STYPE_CFACK		0x0050
 #define IEEE80211_STYPE_CFPOLL		0x0060
 #define IEEE80211_STYPE_CFACKPOLL	0x0070
-#define IEEE80211_STYPE_QOS_DATA	0x0080 //added for WMM 2006/8/2
+#define IEEE80211_STYPE_QOS_DATA	0x0080 /* added for WMM 2006/8/2 */
 #define IEEE80211_STYPE_QOS_NULL	0x00C0

 #define IEEE80211_SCTL_FRAG		0x000F
@@ -410,7 +414,7 @@ struct ieee_param {
 #define	FC_QOS_BIT					BIT(7)
 #define IsDataFrame(pdu)			(((pdu[0] & 0x0C) =3D=3D 0x08) ? true : false)
 #define	IsLegacyDataFrame(pdu)	(IsDataFrame(pdu) && (!(pdu[0] & FC_QOS_BI=
T)))
-//added by wb. Is this right?
+/* added by wb. Is this right? */
 #define IsQoSDataFrame(pframe)  ((*(u16 *)pframe & (IEEE80211_STYPE_QOS_D=
ATA | IEEE80211_FTYPE_DATA)) =3D=3D (IEEE80211_STYPE_QOS_DATA | IEEE80211_=
FTYPE_DATA))
 #define Frame_Order(pframe)     (*(u16 *)pframe & IEEE80211_FCTL_ORDER)
 #define SN_LESS(a, b)		(((a - b) & 0x800) !=3D 0)
@@ -450,8 +454,8 @@ extern u32 ieee80211_debug_level;
 #define IEEE80211_DEBUG(level, fmt, args...) \
 do { if (ieee80211_debug_level & (level)) \
   printk(KERN_DEBUG "ieee80211: " fmt, ## args); } while (0)
-//wb added to debug out data buf
-//if you want print DATA buffer related BA, please set ieee80211_debug_le=
vel to DATA|BA
+/* wb added to debug out data buf */
+/* if you want print DATA buffer related BA, please set ieee80211_debug_l=
evel to DATA|BA */
 #define IEEE80211_DEBUG_DATA(level, data, datalen)	\
 	do { if ((ieee80211_debug_level & (level)) =3D=3D (level))	\
 		{	\
@@ -511,16 +515,16 @@ do { if (ieee80211_debug_level & (level)) \
 #define IEEE80211_DL_TX            (1<<8)
 #define IEEE80211_DL_RX            (1<<9)

-#define IEEE80211_DL_HT		   (1<<10)  //HT
-#define IEEE80211_DL_BA		   (1<<11)  //ba
-#define IEEE80211_DL_TS		   (1<<12)  //TS
+#define IEEE80211_DL_HT		   (1<<10)  /* HT */
+#define IEEE80211_DL_BA		   (1<<11)  /* ba */
+#define IEEE80211_DL_TS		   (1<<12)  /* TS */
 #define IEEE80211_DL_QOS           (1<<13)
 #define IEEE80211_DL_REORDER	   (1<<14)
 #define IEEE80211_DL_IOT	   (1<<15)
 #define IEEE80211_DL_IPS	   (1<<16)
-#define IEEE80211_DL_TRACE	   (1<<29)  //trace function, need to user net=
_ratelimit() together in order not to print too much to the screen
-#define IEEE80211_DL_DATA	   (1<<30)   //use this flag to control whether=
 print data buf out.
-#define IEEE80211_DL_ERR	   (1<<31)   //always open
+#define IEEE80211_DL_TRACE	   (1<<29)  /* trace function, need to user ne=
t_ratelimit() together in order not to print too much to the screen */
+#define IEEE80211_DL_DATA	   (1<<30)   /* use this flag to control whethe=
r print data buf out. */
+#define IEEE80211_DL_ERR	   (1<<31)   /* always open */
 #define IEEE80211_ERROR(f, a...) printk(KERN_ERR "ieee80211: " f, ## a)
 #define IEEE80211_WARNING(f, a...) printk(KERN_WARNING "ieee80211: " f, #=
# a)
 #define IEEE80211_DEBUG_INFO(f, a...)   IEEE80211_DEBUG(IEEE80211_DL_INFO=
, f, ## a)
@@ -539,9 +543,9 @@ do { if (ieee80211_debug_level & (level)) \
 #include <linux/if_arp.h> /* ARPHRD_ETHER */

 #ifndef WIRELESS_SPY
-#define WIRELESS_SPY		// enable iwspy support
+#define WIRELESS_SPY		/* enable iwspy support */
 #endif
-#include <net/iw_handler.h>	// new driver API
+#include <net/iw_handler.h>	/* new driver API */

 #ifndef ETH_P_PAE
 #define ETH_P_PAE 0x888E /* Port Access Entity (IEEE 802.1X) */
@@ -660,7 +664,7 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_OFDM_SHIFT_MASK_A         4


-/* this is stolen and modified from the madwifi driver*/
+/* this is stolen and modified from the madwifi driver */
 #define IEEE80211_FC0_TYPE_MASK		0x0c
 #define IEEE80211_FC0_TYPE_DATA		0x08
 #define IEEE80211_FC0_SUBTYPE_MASK	0xB0
@@ -700,28 +704,28 @@ struct ieee80211_rx_stats {
 	u8 nic_type;
 	u16       Length;
 	//      u8        DataRate;      // In 0.5 Mbps
-	u8        SignalQuality; // in 0-100 index.
-	s32       RecvSignalPower; // Real power in dBm for this packet, no beau=
tification and aggregation.
-	s8        RxPower; // in dBm Translate from PWdB
-	u8        SignalStrength; // in 0-100 index.
+	u8        SignalQuality; /* in 0-100 index. */
+	s32       RecvSignalPower; /* Real power in dBm for this packet, no beau=
tification and aggregation. */
+	s8        RxPower; /* in dBm Translate from PWdB */
+	u8        SignalStrength; /* in 0-100 index. */
 	u16       bHwError:1;
 	u16       bCRC:1;
 	u16       bICV:1;
 	u16       bShortPreamble:1;
-	u16       Antenna:1;      //for rtl8185
-	u16       Decrypted:1;    //for rtl8185, rtl8187
-	u16       Wakeup:1;       //for rtl8185
-	u16       Reserved0:1;    //for rtl8185
+	u16       Antenna:1;      /* for rtl8185 */
+	u16       Decrypted:1;    /* for rtl8185, rtl8187 */
+	u16       Wakeup:1;       /* for rtl8185 */
+	u16       Reserved0:1;    /* for rtl8185 */
 	u8        AGC;
 	u32       TimeStampLow;
 	u32       TimeStampHigh;
 	bool      bShift;
-	bool      bIsQosData;             // Added by Annie, 2005-12-22.
+	bool      bIsQosData;             /* Added by Annie, 2005-12-22. */
 	u8        UserPriority;

-	//1!!!!!!!!!!!!!!!!!!!!!!!!!!!
-	//1Attention Please!!!<11n or 8190 specific code should be put below thi=
s line>
-	//1!!!!!!!!!!!!!!!!!!!!!!!!!!!
+	/*
+	 * Attention Please!!!<11n or 8190 specific code should be put below thi=
s line>
+	 */

 	u8        RxDrvInfoSize;
 	u8        RxBufShift;
@@ -730,21 +734,21 @@ struct ieee80211_rx_stats {
 	bool      bContainHTC;
 	bool      RxIs40MHzPacket;
 	u32       RxPWDBAll;
-	u8        RxMIMOSignalStrength[4];        // in 0~100 index
+	u8        RxMIMOSignalStrength[4];        /* in 0~100 index */
 	s8        RxMIMOSignalQuality[2];
 	bool      bPacketMatchBSSID;
 	bool      bIsCCK;
 	bool      bPacketToSelf;
-	//added by amy
+	/* added by amy */
 	u8        *virtual_address;
-	u16          packetlength;              // Total packet length: Must equ=
al to sum of all FragLength
-	u16          fraglength;                        // FragLength should equ=
al to PacketLength in non-fragment case
-	u16          fragoffset;                        // Data offset for this =
fragment
+	u16          packetlength;              /* Total packet length: Must equ=
al to sum of all FragLength */
+	u16          fraglength;                        /* FragLength should equ=
al to PacketLength in non-fragment case */
+	u16          fragoffset;                        /* Data offset for this =
fragment */
 	u16          ntotalfrag;
 	bool		  bisrxaggrsubframe;
-	bool		  bPacketBeacon;	//cosa add for rssi
-	bool		  bToSelfBA;		//cosa add for rssi
-	s8		  cck_adc_pwdb[4];	//cosa add for rx path selection
+	bool		  bPacketBeacon;	/* cosa add for rssi */
+	bool		  bToSelfBA;		/* cosa add for rssi */
+	s8		  cck_adc_pwdb[4];	/* cosa add for rx path selection */
 	u16		  Seq_Num;

 };
@@ -1064,7 +1068,7 @@ typedef union _frameqos {

 #define MAX_CHANNEL_NUMBER                 161
 #define IEEE80211_SOFTMAC_SCAN_TIME	   100
-//(HZ / 2)
+/* (HZ / 2) */
 #define IEEE80211_SOFTMAC_ASSOC_RETRY_TIME (HZ * 2)

 #define CRC_LENGTH                 4U
@@ -1185,7 +1189,7 @@ static inline const char *eap_get_type(int type)
 {
 	return ((u32)type >=3D ARRAY_SIZE(eap_types)) ? "Unknown" : eap_types[ty=
pe];
 }
-//added by amy for reorder
+/* added by amy for reorder */
 static inline u8 Frame_QoSTID(u8 *buf)
 {
 	struct rtl_80211_hdr_3addr *hdr;
@@ -1195,7 +1199,7 @@ static inline u8 Frame_QoSTID(u8 *buf)
 	return (u8)((frameqos *)(buf + (((fc & IEEE80211_FCTL_TODS) && (fc & IEE=
E80211_FCTL_FROMDS)) ? 30 : 24)))->field.tid;
 }

-//added by amy for reorder
+/* added by amy for reorder */

 struct eapol {
 	u8 snap[6];
@@ -1253,7 +1257,7 @@ struct ieee80211_info_element_hdr {
 */

 #define IEEE80211_DEFAULT_TX_ESSID "Penguin"
-#define IEEE80211_DEFAULT_BASIC_RATE 2 //1Mbps
+#define IEEE80211_DEFAULT_BASIC_RATE 2 /* 1Mbps */

 enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, WMM_six_frame};
 #define MAX_SP_Len  (WMM_all_frame << 4)
@@ -1269,7 +1273,7 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, =
WMM_six_frame};
 #define IEEE80211_PS_UNICAST IEEE80211_DTIM_UCAST
 #define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST

-//added by David for QoS 2006/6/30
+/* added by David for QoS 2006/6/30 */
 //#define WMM_Hang_8187
 #ifdef WMM_Hang_8187
 #undef WMM_Hang_8187
@@ -1285,7 +1289,7 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, =
WMM_six_frame};

 #define MAX_RECEIVE_BUFFER_SIZE 9100

-//UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSC=
P
+/* UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DS=
CP */
 //#define UP2AC(up)	((up<3) ? ((up=3D=3D0)?1:0) : (up>>1))
 #define UP2AC(up) (		   \
 	((up) < 1) ? WME_AC_BE : \
@@ -1293,7 +1297,7 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, =
WMM_six_frame};
 	((up) < 4) ? WME_AC_BE : \
 	((up) < 6) ? WME_AC_VI : \
 	WME_AC_VO)
-//AC Mapping to UP, using in Tx part for selecting the corresponding TX q=
ueue
+/* AC Mapping to UP, using in Tx part for selecting the corresponding TX =
queue */
 #define AC2UP(_ac)	(       \
 	((_ac) =3D=3D WME_AC_VO) ? 6 : \
 	((_ac) =3D=3D WME_AC_VI) ? 5 : \
@@ -1328,7 +1332,7 @@ struct ieee80211_network {
 	u8 bssid[ETH_ALEN];   /* u16 aligned! */
 	u8 channel;

-	// CCXv4 S59, MBSSID.
+	/* CCXv4 S59, MBSSID. */
 	bool	bMBssidValid;
 	u8	MBssid[ETH_ALEN];    /* u16 aligned! */
 	u8	MBssidMask;
@@ -1337,12 +1341,12 @@ struct ieee80211_network {
 	u8 ssid_len;
 	struct ieee80211_qos_data qos_data;

-	//added by amy for LEAP
+	/* added by amy for LEAP */
 	bool	bWithAironetIE;
 	bool	bCkipSupported;
 	bool	bCcxRmEnable;
 	u16	CcxRmState[2];
-	// CCX 2 S38, WLAN Device Version Number element. Annie, 2006-08-20.
+	/* CCX 2 S38, WLAN Device Version Number element. Annie, 2006-08-20. */
 	bool	bWithCcxVerNum;
 	u8	BssCcxVerNumber;
 	/* These are network statistics */
@@ -1371,18 +1375,18 @@ struct ieee80211_network {
 	u8  dtim_data;
 	u32 last_dtim_sta_time[2];

-	//appeded for QoS
+	/* appeded for QoS */
 	u8 wmm_info;
 	struct ieee80211_wmm_ac_param wmm_param[4];
 	u8 QoS_Enable;
 #ifdef THOMAS_TURBO
-	u8 Turbo_Enable;//enable turbo mode, added by thomas
+	u8 Turbo_Enable; /* enable turbo mode, added by thomas */
 #endif
 	u16 CountryIeLen;
 	u8 CountryIeBuf[MAX_IE_LEN];
-	// HT Related, by amy, 2008.04.29
+	/* HT Related, by amy, 2008.04.29 */
 	BSS_HT	bssht;
-	// Add to handle broadcom AP management frame CCK rate.
+	/* Add to handle broadcom AP management frame CCK rate. */
 	bool broadcom_cap_exist;
 	bool ralink_cap_exist;
 	bool atheros_cap_exist;
@@ -1391,7 +1395,7 @@ struct ieee80211_network {
 //	u8	berp_info;
 	bool	berp_info_valid;
 	bool buseprotection;
-	//put at the end of the structure.
+	/* put at the end of the structure. */
 	struct list_head list;
 };

@@ -1466,7 +1470,7 @@ struct bandwidth_autoswitch {
 };


-//added by amy for order
+/* added by amy for order */

 #define REORDER_WIN_SIZE	128
 #define REORDER_ENTRY_NUM	128
@@ -1475,18 +1479,18 @@ struct rx_reorder_entry {
 	u16			SeqNum;
 	struct ieee80211_rxb *prxb;
 };
-//added by amy for order
+/* added by amy for order */
 typedef enum _Fsync_State {
 	Default_Fsync,
 	HW_Fsync,
 	SW_Fsync
 } Fsync_State;

-// Power save mode configured.
+/* Power save mode configured. */
 typedef	enum _RT_PS_MODE {
-	eActive,	// Active/Continuous access.
-	eMaxPs,		// Max power save mode.
-	eFastPs		// Fast power save mode.
+	eActive,	/* Active/Continuous access. */
+	eMaxPs,		/* Max power save mode. */
+	eFastPs		/* Fast power save mode. */
 } RT_PS_MODE;

 typedef enum _IPS_CALLBACK_FUNCION {
@@ -1505,9 +1509,9 @@ typedef enum _RT_JOIN_ACTION {
 struct ibss_parms {
 	u16   atimWin;
 };
-#define MAX_NUM_RATES	264 // Max num of support rates element: 8,  Max nu=
m of ext. support rate: 255. 061122, by rcnjko.
+#define MAX_NUM_RATES	264 /* Max num of support rates element: 8,  Max nu=
m of ext. support rate: 255. 061122, by rcnjko. */

-// RF state.
+/* RF state. */
 typedef	enum _RT_RF_POWER_STATE {
 	eRfOn,
 	eRfSleep,
@@ -1516,9 +1520,9 @@ typedef	enum _RT_RF_POWER_STATE {

 struct rt_power_save_control {

-	//
-	// Inactive Power Save(IPS) : Disable RF when disconnected
-	//
+	/*
+	 * Inactive Power Save(IPS) : Disable RF when disconnected
+	 */
 	bool				bInactivePs;
 	bool				bIPSModeBackup;
 	bool				bSwRfProcessing;
@@ -1526,15 +1530,15 @@ struct rt_power_save_control {
 	struct work_struct	InactivePsWorkItem;
 	struct timer_list	InactivePsTimer;

-	// Return point for join action
+	/* Return point for join action */
 	IPS_CALLBACK_FUNCION	ReturnPoint;

-	// Recored Parameters for rescheduled JoinRequest
+	/* Recored Parameters for rescheduled JoinRequest */
 	bool				bTmpBssDesc;
 	RT_JOIN_ACTION		tmpJoinAction;
 	struct ieee80211_network tmpBssDesc;

-	// Recored Parameters for rescheduled MgntLinkRequest
+	/* Recored Parameters for rescheduled MgntLinkRequest */
 	bool				bTmpScanOnly;
 	bool				bTmpActiveScan;
 	bool				bTmpFilterHiddenAP;
@@ -1553,9 +1557,9 @@ struct rt_power_save_control {
 	struct ibss_parms			tmpIbpm;
 	bool				bTmpIbpm;

-	//
-	// Leisre Poswer Save : Disable RF if connected but traffic is not busy
-	//
+	/*
+	 * Leisre Poswer Save : Disable RF if connected but traffic is not busy
+	 */
 	bool				bLeisurePs;

 };
@@ -1565,7 +1569,7 @@ typedef u32 RT_RF_CHANGE_SOURCE;
 #define RF_CHANGE_BY_HW		BIT(30)
 #define RF_CHANGE_BY_PS		BIT(29)
 #define RF_CHANGE_BY_IPS	BIT(28)
-#define RF_CHANGE_BY_INIT	0	// Do not change the RFOff reason. Defined by=
 Bruce, 2008-01-17.
+#define RF_CHANGE_BY_INIT	0	/* Do not change the RFOff reason. Defined by=
 Bruce, 2008-01-17. */

 typedef enum {
 	COUNTRY_CODE_FCC =3D 0,
@@ -1587,9 +1591,9 @@ struct rt_link_detect {
 	u32				NumRecvBcnInPeriod;
 	u32				NumRecvDataInPeriod;

-	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];	// number of Rx beacon / CheckForHa=
ng_period  to determine link status
-	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];	// number of Rx data / CheckForHan=
g_period  to determine link status
-	u16				SlotNum;	// number of CheckForHang period to determine link statu=
s
+	u32				RxBcnNum[RT_MAX_LD_SLOT_NUM];	/* number of Rx beacon / CheckForHa=
ng_period  to determine link status */
+	u32				RxDataNum[RT_MAX_LD_SLOT_NUM];	/* number of Rx data / CheckForHan=
g_period  to determine link status */
+	u16				SlotNum;	/* number of CheckForHang period to determine link statu=
s */
 	u16				SlotIndex;

 	u32				NumTxOkInPeriod;
@@ -1602,36 +1606,36 @@ struct ieee80211_device {
 	struct net_device *dev;
 	struct ieee80211_security sec;

-	//hw security related
+	/* hw security related */
 //	u8 hwsec_support; //support?
-	u8 hwsec_active;  //hw security active.
+	u8 hwsec_active;  /* hw security active. */
 	bool is_silent_reset;
 	bool ieee_up;
-	//added by amy
+	/* added by amy */
 	bool bSupportRemoteWakeUp;
-	RT_PS_MODE	dot11PowerSaveMode; // Power save mode configured.
+	RT_PS_MODE	dot11PowerSaveMode; /* Power save mode configured. */
 	bool actscanning;
 	bool beinretry;
 	RT_RF_POWER_STATE		eRFPowerState;
 	RT_RF_CHANGE_SOURCE	RfOffReason;
 	bool is_set_key;
-	//11n spec related I wonder if These info structure need to be moved out=
 of ieee80211_device
+	/* 11n spec related I wonder if These info structure need to be moved ou=
t of ieee80211_device */

-	//11n HT below
+	/* 11n HT below */
 	PRT_HIGH_THROUGHPUT	pHTInfo;
 	//struct timer_list		SwBwTimer;
 //	spinlock_t chnlop_spinlock;
 	spinlock_t bw_spinlock;

 	spinlock_t reorder_spinlock;
-	// for HT operation rate set.  we use this one for HT data rate to separ=
ate different descriptors
-	//the way fill this is the same as in the IE
-	u8	Regdot11HTOperationalRateSet[16];		//use RATR format
-	u8	dot11HTOperationalRateSet[16];		//use RATR format
+	/* for HT operation rate set.  we use this one for HT data rate to separ=
ate different descriptors */
+	/* the way fill this is the same as in the IE */
+	u8	Regdot11HTOperationalRateSet[16];		/* use RATR format */
+	u8	dot11HTOperationalRateSet[16];		/* use RATR format */
 	u8	RegHTSuppRateSet[16];
 	u8				HTCurrentOperaRate;
 	u8				HTHighestOperaRate;
-	//wb added for rate operation mode to firmware
+	/* wb added for rate operation mode to firmware */
 	u8	bTxDisableRateFallBack;
 	u8	bTxUseDriverAssingedRate;
 	atomic_t	atm_chnlop;
@@ -1639,12 +1643,12 @@ struct ieee80211_device {
 //	u8	HTHighestOperaRate;
 //	u8	HTCurrentOperaRate;

-	// 802.11e and WMM Traffic Stream Info (TX)
+	/* 802.11e and WMM Traffic Stream Info (TX) */
 	struct list_head		Tx_TS_Admit_List;
 	struct list_head		Tx_TS_Pending_List;
 	struct list_head		Tx_TS_Unused_List;
 	struct tx_ts_record		TxTsRecord[TOTAL_TS_NUM];
-	// 802.11e and WMM Traffic Stream Info (RX)
+	/* 802.11e and WMM Traffic Stream Info (RX) */
 	struct list_head		Rx_TS_Admit_List;
 	struct list_head		Rx_TS_Pending_List;
 	struct list_head		Rx_TS_Unused_List;
@@ -1653,9 +1657,9 @@ struct ieee80211_device {
 	struct rx_reorder_entry	RxReorderEntry[128];
 	struct list_head		RxReorder_Unused_List;
 //#endif
-	// Qos related. Added by Annie, 2005-11-01.
+	/* Qos related. Added by Annie, 2005-11-01. */
 //	PSTA_QOS			pStaQos;
-	u8				ForcedPriority;		// Force per-packet priority 1~7. (default: 0, no=
t to force it.)
+	u8				ForcedPriority;		/* Force per-packet priority 1~7. (default: 0, no=
t to force it.) */


 	/* Bookkeeping structures */
@@ -1725,7 +1729,7 @@ struct ieee80211_device {
 			   */

 	/* Fragmentation structures */
-	// each streaming contain a entry
+	/* each streaming contain a entry */
 	struct ieee80211_frag_entry frag_cache[17][IEEE80211_FRAG_CACHE_LEN];
 	unsigned int frag_next_idx[17];
 	u16 fts; /* Fragmentation Threshold */
@@ -1767,12 +1771,12 @@ struct ieee80211_device {
 	u16 prev_seq_ctl;       /* used to drop duplicate frames */

 	/* map of allowed channels. 0 is dummy */
-	// FIXME: remember to default to a basic channel plan depending of the P=
HY type
+	/* FIXME: remember to default to a basic channel plan depending of the P=
HY type */
 	void *dot11d_info;
 	bool bGlobalDomain;
 	int rate;       /* current rate */
 	int basic_rate;
-	//FIXME: pleace callback, see if redundant with softmac_features
+	/* FIXME: pleace callback, see if redundant with softmac_features */
 	short active_scan;

 	/* this contains flags for selectively enable softmac support */
@@ -1813,8 +1817,8 @@ struct ieee80211_device {
 	short wap_set;
 	short ssid_set;

-	u8  wpax_type_set;    //{added by David, 2006.9.28}
-	u32 wpax_type_notify; //{added by David, 2006.9.26}
+	u8  wpax_type_set;    /* {added by David, 2006.9.28} */
+	u32 wpax_type_notify; /* {added by David, 2006.9.26} */

 	/* QoS related flag */
 	s8  init_wmmparam_flag;
@@ -1836,7 +1840,7 @@ struct ieee80211_device {
 	struct sk_buff *mgmt_queue_ring[MGMT_QUEUE_NUM];
 	int mgmt_queue_head;
 	int mgmt_queue_tail;
-//{ added for rtl819x
+/* { added for rtl819x */
 #define IEEE80211_QUEUE_LIMIT 128
 	u8 AsocRetryCount;
 	unsigned int hw_header;
@@ -1845,12 +1849,12 @@ struct ieee80211_device {
 	struct sk_buff_head  skb_drv_aggQ[MAX_QUEUE_SIZE];
 	u32	sta_edca_param[4];
 	bool aggregation;
-	// Enable/Disable Rx immediate BA capability.
+	/* Enable/Disable Rx immediate BA capability. */
 	bool enable_rx_imm_BA;
 	bool bibsscoordinator;

-	//+by amy for DM ,080515
-	//Dynamic Tx power for near/far range enable/Disable  , by amy , 2008-05=
-15
+	/* +by amy for DM ,080515 */
+	/* Dynamic Tx power for near/far range enable/Disable  , by amy , 2008-0=
5-15 */
 	bool	bdynamic_txpower_enable;

 	bool bCTSToSelfEnable;
@@ -1861,21 +1865,21 @@ struct ieee80211_device {
 	u8	fsync_rssi_threshold;
 	bool	bfsync_enable;

-	u8	fsync_multiple_timeinterval;		// FsyncMultipleTimeInterval * FsyncTim=
eInterval
-	u32	fsync_firstdiff_ratethreshold;		// low threshold
-	u32	fsync_seconddiff_ratethreshold;	 // decrease threshold
+	u8	fsync_multiple_timeinterval;		/* FsyncMultipleTimeInterval * FsyncTim=
eInterval */
+	u32	fsync_firstdiff_ratethreshold;		/* low threshold */
+	u32	fsync_seconddiff_ratethreshold;	 /* decrease threshold */
 	Fsync_State			fsync_state;
 	bool		bis_any_nonbepkts;
-	//20Mhz 40Mhz AutoSwitch Threshold
+	/* 20Mhz 40Mhz AutoSwitch Threshold */
 	struct bandwidth_autoswitch bandwidth_auto_switch;
-	//for txpower tracking
+	/* for txpower tracking */
 	bool FwRWRF;

-	//added by amy for AP roaming
+	/* added by amy for AP roaming */
 	struct rt_link_detect LinkDetectInfo;
-	//added by amy for ps
+	/* added by amy for ps */
 	struct rt_power_save_control PowerSaveControl;
-//}
+/* } */
 	/* used if IEEE_SOFTMAC_TX_QUEUE is set */
 	struct  tx_pending tx_pending;

@@ -1891,11 +1895,11 @@ struct ieee80211_device {
 	 struct delayed_work start_ibss_wq;
 	struct work_struct wx_sync_scan_wq;
 	struct workqueue_struct *wq;
-	// Qos related. Added by Annie, 2005-11-01.
-	//STA_QOS  StaQos;
+	/* Qos related. Added by Annie, 2005-11-01. */
+	/* STA_QOS  StaQos; */

-	//u32 STA_EDCA_PARAM[4];
-	//CHANNEL_ACCESS_SETTING ChannelAccessSetting;
+	/* u32 STA_EDCA_PARAM[4]; */
+	/* CHANNEL_ACCESS_SETTING ChannelAccessSetting; */

 	struct ieee80211_rxb *stats_IndicateArray[REORDER_WIN_SIZE];

@@ -1997,7 +2001,7 @@ struct ieee80211_device {

 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
-	//added by wb for HT related
+	/* added by wb for HT related */
 //	void (*SwChnlByTimerHandler)(struct net_device *dev, int channel);
 	void (*SetBWModeHandler)(struct net_device *dev, enum ht_channel_width B=
andwidth, enum ht_extension_chan_offset Offset);
 //	void (*UpdateHalRATRTableHandler)(struct net_device* dev, u8* pMcsRate=
);
@@ -2349,8 +2353,8 @@ int ieee80211_wx_set_rts(struct ieee80211_device *ie=
ee,
 int ieee80211_wx_get_rts(struct ieee80211_device *ieee,
 			 struct iw_request_info *info,
 			 union iwreq_data *wrqu, char *extra);
-//HT
-#define MAX_RECEIVE_BUFFER_SIZE 9100  //
+/* HT */
+#define MAX_RECEIVE_BUFFER_SIZE 9100
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString);
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString);

@@ -2378,7 +2382,7 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFram=
e);
 void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo);
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee);
 u16 TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate);
-//function in BAPROC.c
+/* function in BAPROC.c */
 int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *=
skb);
 int ieee80211_rx_ADDBARsp(struct ieee80211_device *ieee, struct sk_buff *=
skb);
 int ieee80211_rx_DELBA(struct ieee80211_device *ieee, struct sk_buff *skb=
);
@@ -2390,13 +2394,13 @@ void BaSetupTimeOut(struct timer_list *t);
 void TxBaInactTimeout(struct timer_list *t);
 void RxBaInactTimeout(struct timer_list *t);
 void ResetBaEntry(struct ba_record *pBA);
-//function in TS.c
+/* function in TS.c */
 bool GetTs(
 	struct ieee80211_device		*ieee,
 	struct ts_common_info           **ppTS,
 	u8                              *Addr,
 	u8                              TID,
-	enum tr_select                  TxRxSelect,  //Rx:1, Tx:0
+	enum tr_select                  TxRxSelect,  /* Rx:1, Tx:0 */
 	bool                            bAddNewTs
 	);
 void TSInitialize(struct ieee80211_device *ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c b/driver=
s/staging/rtl8192u/ieee80211/ieee80211_crypt.c
index 36987fccac5d..a47ba3607b78 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
@@ -81,7 +81,8 @@ void ieee80211_crypt_delayed_deinit(struct ieee80211_dev=
ice *ieee,
 	tmp =3D *crypt;
 	*crypt =3D NULL;

-	/* must not run ops->deinit() while there may be pending encrypt or
+	/*
+	 * must not run ops->deinit() while there may be pending encrypt or
 	 * decrypt operations. Use a list of delayed deinits to avoid needing
 	 * locking.
 	 */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h b/driver=
s/staging/rtl8192u/ieee80211/ieee80211_crypt.h
index d3bd5598b25b..4fbc5241f7b5 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
@@ -24,7 +24,8 @@
 struct ieee80211_crypto_ops {
 	const char *name;

-	/* init new crypto context (e.g., allocate private data space,
+	/*
+	 * init new crypto context (e.g., allocate private data space,
 	 * select IV, etc.); returns NULL on failure or pointer to allocated
 	 * private data on success
 	 */
@@ -33,7 +34,8 @@ struct ieee80211_crypto_ops {
 	/* deinitialize crypto context and free allocated private data */
 	void (*deinit)(void *priv);

-	/* encrypt/decrypt return < 0 on error or >=3D 0 on success. The return
+	/*
+	 * encrypt/decrypt return < 0 on error or >=3D 0 on success. The return
 	 * value from decrypt_mpdu is passed as the keyidx value for
 	 * decrypt_msdu. skb must have enough head and tail room for the
 	 * encryption; if not, error will be returned; these functions are
@@ -42,7 +44,8 @@ struct ieee80211_crypto_ops {
 	int (*encrypt_mpdu)(struct sk_buff *skb, int hdr_len, void *priv);
 	int (*decrypt_mpdu)(struct sk_buff *skb, int hdr_len, void *priv);

-	/* These functions are called for full MSDUs, i.e. full frames.
+	/*
+	 * These functions are called for full MSDUs, i.e. full frames.
 	 * These can be NULL if full MSDU operations are not needed.
 	 */
 	int (*encrypt_msdu)(struct sk_buff *skb, int hdr_len, void *priv);
@@ -52,12 +55,14 @@ struct ieee80211_crypto_ops {
 	int (*set_key)(void *key, int len, u8 *seq, void *priv);
 	int (*get_key)(void *key, int len, u8 *seq, void *priv);

-	/* procfs handler for printing out key information and possible
+	/*
+	 * procfs handler for printing out key information and possible
 	 * statistics
 	 */
 	char * (*print_stats)(char *p, void *priv);

-	/* maximum number of bytes added by encryption; encrypt buf is
+	/*
+	 * maximum number of bytes added by encryption; encrypt buf is
 	 * allocated with extra_prefix_len bytes, copy of in_buf, and
 	 * extra_postfix_len; encrypt need not use all this space, but
 	 * the result must start at the beginning of the buffer and correct
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index d7188b3f3190..ad0b918ecf0d 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -133,7 +133,8 @@ static void ccmp_init_blocks(struct crypto_tfm *tfm,
 		qc =3D *pos & 0x0f;
 		aad_len +=3D 2;
 	}
-	/* CCM Initial Block:
+	/*
+	 * CCM Initial Block:
 	 * Flag (Include authentication header, M=3D3 (8-octet MIC),
 	 *       L=3D1 (2-octet Dlen))
 	 * Nonce: 0x00 | A2 | PN
@@ -146,7 +147,8 @@ static void ccmp_init_blocks(struct crypto_tfm *tfm,
 	b0[14] =3D (dlen >> 8) & 0xff;
 	b0[15] =3D dlen & 0xff;

-	/* AAD:
+	/*
+	 * AAD:
 	 * FC with bits 4..6 and 11..13 masked to zero; 14 is always one
 	 * A1 | A2 | A3
 	 * SC with bits 4..15 (seq#) masked to zero
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 0927b2b15151..db4b640d1d8c 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -567,11 +567,11 @@ static int ieee80211_michael_mic_add(struct sk_buff =
*skb, int hdr_len, void *pri

 	michael_mic_hdr(skb, tkey->tx_hdr);

-	// { david, 2006.9.1
-	// fix the wpa process with wmm enabled.
+	/* { david, 2006.9.1 */
+	/* fix the wpa process with wmm enabled. */
 	if (IEEE80211_QOS_HAS_SEQ(le16_to_cpu(hdr->frame_ctl)))
 		tkey->tx_hdr[12] =3D *(skb->data + hdr_len - 2) & 0x07;
-	// }
+	/* } */
 	pos =3D skb_put(skb, 8);

 	if (michael_mic(tkey->tx_tfm_michael, &tkey->key[16], tkey->tx_hdr,
@@ -615,11 +615,11 @@ static int ieee80211_michael_mic_verify(struct sk_bu=
ff *skb, int keyidx,
 		return -1;

 	michael_mic_hdr(skb, tkey->rx_hdr);
-	// { david, 2006.9.1
-	// fix the wpa process with wmm enabled.
+	/* { david, 2006.9.1 */
+	/* fix the wpa process with wmm enabled. */
 	if (IEEE80211_QOS_HAS_SEQ(le16_to_cpu(hdr->frame_ctl)))
 		tkey->rx_hdr[12] =3D *(skb->data + hdr_len - 2) & 0x07;
-	// }
+	/* } */

 	if (michael_mic(tkey->rx_tfm_michael, &tkey->key[24], tkey->rx_hdr,
 			skb->data + hdr_len, skb->len - 8 - hdr_len, mic))
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/dr=
ivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 805493a0870d..9cb386436377 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -72,7 +72,8 @@ static void prism2_wep_deinit(void *priv)
 	kfree(priv);
 }

-/* Perform WEP encryption on given skb that has at least 4 bytes of headr=
oom
+/*
+ * Perform WEP encryption on given skb that has at least 4 bytes of headr=
oom
  * for IV and 4 bytes of tailroom for ICV. Both IV and ICV will be transm=
itted,
  * so the payload length increases with 8 bytes.
  *
@@ -103,7 +104,8 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int=
 hdr_len, void *priv)

 	wep->iv++;

-	/* Fluhrer, Mantin, and Shamir have reported weaknesses in the key
+	/*
+	 * Fluhrer, Mantin, and Shamir have reported weaknesses in the key
 	 * scheduling algorithm of RC4. At least IVs (KeyByte + 3, 0xff, N)
 	 * can be used to speedup attacks, so avoid using them.
 	 */
@@ -150,7 +152,8 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int=
 hdr_len, void *priv)
 }


-/* Perform WEP decryption on given buffer. Buffer includes whole WEP part=
 of
+/*
+ * Perform WEP decryption on given buffer. Buffer includes whole WEP part=
 of
  * the frame: IV (4 bytes), encrypted payload (including SNAP header),
  * ICV (4 bytes). len includes both IV and ICV.
  *
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drive=
rs/staging/rtl8192u/ieee80211/ieee80211_module.c
index d7975aa335b2..dd7ff7e84bd0 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -158,7 +158,8 @@ struct net_device *alloc_ieee80211(int sizeof_priv)
 	if (ieee->pHTInfo =3D=3D NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for HTInfo\n");

-		/* By this point in code ieee80211_networks_allocate() has been
+		/*
+		 * By this point in code ieee80211_networks_allocate() has been
 		 * successfully called so the memory allocated should be freed
 		 */
 		ieee80211_networks_free(ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_rx.c
index 0e762e559675..eebd8deb0087 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -143,8 +143,10 @@ ieee80211_frag_cache_get(struct ieee80211_device *iee=
e,
 		memcpy(entry->src_addr, hdr->addr2, ETH_ALEN);
 		memcpy(entry->dst_addr, hdr->addr1, ETH_ALEN);
 	} else {
-		/* received a fragment of a frame for which the head fragment
-		 * should have already been received */
+		/*
+		 * received a fragment of a frame for which the head fragment
+		 * should have already been received
+		 */
 		entry =3D ieee80211_frag_cache_find(ieee, seq, frag, tid,hdr->addr2,
 						  hdr->addr1);
 		if (entry) {
@@ -199,17 +201,20 @@ static int ieee80211_frag_cache_invalidate(struct ie=
ee80211_device *ieee,



-/* ieee80211_rx_frame_mgtmt
+/*
+ * ieee80211_rx_frame_mgtmt
  *
  * Responsible for handling management control frames
  *
- * Called by ieee80211_rx */
+ * Called by ieee80211_rx
+ */
 static inline int
 ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee, struct sk_buff *sk=
b,
 			struct ieee80211_rx_stats *rx_stats, u16 type,
 			u16 stype)
 {
-	/* On the struct stats definition there is written that
+	/*
+	 * On the struct stats definition there is written that
 	 * this is not mandatory.... but seems that the probe
 	 * response parser uses it
 	 */
@@ -244,15 +249,19 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *iee=
e, struct sk_buff *skb,
 		if (stype =3D=3D WLAN_FC_STYPE_BEACON &&
 		    ieee->iw_mode =3D=3D IW_MODE_MASTER) {
 			struct sk_buff *skb2;
-			/* Process beacon frames also in kernel driver to
-			 * update STA(AP) table statistics */
+			/*
+			 * Process beacon frames also in kernel driver to
+			 * update STA(AP) table statistics
+			 */
 			skb2 =3D skb_clone(skb, GFP_ATOMIC);
 			if (skb2)
 				hostap_rx(skb2->dev, skb2, rx_stats);
 		}

-		/* send management frames to the user space daemon for
-		 * processing */
+		/*
+		 * send management frames to the user space daemon for
+		 * processing
+		 */
 		ieee->apdevstats.rx_packets++;
 		ieee->apdevstats.rx_bytes +=3D skb->len;
 		prism2_rx_80211(ieee->apdev, skb, rx_stats, PRISM2_RX_MGMT);
@@ -425,18 +434,18 @@ static int is_duplicate_packet(struct ieee80211_devi=
ce *ieee,
 	u8 tid;


-	//TO2DS and QoS
+	/* TO2DS and QoS */
 	if(((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS)&&IEEE8021=
1_QOS_HAS_SEQ(fc)) {
 	  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
 	  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
 	  tid =3D UP2AC(tid);
 	  tid++;
-	} else if(IEEE80211_QOS_HAS_SEQ(fc)) { //QoS
+	} else if (IEEE80211_QOS_HAS_SEQ(fc)) { /* QoS */
 	  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
 	  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
 	  tid =3D UP2AC(tid);
 	  tid++;
-	} else { // no QoS
+	} else { /* no QoS */
 	  tid =3D 0;
 	}

@@ -532,7 +541,7 @@ void ieee80211_indicate_packets(struct ieee80211_devic=
e *ieee, struct ieee80211_
 //		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): hahahahhhh, We indicate p=
acket from reorder list, index is %u\n",__func__,index);
 	for(j =3D 0; j<index; j++)
 	{
-//added by amy for reorder
+/* added by amy for reorder */
 		struct ieee80211_rxb *prxb =3D prxbIndicateArray[j];
 		for(i =3D 0; i<prxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb =3D prxb->subframes[i];
@@ -543,8 +552,10 @@ void ieee80211_indicate_packets(struct ieee80211_devi=
ce *ieee, struct ieee80211_
 				((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
 				  ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
 				 memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D 0)) {
-			/* remove RFC1042 or Bridge-Tunnel encapsulation and
-			 * replace EtherType */
+			/*
+			 * remove RFC1042 or Bridge-Tunnel encapsulation and
+			 * replace EtherType
+			 */
 				skb_pull(sub_skb, SNAP_SIZE);
 				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->src, ETH_ALEN);
 				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->dst, ETH_ALEN);
@@ -637,7 +648,8 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 	 * After Packet dropping and Sliding Window shifting as above, we can no=
w just indicate the packets
 	 * with the SeqNum smaller than latest WinStart and buffer other packets=
.
 	 */
-	/* For Rx Reorder condition:
+	/*
+	 * For Rx Reorder condition:
 	 * 1. All packets with SeqNum smaller than WinStart =3D> Indicate
 	 * 2. All packets with SeqNum larger than or equal to WinStart =3D> Buff=
er it.
 	 */
@@ -650,7 +662,7 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 		index =3D 1;
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
-		//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): We RX no ordered packed, =
insert to ordered list\n",__func__);
+		/* IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): We RX no ordered packed,=
 insert to ordered list\n",__func__); */
 		if(!list_empty(&ieee->RxReorder_Unused_List)) {
 			pReorderEntry =3D list_entry(ieee->RxReorder_Unused_List.next, struct =
rx_reorder_entry, List);
 			list_del_init(&pReorderEntry->List);
@@ -728,11 +740,11 @@ static void RxReorderIndicatePacket(struct ieee80211=
_device *ieee,

 	/* Handling pending timer. Set this timer to prevent from long time Rx b=
uffering.*/
 	if (index>0) {
-		// Cancel previous pending timer.
+		/* Cancel previous pending timer. */
 	//	del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq =3D 0xffff;

-		// Indicate packets
+		/* Indicate packets */
 		if(index>REORDER_WIN_SIZE){
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!! \n");
 			kfree(prxbIndicateArray);
@@ -742,7 +754,7 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 	}

 	if (bPktInBuf && pTS->rx_timeout_indicate_seq =3D=3D 0xffff) {
-		// Set new pending timer.
+		/* Set new pending timer. */
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n", __=
func__);
 		pTS->rx_timeout_indicate_seq =3D pTS->rx_indicate_seq;
 		if(timer_pending(&pTS->rx_pkt_pending_timer))
@@ -785,7 +797,7 @@ static u8 parse_subframe(struct sk_buff *skb,
 	if (rx_stats->bContainHTC) {
 		LLCOffset +=3D HTCLNG;
 	}
-	// Null packet, don't indicate it to upper layer
+	/* Null packet, don't indicate it to upper layer */
 	ChkLength =3D LLCOffset;/* + (Frame_WEP(frame)!=3D0 ?Adapter->MgntInfo.S=
ecurityInfo.EncryptionHeadOverhead:0);*/

 	if (skb->len <=3D ChkLength)
@@ -812,7 +824,7 @@ static u8 parse_subframe(struct sk_buff *skb,
 		while(skb->len > ETHERNET_HEADER_SIZE) {
 			/* Offset 12 denote 2 mac address */
 			nSubframe_Length =3D *((u16 *)(skb->data + 12));
-			//=3D=3Dm=3D=3D>change the length order
+			/* =3D=3Dm=3D=3D>change the length order */
 			nSubframe_Length =3D (nSubframe_Length>>8) + (nSubframe_Length<<8);

 			if (skb->len<(ETHERNET_HEADER_SIZE + nSubframe_Length)) {
@@ -869,9 +881,11 @@ static u8 parse_subframe(struct sk_buff *skb,
 	}
 }

-/* All received frames are sent to this function. @skb contains the frame=
 in
+/*
+ * All received frames are sent to this function. @skb contains the frame=
 in
  * IEEE 802.11 format, i.e., in the format it was sent over air.
- * This function is called only as a tasklet (software IRQ). */
+ * This function is called only as a tasklet (software IRQ).
+ */
 int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 		 struct ieee80211_rx_stats *rx_stats)
 {
@@ -884,12 +898,12 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	struct net_device_stats *stats;
 	unsigned int frag;
 	u16 ethertype;
-	//added by amy for reorder
+	/* added by amy for reorder */
 	u8	TID =3D 0;
 	u16	SeqNum =3D 0;
 	struct rx_ts_record *pTS =3D NULL;
 	//bool bIsAggregateFrame =3D false;
-	//added by amy for reorder
+	/* added by amy for reorder */
 #ifdef NOT_YET
 	struct net_device *wds =3D NULL;
 	struct net_device *wds =3D NULL;
@@ -905,7 +919,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,

 	int i;
 	struct ieee80211_rxb *rxb =3D NULL;
-	// cheat the hdr type
+	/* cheat the hdr type */
 	hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 	stats =3D &ieee->stats;

@@ -933,8 +947,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,

 	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
 #ifdef NOT_YET
-	/* Put this code here so that we avoid duplicating it in all
-	 * Rx paths. - Jean II */
+	/*
+	 * Put this code here so that we avoid duplicating it in all
+	 * Rx paths. - Jean II
+	 */
 #ifdef IW_WIRELESS_SPY		/* defined in iw_handler.h */
 	/* If spy monitoring on */
 	if (iface->spy_data.spy_number > 0) {
@@ -964,28 +980,34 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 #ifdef NOT_YET
 		sta =3D NULL;

-		/* Use station specific key to override default keys if the
+		/*
+		 * Use station specific key to override default keys if the
 		 * receiver address is a unicast address ("individual RA"). If
 		 * bcrx_sta_key parameter is set, station specific key is used
 		 * even with broad/multicast targets (this is against IEEE
 		 * 802.11, but makes it easier to use different keys with
-		 * stations that do not support WEP key mapping). */
+		 * stations that do not support WEP key mapping).
+		 */

 		if (!(hdr->addr1[0] & 0x01) || local->bcrx_sta_key)
 			(void) hostap_handle_sta_crypto(local, hdr, &crypt,
 							&sta);
 #endif

-		/* allow NULL decrypt to indicate an station specific override
-		 * for default encryption */
+		/*
+		 * allow NULL decrypt to indicate an station specific override
+		 * for default encryption
+		 */
 		if (crypt && (!crypt->ops || !crypt->ops->decrypt_mpdu))
 			crypt =3D NULL;

 		if (!crypt && (fc & IEEE80211_FCTL_WEP)) {
-			/* This seems to be triggered by some (multicast?)
+			/*
+			 * This seems to be triggered by some (multicast?)
 			 * frames from other than current BSS, so just drop the
 			 * frames silently instead of filling system log with
-			 * these reports. */
+			 * these reports.
+			 */
 			IEEE80211_DEBUG_DROP("Decryption failed (not set)"
 					     " (SA=3D%pM)\n",
 					     hdr->addr2);
@@ -997,7 +1019,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 	if (skb->len < IEEE80211_DATA_HDR3_LEN)
 		goto rx_dropped;

-	// if QoS enabled, should check the sequence for each of the AC
+	/* if QoS enabled, should check the sequence for each of the AC */
 	if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos_=
data.active|| !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
 		if (is_duplicate_packet(ieee, hdr))
 		goto rx_dropped;
@@ -1104,13 +1126,15 @@ int ieee80211_rx(struct ieee80211_device *ieee, st=
ruct sk_buff *skb,
 	}
 #endif
 	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
-	/* Nullfunc frames may have PS-bit set, so they must be passed to
-	 * hostap_handle_sta_rx() before being dropped here. */
+	/*
+	 * Nullfunc frames may have PS-bit set, so they must be passed to
+	 * hostap_handle_sta_rx() before being dropped here.
+	 */
 	if (stype !=3D IEEE80211_STYPE_DATA &&
 	    stype !=3D IEEE80211_STYPE_DATA_CFACK &&
 	    stype !=3D IEEE80211_STYPE_DATA_CFPOLL &&
 	    stype !=3D IEEE80211_STYPE_DATA_CFACKPOLL&&
-	    stype !=3D IEEE80211_STYPE_QOS_DATA//add by David,2006.8.4
+	    stype !=3D IEEE80211_STYPE_QOS_DATA/* add by David,2006.8.4 */
 	    ) {
 		if (stype !=3D IEEE80211_STYPE_NULLFUNC)
 			IEEE80211_DEBUG_DROP(
@@ -1136,7 +1160,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;

 	/* skb: hdr + (possibly fragmented) plaintext payload */
-	// PR: FIXME: hostap has additional conditions in the "if" below:
+	/* PR: FIXME: hostap has additional conditions in the "if" below: */
 	// ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
 	if ((frag !=3D 0 || (fc & IEEE80211_FCTL_MOREFRAGS))) {
 		int flen;
@@ -1164,33 +1188,43 @@ int ieee80211_rx(struct ieee80211_device *ieee, st=
ruct sk_buff *skb,
 		}

 		if (frag =3D=3D 0) {
-			/* copy first fragment (including full headers) into
-			 * beginning of the fragment cache skb */
+			/*
+			 * copy first fragment (including full headers) into
+			 * beginning of the fragment cache skb
+			 */
 			skb_put_data(frag_skb, skb->data, flen);
 		} else {
-			/* append frame payload to the end of the fragment
-			 * cache skb */
+			/*
+			 * append frame payload to the end of the fragment
+			 * cache skb
+			 */
 			skb_put_data(frag_skb, skb->data + hdrlen, flen);
 		}
 		dev_kfree_skb_any(skb);
 		skb =3D NULL;

 		if (fc & IEEE80211_FCTL_MOREFRAGS) {
-			/* more fragments expected - leave the skb in fragment
+			/*
+			 * more fragments expected - leave the skb in fragment
 			 * cache for now; it will be delivered to upper layers
-			 * after all fragments have been received */
+			 * after all fragments have been received
+			 */
 			goto rx_exit;
 		}

-		/* this was the last fragment and the frame will be
-		 * delivered, so remove skb from fragment cache */
+		/*
+		 * this was the last fragment and the frame will be
+		 * delivered, so remove skb from fragment cache
+		 */
 		skb =3D frag_skb;
 		hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
 		ieee80211_frag_cache_invalidate(ieee, hdr);
 	}

-	/* skb: hdr + (possible reassembled) full MSDU payload; possibly still
-	 * encrypted/authenticated */
+	/*
+	 * skb: hdr + (possible reassembled) full MSDU payload; possibly still
+	 * encrypted/authenticated
+	 */
 	if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
 	    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt))
 	{
@@ -1198,7 +1232,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 		goto rx_dropped;
 	}

-	//added by amy for AP roaming
+	/* added by amy for AP roaming */
 	ieee->LinkDetectInfo.NumRecvDataInPeriod++;
 	ieee->LinkDetectInfo.NumRxOkInPeriod++;

@@ -1208,8 +1242,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 		    ieee80211_is_eapol_frame(ieee, skb, hdrlen)) {

 #ifdef CONFIG_IEEE80211_DEBUG
-			/* pass unencrypted EAPOL frames even if encryption is
-			 * configured */
+			/*
+			 * pass unencrypted EAPOL frames even if encryption is
+			 * configured
+			 */
 			struct eapol *eap =3D (struct eapol *)(skb->data +
 				24);
 			IEEE80211_DEBUG_EAP("RX: IEEE 802.1X EAPOL frame: %s\n",
@@ -1248,7 +1284,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 		printk(KERN_WARNING "RX: IEEE802.1X EPAOL frame!\n");
 	}
 */
-//added by amy for reorder
+/* added by amy for reorder */
 	if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
 		&& !is_multicast_ether_addr(hdr->addr1))
 	{
@@ -1260,7 +1296,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 			ieee->bis_any_nonbepkts =3D true;
 		}
 	}
-//added by amy for reorder
+/* added by amy for reorder */
 	/* skb: hdr + (possible reassembled) full plaintext payload */
 	//ethertype =3D (payload[6] << 8) | payload[7];
 	rxb =3D kmalloc(sizeof(struct ieee80211_rxb), GFP_ATOMIC);
@@ -1278,9 +1314,9 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 		goto rx_dropped;
 	}

-//added by amy for reorder
+/* added by amy for reorder */
 	if (!ieee->pHTInfo->bCurRxReorderEnable || !pTS) {
-//added by amy for reorder
+/* added by amy for reorder */
 		for(i =3D 0; i<rxb->nr_subframes; i++) {
 			struct sk_buff *sub_skb =3D rxb->subframes[i];

@@ -1291,8 +1327,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 						((memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) =3D=3D 0 &&
 						  ethertype !=3D ETH_P_AARP && ethertype !=3D ETH_P_IPX) ||
 						 memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE) =3D=3D 0)) =
{
-					/* remove RFC1042 or Bridge-Tunnel encapsulation and
-					 * replace EtherType */
+					/*
+					 * remove RFC1042 or Bridge-Tunnel encapsulation and
+					 * replace EtherType
+					 */
 					skb_pull(sub_skb, SNAP_SIZE);
 					memcpy(skb_push(sub_skb, ETH_ALEN), src, ETH_ALEN);
 					memcpy(skb_push(sub_skb, ETH_ALEN), dst, ETH_ALEN);
@@ -1346,9 +1384,11 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 	rxb =3D NULL;
 	stats->rx_dropped++;

-	/* Returning 0 indicates to caller that we have not handled the SKB--
+	/*
+	 * Returning 0 indicates to caller that we have not handled the SKB--
 	 * so it is still allocated and can be used again by underlying
-	 * hardware as a DMA target */
+	 * hardware as a DMA target
+	 */
 	return 0;
 }
 EXPORT_SYMBOL(ieee80211_rx);
@@ -1574,11 +1614,11 @@ static inline void ieee80211_extract_country_ie(
 			}
 		}

-		//
-		// 070305, rcnjko: I update country IE watch dog here because
-		// some AP (e.g. Cisco 1242) don't include country IE in their
-		// probe response frame.
-		//
+		/*
+		 * 070305, rcnjko: I update country IE watch dog here because
+		 * some AP (e.g. Cisco 1242) don't include country IE in their
+		 * probe response frame.
+		 */
 		if (IS_EQUAL_CIE_SRC(ieee, addr2) )
 		{
 			UPDATE_CIE_WATCHDOG(ieee);
@@ -1613,9 +1653,11 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 					     info_element->len +
 					     sizeof(*info_element),
 					     length, info_element->id);
-			/* We stop processing but don't return an error here
+			/*
+			 * We stop processing but don't return an error here
 			 * because some misbehaviour APs break this rule. ie.
-			 * Orinoco AP1000. */
+			 * Orinoco AP1000.
+			 */
 			break;
 		}

@@ -1789,7 +1831,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 			}
 #endif

-			//for HTcap and HTinfo parameters
+			/* for HTcap and HTinfo parameters */
 			if(tmp_htcap_len =3D=3D 0){
 				if(info_element->len >=3D 4 &&
 				   info_element->data[0] =3D=3D 0x00 &&
@@ -1883,7 +1925,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 			}
 			else
 				network->ralink_cap_exist =3D false;
-			//added by amy for atheros AP
+			/* added by amy for atheros AP */
 			if((info_element->len >=3D 3 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x03 &&
@@ -1908,7 +1950,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 			}
 			else
 				network->cisco_cap_exist =3D false;
-			//added by amy for LEAP of cisco
+			/* added by amy for LEAP of cisco */
 			if (info_element->len > 4 &&
 				info_element->data[0] =3D=3D 0x00 &&
 				info_element->data[1] =3D=3D 0x40 &&
@@ -1924,9 +1966,9 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 					}
 					else
 						network->bCcxRmEnable =3D false;
-					//
-					// CCXv4 Table 59-1 MBSSID Masks.
-					//
+					/*
+					 * CCXv4 Table 59-1 MBSSID Masks.
+					 */
 					network->MBssidMask =3D network->CcxRmState[1] & 0x07;
 					if(network->MBssidMask !=3D 0)
 					{
@@ -1973,7 +2015,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 			       network->rsn_ie_len);
 			break;

-			//HT related element.
+			/* HT related element. */
 		case MFIE_TYPE_HT_CAP:
 			IEEE80211_DEBUG_SCAN("MFIE_TYPE_HT_CAP: %d bytes\n",
 					     info_element->len);
@@ -1984,9 +2026,11 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 					sizeof(network->bssht.bdHTCapBuf):tmp_htcap_len;
 				memcpy(network->bssht.bdHTCapBuf,info_element->data,network->bssht.bd=
HTCapLen);

-				//If peer is HT, but not WMM, call QosSetLegacyWMMParamWithHT()
-				// windows driver will update WMM parameters each beacon received onc=
e connected
-				// Linux driver is a bit different.
+				/*
+				 * If peer is HT, but not WMM, call QosSetLegacyWMMParamWithHT()
+				 * windows driver will update WMM parameters each beacon received onc=
e connected
+				 * Linux driver is a bit different.
+				 */
 				network->bssht.bdSupportHT =3D true;
 			}
 			else
@@ -2013,9 +2057,11 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 			{
 				network->bWithAironetIE =3D true;

-				// CCX 1 spec v1.13, A01.1 CKIP Negotiation (page23):
-				// "A Cisco access point advertises support for CKIP in beacon and pr=
obe response packets,
-				//  by adding an Aironet element and setting one or both of the CKIP =
negotiation bits."
+				/*
+				 * CCX 1 spec v1.13, A01.1 CKIP Negotiation (page23):
+				 * "A Cisco access point advertises support for CKIP in beacon and pr=
obe response packets,
+				 * by adding an Aironet element and setting one or both of the CKIP n=
egotiation bits."
+				 */
 				if(	(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_MIC)	||
 					(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_PK)	)
 				{
@@ -2040,7 +2086,7 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 		case MFIE_TYPE_COUNTRY:
 			IEEE80211_DEBUG_SCAN("MFIE_TYPE_COUNTRY: %d bytes\n",
 					     info_element->len);
-			ieee80211_extract_country_ie(ieee, info_element, network, network->bss=
id);//addr2 is same as addr3 when from an AP
+			ieee80211_extract_country_ie(ieee, info_element, network, network->bss=
id);/* addr2 is same as addr3 when from an AP */
 			break;
 /* TODO */
 		default:
@@ -2075,7 +2121,7 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 {
 	u8 RetSS;

-	// Step 1. Scale mapping.
+	/* Step 1. Scale mapping. */
 	if(CurrSS >=3D 71 && CurrSS <=3D 100)
 	{
 		RetSS =3D 90 + ((CurrSS - 70) / 3);
@@ -2118,7 +2164,7 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 	}
 	//RT_TRACE(COMP_DBG, DBG_LOUD, ("##### After Mapping:  LastSS: %d, CurrS=
S: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));

-	// Step 2. Smoothing.
+	/* Step 2. Smoothing. */

 	//RT_TRACE(COMP_DBG, DBG_LOUD, ("$$$$$ After Smoothing:  LastSS: %d, Cur=
rSS: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));

@@ -2128,9 +2174,9 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 /* 0-100 index */
 static long ieee80211_translate_todbm(u8 signal_strength_index)
 {
-	long	signal_power; // in dBm.
+	long	signal_power; /* in dBm. */

-	// Translate to dBm (x=3D0.5y-95).
+	/* Translate to dBm (x=3D0.5y-95). */
 	signal_power =3D (long)((signal_strength_index + 1) >> 1);
 	signal_power -=3D 95;

@@ -2180,7 +2226,7 @@ static inline int ieee80211_network_init(
 #endif
 	network->CountryIeLen =3D 0;
 	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
-//Initialize HT parameters
+/* Initialize HT parameters */
 	//ieee80211_ht_initialize(&network->bssht);
 	HTInitializeBssDesc(&network->bssht);
 	if (stats->freq =3D=3D IEEE80211_52GHZ_BAND) {
@@ -2236,10 +2282,12 @@ static inline int ieee80211_network_init(
 static inline int is_same_network(struct ieee80211_network *src,
 				  struct ieee80211_network *dst, struct ieee80211_device *ieee)
 {
-	/* A network is only a duplicate if the channel, BSSID, ESSID
+	/*
+	 * A network is only a duplicate if the channel, BSSID, ESSID
 	 * and the capability field (in particular IBSS and BSS) all match.
 	 * We treat all <hidden> with the same BSSID and channel
-	 * as one network */
+	 * as one network
+	 */
 	return //((src->ssid_len =3D=3D dst->ssid_len) &&
 		(((src->ssid_len =3D=3D dst->ssid_len) || (ieee->iw_mode =3D=3D IW_MODE=
_INFRA)) &&
 		(src->channel =3D=3D dst->channel) &&
@@ -2334,7 +2382,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	dst->qos_data.old_param_count =3D old_param;

 	/* dst->last_associate is not overwritten */
-	dst->wmm_info =3D src->wmm_info; //sure to exist in beacon or probe resp=
onse frame.
+	dst->wmm_info =3D src->wmm_info; /* sure to exist in beacon or probe res=
ponse frame. */
 	if (src->wmm_param[0].aci_aifsn|| \
 	   src->wmm_param[1].aci_aifsn|| \
 	   src->wmm_param[2].aci_aifsn|| \
@@ -2349,7 +2397,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	dst->CountryIeLen =3D src->CountryIeLen;
 	memcpy(dst->CountryIeBuf, src->CountryIeBuf, src->CountryIeLen);

-	//added by amy for LEAP
+	/* added by amy for LEAP */
 	dst->bWithAironetIE =3D src->bWithAironetIE;
 	dst->bCkipSupported =3D src->bCkipSupported;
 	memcpy(dst->CcxRmState, src->CcxRmState, 2);
@@ -2420,12 +2468,14 @@ static inline void ieee80211_process_probe_respons=
e(
 		goto out;
 	}

-	// For Asus EeePc request,
-	// (1) if wireless adapter receive get any 802.11d country code in AP be=
acon,
-	//	   wireless adapter should follow the country code.
-	// (2)  If there is no any country code in beacon,
-	//       then wireless adapter should do active scan from ch1~11 and
-	//       passive scan from ch12~14
+	/*
+	 * For Asus EeePc request,
+	 * (1) if wireless adapter receive get any 802.11d country code in AP be=
acon,
+	 * wireless adapter should follow the country code.
+	 * (2)  If there is no any country code in beacon,
+	 * then wireless adapter should do active scan from ch1~11 and
+	 * passive scan from ch12~14
+	 */

 	if (!is_legal_channel(ieee, network->channel))
 		goto out;
@@ -2433,7 +2483,7 @@ static inline void ieee80211_process_probe_response(
 	{
 		if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP)
 		{
-			// Case 1: Country code
+			/* Case 1: Country code */
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
 				if (!is_legal_channel(ieee, network->channel)) {
@@ -2441,10 +2491,10 @@ static inline void ieee80211_process_probe_respons=
e(
 					goto out;
 				}
 			}
-			// Case 2: No any country code.
+			/* Case 2: No any country code. */
 			else
 			{
-				// Filter over channel ch12~14
+				/* Filter over channel ch12~14 */
 				if (network->channel > 11)
 				{
 					printk("GetScanInfo(): For Global Domain, filter probe response at c=
hannel(%d).\n", network->channel);
@@ -2454,7 +2504,7 @@ static inline void ieee80211_process_probe_response(
 		}
 		else
 		{
-			// Case 1: Country code
+			/* Case 1: Country code */
 			if(IS_COUNTRY_IE_VALID(ieee) )
 			{
 				if (!is_legal_channel(ieee, network->channel)) {
@@ -2462,10 +2512,10 @@ static inline void ieee80211_process_probe_respons=
e(
 					goto out;
 				}
 			}
-			// Case 2: No any country code.
+			/* Case 2: No any country code. */
 			else
 			{
-				// Filter over channel ch12~14
+				/* Filter over channel ch12~14 */
 				if (network->channel > 14)
 				{
 					printk("GetScanInfo(): For Global Domain, filter beacon at channel(%=
d).\n",network->channel);
@@ -2475,15 +2525,19 @@ static inline void ieee80211_process_probe_respons=
e(
 		}
 	}

-	/* The network parsed correctly -- so now we scan our known networks
+	/*
+	 * The network parsed correctly -- so now we scan our known networks
 	 * to see if we can find it in our list.
 	 *
 	 * NOTE:  This search is definitely not optimized.  Once its doing
 	 *        the "right thing" we'll optimize it for efficiency if
-	 *        necessary */
+	 *        necessary
+	 */

-	/* Search for this entry in the list and update it if it is
-	 * already there. */
+	/*
+	 * Search for this entry in the list and update it if it is
+	 * already there.
+	 */

 	spin_lock_irqsave(&ieee->lock, flags);

@@ -2500,8 +2554,7 @@ static inline void ieee80211_process_probe_response(
 		{
 			if(ieee->state =3D=3D IEEE80211_LINKED)
 				ieee->LinkDetectInfo.NumRecvBcnInPeriod++;
-		}
-		else //hidden AP
+		} else /* hidden AP */
 			network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWORK_EM=
PTY_ESSID & ieee->current_network.flags);
 	}

@@ -2513,8 +2566,10 @@ static inline void ieee80211_process_probe_response=
(
 			oldest =3D target;
 	}

-	/* If we didn't find a match, then get a new network slot to initialize
-	 * with this beacon's information */
+	/*
+	 * If we didn't find a match, then get a new network slot to initialize
+	 * with this beacon's information
+	 */
 	if (&target->list =3D=3D &ieee->network_list) {
 		if (list_empty(&ieee->network_free_list)) {
 			/* If there are no more slots, expire the oldest */
@@ -2553,12 +2608,13 @@ static inline void ieee80211_process_probe_respons=
e(
 				     fc =3D=3D IEEE80211_STYPE_PROBE_RESP ?
 				     "PROBE RESPONSE" : "BEACON");

-		/* we have an entry and we are going to update it. But this entry may
+		/*
+		 * we have an entry and we are going to update it. But this entry may
 		 * be already expired. In this case we do the same as we found a new
 		 * net and call the new_net handler
 		 */
 		renew =3D !time_after(target->last_scanned + ieee->scan_age, jiffies);
-		//YJ,add,080819,for hidden ap
+		/* YJ,add,080819,for hidden ap */
 		if(is_beacon(beacon->header.frame_ctl) =3D=3D 0)
 			network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWORK_EM=
PTY_ESSID & target->flags);
 		//if(strncmp(network->ssid, "linksys-c",9) =3D=3D 0)
@@ -2567,7 +2623,7 @@ static inline void ieee80211_process_probe_response(
 		    && (((network->ssid_len > 0) && (strncmp(target->ssid, network->ssi=
d, network->ssid_len)))\
 		    ||((ieee->current_network.ssid_len =3D=3D network->ssid_len)&&(strn=
cmp(ieee->current_network.ssid, network->ssid, network->ssid_len) =3D=3D 0=
)&&(ieee->state =3D=3D IEEE80211_NOLINK))))
 			renew =3D 1;
-		//YJ,add,080819,for hidden ap,end
+		/* YJ,add,080819,for hidden ap,end */

 		update_network(target, network);
 		if(renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/driv=
ers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 944c8894f9ff..27e81a1de51e 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -33,7 +33,8 @@ short ieee80211_is_shortslot(const struct ieee80211_netw=
ork *net)
 }
 EXPORT_SYMBOL(ieee80211_is_shortslot);

-/* returns the total length needed for pleacing the RATE MFIE
+/*
+ * returns the total length needed for pleacing the RATE MFIE
  * tag and the EXTENDED RATE MFIE tag if needed.
  * It encludes two bytes per tag for the tag itself and its len
  */
@@ -50,7 +51,8 @@ static unsigned int ieee80211_MFIE_rate_len(struct ieee8=
0211_device *ieee)
 	return rate_len;
 }

-/* pleace the MFIE rate, tag to the memory (double) poined.
+/*
+ * pleace the MFIE rate, tag to the memory (double) poined.
  * Then it updates the pointer so that
  * it points after the new MFIE tag added.
  */
@@ -263,9 +265,10 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, st=
ruct ieee80211_device *ieee
 		    (skb_queue_len(&ieee->skb_waitQ[tcb_desc->queue_index]) !=3D 0) || =
\
 		    (ieee->queue_stop)) {
 			/* insert the skb packet to the management queue */
-			/* as for the completion function, it does not need
+			/*
+			 * as for the completion function, it does not need
 			 * to check it any more.
-			 * */
+			 */
 			printk("%s():insert to waitqueue!\n", __func__);
 			skb_queue_tail(&ieee->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
@@ -405,7 +408,8 @@ static void ieee80211_send_probe_requests(struct ieee8=
0211_device *ieee)
 	}
 }

-/* this performs syncro scan blocking the caller until all channels
+/*
+ * this performs syncro scan blocking the caller until all channels
  * in the allowed channel map has been checked.
  */
 void ieee80211_softmac_scan_syncro(struct ieee80211_device *ieee)
@@ -423,7 +427,8 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_de=
vice *ieee)
 				goto out; /* scan completed */
 		} while (!channel_map[ch]);

-		/* this function can be called in two situations
+		/*
+		 * this function can be called in two situations
 		 * 1- We have switched to ad-hoc mode and we are
 		 *    performing a complete syncro scan before conclude
 		 *    there are no interesting cell and to create a
@@ -448,7 +453,8 @@ void ieee80211_softmac_scan_syncro(struct ieee80211_de=
vice *ieee)
 		if (channel_map[ch] =3D=3D 1)
 			ieee80211_send_probe_requests(ieee);

-		/* this prevent excessive time wait when we
+		/*
+		 * this prevent excessive time wait when we
 		 * need to wait for a syncro scan to end..
 		 */
 		if (ieee->state >=3D IEEE80211_LINKED && ieee->sync_scan_hurryup)
@@ -712,7 +718,7 @@ static struct sk_buff *ieee80211_probe_resp(struct iee=
e80211_device *ieee, u8 *d
 //	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>tmp_ht_cap_len i=
s %d,tmp_ht_info_len is %d, tmp_generic_ie_len is %d\n",tmp_ht_cap_len,tmp=
_ht_info_len,tmp_generic_ie_len);
 	beacon_size =3D sizeof(struct ieee80211_probe_response) + 2
 		+ ssid_len
-		+ 3 //channel
+		+ 3 /* channel */
 		+ rate_len
 		+ rate_ex_len
 		+ atim_len
@@ -789,7 +795,7 @@ static struct sk_buff *ieee80211_probe_resp(struct iee=
e80211_device *ieee, u8 *d

 	if (wpa_ie_len) {
 		if (ieee->iw_mode =3D=3D IW_MODE_ADHOC) {
-			//as Windows will set pairwise key same as the group key which is not =
allowed in Linux, so set this for IOT issue. WB 2008.07.07
+			/* as Windows will set pairwise key same as the group key which is not=
 allowed in Linux, so set this for IOT issue. WB 2008.07.07 */
 			memcpy(&ieee->wpa_ie[14], &ieee->wpa_ie[8], 4);
 		}
 		memcpy(tag, ieee->wpa_ie, ieee->wpa_ie_len);
@@ -946,7 +952,7 @@ ieee80211_association_req(struct ieee80211_network *be=
acon,
 	//u16 suite_count =3D 0;
 	//u8 suit_select =3D 0;
 	//unsigned int wpa_len =3D beacon->wpa_ie_len;
-	//for HT
+	/* for HT */
 	u8 *ht_cap_buf =3D NULL;
 	u8 ht_cap_len =3D 0;
 	u8 *realtek_ie_buf =3D NULL;
@@ -1033,18 +1039,18 @@ ieee80211_association_req(struct ieee80211_network=
 *beacon,
 	memcpy(hdr->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy(hdr->header.addr3, beacon->bssid, ETH_ALEN);

-	memcpy(ieee->ap_mac_addr, beacon->bssid, ETH_ALEN);//for HW security, Jo=
hn
+	memcpy(ieee->ap_mac_addr, beacon->bssid, ETH_ALEN);/* for HW security, J=
ohn */

 	hdr->capability =3D cpu_to_le16(WLAN_CAPABILITY_BSS);
 	if (beacon->capability & WLAN_CAPABILITY_PRIVACY)
 		hdr->capability |=3D cpu_to_le16(WLAN_CAPABILITY_PRIVACY);

 	if (beacon->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
-		hdr->capability |=3D cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE); //add=
 short_preamble here
+		hdr->capability |=3D cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE); /* ad=
d short_preamble here */

 	if (ieee->short_slot)
 		hdr->capability |=3D cpu_to_le16(WLAN_CAPABILITY_SHORT_SLOT);
-	if (wmm_info_len) //QOS
+	if (wmm_info_len) /* QOS */
 		hdr->capability |=3D cpu_to_le16(WLAN_CAPABILITY_QOS);

 	hdr->listen_interval =3D cpu_to_le16(0xa);
@@ -1058,24 +1064,26 @@ ieee80211_association_req(struct ieee80211_network=
 *beacon,

 	ieee80211_MFIE_Brate(ieee, &tag);
 	ieee80211_MFIE_Grate(ieee, &tag);
-	// For CCX 1 S13, CKIP. Added by Annie, 2006-08-14.
+	/* For CCX 1 S13, CKIP. Added by Annie, 2006-08-14. */
 	if (beacon->bCkipSupported) {
-		static u8	AironetIeOui[] =3D {0x00, 0x01, 0x66}; // "4500-client"
+		static u8	AironetIeOui[] =3D {0x00, 0x01, 0x66}; /* "4500-client" */
 		u8	CcxAironetBuf[30];
 		struct octet_string	osCcxAironetIE;

 		memset(CcxAironetBuf, 0, 30);
 		osCcxAironetIE.octet =3D CcxAironetBuf;
 		osCcxAironetIE.length =3D sizeof(CcxAironetBuf);
-		//
-		// Ref. CCX test plan v3.61, 3.2.3.1 step 13.
-		// We want to make the device type as "4500-client". 060926, by CCW.
-		//
+		/*
+		 * Ref. CCX test plan v3.61, 3.2.3.1 step 13.
+		 * We want to make the device type as "4500-client". 060926, by CCW.
+		 */
 		memcpy(osCcxAironetIE.octet, AironetIeOui, sizeof(AironetIeOui));

-		// CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
-		// "The CKIP negotiation is started with the associate request from the=
 client to the access point,
-		//  containing an Aironet element with both the MIC and KP bits set."
+		/*
+		 * CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
+		 * "The CKIP negotiation is started with the associate request from the=
 client to the access point,
+		 *  containing an Aironet element with both the MIC and KP bits set."
+		 */
 		osCcxAironetIE.octet[IE_CISCO_FLAG_POSITION] |=3D (SUPPORT_CKIP_PK | SU=
PPORT_CKIP_MIC);
 		tag =3D skb_put(skb, ckip_ie_len);
 		*tag++ =3D MFIE_TYPE_AIRONET;
@@ -1109,7 +1117,7 @@ ieee80211_association_req(struct ieee80211_network *=
beacon,
 		memcpy(tag, osCcxVerNum.octet, osCcxVerNum.length);
 		tag +=3D osCcxVerNum.length;
 	}
-	//HT cap element
+	/* HT cap element */
 	if (ieee->pHTInfo->bCurrentHTSupport && ieee->pHTInfo->bEnableHT) {
 		if (ieee->pHTInfo->ePeerHTSpecVer !=3D HT_SPEC_VER_EWC) {
 			tag =3D skb_put(skb, ht_cap_len);
@@ -1120,7 +1128,7 @@ ieee80211_association_req(struct ieee80211_network *=
beacon,
 		}
 	}

-	//choose what wpa_supplicant gives to associate.
+	/* choose what wpa_supplicant gives to associate. */
 	if (wpa_ie_len)
 		skb_put_data(skb, ieee->wpa_ie, wpa_ie_len);

@@ -1163,7 +1171,8 @@ void ieee80211_associate_abort(struct ieee80211_devi=
ce *ieee)

 	ieee->associate_seq++;

-	/* don't scan, and avoid to have the RX path possibily
+	/*
+	 * don't scan, and avoid to have the RX path possibily
 	 * try again to associate. Even do not react to AUTH or
 	 * ASSOC response. Just wait for the retry wq to be scheduled.
 	 * Here we will check if there are good nets to associate
@@ -1208,7 +1217,7 @@ static void ieee80211_associate_step1(struct ieee802=
11_device *ieee)
 		ieee->state =3D IEEE80211_ASSOCIATING_AUTHENTICATING;
 		IEEE80211_DEBUG_MGMT("Sending authentication request\n");
 		softmac_mgmt_xmit(skb, ieee);
-		//BUGON when you try to add_timer twice, using mod_timer may be better,=
 john0709
+		/* BUGON when you try to add_timer twice, using mod_timer may be better=
, john0709 */
 		if (!timer_pending(&ieee->associate_timer)) {
 			ieee->associate_timer.expires =3D jiffies + (HZ / 2);
 			add_timer(&ieee->associate_timer);
@@ -1289,7 +1298,7 @@ static void ieee80211_associate_complete_wq(struct w=
ork_struct *work)
 		//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EX=
T);
 	}
 	ieee->LinkDetectInfo.SlotNum =3D 2 * (1 + ieee->current_network.beacon_i=
nterval / 500);
-	// To prevent the immediately calling watch_dog after association.
+	/* To prevent the immediately calling watch_dog after association. */
 	if (ieee->LinkDetectInfo.NumRecvBcnInPeriod =3D=3D 0 || ieee->LinkDetect=
Info.NumRecvDataInPeriod =3D=3D 0) {
 		ieee->LinkDetectInfo.NumRecvBcnInPeriod =3D 1;
 		ieee->LinkDetectInfo.NumRecvDataInPeriod =3D 1;
@@ -1346,7 +1355,8 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee

 	short apset, ssidset, ssidbroad, apmatch, ssidmatch;

-	/* we are interested in new new only if we are not associated
+	/*
+	 * we are interested in new new only if we are not associated
 	 * and we are not associating / authenticating
 	 */
 	if (ieee->state !=3D IEEE80211_NOLINK)
@@ -1359,7 +1369,8 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee
 		return;

 	if (ieee->iw_mode =3D=3D IW_MODE_INFRA || ieee->iw_mode =3D=3D IW_MODE_A=
DHOC) {
-		/* if the user specified the AP MAC, we need also the essid
+		/*
+		 * if the user specified the AP MAC, we need also the essid
 		 * This could be obtained by beacons or, if the network does not
 		 * broadcast it, it can be put manually.
 		 */
@@ -1370,18 +1381,21 @@ inline void ieee80211_softmac_new_net(struct ieee8=
0211_device *ieee, struct ieee
 		ssidmatch =3D (ieee->current_network.ssid_len =3D=3D net->ssid_len) &&
 			(!strncmp(ieee->current_network.ssid, net->ssid, net->ssid_len));

-		/* if the user set the AP check if match.
+		/*
+		 * if the user set the AP check if match.
 		 * if the network does not broadcast essid we check the user supplyed A=
NY essid
 		 * if the network does broadcast and the user does not set essid it is =
OK
 		 * if the network does broadcast and the user did set essid chech if es=
sid match
 		 */
 		if ((apset && apmatch &&
 		     ((ssidset && ssidbroad && ssidmatch) || (ssidbroad && !ssidset) ||=
 (!ssidbroad && ssidset))) ||
-		    /* if the ap is not set, check that the user set the bssid
+		    /*
+		     * if the ap is not set, check that the user set the bssid
 		     * and the network does broadcast and that those two bssid matches
 		     */
 		    (!apset && ssidset && ssidbroad && ssidmatch)) {
-			/* if the essid is hidden replace it with the
+			/*
+			 * if the essid is hidden replace it with the
 			 * essid provided by the user.
 			 */
 			if (!ssidbroad) {
@@ -1404,7 +1418,7 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee
 			if (ieee->iw_mode =3D=3D IW_MODE_INFRA) {
 				/* Join the network for the first time */
 				ieee->AsocRetryCount =3D 0;
-				//for HT by amy 080514
+				/* for HT by amy 080514 */
 				if ((ieee->current_network.qos_data.supported =3D=3D 1) &&
 				    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSup=
portHT))
 				    ieee->current_network.bssht.bdSupportHT) {
@@ -1444,7 +1458,8 @@ void ieee80211_softmac_check_all_nets(struct ieee802=
11_device *ieee)
 	spin_lock_irqsave(&ieee->lock, flags);

 	list_for_each_entry(target, &ieee->network_list, list) {
-		/* if the state become different that NOLINK means
+		/*
+		 * if the state become different that NOLINK means
 		 * we had found what we are searching for
 		 */

@@ -1624,7 +1639,7 @@ ieee80211_rx_assoc_rq(struct ieee80211_device *ieee,=
 struct sk_buff *skb)
 		ieee80211_resp_to_assoc_rq(ieee, dest);

 	printk(KERN_INFO"New client associated: %pM\n", dest);
-	//FIXME
+	/* FIXME */
 }

 static void ieee80211_sta_ps_send_null_frame(struct ieee80211_device *iee=
e,
@@ -1651,7 +1666,7 @@ static short ieee80211_sta_ps_sleep(struct ieee80211=
_device *ieee, u32 *time_h,
 	dtim =3D ieee->current_network.dtim_data;
 	if (!(dtim & IEEE80211_DTIM_VALID))
 		return 0;
-	timeout =3D ieee->current_network.beacon_interval; //should we use ps_ti=
meout value or beacon_interval
+	timeout =3D ieee->current_network.beacon_interval; /* should we use ps_t=
imeout value or beacon_interval */
 	ieee->current_network.dtim_data =3D IEEE80211_DTIM_INVALID;

 	if (dtim & ((IEEE80211_DTIM_UCAST | IEEE80211_DTIM_MBCAST) & ieee->ps))
@@ -1696,7 +1711,7 @@ static inline void ieee80211_sta_ps(struct ieee80211=
_device *ieee)
 	if ((ieee->ps =3D=3D IEEE80211_PS_DISABLED ||
 	     ieee->iw_mode !=3D IW_MODE_INFRA ||
 	     ieee->state !=3D IEEE80211_LINKED)) {
-		//	#warning CHECK_LOCK_HERE
+		/* 	#warning CHECK_LOCK_HERE */
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);

 		ieee80211_sta_wakeup(ieee, 1);
@@ -1729,7 +1744,7 @@ static inline void ieee80211_sta_ps(struct ieee80211=
_device *ieee)
 			spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags2);
 		}
 	} else if (sleep =3D=3D 2) {
-//#warning CHECK_LOCK_HERE
+/* #warning CHECK_LOCK_HERE */
 		spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);

 		ieee80211_sta_wakeup(ieee, 1);
@@ -1774,7 +1789,8 @@ void ieee80211_ps_tx_ack(struct ieee80211_device *ie=
ee, short success)
 			ieee->sta_sleep =3D 1;
 			ieee->enter_sleep_state(ieee->dev, ieee->ps_th, ieee->ps_tl);
 		}
-		/* if the card report not success we can't be sure the AP
+		/*
+		 * if the card report not success we can't be sure the AP
 		 * has not RXed so we can't assume the AP believe us awake
 		 */
 	} else {
@@ -1925,7 +1941,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 								       network, rx_stats)) {
 						return 1;
 					} else {
-						//filling the PeerHTCap. //maybe not necessary as we can get its in=
fo from current_network.
+						/* filling the PeerHTCap. maybe not necessary as we can get its inf=
o from current_network. */
 						memcpy(ieee->pHTInfo->PeerHTCapBuf, network->bssht.bdHTCapBuf, netw=
ork->bssht.bdHTCapLen);
 						memcpy(ieee->pHTInfo->PeerHTInfoBuf, network->bssht.bdHTInfoBuf, ne=
twork->bssht.bdHTInfoLen);
 					}
@@ -1978,9 +1994,10 @@ ieee80211_rx_frame_softmac(struct ieee80211_device =
*ieee, struct sk_buff *skb,

 	case IEEE80211_STYPE_DISASSOC:
 	case IEEE80211_STYPE_DEAUTH:
-		/* FIXME for now repeat all the association procedure
-		* both for disassociation and deauthentication
-		*/
+		/*
+		 * FIXME for now repeat all the association procedure
+		 * both for disassociation and deauthentication
+		 */
 		if ((ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE) &&
 		    ieee->state =3D=3D IEEE80211_LINKED &&
 		    ieee->iw_mode =3D=3D IW_MODE_INFRA) {
@@ -2004,7 +2021,8 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 	return 0;
 }

-/* The following are for a simpler TX queue management.
+/*
+ * The following are for a simpler TX queue management.
  * Instead of using netif_[stop/wake]_queue, the driver
  * will use these two functions (plus a reset one) that
  * will internally call the kernel netif_* and take care
@@ -2051,7 +2069,8 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *tx=
b, struct ieee80211_device *
 		    (!ieee->check_nic_enough_desc(ieee->dev, queue_index)) || \
 		    (ieee->queue_stop)) {
 			/* insert the skb packet to the wait queue */
-			/* as for the completion function, it does not need
+			/*
+			 * as for the completion function, it does not need
 			 * to check it any more.
 			 * */
 			//printk("error:no descriptor left@queue_index %d\n", queue_index);
@@ -2205,7 +2224,8 @@ static void ieee80211_start_ibss_wq(struct work_stru=
ct *work)
 {
 	struct delayed_work *dwork =3D to_delayed_work(work);
 	struct ieee80211_device *ieee =3D container_of(dwork, struct ieee80211_d=
evice, start_ibss_wq);
-	/* iwconfig mode ad-hoc will schedule this and return
+	/*
+	 * iwconfig mode ad-hoc will schedule this and return
 	 * on the other hand this will block further iwconfig SET
 	 * operations because of the wx_mutex hold.
 	 * Anyway some most set operations set a flag to speed-up
@@ -2230,7 +2250,8 @@ static void ieee80211_start_ibss_wq(struct work_stru=
ct *work)
 //	if((IS_DOT11D_ENABLE(ieee)) && (ieee->state =3D=3D IEEE80211_NOLINK))
 	if (ieee->state =3D=3D IEEE80211_NOLINK)
 		ieee->current_network.channel =3D 6;
-	/* if not then the state is not linked. Maybe the user switched to
+	/*
+	 * if not then the state is not linked. Maybe the user switched to
 	 * ad-hoc mode just after being in monitor mode, or just after
 	 * being very few time in managed mode (so the card have had no
 	 * time to scan all the chans..) or we have just run up the iface
@@ -2281,7 +2302,7 @@ static void ieee80211_start_ibss_wq(struct work_stru=
ct *work)
 			ieee->rate =3D 22;
 		}

-		// By default, WMM function will be disabled in IBSS mode
+		/* By default, WMM function will be disabled in IBSS mode */
 		ieee->current_network.QoS_Enable =3D 0;
 		ieee->SetWirelessMode(ieee->dev, IEEE_G);
 		ieee->current_network.atim_window =3D 0;
@@ -2315,22 +2336,24 @@ inline void ieee80211_start_ibss(struct ieee80211_=
device *ieee)
 void ieee80211_start_bss(struct ieee80211_device *ieee)
 {
 	unsigned long flags;
-	//
-	// Ref: 802.11d 11.1.3.3
-	// STA shall not start a BSS unless properly formed Beacon frame includi=
ng a Country IE.
-	//
+	/*
+	 * Ref: 802.11d 11.1.3.3
+	 * STA shall not start a BSS unless properly formed Beacon frame includi=
ng a Country IE.
+	 */
 	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee)) {
 		if (!ieee->bGlobalDomain)
 			return;
 	}
-	/* check if we have already found the net we
+	/*
+	 * check if we have already found the net we
 	 * are interested in (if any).
 	 * if not (we are disassociated and we are not
 	 * in associating / authenticating phase) start the background scanning.
 	 */
 	ieee80211_softmac_check_all_nets(ieee);

-	/* ensure no-one start an associating process (thus setting
+	/*
+	 * ensure no-one start an associating process (thus setting
 	 * the ieee->state to ieee80211_ASSOCIATING) while we
 	 * have just cheked it and we are going to enable scan.
 	 * The ieee80211_new_net function is always called with
@@ -2378,19 +2401,20 @@ static void ieee80211_associate_retry_wq(struct wo=
rk_struct *work)
 	if (ieee->state !=3D IEEE80211_ASSOCIATING_RETRY)
 		goto exit;

-	/* until we do not set the state to IEEE80211_NOLINK
-	* there are no possibility to have someone else trying
-	* to start an association procedure (we get here with
-	* ieee->state =3D IEEE80211_ASSOCIATING).
-	* When we set the state to IEEE80211_NOLINK it is possible
-	* that the RX path run an attempt to associate, but
-	* both ieee80211_softmac_check_all_nets and the
-	* RX path works with ieee->lock held so there are no
-	* problems. If we are still disassociated then start a scan.
-	* the lock here is necessary to ensure no one try to start
-	* an association procedure when we have just checked the
-	* state and we are going to start the scan.
-	*/
+	/*
+	 * until we do not set the state to IEEE80211_NOLINK
+	 * there are no possibility to have someone else trying
+	 * to start an association procedure (we get here with
+	 * ieee->state =3D IEEE80211_ASSOCIATING).
+	 * When we set the state to IEEE80211_NOLINK it is possible
+	 * that the RX path run an attempt to associate, but
+	 * both ieee80211_softmac_check_all_nets and the
+	 * RX path works with ieee->lock held so there are no
+	 * problems. If we are still disassociated then start a scan.
+	 * the lock here is necessary to ensure no one try to start
+	 * an association procedure when we have just checked the
+	 * state and we are going to start the scan.
+	 */
 	ieee->state =3D IEEE80211_NOLINK;

 	ieee80211_softmac_check_all_nets(ieee);
@@ -2468,7 +2492,7 @@ void ieee80211_stop_protocol(struct ieee80211_device=
 *ieee)
 	ieee80211_stop_scan(ieee);

 	ieee80211_disassociate(ieee);
-	RemoveAllTS(ieee); //added as we disconnect from the previous BSS, Remov=
e all TS
+	RemoveAllTS(ieee); /* added as we disconnect from the previous BSS, Remo=
ve all TS */
 }

 void ieee80211_softmac_start_protocol(struct ieee80211_device *ieee)
@@ -2510,9 +2534,10 @@ void ieee80211_start_protocol(struct ieee80211_devi=
ce *ieee)
 		ieee->last_packet_time[i] =3D 0;
 	}

-	ieee->init_wmmparam_flag =3D 0;//reinitialize AC_xx_PARAM registers.
+	ieee->init_wmmparam_flag =3D 0;/* reinitialize AC_xx_PARAM registers. */

-	/* if the user set the MAC of the ad-hoc cell and then
+	/*
+	 * if the user set the MAC of the ad-hoc cell and then
 	 * switch to managed mode, shall we  make sure that association
 	 * attempts does not fail just because the user provide the essid
 	 * and the nic is still checking for the AP MAC ??
@@ -2544,7 +2569,7 @@ void ieee80211_softmac_init(struct ieee80211_device =
*ieee)
 	ieee->dot11d_info =3D kzalloc(sizeof(struct rt_dot11d_info), GFP_KERNEL)=
;
 	if (!ieee->dot11d_info)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "can't alloc memory for DOT11D\n");
-	//added for  AP roaming
+	/* added for  AP roaming */
 	ieee->LinkDetectInfo.SlotNum =3D 2;
 	ieee->LinkDetectInfo.NumRecvBcnInPeriod =3D 0;
 	ieee->LinkDetectInfo.NumRecvDataInPeriod =3D 0;
@@ -2552,7 +2577,7 @@ void ieee80211_softmac_init(struct ieee80211_device =
*ieee)
 	ieee->assoc_id =3D 0;
 	ieee->queue_stop =3D 0;
 	ieee->scanning =3D 0;
-	ieee->softmac_features =3D 0; //so IEEE2100-like driver are happy
+	ieee->softmac_features =3D 0; /* so IEEE2100-like driver are happy */
 	ieee->wap_set =3D 0;
 	ieee->ssid_set =3D 0;
 	ieee->proto_started =3D 0;
@@ -2560,10 +2585,10 @@ void ieee80211_softmac_init(struct ieee80211_devic=
e *ieee)
 	ieee->rate =3D 22;
 	ieee->ps =3D IEEE80211_PS_DISABLED;
 	ieee->sta_sleep =3D 0;
-	ieee->Regdot11HTOperationalRateSet[0] =3D 0xff;//support MCS 0~7
-	ieee->Regdot11HTOperationalRateSet[1] =3D 0xff;//support MCS 8~15
+	ieee->Regdot11HTOperationalRateSet[0] =3D 0xff;/* support MCS 0~7 */
+	ieee->Regdot11HTOperationalRateSet[1] =3D 0xff;/* support MCS 8~15 */
 	ieee->Regdot11HTOperationalRateSet[4] =3D 0x01;
-	//added by amy
+	/* added by amy */
 	ieee->actscanning =3D false;
 	ieee->beinretry =3D false;
 	ieee->is_set_key =3D false;
@@ -2639,7 +2664,7 @@ static int ieee80211_wpa_mlme(struct ieee80211_devic=
e *ieee, int command, int re

 	switch (command) {
 	case IEEE_MLME_STA_DEAUTH:
-		// silently ignore
+		/* silently ignore */
 		break;

 	case IEEE_MLME_STA_DISASSOC:
@@ -2728,7 +2753,8 @@ static int ieee80211_wpa_set_param(struct ieee80211_=
device *ieee, u8 name, u32 v
 		break;

 	case IEEE_PARAM_DROP_UNENCRYPTED: {
-		/* HACK:
+		/*
+		 * HACK:
 		 *
 		 * wpa_supplicant calls set_wpa_enabled when the driver
 		 * is loaded and unloaded, regardless of if WPA is being
@@ -2744,7 +2770,8 @@ static int ieee80211_wpa_set_param(struct ieee80211_=
device *ieee, u8 name, u32 v
 			.enabled =3D value,
 		};
 		ieee->drop_unencrypted =3D value;
-		/* We only change SEC_LEVEL for open mode. Others
+		/*
+		 * We only change SEC_LEVEL for open mode. Others
 		 * are set by ipw_wpa_set_encryption.
 		 */
 		if (!value) {
@@ -2771,7 +2798,7 @@ static int ieee80211_wpa_set_param(struct ieee80211_=
device *ieee, u8 name, u32 v
 		ieee->ieee802_1x =3D value;
 		break;
 	case IEEE_PARAM_WPAX_SELECT:
-		// added for WPA2 mixed mode
+		/* added for WPA2 mixed mode */
 		spin_lock_irqsave(&ieee->wpax_suitlist_lock, flags);
 		ieee->wpax_type_set =3D 1;
 		ieee->wpax_type_notify =3D value;
@@ -2821,7 +2848,7 @@ static int ieee80211_wpa_set_encryption(struct ieee8=
0211_device *ieee,
 	if (strcmp(param->u.crypt.alg, "none") =3D=3D 0) {
 		if (crypt) {
 			sec.enabled =3D 0;
-			// FIXME FIXME
+			/* FIXME FIXME */
 			//sec.encrypt =3D 0;
 			sec.level =3D SEC_LEVEL_0;
 			sec.flags |=3D SEC_ENABLED | SEC_LEVEL;
@@ -2830,7 +2857,7 @@ static int ieee80211_wpa_set_encryption(struct ieee8=
0211_device *ieee,
 		goto done;
 	}
 	sec.enabled =3D 1;
-// FIXME FIXME
+/* FIXME FIXME */
 //	sec.encrypt =3D 1;
 	sec.flags |=3D SEC_ENABLED;

@@ -2839,7 +2866,7 @@ static int ieee80211_wpa_set_encryption(struct ieee8=
0211_device *ieee,
 	    strcmp(param->u.crypt.alg, "TKIP"))
 		goto skip_host_crypt;

-	//set WEP40 first, it will be modified according to WEP104 or WEP40 at o=
ther place
+	/* set WEP40 first, it will be modified according to WEP104 or WEP40 at =
other place */
 	if (!strcmp(param->u.crypt.alg, "WEP"))
 		module =3D "ieee80211_crypt_wep";
 	else if (!strcmp(param->u.crypt.alg, "TKIP"))
@@ -2919,11 +2946,13 @@ static int ieee80211_wpa_set_encryption(struct iee=
e80211_device *ieee,
 	if (ieee->set_security)
 		ieee->set_security(ieee->dev, &sec);

-	/* Do not reset port if card is in Managed mode since resetting will
+	/*
+	 * Do not reset port if card is in Managed mode since resetting will
 	 * generate new IEEE 802.11 authentication which may end up in looping
 	 * with IEEE 802.1X.  If your hardware requires a reset after WEP
 	 * configuration (for example... Prism2), implement the reset_port in
-	 * the callbacks structures used to initialize the 802.11 stack. */
+	 * the callbacks structures used to initialize the 802.11 stack.
+	 */
 	if (ieee->reset_on_keychange &&
 	    ieee->iw_mode !=3D IW_MODE_INFRA &&
 	    ieee->reset_port &&
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index aab1586fe0dd..2bf333c12bbc 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -112,7 +112,7 @@ int ieee80211_wx_get_wap(struct ieee80211_device *ieee=
,
 	if (ieee->iw_mode =3D=3D IW_MODE_MONITOR)
 		return -1;

-	/* We want avoid to give to the user inconsistent infos*/
+	/* We want avoid to give to the user inconsistent infos */
 	spin_lock_irqsave(&ieee->lock, flags);

 	if (ieee->state !=3D IEEE80211_LINKED &&
@@ -159,7 +159,8 @@ int ieee80211_wx_set_wap(struct ieee80211_device *ieee=
,
 	if (ifup)
 		ieee80211_stop_protocol(ieee);

-	/* just to avoid to give inconsistent infos in the
+	/*
+	 * just to avoid to give inconsistent infos in the
 	 * get wx method. not really needed otherwise
 	 */
 	spin_lock_irqsave(&ieee->lock, flags);
@@ -408,7 +409,8 @@ int ieee80211_wx_set_essid(struct ieee80211_device *ie=
ee,
 		ieee80211_stop_protocol(ieee);


-	/* this is just to be sure that the GET wx callback
+	/*
+	 * this is just to be sure that the GET wx callback
 	 * has consisten infos. not needed otherwise
 	 */
 	spin_lock_irqsave(&ieee->lock, flags);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_tx.c
index 8e1ec4409b4f..f5c991f6d34f 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -188,12 +188,14 @@ int ieee80211_encrypt_fragment(
 		return -1;
 	}

-	/* To encrypt, frame format is:
+	/*
+	 * To encrypt, frame format is:
 	 * IV (4 bytes), clear payload (including SNAP), ICV (4 bytes)
 	 */

-	// PR: FIXME: Copied from hostap. Check fragmentation/MSDU/MPDU encrypti=
on.
-	/* Host-based IEEE 802.11 fragmentation for TX is not yet supported, so
+	/* PR: FIXME: Copied from hostap. Check fragmentation/MSDU/MPDU encrypti=
on. */
+	/*
+	 * Host-based IEEE 802.11 fragmentation for TX is not yet supported, so
 	 * call both MSDU and MPDU encryption functions from here.
 	 */
 	atomic_inc(&crypt->refcnt);
@@ -255,8 +257,8 @@ static struct ieee80211_txb *ieee80211_alloc_txb(int n=
r_frags, int txb_size,
 	return txb;
 }

-// Classify the to-be send data packet
-// Need to acquire the sent queue index.
+/* Classify the to-be send data packet */
+/* Need to acquire the sent queue index. */
 static int
 ieee80211_classify(struct sk_buff *skb, struct ieee80211_network *network=
)
 {
@@ -301,11 +303,11 @@ static void ieee80211_tx_query_agg_cap(struct ieee80=
211_device *ieee,

 	if (is_multicast_ether_addr(hdr->addr1))
 		return;
-	//check packet and mode later
+	/* check packet and mode later */
 #ifdef TO_DO_LIST
 	if (pTcb->PacketLength >=3D 4096)
 		return;
-	// For RTL819X, if pairwisekey =3D wep/tkip, we don't aggrregation.
+	/* For RTL819X, if pairwisekey =3D wep/tkip, we don't aggrregation. */
 	if (!Adapter->HalFunc.GetNmodeSupportBySecCfgHandler(Adapter))
 		return;
 #endif
@@ -366,8 +368,8 @@ static void ieee80211_qurey_ShortPreambleMode(struct i=
eee80211_device *ieee,
 					      struct cb_desc *tcb_desc)
 {
 	tcb_desc->bUseShortPreamble =3D false;
-	if (tcb_desc->data_rate =3D=3D 2)
-	{//// 1M can only use Long Preamble. 11B spec
+	if (tcb_desc->data_rate =3D=3D 2) {
+	/* 1M can only use Long Preamble. 11B spec */
 		return;
 	}
 	else if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMB=
LE)
@@ -411,9 +413,9 @@ static void ieee80211_query_BandwidthMode(struct ieee8=
0211_device *ieee,
 	if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
 		return;

-	if ((tcb_desc->data_rate & 0x80)=3D=3D0) // If using legacy rate, it sha=
ll use 20MHz channel.
+	if ((tcb_desc->data_rate & 0x80) =3D=3D 0) /* If using legacy rate, it s=
hall use 20MHz channel. */
 		return;
-	//BandWidthAutoSwitch is for auto switch to 20 or 40 in long distance
+	/* BandWidthAutoSwitch is for auto switch to 20 or 40 in long distance *=
/
 	if(pHTInfo->bCurBW40MHz && pHTInfo->bCurTxBW40MHz && !ieee->bandwidth_au=
to_switch.bforced_tx20Mhz)
 		tcb_desc->bPacketBW =3D true;
 	return;
@@ -423,25 +425,27 @@ static void ieee80211_query_protectionmode(struct ie=
ee80211_device *ieee,
 					   struct cb_desc *tcb_desc,
 					   struct sk_buff *skb)
 {
-	// Common Settings
+	/* Common Settings */
 	tcb_desc->bRTSSTBC			=3D false;
-	tcb_desc->bRTSUseShortGI		=3D false; // Since protection frames are alwa=
ys sent by legacy rate, ShortGI will never be used.
-	tcb_desc->bCTSEnable			=3D false; // Most of protection using RTS/CTS
-	tcb_desc->RTSSC				=3D 0;		// 20MHz: Don't care;  40MHz: Duplicate.
-	tcb_desc->bRTSBW			=3D false; // RTS frame bandwidth is always 20MHz
+	tcb_desc->bRTSUseShortGI		=3D false; /* Since protection frames are alwa=
ys sent by legacy rate, ShortGI will never be used. */
+	tcb_desc->bCTSEnable			=3D false; /* Most of protection using RTS/CTS */
+	tcb_desc->RTSSC				=3D 0;		/* 20MHz: Don't care;  40MHz: Duplicate. */
+	tcb_desc->bRTSBW			=3D false; /* RTS frame bandwidth is always 20MHz */

-	if(tcb_desc->bBroadcast || tcb_desc->bMulticast)//only unicast frame wil=
l use rts/cts
+	if (tcb_desc->bBroadcast || tcb_desc->bMulticast)/* only unicast frame w=
ill use rts/cts */
 		return;

-	if (is_broadcast_ether_addr(skb->data+16))  //check addr3 as infrastruct=
ure add3 is DA.
+	if (is_broadcast_ether_addr(skb->data+16))  /* check addr3 as infrastruc=
ture add3 is DA. */
 		return;

-	if (ieee->mode < IEEE_N_24G) //b, g mode
+	if (ieee->mode < IEEE_N_24G) /* b, g mode */
 	{
-			// (1) RTS_Threshold is compared to the MPDU, not MSDU.
-			// (2) If there are more than one frag in  this MSDU, only the first f=
rag uses protection frame.
-			//		Other fragments are protected by previous fragment.
-			//		So we only need to check the length of first fragment.
+			/*
+			 * (1) RTS_Threshold is compared to the MPDU, not MSDU.
+			 * (2) If there are more than one frag in  this MSDU, only the first f=
rag uses protection frame.
+			 * 	Other fragments are protected by previous fragment.
+			 * 	So we only need to check the length of first fragment.
+			 */
 		if (skb->len > ieee->rts)
 		{
 			tcb_desc->bRTSEnable =3D true;
@@ -449,57 +453,54 @@ static void ieee80211_query_protectionmode(struct ie=
ee80211_device *ieee,
 		}
 		else if (ieee->current_network.buseprotection)
 		{
-			// Use CTS-to-SELF in protection mode.
+			/* Use CTS-to-SELF in protection mode. */
 			tcb_desc->bRTSEnable =3D true;
 			tcb_desc->bCTSEnable =3D true;
 			tcb_desc->rts_rate =3D MGN_24M;
 		}
-		//otherwise return;
+		/* otherwise return; */
 		return;
-	}
-	else
-	{// 11n High throughput case.
+	} else {/* 11n High throughput case. */
 		PRT_HIGH_THROUGHPUT pHTInfo =3D ieee->pHTInfo;
 		while (true)
 		{
-			//check ERP protection
-			if (ieee->current_network.buseprotection)
-			{// CTS-to-SELF
+			/* check ERP protection */
+			if (ieee->current_network.buseprotection) {/* CTS-to-SELF */
 				tcb_desc->bRTSEnable =3D true;
 				tcb_desc->bCTSEnable =3D true;
 				tcb_desc->rts_rate =3D MGN_24M;
 				break;
 			}
-			//check HT op mode
+			/* check HT op mode */
 			if(pHTInfo->bCurrentHTSupport  && pHTInfo->bEnableHT)
 			{
 				u8 HTOpMode =3D pHTInfo->CurrentOpMode;
 				if((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =3D=3D 3))=
 ||
 							(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3) )
 				{
-					tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
+					tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
 					tcb_desc->bRTSEnable =3D true;
 					break;
 				}
 			}
-			//check rts
+			/* check rts */
 			if (skb->len > ieee->rts)
 			{
-				tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
+				tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
 				tcb_desc->bRTSEnable =3D true;
 				break;
 			}
-			//to do list: check MIMO power save condition.
-			//check AMPDU aggregation for TXOP
+			/* to do list: check MIMO power save condition. */
+			/* check AMPDU aggregation for TXOP */
 			if(tcb_desc->bAMPDUEnable)
 			{
-				tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
-				// According to 8190 design, firmware sends CF-End only if RTS/CTS is=
 enabled. However, it degrads
-				// throughput around 10M, so we disable of this mechanism. 2007.08.03=
 by Emily
+				tcb_desc->rts_rate =3D MGN_24M; /* Rate is 24Mbps. */
+				/* According to 8190 design, firmware sends CF-End only if RTS/CTS is=
 enabled. However, it degrads */
+				/* throughput around 10M, so we disable of this mechanism. 2007.08.03=
 by Emily */
 				tcb_desc->bRTSEnable =3D false;
 				break;
 			}
-			//check IOT action
+			/* check IOT action */
 			if(pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF)
 			{
 				tcb_desc->bCTSEnable	=3D true;
@@ -507,11 +508,11 @@ static void ieee80211_query_protectionmode(struct ie=
ee80211_device *ieee,
 				tcb_desc->bRTSEnable =3D true;
 				break;
 			}
-			// Totally no protection case!!
+			/* Totally no protection case!! */
 			goto NO_PROTECTION;
 		}
 		}
-	// For test , CTS replace with RTS
+	/* For test , CTS replace with RTS */
 	if (0) {
 		tcb_desc->bCTSEnable	=3D true;
 		tcb_desc->rts_rate =3D MGN_24M;
@@ -567,7 +568,7 @@ static void ieee80211_query_seqnum(struct ieee80211_de=
vice *ieee,
 {
 	if (is_multicast_ether_addr(dst))
 		return;
-	if (IsQoSDataFrame(skb->data)) //we deal qos data only
+	if (IsQoSDataFrame(skb->data)) /* we deal qos data only */
 	{
 		struct tx_ts_record *pTS =3D NULL;
 		if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priority, =
TX_DIR, true))
@@ -603,7 +604,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)

 	spin_lock_irqsave(&ieee->lock, flags);

-	/* If there is no driver handler to take the TXB, dont' bother
+	/*
+	 * If there is no driver handler to take the TXB, dont' bother
 	 * creating it...
 	 */
 	if ((!ieee->hard_start_xmit && !(ieee->softmac_features & IEEE_SOFTMAC_T=
X_QUEUE))||
@@ -667,14 +669,16 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)

 		if (ieee->iw_mode =3D=3D IW_MODE_INFRA) {
 			fc |=3D IEEE80211_FCTL_TODS;
-			/* To DS: Addr1 =3D BSSID, Addr2 =3D SA,
+			/*
+			 * To DS: Addr1 =3D BSSID, Addr2 =3D SA,
 			 * Addr3 =3D DA
 			 */
 			memcpy(&header.addr1, ieee->current_network.bssid, ETH_ALEN);
 			memcpy(&header.addr2, &src, ETH_ALEN);
 			memcpy(&header.addr3, &dest, ETH_ALEN);
 		} else if (ieee->iw_mode =3D=3D IW_MODE_ADHOC) {
-			/* not From/To DS: Addr1 =3D DA, Addr2 =3D SA,
+			/*
+			 * not From/To DS: Addr1 =3D DA, Addr2 =3D SA,
 			 * Addr3 =3D BSSID
 			 */
 			memcpy(&header.addr1, dest, ETH_ALEN);
@@ -684,7 +688,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)

 		header.frame_ctl =3D cpu_to_le16(fc);

-		/* Determine fragmentation size based on destination (multicast
+		/*
+		 * Determine fragmentation size based on destination (multicast
 		 * and broadcast are not fragmented)
 		 */
 		if (is_multicast_ether_addr(header.addr1)) {
@@ -692,7 +697,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			qos_ctl |=3D QOS_CTL_NOTCONTAIN_ACK;
 		}
 		else {
-			frag_size =3D ieee->fts;//default:392
+			frag_size =3D ieee->fts;/* default:392 */
 			qos_ctl =3D 0;
 		}

@@ -702,12 +707,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
 			hdr_len =3D IEEE80211_3ADDR_LEN + 2;

 			skb->priority =3D ieee80211_classify(skb, &ieee->current_network);
-			qos_ctl |=3D skb->priority; //set in the ieee80211_classify
+			qos_ctl |=3D skb->priority; /* set in the ieee80211_classify */
 			header.qos_ctl =3D cpu_to_le16(qos_ctl & IEEE80211_QOS_TID);
 		} else {
 			hdr_len =3D IEEE80211_3ADDR_LEN;
 		}
-		/* Determine amount of payload per fragment.  Regardless of if
+		/*
+		 * Determine amount of payload per fragment.  Regardless of if
 		 * this stack is providing the full 802.11 header, one will
 		 * eventually be affixed to this fragment -- so we must account for
 		 * it when determining the amount of payload space.
@@ -722,7 +728,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			bytes_per_frag -=3D crypt->ops->extra_prefix_len +
 				crypt->ops->extra_postfix_len;

-		/* Number of fragments is the total bytes_per_frag /
+		/*
+		 * Number of fragments is the total bytes_per_frag /
 		 * payload_per_fragment
 		 */
 		nr_frags =3D bytes / bytes_per_frag;
@@ -732,7 +739,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 		else
 			bytes_last_frag =3D bytes_per_frag;

-		/* When we allocate the TXB we allocate enough space for the reserve
+		/*
+		 * When we allocate the TXB we allocate enough space for the reserve
 		 * and full fragment bytes (bytes_per_frag doesn't include prefix,
 		 * postfix, header, FCS, etc.)
 		 */
@@ -780,7 +788,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			}
 			frag_hdr =3D skb_put_data(skb_frag, &header, hdr_len);

-			/* If this is not the last fragment, then add the MOREFRAGS
+			/*
+			 * If this is not the last fragment, then add the MOREFRAGS
 			 * bit to the frame control
 			 */
 			if (i !=3D nr_frags - 1) {
@@ -795,7 +804,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			//if(ieee->current_network.QoS_Enable)
 			if(qos_actived)
 			{
-				// add 1 only indicate to corresponding seq number control 2006/7/12
+				/* add 1 only indicate to corresponding seq number control 2006/7/12 =
*/
 				frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[UP2AC(skb->priority)=
+1]<<4 | i);
 			} else {
 				frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[0]<<4 | i);
@@ -814,7 +823,8 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			/* Advance the SKB... */
 			skb_pull(skb, bytes);

-			/* Encryption routine will move the header forward in order
+			/*
+			 * Encryption routine will move the header forward in order
 			 * to insert the IV between the header and the payload
 			 */
 			if (encrypt)
@@ -856,7 +866,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 	}

  success:
-//WB add to fill data tcb_desc here. only first fragment is considered, n=
eed to change, and you may remove to other place.
+/* WB add to fill data tcb_desc here. only first fragment is considered, =
need to change, and you may remove to other place. */
 	if (txb)
 	{
 		struct cb_desc *tcb_desc =3D (struct cb_desc *)(txb->fragments[0]->cb +=
 MAX_DEV_ADDR_SIZE);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_wx.c
index dead134f6de0..6cf9e25d6607 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -130,7 +130,7 @@ static inline char *rtl819x_translate_scan(struct ieee=
80211_device *ieee,
 			max_rate =3D rate;
 	}

-	if (network->mode >=3D IEEE_N_24G)//add N rate here;
+	if (network->mode >=3D IEEE_N_24G)/* add N rate here; */
 	{
 		struct ht_capability_ele *ht_cap =3D NULL;
 		bool is40M =3D false, isShortGI =3D false;
@@ -211,8 +211,10 @@ static inline char *rtl819x_translate_scan(struct iee=
e80211_device *ieee,
 	}


-	/* Add EXTRA: Age to display seconds since last beacon/probe response
-	 * for given network. */
+	/*
+	 * Add EXTRA: Age to display seconds since last beacon/probe response
+	 * for given network.
+	 */
 	iwe.cmd =3D IWEVCUSTOM;
 	p =3D custom;
 	p +=3D snprintf(p, MAX_CUSTOM_LEN - (p - custom),
@@ -233,7 +235,7 @@ int ieee80211_wx_get_scan(struct ieee80211_device *iee=
e,

 	char *ev =3D extra;
 //	char *stop =3D ev + IW_SCAN_MAX_DATA;
-	char *stop =3D ev + wrqu->data.length;//IW_SCAN_MAX_DATA;
+	char *stop =3D ev + wrqu->data.length;/* IW_SCAN_MAX_DATA; */
 	//char *stop =3D ev + IW_SCAN_MAX_DATA;
 	int i =3D 0;
 	int err =3D 0;
@@ -309,8 +311,10 @@ int ieee80211_wx_set_encode(struct ieee80211_device *=
ieee,
 		} else
 			IEEE80211_DEBUG_WX("Disabling encryption.\n");

-		/* Check all the keys to see if any are still configured,
-		 * and if no key index was provided, de-init them all */
+		/*
+		 * Check all the keys to see if any are still configured,
+		 * and if no key index was provided, de-init them all
+		 */
 		for (i =3D 0; i < WEP_KEYS; i++) {
 			if (ieee->crypt[i] !=3D NULL) {
 				if (key_provided)
@@ -336,8 +340,10 @@ int ieee80211_wx_set_encode(struct ieee80211_device *=
ieee,

 	if (*crypt !=3D NULL && (*crypt)->ops !=3D NULL &&
 	    strcmp((*crypt)->ops->name, "WEP") !=3D 0) {
-		/* changing to use WEP; deinit previously used algorithm
-		 * on this key */
+		/*
+		 * changing to use WEP; deinit previously used algorithm
+		 * on this key
+		 */
 		ieee80211_crypt_delayed_deinit(ieee, crypt);
 	}

@@ -380,7 +386,8 @@ int ieee80211_wx_set_encode(struct ieee80211_device *i=
eee,
 		(*crypt)->ops->set_key(sec.keys[key], len, NULL,
 				       (*crypt)->priv);
 		sec.flags |=3D BIT(key);
-		/* This ensures a key will be activated if no key is
+		/*
+		 * This ensures a key will be activated if no key is
 		 * explicitly set
 		 */
 		if (key =3D=3D sec.active_key)
@@ -422,19 +429,23 @@ int ieee80211_wx_set_encode(struct ieee80211_device =
*ieee,
 	IEEE80211_DEBUG_WX("Auth: %s\n", sec.auth_mode =3D=3D WLAN_AUTH_OPEN ?
 			   "OPEN" : "SHARED KEY");

-	/* For now we just support WEP, so only set that security level...
-	 * TODO: When WPA is added this is one place that needs to change */
+	/*
+	 * For now we just support WEP, so only set that security level...
+	 * TODO: When WPA is added this is one place that needs to change
+	 */
 	sec.flags |=3D SEC_LEVEL;
 	sec.level =3D SEC_LEVEL_1; /* 40 and 104 bit WEP */

 	if (ieee->set_security)
 		ieee->set_security(dev, &sec);

-	/* Do not reset port if card is in Managed mode since resetting will
+	/*
+	 * Do not reset port if card is in Managed mode since resetting will
 	 * generate new IEEE 802.11 authentication which may end up in looping
 	 * with IEEE 802.1X.  If your hardware requires a reset after WEP
 	 * configuration (for example... Prism2), implement the reset_port in
-	 * the callbacks structures used to initialize the 802.11 stack. */
+	 * the callbacks structures used to initialize the 802.11 stack.
+	 */
 	if (ieee->reset_on_keychange &&
 	    ieee->iw_mode !=3D IW_MODE_INFRA &&
 	    ieee->reset_port && ieee->reset_port(dev)) {
@@ -612,7 +623,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_devic=
e *ieee,
 		ret =3D -EINVAL;
 		goto done;
 	}
- //skip_host_crypt:
+ /* skip_host_crypt: */
 	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY) {
 		ieee->tx_keyidx =3D idx;
 		sec.active_key =3D idx;
@@ -738,9 +749,9 @@ int ieee80211_wx_set_auth(struct ieee80211_device *iee=
e,
 	case IW_AUTH_CIPHER_GROUP:
 	case IW_AUTH_KEY_MGMT:
 		/*
- *                  * Host AP driver does not use these parameters and al=
lows
- *                                   * wpa_supplicant to control them int=
ernally.
- *                                                    */
+		* Host AP driver does not use these parameters and allows
+		* wpa_supplicant to control them internally.
+		*/
 		break;
 	case IW_AUTH_TKIP_COUNTERMEASURES:
 		ieee->tkip_countermeasures =3D data->value;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/sta=
ging/rtl8192u/ieee80211/rtl819x_BA.h
index 1a727856ba53..215748895c2d 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -51,4 +51,4 @@ struct ba_record {
 	union sequence_control	start_seq_ctrl;
 };

-#endif //end _BATYPE_H_
+#endif /* end _BATYPE_H_ */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 53869b3c985c..adfe1878f36d 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -42,17 +42,17 @@ static void DeActivateBAEntry(struct ieee80211_device =
*ieee, struct ba_record *p
  ************************************************************************=
********************************************/
 static u8 TxTsDeleteBA(struct ieee80211_device *ieee, struct tx_ts_record=
 *pTxTs)
 {
-	struct ba_record *pAdmittedBa =3D &pTxTs->tx_admitted_ba_record;  //Thes=
e two BA entries must exist in TS structure
+	struct ba_record *pAdmittedBa =3D &pTxTs->tx_admitted_ba_record;  /* The=
se two BA entries must exist in TS structure */
 	struct ba_record *pPendingBa =3D &pTxTs->tx_pending_ba_record;
 	u8			bSendDELBA =3D false;

-	// Delete pending BA
+	/* Delete pending BA */
 	if (pPendingBa->valid) {
 		DeActivateBAEntry(ieee, pPendingBa);
 		bSendDELBA =3D true;
 	}

-	// Delete admitted BA
+	/* Delete admitted BA */
 	if (pAdmittedBa->valid) {
 		DeActivateBAEntry(ieee, pAdmittedBa);
 		bSendDELBA =3D true;
@@ -95,7 +95,7 @@ void ResetBaEntry(struct ba_record *pBA)
 	pBA->dialog_token		=3D 0;
 	pBA->start_seq_ctrl.short_data	=3D 0;
 }
-//These functions need porting here or not?
+/* These functions need porting here or not? */
 /************************************************************************=
*******************************************************
  *function:  construct ADDBAREQ and ADDBARSP frame here together.
  *   input:  u8*		Dst	//ADDBA frame's destination
@@ -117,11 +117,11 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80=
211_device *ieee, u8 *Dst, s
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "pBA is NULL\n");
 		return NULL;
 	}
-	skb =3D dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need =
to add something others? FIXME
+	skb =3D dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); /* need=
 to add something others? FIXME */
 	if (!skb)
 		return NULL;

-	memset(skb->data, 0, sizeof(struct rtl_80211_hdr_3addr));	//I wonder whe=
ther it's necessary. Apparently kernel will not do it when alloc a skb.
+	memset(skb->data, 0, sizeof(struct rtl_80211_hdr_3addr));	/* I wonder wh=
ether it's necessary. Apparently kernel will not do it when alloc a skb. *=
/
 	skb_reserve(skb, ieee->tx_headroom);

 	BAReq =3D skb_put(skb, sizeof(struct rtl_80211_hdr_3addr));
@@ -131,33 +131,33 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80=
211_device *ieee, u8 *Dst, s

 	memcpy(BAReq->addr3, ieee->current_network.bssid, ETH_ALEN);

-	BAReq->frame_ctl =3D cpu_to_le16(IEEE80211_STYPE_MANAGE_ACT); //action f=
rame
+	BAReq->frame_ctl =3D cpu_to_le16(IEEE80211_STYPE_MANAGE_ACT); /* action =
frame */

 	//tag +=3D sizeof( struct rtl_80211_hdr_3addr); //move to action field
 	tag =3D skb_put(skb, 9);
 	*tag++ =3D ACT_CAT_BA;
 	*tag++ =3D type;
-	// Dialog Token
+	/* Dialog Token */
 	*tag++ =3D pBA->dialog_token;

 	if (ACT_ADDBARSP =3D=3D type) {
-		// Status Code
+		/* Status Code */
 		netdev_info(ieee->dev, "=3D=3D=3D=3D=3D>to send ADDBARSP\n");

 		put_unaligned_le16(StatusCode, tag);
 		tag +=3D 2;
 	}
-	// BA Parameter Set
+	/* BA Parameter Set */

 	put_unaligned_le16(pBA->param_set.short_data, tag);
 	tag +=3D 2;
-	// BA Timeout Value
+	/* BA Timeout Value */

 	put_unaligned_le16(pBA->timeout_value, tag);
 	tag +=3D 2;

 	if (ACT_ADDBAREQ =3D=3D type) {
-	// BA Start SeqCtrl
+	/* BA Start SeqCtrl */
 		memcpy(tag, (u8 *)&(pBA->start_seq_ctrl), 2);
 		tag +=3D 2;
 	}
@@ -202,7 +202,7 @@ static struct sk_buff *ieee80211_DELBA(
 	DelbaParamSet.field.initiator	=3D (TxRxSelect =3D=3D TX_DIR) ? 1 : 0;
 	DelbaParamSet.field.tid	=3D pBA->param_set.field.tid;

-	skb =3D dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); //need =
to add something others? FIXME
+	skb =3D dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); /* need=
 to add something others? FIXME */
 	if (!skb)
 		return NULL;
 //	memset(skb->data, 0, len+sizeof( struct rtl_80211_hdr_3addr));
@@ -213,18 +213,18 @@ static struct sk_buff *ieee80211_DELBA(
 	memcpy(Delba->addr1, dst, ETH_ALEN);
 	memcpy(Delba->addr2, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy(Delba->addr3, ieee->current_network.bssid, ETH_ALEN);
-	Delba->frame_ctl =3D cpu_to_le16(IEEE80211_STYPE_MANAGE_ACT); //action f=
rame
+	Delba->frame_ctl =3D cpu_to_le16(IEEE80211_STYPE_MANAGE_ACT); /* action =
frame */

 	tag =3D skb_put(skb, 6);

 	*tag++ =3D ACT_CAT_BA;
 	*tag++ =3D ACT_DELBA;

-	// DELBA Parameter Set
+	/* DELBA Parameter Set */

 	put_unaligned_le16(DelbaParamSet.short_data, tag);
 	tag +=3D 2;
-	// Reason Code
+	/* Reason Code */

 	put_unaligned_le16(ReasonCode, tag);
 	tag +=3D 2;
@@ -247,13 +247,15 @@ static void ieee80211_send_ADDBAReq(struct ieee80211=
_device *ieee,
 				    u8 *dst, struct ba_record *pBA)
 {
 	struct sk_buff *skb;
-	skb =3D ieee80211_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ); //construct AC=
T_ADDBAREQ frames so set statuscode zero.
+	skb =3D ieee80211_ADDBA(ieee, dst, pBA, 0, ACT_ADDBAREQ); /* construct A=
CT_ADDBAREQ frames so set statuscode zero. */

 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
-		//add statistic needed here.
-		//and skb will be freed in softmac_mgmt_xmit(), so omit all dev_kfree_s=
kb_any() outside softmac_mgmt_xmit()
-		//WB
+		/*
+		 * add statistic needed here.
+		 * and skb will be freed in softmac_mgmt_xmit(), so omit all dev_kfree_=
skb_any() outside softmac_mgmt_xmit()
+		 * WB
+		 */
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n",=
 __func__);
 	}
@@ -271,10 +273,10 @@ static void ieee80211_send_ADDBARsp(struct ieee80211=
_device *ieee, u8 *dst,
 				    struct ba_record *pBA, u16 StatusCode)
 {
 	struct sk_buff *skb;
-	skb =3D ieee80211_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP); //con=
struct ACT_ADDBARSP frames
+	skb =3D ieee80211_ADDBA(ieee, dst, pBA, StatusCode, ACT_ADDBARSP); /* co=
nstruct ACT_ADDBARSP frames */
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
-		//same above
+		/* same above */
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n",=
 __func__);
 	}
@@ -297,10 +299,10 @@ static void ieee80211_send_DELBA(struct ieee80211_de=
vice *ieee, u8 *dst,
 				 u16 ReasonCode)
 {
 	struct sk_buff *skb;
-	skb =3D ieee80211_DELBA(ieee, dst, pBA, TxRxSelect, ReasonCode); //const=
ruct ACT_ADDBARSP frames
+	skb =3D ieee80211_DELBA(ieee, dst, pBA, TxRxSelect, ReasonCode); /* cons=
truct ACT_ADDBARSP frames */
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
-		//same above
+		/* same above */
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "alloc skb error in function %s()\n",=
 __func__);
 	}
@@ -337,13 +339,13 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 	tag =3D (u8 *)req;
 	dst =3D &req->addr2[0];
 	tag +=3D sizeof(struct rtl_80211_hdr_3addr);
-	pDialogToken =3D tag + 2;  //category+action
-	pBaParamSet =3D (union ba_param_set *)(tag + 3);   //+DialogToken
+	pDialogToken =3D tag + 2;  /* category+action */
+	pBaParamSet =3D (union ba_param_set *)(tag + 3);   /* +DialogToken */
 	pBaTimeoutVal =3D (u16 *)(tag + 5);
 	pBaStartSeqCtrl =3D (union sequence_control *)(req + 7);

 	netdev_info(ieee->dev, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D>rx ADDBAREQ from :%pM\n", dst);
-//some other capability is not ready now.
+	/* some other capability is not ready now. */
 	if ((ieee->current_network.qos_data.active =3D=3D 0) ||
 		(!ieee->pHTInfo->bCurrentHTSupport)) //||
 	//	(!ieee->pStaQos->bEnableRxImmBA)	)
@@ -352,8 +354,8 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "Failed to reply on ADDBA_REQ as some=
 capability is not ready(%d, %d)\n", ieee->current_network.qos_data.active=
, ieee->pHTInfo->bCurrentHTSupport);
 		goto OnADDBAReq_Fail;
 	}
-	// Search for related traffic stream.
-	// If there is no matched TS, reject the ADDBA request.
+	/* Search for related traffic stream. */
+	/* If there is no matched TS, reject the ADDBA request. */
 	if (!GetTs(
 			ieee,
 			(struct ts_common_info **)(&pTS),
@@ -366,23 +368,23 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 		goto OnADDBAReq_Fail;
 	}
 	pBA =3D &pTS->rx_admitted_ba_record;
-	// To Determine the ADDBA Req content
-	// We can do much more check here, including buffer_size, AMSDU_Support,=
 Policy, StartSeqCtrl...
-	// I want to check StartSeqCtrl to make sure when we start aggregation!!=
!
-	//
+	/*
+	 * To Determine the ADDBA Req content
+	 * We can do much more check here, including buffer_size, AMSDU_Support,=
 Policy, StartSeqCtrl...
+	 * I want to check StartSeqCtrl to make sure when we start aggregation!!=
!
+	 */
 	if (pBaParamSet->field.ba_policy =3D=3D BA_POLICY_DELAYED) {
 		rc =3D ADDBA_STATUS_INVALID_PARAM;
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "BA Policy is not correct in %s()\n",=
 __func__);
 		goto OnADDBAReq_Fail;
 	}
-		// Admit the ADDBA Request
-	//
+		/* Admit the ADDBA Request */
 	DeActivateBAEntry(ieee, pBA);
 	pBA->dialog_token =3D *pDialogToken;
 	pBA->param_set =3D *pBaParamSet;
 	pBA->timeout_value =3D *pBaTimeoutVal;
 	pBA->start_seq_ctrl =3D *pBaStartSeqCtrl;
-	//for half N mode we only aggregate 1 frame
+	/* for half N mode we only aggregate 1 frame */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pBA->param_set.field.buffer_size =3D 1;
 	else
@@ -390,7 +392,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 	ActivateBAEntry(ieee, pBA, pBA->timeout_value);
 	ieee80211_send_ADDBARsp(ieee, dst, pBA, ADDBA_STATUS_SUCCESS);

-	// End of procedure.
+	/* End of procedure. */
 	return 0;

 OnADDBAReq_Fail:
@@ -401,7 +403,7 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 		BA.dialog_token =3D *pDialogToken;
 		BA.param_set.field.ba_policy =3D BA_POLICY_IMMEDIATE;
 		ieee80211_send_ADDBARsp(ieee, dst, &BA, rc);
-		return 0; //we send RSP out.
+		return 0; /* we send RSP out. */
 	}

 }
@@ -438,8 +440,10 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *ie=
ee, struct sk_buff *skb)
 	pBaParamSet =3D (union ba_param_set *)(tag + 5);
 	pBaTimeoutVal =3D (u16 *)(tag + 7);

-	// Check the capability
-	// Since we can always receive A-MPDU, we just check if it is under HT m=
ode.
+	/*
+	 * Check the capability
+	 * Since we can always receive A-MPDU, we just check if it is under HT m=
ode.
+	 */
 	if (ieee->current_network.qos_data.active =3D=3D 0  ||
 	    !ieee->pHTInfo->bCurrentHTSupport ||
 	    !ieee->pHTInfo->bCurrentAMPDUEnable) {
@@ -449,10 +453,10 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 	}


-	//
-	// Search for related TS.
-	// If there is no TS found, we wil reject ADDBA Rsp by sending DELBA fra=
me.
-	//
+	/*
+	 * Search for related TS.
+	 * If there is no TS found, we wil reject ADDBA Rsp by sending DELBA fra=
me.
+	 */
 	if (!GetTs(
 			ieee,
 			(struct ts_common_info **)(&pTS),
@@ -470,12 +474,12 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 	pAdmittedBA =3D &pTS->tx_admitted_ba_record;


-	//
-	// Check if related BA is waiting for setup.
-	// If not, reject by sending DELBA frame.
-	//
+	/*
+	 * Check if related BA is waiting for setup.
+	 * If not, reject by sending DELBA frame.
+	 */
 	if (pAdmittedBA->valid) {
-		// Since BA is already setup, we ignore all other ADDBA Response.
+		/* Since BA is already setup, we ignore all other ADDBA Response. */
 		IEEE80211_DEBUG(IEEE80211_DL_BA, "OnADDBARsp(): Recv ADDBA Rsp. Drop be=
cause already admit it! \n");
 		return -1;
 	} else if ((!pPendingBA->valid) || (*pDialogToken !=3D pPendingBA->dialo=
g_token)) {
@@ -489,13 +493,13 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *i=
eee, struct sk_buff *skb)


 	if (*pStatusCode =3D=3D ADDBA_STATUS_SUCCESS) {
-		//
-		// Determine ADDBA Rsp content here.
-		// We can compare the value of BA parameter set that Peer returned and =
Self sent.
-		// If it is OK, then admitted. Or we can send DELBA to cancel BA mechan=
ism.
-		//
+		/*
+		 * Determine ADDBA Rsp content here.
+		 * We can compare the value of BA parameter set that Peer returned and =
Self sent.
+		 * If it is OK, then admitted. Or we can send DELBA to cancel BA mechan=
ism.
+		 */
 		if (pBaParamSet->field.ba_policy =3D=3D BA_POLICY_DELAYED) {
-			// Since this is a kind of ADDBA failed, we delay next ADDBA process.
+			/* Since this is a kind of ADDBA failed, we delay next ADDBA process. =
*/
 			pTS->add_ba_req_delayed =3D true;
 			DeActivateBAEntry(ieee, pAdmittedBA);
 			ReasonCode =3D DELBA_REASON_END_BA;
@@ -503,9 +507,9 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *iee=
e, struct sk_buff *skb)
 		}


-		//
-		// Admitted condition
-		//
+		/*
+		 * Admitted condition
+		 */
 		pAdmittedBA->dialog_token =3D *pDialogToken;
 		pAdmittedBA->timeout_value =3D *pBaTimeoutVal;
 		pAdmittedBA->start_seq_ctrl =3D pPendingBA->start_seq_ctrl;
@@ -513,11 +517,11 @@ int ieee80211_rx_ADDBARsp(struct ieee80211_device *i=
eee, struct sk_buff *skb)
 		DeActivateBAEntry(ieee, pAdmittedBA);
 		ActivateBAEntry(ieee, pAdmittedBA, *pBaTimeoutVal);
 	} else {
-		// Delay next ADDBA process.
+		/* Delay next ADDBA process. */
 		pTS->add_ba_req_delayed =3D true;
 	}

-	// End of procedure
+	/* End of procedure */
 	return 0;

 OnADDBARsp_Reject:
@@ -600,9 +604,9 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, =
struct sk_buff *skb)
 	return 0;
 }

-//
-// ADDBA initiate. This can only be called by TX side.
-//
+/*
+ * ADDBA initiate. This can only be called by TX side.
+ */
 void
 TsInitAddBA(
 	struct ieee80211_device *ieee,
@@ -616,17 +620,17 @@ TsInitAddBA(
 	if (pBA->valid && !bOverwritePending)
 		return;

-	// Set parameters to "Pending" variable set
+	/* Set parameters to "Pending" variable set */
 	DeActivateBAEntry(ieee, pBA);

-	pBA->dialog_token++;						// DialogToken: Only keep the latest dialog to=
ken
-	pBA->param_set.field.amsdu_support =3D 0;	// Do not support A-MSDU with =
A-MPDU now!!
-	pBA->param_set.field.ba_policy =3D Policy;	// Policy: Delayed or Immedia=
te
-	pBA->param_set.field.tid =3D pTS->ts_common_info.t_spec.ts_info.uc_tsid;=
	// TID
-	// buffer_size: This need to be set according to A-MPDU vector
-	pBA->param_set.field.buffer_size =3D 32;		// buffer_size: This need to b=
e set according to A-MPDU vector
-	pBA->timeout_value =3D 0;					// Timeout value: Set 0 to disable Timer
-	pBA->start_seq_ctrl.field.seq_num =3D (pTS->tx_cur_seq + 3) % 4096;	// B=
lock Ack will start after 3 packets later.
+	pBA->dialog_token++;						/* DialogToken: Only keep the latest dialog to=
ken */
+	pBA->param_set.field.amsdu_support =3D 0;	/* Do not support A-MSDU with =
A-MPDU now!! */
+	pBA->param_set.field.ba_policy =3D Policy;	/* Policy: Delayed or Immedia=
te */
+	pBA->param_set.field.tid =3D pTS->ts_common_info.t_spec.ts_info.uc_tsid;=
	/* TID */
+	/* buffer_size: This need to be set according to A-MPDU vector */
+	pBA->param_set.field.buffer_size =3D 32;		/* buffer_size: This need to b=
e set according to A-MPDU vector */
+	pBA->timeout_value =3D 0;					/* Timeout value: Set 0 to disable Timer *=
/
+	pBA->start_seq_ctrl.field.seq_num =3D (pTS->tx_cur_seq + 3) % 4096;	/* B=
lock Ack will start after 3 packets later. */

 	ActivateBAEntry(ieee, pBA, BA_SETUP_TIMEOUT);

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/sta=
ging/rtl8192u/ieee80211/rtl819x_HT.h
index b7769bca9740..5691de03e740 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -38,7 +38,7 @@ enum ht_extension_chan_offset {
 };

 struct ht_capability_ele {
-	//HT capability info
+	/* HT capability info */
 	u8	AdvCoding:1;
 	u8	ChlWidth:1;
 	u8	MimoPwrSave:2;
@@ -54,21 +54,21 @@ struct ht_capability_ele {
 	u8	Rsvd1:1;
 	u8	LSigTxopProtect:1;

-	//MAC HT parameters info
+	/* MAC HT parameters info */
 	u8	MaxRxAMPDUFactor:2;
 	u8	MPDUDensity:3;
 	u8	Rsvd2:3;

-	//Supported MCS set
+	/* Supported MCS set */
 	u8	MCS[16];

-	//Extended HT Capability Info
+	/* Extended HT Capability Info */
 	u16	ExtHTCapInfo;

-	//TXBF Capabilities
+	/* TXBF Capabilities */
 	u8	TxBFCap[4];

-	//Antenna Selection Capabilities
+	/* Antenna Selection Capabilities */
 	u8	ASCap;

 } __packed;
@@ -124,49 +124,49 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u8				bEnableHT;
 	u8				bCurrentHTSupport;

-	u8				bRegBW40MHz;				// Tx 40MHz channel capability
-	u8				bCurBW40MHz;				// Tx 40MHz channel capability
+	u8				bRegBW40MHz;				/* Tx 40MHz channel capability */
+	u8				bCurBW40MHz;				/* Tx 40MHz channel capability */

-	u8				bRegShortGI40MHz;			// Tx Short GI for 40Mhz
-	u8				bCurShortGI40MHz;			// Tx Short GI for 40MHz
+	u8				bRegShortGI40MHz;			/* Tx Short GI for 40Mhz */
+	u8				bCurShortGI40MHz;			/* Tx Short GI for 40MHz */

-	u8				bRegShortGI20MHz;			// Tx Short GI for 20MHz
-	u8				bCurShortGI20MHz;			// Tx Short GI for 20MHz
+	u8				bRegShortGI20MHz;			/* Tx Short GI for 20MHz */
+	u8				bCurShortGI20MHz;			/* Tx Short GI for 20MHz */

-	u8				bRegSuppCCK;				// Tx CCK rate capability
-	u8				bCurSuppCCK;				// Tx CCK rate capability
+	u8				bRegSuppCCK;				/* Tx CCK rate capability */
+	u8				bCurSuppCCK;				/* Tx CCK rate capability */

-	// 802.11n spec version for "peer"
+	/* 802.11n spec version for "peer" */
 	HT_SPEC_VER			ePeerHTSpecVer;

-	// HT related information for "Self"
-	struct ht_capability_ele	SelfHTCap;		// This is HT cap element sent to p=
eer STA, which also indicate HT Rx capabilities.
-	HT_INFORMATION_ELE	SelfHTInfo;		// This is HT info element sent to peer =
STA, which also indicate HT Rx capabilities.
+	/* HT related information for "Self" */
+	struct ht_capability_ele	SelfHTCap;		/* This is HT cap element sent to p=
eer STA, which also indicate HT Rx capabilities. */
+	HT_INFORMATION_ELE	SelfHTInfo;		/* This is HT info element sent to peer =
STA, which also indicate HT Rx capabilities. */

-	// HT related information for "Peer"
+	/* HT related information for "Peer" */
 	u8				PeerHTCapBuf[32];
 	u8				PeerHTInfoBuf[32];

-	// A-MSDU related
-	u8				bAMSDU_Support;			// This indicates Tx A-MSDU capability
-	u16				nAMSDU_MaxSize;			// This indicates Tx A-MSDU capability
-	u8				bCurrent_AMSDU_Support;	// This indicates Tx A-MSDU capability
-	u16				nCurrent_AMSDU_MaxSize;	// This indicates Tx A-MSDU capability
-
-	// AMPDU  related <2006.08.10 Emily>
-	u8				bAMPDUEnable;				// This indicate Tx A-MPDU capability
-	u8				bCurrentAMPDUEnable;		// This indicate Tx A-MPDU capability
-	u8				AMPDU_Factor;				// This indicate Tx A-MPDU capability
-	u8				CurrentAMPDUFactor;		// This indicate Tx A-MPDU capability
-	u8				MPDU_Density;				// This indicate Tx A-MPDU capability
-	u8				CurrentMPDUDensity;			// This indicate Tx A-MPDU capability
-
-	// Forced A-MPDU enable
+	/* A-MSDU related */
+	u8				bAMSDU_Support;			/* This indicates Tx A-MSDU capability */
+	u16				nAMSDU_MaxSize;			/* This indicates Tx A-MSDU capability */
+	u8				bCurrent_AMSDU_Support;	/* This indicates Tx A-MSDU capability */
+	u16				nCurrent_AMSDU_MaxSize;	/* This indicates Tx A-MSDU capability */
+
+	/* AMPDU  related <2006.08.10 Emily> */
+	u8				bAMPDUEnable;				/* This indicate Tx A-MPDU capability */
+	u8				bCurrentAMPDUEnable;		/* This indicate Tx A-MPDU capability */
+	u8				AMPDU_Factor;				/* This indicate Tx A-MPDU capability */
+	u8				CurrentAMPDUFactor;		/* This indicate Tx A-MPDU capability */
+	u8				MPDU_Density;				/* This indicate Tx A-MPDU capability */
+	u8				CurrentMPDUDensity;			/* This indicate Tx A-MPDU capability */
+
+	/* Forced A-MPDU enable */
 	HT_AGGRE_MODE_E	ForcedAMPDUMode;
 	u8				ForcedAMPDUFactor;
 	u8				ForcedMPDUDensity;

-	// Forced A-MSDU enable
+	/* Forced A-MSDU enable */
 	HT_AGGRE_MODE_E	ForcedAMSDUMode;
 	u16				ForcedAMSDUMaxSize;

@@ -174,27 +174,27 @@ typedef struct _RT_HIGH_THROUGHPUT {

 	u8				CurrentOpMode;

-	// MIMO PS related
+	/* MIMO PS related */
 	u8				SelfMimoPs;
 	u8				PeerMimoPs;

-	// 40MHz Channel Offset settings.
+	/* 40MHz Channel Offset settings. */
 	enum ht_extension_chan_offset	CurSTAExtChnlOffset;
-	u8				bCurTxBW40MHz;	// If we use 40 MHz to Tx
+	u8				bCurTxBW40MHz;	/* If we use 40 MHz to Tx */
 	u8				PeerBandwidth;

-	// For Bandwidth Switching
+	/* For Bandwidth Switching */
 	u8				bSwBwInProgress;
 	u8				SwBwStep;
 	//struct timer_list		SwBwTimer;  //moved to ieee80211_device. as timer_l=
ist need include some header file here.

-	// For Realtek proprietary A-MPDU factor for aggregation
+	/* For Realtek proprietary A-MPDU factor for aggregation */
 	u8				bRegRT2RTAggregation;
 	u8				bCurrentRT2RTAggregation;
 	u8				bCurrentRT2RTLongSlotTime;
 	u8				szRT2RTAggBuffer[10];

-	// Rx Reorder control
+	/* Rx Reorder control */
 	u8				bRegRxReorderEnable;
 	u8				bCurRxReorderEnable;
 	u8				RxReorderWinSize;
@@ -211,10 +211,10 @@ typedef struct _RT_HIGH_THROUGHPUT {
 	u8				UsbRxFwAggrTimeout;
 #endif

-	// Add for Broadcom(Linksys) IOT. Joseph
+	/* Add for Broadcom(Linksys) IOT. Joseph */
 	u8				bIsPeerBcm;

-	// For IOT issue.
+	/* For IOT issue. */
 	u8				IOTPeer;
 	u32				IOTAction;
 } __attribute__ ((packed)) RT_HIGH_THROUGHPUT, *PRT_HIGH_THROUGHPUT;
@@ -226,7 +226,7 @@ typedef struct _RT_HIGH_THROUGHPUT {
 typedef struct _BSS_HT {
 	u8				bdSupportHT;

-	// HT related elements
+	/* HT related elements */
 	u8					bdHTCapBuf[32];
 	u16					bdHTCapLen;
 	u8					bdHTInfoBuf[32];
@@ -258,9 +258,9 @@ extern u8 MCS_FILTER_1SS[16];
 						(LegacyRate) :\
 						(PICK_RATE(LegacyRate, HTRate))

-// MCS Bw 40 {1~7, 12~15,32}
+/* MCS Bw 40 {1~7, 12~15,32} */
 #define	RATE_ADPT_1SS_MASK		0xFF
-#define	RATE_ADPT_2SS_MASK		0xF0 //Skip MCS8~11 because mcs7 > mcs6, 9, 1=
0, 11. 2007.01.16 by Emily
+#define	RATE_ADPT_2SS_MASK		0xF0 /* Skip MCS8~11 because mcs7 > mcs6, 9, =
10, 11. 2007.01.16 by Emily */
 #define	RATE_ADPT_MCS32_MASK		0x01

 #define		IS_11N_MCS_RATE(rate)		(rate & 0x80)
@@ -300,4 +300,4 @@ typedef enum _HT_IOT_ACTION {
 	HT_IOT_ACT_FORCED_CTS2SELF =3D 0x00000200,
 }HT_IOT_ACTION_E, *PHT_IOT_ACTION_E;

-#endif //_RTL819XU_HTTYPE_H_
+#endif /* _RTL819XU_HTTYPE_H_ */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index c73a8058cf87..4359d6f5735c 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -15,29 +15,29 @@ u16 MCS_DATA_RATE[2][2][77] =3D {
 		 39, 78, 117, 234, 312, 351, 390, 52, 104, 156, 208, 312, 416, 468, 520=
,
 		 0, 78, 104, 130, 117, 156, 195, 104, 130, 130, 156, 182, 182, 208, 156=
, 195,
 		 195, 234, 273, 273, 312, 130, 156, 181, 156, 181, 208, 234, 208, 234, =
260, 260,
-		 286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			//=
 Long GI, 20MHz
+		 286, 195, 234, 273, 234, 273, 312, 351, 312, 351, 390, 390, 429},			/*=
 Long GI, 20MHz */
 		{14, 29, 43, 58, 87, 116, 130, 144, 29, 58, 87, 116, 173, 231, 260, 289=
,
 		 43, 87, 130, 173, 260, 347, 390, 433, 58, 116, 173, 231, 347, 462, 520=
, 578,
 		 0, 87, 116, 144, 130, 173, 217, 116, 144, 144, 173, 202, 202, 231, 173=
, 217,
 		 217, 260, 303, 303, 347, 144, 173, 202, 173, 202, 231, 260, 231, 260, =
289, 289,
-		 318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		/=
/ Short GI, 20MHz
+		 318, 217, 260, 303, 260, 303, 347, 390, 347, 390, 433, 433, 477}	},		/=
* Short GI, 20MHz */
 	{	{27, 54, 81, 108, 162, 216, 243, 270, 54, 108, 162, 216, 324, 432, 486=
, 540,
 		 81, 162, 243, 324, 486, 648, 729, 810, 108, 216, 324, 432, 648, 864, 9=
72, 1080,
 		 12, 162, 216, 270, 243, 324, 405, 216, 270, 270, 324, 378, 378, 432, 3=
24, 405,
 		 405, 486, 567, 567, 648, 270, 324, 378, 324, 378, 432, 486, 432, 486, =
540, 540,
-		 594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	// L=
ong GI, 40MHz
+		 594, 405, 486, 567, 486, 567, 648, 729, 648, 729, 810, 810, 891},	/* L=
ong GI, 40MHz */
 		{30, 60, 90, 120, 180, 240, 270, 300, 60, 120, 180, 240, 360, 480, 540,=
 600,
 		 90, 180, 270, 360, 540, 720, 810, 900, 120, 240, 360, 480, 720, 960, 1=
080, 1200,
 		 13, 180, 240, 300, 270, 360, 450, 240, 300, 300, 360, 420, 420, 480, 3=
60, 450,
 		 450, 540, 630, 630, 720, 300, 360, 420, 360, 420, 480, 540, 480, 540, =
600, 600,
-		 660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	// =
Short GI, 40MHz
+		 660, 450, 540, 630, 540, 630, 720, 810, 720, 810, 900, 900, 990}	}	/* =
Short GI, 40MHz */
 };

 static u8 UNKNOWN_BORADCOM[3] =3D {0x00, 0x14, 0xbf};
 static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] =3D {0x00, 0x1a, 0x70};
 static u8 LINKSYSWRT350_LINKSYSWRT150_BROADCOM[3] =3D {0x00, 0x1d, 0x7e};
 static u8 NETGEAR834Bv2_BROADCOM[3] =3D {0x00, 0x1b, 0x2f};
-static u8 BELKINF5D8233V1_RALINK[3] =3D {0x00, 0x17, 0x3f};	//cosa 032020=
08
+static u8 BELKINF5D8233V1_RALINK[3] =3D {0x00, 0x17, 0x3f};	/* cosa 03202=
008 */
 static u8 BELKINF5D82334V3_RALINK[3] =3D {0x00, 0x1c, 0xdf};
 static u8 PCI_RALINK[3] =3D {0x00, 0x90, 0xcc};
 static u8 EDIMAX_RALINK[3] =3D {0x00, 0x0e, 0x2e};
@@ -63,47 +63,47 @@ void HTUpdateDefaultSetting(struct ieee80211_device *i=
eee)

 	//printk("pHTinfo:%p, &pHTinfo:%p, mptr:%p,  offsetof:%x\n", pHTInfo, &p=
HTInfo, __mptr, offsetof(struct ieee80211_device, pHTInfo));
 	//printk("=3D=3D=3D>ieee:%p,\n", ieee);
-	// ShortGI support
+	/* ShortGI support */
 	pHTInfo->bRegShortGI20MHz =3D 1;
 	pHTInfo->bRegShortGI40MHz =3D 1;

-	// 40MHz channel support
+	/* 40MHz channel support */
 	pHTInfo->bRegBW40MHz =3D 1;

-	// CCK rate support in 40MHz channel
+	/* CCK rate support in 40MHz channel */
 	if (pHTInfo->bRegBW40MHz)
 		pHTInfo->bRegSuppCCK =3D 1;
 	else
 		pHTInfo->bRegSuppCCK =3D true;

-	// AMSDU related
+	/* AMSDU related */
 	pHTInfo->nAMSDU_MaxSize =3D 7935UL;
 	pHTInfo->bAMSDU_Support =3D 0;

-	// AMPDU related
+	/* AMPDU related */
 	pHTInfo->bAMPDUEnable =3D 1;
-	pHTInfo->AMPDU_Factor =3D 2; //// 0: 2n13(8K), 1:2n14(16K), 2:2n15(32K),=
 3:2n16(64k)
-	pHTInfo->MPDU_Density =3D 0;// 0: No restriction, 1: 1/8usec, 2: 1/4usec=
, 3: 1/2usec, 4: 1usec, 5: 2usec, 6: 4usec, 7:8usec
+	pHTInfo->AMPDU_Factor =3D 2; /* // 0: 2n13(8K), 1:2n14(16K), 2:2n15(32K)=
, 3:2n16(64k) */
+	pHTInfo->MPDU_Density =3D 0;/* 0: No restriction, 1: 1/8usec, 2: 1/4usec=
, 3: 1/2usec, 4: 1usec, 5: 2usec, 6: 4usec, 7:8usec */

-	// MIMO Power Save
-	pHTInfo->SelfMimoPs =3D 3;// 0: Static Mimo Ps, 1: Dynamic Mimo Ps, 3: N=
o Limitation, 2: Reserved(Set to 3 automatically.)
+	/* MIMO Power Save */
+	pHTInfo->SelfMimoPs =3D 3;/* 0: Static Mimo Ps, 1: Dynamic Mimo Ps, 3: N=
o Limitation, 2: Reserved(Set to 3 automatically.) */
 	if (pHTInfo->SelfMimoPs =3D=3D 2)
 		pHTInfo->SelfMimoPs =3D 3;
-	// 8190 only. Assign rate operation mode to firmware
+	/* 8190 only. Assign rate operation mode to firmware */
 	ieee->bTxDisableRateFallBack =3D 0;
 	ieee->bTxUseDriverAssingedRate =3D 0;

 #ifdef	TO_DO_LIST
-	// 8190 only. Assign duration operation mode to firmware
+	/* 8190 only. Assign duration operation mode to firmware */
 	pMgntInfo->bTxEnableFwCalcDur =3D (BOOLEAN)pNdisCommon->bRegTxEnableFwCa=
lcDur;
 #endif
 	/*
 	 * 8190 only, Realtek proprietary aggregation mode
 	 * Set MPDUDensity=3D2,   1: Set MPDUDensity=3D2(32k)  for Realtek AP an=
d set MPDUDensity=3D0(8k) for others
 	 */
-	pHTInfo->bRegRT2RTAggregation =3D 1;//0: Set MPDUDensity=3D2,   1: Set M=
PDUDensity=3D2(32k)  for Realtek AP and set MPDUDensity=3D0(8k) for others
+	pHTInfo->bRegRT2RTAggregation =3D 1;/* 0: Set MPDUDensity=3D2,   1: Set =
MPDUDensity=3D2(32k)  for Realtek AP and set MPDUDensity=3D0(8k) for other=
s */

-	// For Rx Reorder Control
+	/* For Rx Reorder Control */
 	pHTInfo->bRegRxReorderEnable =3D 1;
 	pHTInfo->RxReorderWinSize =3D 64;
 	pHTInfo->RxReorderPendingTime =3D 30;
@@ -115,7 +115,7 @@ void HTUpdateDefaultSetting(struct ieee80211_device *i=
eee)
 	pHTInfo->UsbRxFwAggrEn =3D 1;
 	pHTInfo->UsbRxFwAggrPageNum =3D 24;
 	pHTInfo->UsbRxFwAggrPacketNum =3D 8;
-	pHTInfo->UsbRxFwAggrTimeout =3D 16; ////usb rx FW aggregation timeout th=
reshold.It's in units of 64us
+	pHTInfo->UsbRxFwAggrTimeout =3D 16; /* usb rx FW aggregation timeout thr=
eshold.It's in units of 64us */
 #endif
 }

@@ -130,11 +130,11 @@ void HTUpdateDefaultSetting(struct ieee80211_device =
*ieee)
  */
 void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 {
-	static u8	          EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};	// For 1=
1n EWC definition, 2007.07.17, by Emily
+	static u8	          EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};	/* For 1=
1n EWC definition, 2007.07.17, by Emily */
 	struct ht_capability_ele *pCapELE;

 	if (!memcmp(CapIE, EWC11NHTCap, sizeof(EWC11NHTCap))) {
-		//EWC IE
+		/* EWC IE */
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pCapELE =3D (struct ht_capability_ele *)(&CapIE[4]);
 	} else {
@@ -165,11 +165,11 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
  */
 void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 {
-	static u8	EWC11NHTInfo[] =3D {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC de=
finition, 2007.07.17, by Emily
+	static u8	EWC11NHTInfo[] =3D {0x00, 0x90, 0x4c, 0x34};	/* For 11n EWC de=
finition, 2007.07.17, by Emily */
 	PHT_INFORMATION_ELE		pHTInfoEle;

 	if (!memcmp(InfoIE, EWC11NHTInfo, sizeof(EWC11NHTInfo))) {
-		// Not EWC IE
+		/* Not EWC IE */
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pHTInfoEle =3D (PHT_INFORMATION_ELE)(&InfoIE[4]);
 	} else {
@@ -366,14 +366,14 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_=
device *ieee)
 	bool retValue =3D false;

 #ifdef TODO
-	// Apply for 819u only
+	/* Apply for 819u only */
 #if (HAL_CODE_BASE =3D=3D RTL8192)

 #if (DEV_BUS_TYPE =3D=3D USB_INTERFACE)
-	// Alway disable MCS15 by Jerry Chang's request.by Emily, 2008.04.15
+	/* Alway disable MCS15 by Jerry Chang's request.by Emily, 2008.04.15 */
 	retValue =3D true;
 #elif (DEV_BUS_TYPE =3D=3D PCI_INTERFACE)
-	// Enable MCS15 if the peer is Cisco AP. by Emily, 2008.05.12
+	/* Enable MCS15 if the peer is Cisco AP. by Emily, 2008.05.12 */
 //	if(pBssDesc->bCiscoCapExist)
 //		retValue =3D false;
 //	else
@@ -381,7 +381,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_de=
vice *ieee)
 #endif
 #endif
 #endif
-	// Jerry Chang suggest that 8190 1x2 does not need to disable MCS15
+	/* Jerry Chang suggest that 8190 1x2 does not need to disable MCS15 */

 	return retValue;
 }
@@ -403,7 +403,7 @@ static bool HTIOTActIsDisableMCSTwoSpatialStream(struc=
t ieee80211_device *ieee,
 						 u8 *PeerMacAddr)
 {
 #ifdef TODO
-	// Apply for 819u only
+	/* Apply for 819u only */
 #endif
 	return false;
 }
@@ -433,8 +433,8 @@ static u8 HTIOTActIsMgntUseCCK6M(struct ieee80211_netw=
ork *network)
 {
 	u8	retValue =3D 0;

-	// 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for bro=
adcom AP.
-	// 2008/01/28 MH We must prevent that we select null bssid to link.
+	/* 2008/01/25 MH Judeg if we need to use OFDM to sned MGNT frame for bro=
adcom AP. */
+	/* 2008/01/28 MH We must prevent that we select null bssid to link. */

 	if (network->broadcom_cap_exist)
 		retValue =3D 1;
@@ -484,7 +484,7 @@ void HTConstructCapabilityElement(struct ieee80211_dev=
ice *ieee, u8 *posHTCap, u
 	}
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer =3D=3D HT_SPEC_VER_EWC) {
-		u8	EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definitio=
n, 2007.07.17, by Emily
+		u8	EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};	/* For 11n EWC definitio=
n, 2007.07.17, by Emily */

 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE =3D (struct ht_capability_ele *)&posHTCap[4];
@@ -492,8 +492,8 @@ void HTConstructCapabilityElement(struct ieee80211_dev=
ice *ieee, u8 *posHTCap, u
 		pCapELE =3D (struct ht_capability_ele *)posHTCap;
 	}

-	//HT capability info
-	pCapELE->AdvCoding		=3D 0; // This feature is not supported now!!
+	/* HT capability info */
+	pCapELE->AdvCoding		=3D 0; /* This feature is not supported now!! */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth =3D 0;
 	else
@@ -501,18 +501,18 @@ void HTConstructCapabilityElement(struct ieee80211_d=
evice *ieee, u8 *posHTCap, u

 //	pCapELE->ChlWidth		=3D (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		=3D pHT->SelfMimoPs;
-	pCapELE->GreenField		=3D 0; // This feature is not supported now!!
-	pCapELE->ShortGI20Mhz		=3D 1; // We can receive Short GI!!
-	pCapELE->ShortGI40Mhz		=3D 1; // We can receive Short GI!!
+	pCapELE->GreenField		=3D 0; /* This feature is not supported now!! */
+	pCapELE->ShortGI20Mhz		=3D 1; /* We can receive Short GI!! */
+	pCapELE->ShortGI40Mhz		=3D 1; /* We can receive Short GI!! */
 	//DbgPrint("TX HT cap/info ele BW=3D%d SG20=3D%d SG40=3D%d\n\r",
 	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			=3D 1;
 	pCapELE->RxSTBC			=3D 0;
-	pCapELE->DelayBA		=3D 0;	// Do not support now!!
+	pCapELE->DelayBA		=3D 0;	/* Do not support now!! */
 	pCapELE->MaxAMSDUSize	        =3D (MAX_RECEIVE_BUFFER_SIZE >=3D 7935) ? =
1 : 0;
 	pCapELE->DssCCk			=3D ((pHT->bRegBW40MHz) ? (pHT->bRegSuppCCK ? 1 : 0) :=
 0);
-	pCapELE->PSMP			=3D 0; // Do not support now!!
-	pCapELE->LSigTxopProtect	=3D 0; // Do not support now!!
+	pCapELE->PSMP			=3D 0; /* Do not support now!! */
+	pCapELE->LSigTxopProtect	=3D 0; /* Do not support now!! */

 	/*
 	 * MAC HT parameters info
@@ -521,14 +521,14 @@ void HTConstructCapabilityElement(struct ieee80211_d=
evice *ieee, u8 *posHTCap, u
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "TX HT cap/info ele BW=3D%d MaxAMSDUSiz=
e:%d DssCCk:%d\n", pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssC=
Ck);

 	if (IsEncrypt) {
-		pCapELE->MPDUDensity	=3D 7; // 8us
-		pCapELE->MaxRxAMPDUFactor =3D 2; // 2 is for 32 K and 3 is 64K
+		pCapELE->MPDUDensity	=3D 7; /* 8us */
+		pCapELE->MaxRxAMPDUFactor =3D 2; /* 2 is for 32 K and 3 is 64K */
 	} else {
-		pCapELE->MaxRxAMPDUFactor =3D 3; // 2 is for 32 K and 3 is 64K
-		pCapELE->MPDUDensity	=3D 0; // no density
+		pCapELE->MaxRxAMPDUFactor =3D 3; /* 2 is for 32 K and 3 is 64K */
+		pCapELE->MPDUDensity	=3D 0; /* no density */
 	}

-	//Supported MCS set
+	/* Supported MCS set */
 	memcpy(pCapELE->MCS, ieee->Regdot11HTOperationalRateSet, 16);
 	if (pHT->IOTAction & HT_IOT_ACT_DISABLE_MCS15)
 		pCapELE->MCS[1] &=3D 0x7f;
@@ -550,15 +550,15 @@ void HTConstructCapabilityElement(struct ieee80211_d=
evice *ieee, u8 *posHTCap, u
 			pCapELE->MCS[i] =3D 0;
 	}

-	//Extended HT Capability Info
+	/* Extended HT Capability Info */
 	memset(&pCapELE->ExtHTCapInfo, 0, 2);

-	//TXBF Capabilities
+	/* TXBF Capabilities */
 	memset(pCapELE->TxBFCap, 0, 4);

-	//Antenna Selection Capabilities
+	/* Antenna Selection Capabilities */
 	pCapELE->ASCap =3D 0;
-//add 2 to give space for element ID and len when construct frames
+/* add 2 to give space for element ID and len when construct frames */
 	if (pHT->ePeerHTSpecVer =3D=3D HT_SPEC_VER_EWC)
 		*len =3D 30 + 2;
 	else
@@ -597,7 +597,7 @@ void HTConstructInfoElement(struct ieee80211_device *i=
eee, u8 *posHTInfo, u8 *le
 	}

 	memset(posHTInfo, 0, *len);
-	if ((ieee->iw_mode =3D=3D IW_MODE_ADHOC) || (ieee->iw_mode =3D=3D IW_MOD=
E_MASTER)) { //ap mode is not currently supported
+	if ((ieee->iw_mode =3D=3D IW_MODE_ADHOC) || (ieee->iw_mode =3D=3D IW_MOD=
E_MASTER)) { /* ap mode is not currently supported */
 		pHTInfoEle->ControlChl			=3D ieee->current_network.channel;
 		pHTInfoEle->ExtChlOffset		=3D ((!pHT->bRegBW40MHz) ? HT_EXTCHNL_OFFSET_=
NO_EXT :
 											(ieee->current_network.channel <=3D 6) ?
@@ -616,9 +616,9 @@ void HTConstructInfoElement(struct ieee80211_device *i=
eee, u8 *posHTInfo, u8 *le

 		memset(pHTInfoEle->BasicMSC, 0, 16);

-		*len =3D 22 + 2; //same above
+		*len =3D 22 + 2; /* same above */
 	} else {
-		//STA should not generate High Throughput Information Element
+		/* STA should not generate High Throughput Information Element */
 		*len =3D 0;
 	}
 	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTInfo, *=
len - 2);
@@ -688,7 +688,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_devic=
e *ieee, u8 *posRT2RTAgg,
 	}
 	*/
 #else
-	// Do Nothing
+	/* Do Nothing */
 #endif

 	posRT2RTAgg->Length =3D 6;
@@ -715,25 +715,25 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ie=
ee, u8 *pOperateMCS)
 	case IEEE_A:
 	case IEEE_B:
 	case IEEE_G:
-		//legacy rate routine handled at selectedrate
+		/* legacy rate routine handled at selectedrate */

-		//no MCS rate
+		/* no MCS rate */
 		memset(pOperateMCS, 0, 16);
 		break;

-	case IEEE_N_24G:	//assume CCK rate ok
+	case IEEE_N_24G:	/* assume CCK rate ok */
 	case IEEE_N_5G:
-		// Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G.
-		// Legacy part shall be handled at SelectRateSet().
+		/* Legacy part we only use 6, 5.5,2,1 for N_24G and 6 for N_5G. */
+		/* Legacy part shall be handled at SelectRateSet(). */

-		//HT part
-		// TODO: may be different if we have different number of antenna
-		pOperateMCS[0] &=3D RATE_ADPT_1SS_MASK;	//support MCS 0~7
+		/* HT part */
+		/* TODO: may be different if we have different number of antenna */
+		pOperateMCS[0] &=3D RATE_ADPT_1SS_MASK;	/* support MCS 0~7 */
 		pOperateMCS[1] &=3D RATE_ADPT_2SS_MASK;
 		pOperateMCS[3] &=3D RATE_ADPT_MCS32_MASK;
 		break;

-	//should never reach here
+	/* should never reach here */
 	default:
 		break;
 	}
@@ -811,11 +811,11 @@ static u8 HTFilterMCSRate(struct ieee80211_device *i=
eee, u8 *pSupportMCS,
 {
 	u8 i =3D 0;

-	// filter out operational rate set not supported by AP, the length of it=
 is 16
+	/* filter out operational rate set not supported by AP, the length of it=
 is 16 */
 	for (i =3D 0; i <=3D 15; i++)
 		pOperateMCS[i] =3D ieee->Regdot11HTOperationalRateSet[i] & pSupportMCS[=
i];

-	// TODO: adjust our operational rate set  according to our channel bandw=
idth, STBC and Antenna number
+	/* TODO: adjust our operational rate set  according to our channel bandw=
idth, STBC and Antenna number */
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
@@ -823,7 +823,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *iee=
e, u8 *pSupportMCS,
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);

-	// For RTL819X, if pairwisekey =3D wep/tkip, we support only MCS0~7.
+	/* For RTL819X, if pairwisekey =3D wep/tkip, we support only MCS0~7. */
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pOperateMCS[1] =3D 0;

@@ -845,8 +845,8 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	u16	nMaxAMSDUSize =3D 0;
 	u8	*pMcsFilter =3D NULL;

-	static u8				EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};		// For 11n EWC=
 definition, 2007.07.17, by Emily
-	static u8				EWC11NHTInfo[] =3D {0x00, 0x90, 0x4c, 0x34};	// For 11n EWC=
 definition, 2007.07.17, by Emily
+	static u8				EWC11NHTCap[] =3D {0x00, 0x90, 0x4c, 0x33};		/* For 11n EWC=
 definition, 2007.07.17, by Emily */
+	static u8				EWC11NHTInfo[] =3D {0x00, 0x90, 0x4c, 0x34};	/* For 11n EWC=
 definition, 2007.07.17, by Emily */

 	if (!pHTInfo->bCurrentHTSupport) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,
@@ -860,7 +860,6 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)

 //	HTDebugHTCapability(pHTInfo->PeerHTCapBuf,"HTOnAssocRsp_wq");
 //	HTDebugHTInfo(pHTInfo->PeerHTInfoBuf,"HTOnAssocRsp_wq");
-	//
 	if (!memcmp(pHTInfo->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
 		pPeerHTCap =3D (struct ht_capability_ele *)(&pHTInfo->PeerHTCapBuf[4]);
 	else
@@ -871,13 +870,12 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pPeerHTInfo =3D (PHT_INFORMATION_ELE)(pHTInfo->PeerHTInfoBuf);

-	////////////////////////////////////////////////////////
-	// Configurations:
-	////////////////////////////////////////////////////////
+	/*
+	 * Configurations:
+	 */
 	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, si=
zeof(struct ht_capability_ele));
 //	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, s=
izeof(HT_INFORMATION_ELE));
 	// Config Supported Channel Width setting
-	//
 	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), =
(enum ht_extension_chan_offset)(pPeerHTInfo->ExtChlOffset));

 	pHTInfo->bCurTxBW40MHz =3D (pPeerHTInfo->RecommemdedTxWidth =3D=3D 1);
@@ -927,7 +925,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * By Emily
 	 */
 	if (!pHTInfo->bRegRT2RTAggregation) {
-		// Decide AMPDU Factor according to protocol handshake
+		/* Decide AMPDU Factor according to protocol handshake */
 		if (pHTInfo->AMPDU_Factor > pPeerHTCap->MaxRxAMPDUFactor)
 			pHTInfo->CurrentAMPDUFactor =3D pPeerHTCap->MaxRxAMPDUFactor;
 		else
@@ -939,7 +937,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		 */
 		if (ieee->current_network.bssht.bdRT2RTAggregation) {
 			if (ieee->pairwise_key_type !=3D KEY_TYPE_NA)
-				// Realtek may set 32k in security mode and 64k for others
+				/* Realtek may set 32k in security mode and 64k for others */
 				pHTInfo->CurrentAMPDUFactor =3D pPeerHTCap->MaxRxAMPDUFactor;
 			else
 				pHTInfo->CurrentAMPDUFactor =3D HT_AGG_SIZE_64K;
@@ -960,10 +958,10 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pHTInfo->CurrentMPDUDensity =3D pPeerHTCap->MPDUDensity;
 	if (ieee->pairwise_key_type !=3D KEY_TYPE_NA)
-		pHTInfo->CurrentMPDUDensity	=3D 7; // 8us
-	// Force TX AMSDU
+		pHTInfo->CurrentMPDUDensity	=3D 7; /* 8us */
+	/* Force TX AMSDU */

-	// Lanhsin: mark for tmp to avoid deauth by ap from  s3
+	/* Lanhsin: mark for tmp to avoid deauth by ap from  s3 */
 	//if(memcmp(pMgntInfo->Bssid, NETGEAR834Bv2_BROADCOM, 3)=3D=3D0)
 	if (0) {
 		pHTInfo->bCurrentAMPDUEnable =3D false;
@@ -973,7 +971,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pHTInfo->IOTAction |=3D  HT_IOT_ACT_TX_USE_AMSDU_8K;
 	}

-	// Rx Reorder Setting
+	/* Rx Reorder Setting */
 	pHTInfo->bCurRxReorderEnable =3D pHTInfo->bRegRxReorderEnable;

 	/*
@@ -1000,7 +998,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		pMcsFilter =3D MCS_FILTER_1SS;
 	else
 		pMcsFilter =3D MCS_FILTER_ALL;
-	//WB add for MCS8 bug
+	/* WB add for MCS8 bug */
 //	pMcsFilter =3D MCS_FILTER_1SS;
 	ieee->HTHighestOperaRate =3D HTGetHighestMCSRate(ieee, ieee->dot11HTOper=
ationalRateSet, pMcsFilter);
 	ieee->HTCurrentOperaRate =3D ieee->HTHighestOperaRate;
@@ -1020,7 +1018,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
  *                                  *  (1) MPInitialization Phase
  *                                  *  (2) Receiving of Deauthentication =
from AP
  */
-// TODO: Should this funciton be called when receiving of Disassociation?
+/* TODO: Should this funciton be called when receiving of Disassociation?=
 */
 void HTInitializeHTInfo(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo =3D ieee->pHTInfo;
@@ -1031,11 +1029,11 @@ void HTInitializeHTInfo(struct ieee80211_device *i=
eee)
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>%s()=
\n", __func__);
 	pHTInfo->bCurrentHTSupport =3D false;

-	// 40MHz channel support
+	/* 40MHz channel support */
 	pHTInfo->bCurBW40MHz =3D false;
 	pHTInfo->bCurTxBW40MHz =3D false;

-	// Short GI support
+	/* Short GI support */
 	pHTInfo->bCurShortGI20MHz =3D false;
 	pHTInfo->bCurShortGI40MHz =3D false;
 	pHTInfo->bForcedShortGI =3D false;
@@ -1048,15 +1046,15 @@ void HTInitializeHTInfo(struct ieee80211_device *i=
eee)
 	 */
 	pHTInfo->bCurSuppCCK =3D true;

-	// AMSDU related
+	/* AMSDU related */
 	pHTInfo->bCurrent_AMSDU_Support =3D false;
 	pHTInfo->nCurrent_AMSDU_MaxSize =3D pHTInfo->nAMSDU_MaxSize;

-	// AMPUD related
+	/* AMPUD related */
 	pHTInfo->CurrentMPDUDensity =3D pHTInfo->MPDU_Density;
 	pHTInfo->CurrentAMPDUFactor =3D pHTInfo->AMPDU_Factor;

-	// Initialize all of the parameters related to 11n
+	/* Initialize all of the parameters related to 11n */
 	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap));
 	memset(&pHTInfo->SelfHTInfo, 0, sizeof(pHTInfo->SelfHTInfo));
 	memset(&pHTInfo->PeerHTCapBuf, 0, sizeof(pHTInfo->PeerHTCapBuf));
@@ -1064,22 +1062,22 @@ void HTInitializeHTInfo(struct ieee80211_device *i=
eee)

 	pHTInfo->bSwBwInProgress =3D false;

-	// Set default IEEE spec for Draft N
+	/* Set default IEEE spec for Draft N */
 	pHTInfo->ePeerHTSpecVer =3D HT_SPEC_VER_IEEE;

-	// Realtek proprietary aggregation mode
+	/* Realtek proprietary aggregation mode */
 	pHTInfo->bCurrentRT2RTAggregation =3D false;
 	pHTInfo->bCurrentRT2RTLongSlotTime =3D false;
 	pHTInfo->IOTPeer =3D 0;
 	pHTInfo->IOTAction =3D 0;

-	//MCS rate initialized here
+	/* MCS rate initialized here */
 	{
 		u8 *RegHTSuppRateSets =3D &ieee->RegHTSuppRateSet[0];

-		RegHTSuppRateSets[0] =3D 0xFF;	//support MCS 0~7
-		RegHTSuppRateSets[1] =3D 0xFF;	//support MCS 8~15
-		RegHTSuppRateSets[4] =3D 0x01;	//support MCS 32
+		RegHTSuppRateSets[0] =3D 0xFF;	/* support MCS 0~7 */
+		RegHTSuppRateSets[1] =3D 0xFF;	/* support MCS 8~15 */
+		RegHTSuppRateSets[4] =3D 0x01;	/* support MCS 32 */
 	}
 }

@@ -1122,9 +1120,9 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_=
device *ieee,	struct ieee802
 //	u8*	pMcsFilter;
 	u8	bIOTAction =3D 0;

-	//
-	//  Save Peer Setting before Association
-	//
+	/*
+	 *  Save Peer Setting before Association
+	 */
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D>%s()\n", __func__);
 	/*unmark bEnableHT flag here is the same reason why unmarked in function=
 ieee80211_softmac_new_net. WB 2008.09.10*/
 //	if( pHTInfo->bEnableHT &&  pNetwork->bssht.bdSupportHT)
@@ -1132,14 +1130,14 @@ void HTResetSelfAndSavePeerSetting(struct ieee8021=
1_device *ieee,	struct ieee802
 		pHTInfo->bCurrentHTSupport =3D true;
 		pHTInfo->ePeerHTSpecVer =3D pNetwork->bssht.bdHTSpecVer;

-		// Save HTCap and HTInfo information Element
+		/* Save HTCap and HTInfo information Element */
 		if (pNetwork->bssht.bdHTCapLen > 0 &&	pNetwork->bssht.bdHTCapLen <=3D s=
izeof(pHTInfo->PeerHTCapBuf))
 			memcpy(pHTInfo->PeerHTCapBuf, pNetwork->bssht.bdHTCapBuf, pNetwork->bs=
sht.bdHTCapLen);

 		if (pNetwork->bssht.bdHTInfoLen > 0 && pNetwork->bssht.bdHTInfoLen <=3D=
 sizeof(pHTInfo->PeerHTInfoBuf))
 			memcpy(pHTInfo->PeerHTInfoBuf, pNetwork->bssht.bdHTInfoBuf, pNetwork->=
bssht.bdHTInfoLen);

-		// Check whether RT to RT aggregation mode is enabled
+		/* Check whether RT to RT aggregation mode is enabled */
 		if (pHTInfo->bRegRT2RTAggregation) {
 			pHTInfo->bCurrentRT2RTAggregation =3D pNetwork->bssht.bdRT2RTAggregati=
on;
 			pHTInfo->bCurrentRT2RTLongSlotTime =3D pNetwork->bssht.bdRT2RTLongSlot=
Time;
@@ -1148,7 +1146,7 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_=
device *ieee,	struct ieee802
 			pHTInfo->bCurrentRT2RTLongSlotTime =3D false;
 		}

-		// Determine the IOT Peer Vendor.
+		/* Determine the IOT Peer Vendor. */
 		HTIOTPeerDetermine(ieee);

 		/*
@@ -1261,7 +1259,7 @@ void HTSetConnectBwMode(struct ieee80211_device *iee=
e, enum ht_channel_width Ban
 	if (!pHTInfo->bRegBW40MHz)
 		return;

-	// To reduce dummy operation
+	/* To reduce dummy operation */
 //	if((pHTInfo->bCurBW40MHz=3D=3Dfalse && Bandwidth=3D=3DHT_CHANNEL_WIDTH=
_20) ||
 //	   (pHTInfo->bCurBW40MHz=3D=3Dtrue && Bandwidth=3D=3DHT_CHANNEL_WIDTH_=
20_40 && Offset=3D=3DpHTInfo->CurSTAExtChnlOffset))
 //		return;
@@ -1271,9 +1269,9 @@ void HTSetConnectBwMode(struct ieee80211_device *iee=
e, enum ht_channel_width Ban
 //		spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
 		return;
 	}
-	//if in half N mode, set to 20M bandwidth please 09.08.2008 WB.
+	/* if in half N mode, set to 20M bandwidth please 09.08.2008 WB. */
 	if (Bandwidth =3D=3D HT_CHANNEL_WIDTH_20_40 && (!ieee->GetHalfNmodeSuppo=
rtByAPsHandler(ieee->dev))) {
-			// Handle Illegal extension channel offset!!
+			/* Handle Illegal extension channel offset!! */
 		if (ieee->current_network.channel < 2 && Offset =3D=3D HT_EXTCHNL_OFFSE=
T_LOWER)
 			Offset =3D HT_EXTCHNL_OFFSET_NO_EXT;
 		if (Offset =3D=3D HT_EXTCHNL_OFFSET_UPPER || Offset =3D=3D HT_EXTCHNL_O=
FFSET_LOWER) {
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/st=
aging/rtl8192u/ieee80211/rtl819x_Qos.h
index 3052f53d2e7e..44418a284fe9 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -19,10 +19,10 @@ struct aci_aifsn {
  * Ref: WMM spec 2.2.11: WME TSPEC Element, p.18.
  */
 enum direction_value {
-	DIR_UP			=3D 0,		// 0x00	// UpLink
-	DIR_DOWN		=3D 1,		// 0x01	// DownLink
-	DIR_DIRECT		=3D 2,		// 0x10	// DirectLink
-	DIR_BI_DIR		=3D 3,		// 0x11	// Bi-Direction
+	DIR_UP			=3D 0,		/* 0x00 UpLink */
+	DIR_DOWN		=3D 1,		/* 0x01	DownLink */
+	DIR_DIRECT		=3D 2,		/* 0x10	DirectLink */
+	DIR_BI_DIR		=3D 3,		/* 0x11	Bi-Direction */
 };

 /*
@@ -33,15 +33,15 @@ enum direction_value {
  * Note: sizeof 3 Bytes
  */
 struct qos_tsinfo {
-	u16		uc_traffic_type:1;	        //WMM is reserved
+	u16		uc_traffic_type:1;	        /* WMM is reserved */
 	u16		uc_tsid:4;
 	u16		uc_direction:2;
-	u16		uc_access_policy:2;	        //WMM: bit8=3D0, bit7=3D1
-	u16		uc_aggregation:1;	        //WMM is reserved
-	u16		uc_psb:1;		        //WMMSA is APSD
+	u16		uc_access_policy:2;	        /* WMM: bit8=3D0, bit7=3D1 */
+	u16		uc_aggregation:1;	        /* WMM is reserved */
+	u16		uc_psb:1;		        /* WMMSA is APSD */
 	u16		uc_up:3;
-	u16		uc_ts_info_ack_policy:2;	//WMM is reserved
-	u8		uc_schedule:1;		        //WMM is reserved
+	u16		uc_ts_info_ack_policy:2;	/* WMM is reserved */
+	u8		uc_schedule:1;		        /* WMM is reserved */
 	u8:7;
 };

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 7cac668bfb0b..469d6ab3dc8e 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -6,15 +6,15 @@

 static void TsSetupTimeOut(struct timer_list *unused)
 {
-	// Not implement yet
-	// This is used for WMMSA and ACM , that would send ADDTSReq frame.
+	/* Not implement yet */
+	/* This is used for WMMSA and ACM , that would send ADDTSReq frame. */
 }

 static void TsInactTimeout(struct timer_list *unused)
 {
-	// Not implement yet
-	// This is used for WMMSA and ACM.
-	// This function would be call when TS is no Tx/Rx for some period of ti=
me.
+	/* Not implement yet */
+	/* This is used for WMMSA and ACM. */
+	/* This function would be call when TS is no Tx/Rx for some period of ti=
me. */
 }

 /************************************************************************=
********************************************
@@ -38,7 +38,7 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
 	IEEE80211_DEBUG(IEEE80211_DL_REORDER, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D>%s()\n", __func__);
 	if (pRxTs->rx_timeout_indicate_seq !=3D 0xffff) {
-		// Indicate the pending packets sequentially according to SeqNum until =
meet the gap.
+		/* Indicate the pending packets sequentially according to SeqNum until =
meet the gap. */
 		while (!list_empty(&pRxTs->rx_pending_pkt_list)) {
 			pReorderEntry =3D list_entry(pRxTs->rx_pending_pkt_list.prev, struct r=
x_reorder_entry, List);
 			if (index =3D=3D 0)
@@ -64,10 +64,10 @@ static void RxPktPendingTimeout(struct timer_list *t)
 	}

 	if (index > 0) {
-		// Set rx_timeout_indicate_seq to 0xffff to indicate no pending packets=
 in buffer now.
+		/* Set rx_timeout_indicate_seq to 0xffff to indicate no pending packets=
 in buffer now. */
 		pRxTs->rx_timeout_indicate_seq =3D 0xffff;

-		// Indicate packets
+		/* Indicate packets */
 		if (index > REORDER_WIN_SIZE) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx Reord=
er buffer full!! \n");
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
@@ -117,16 +117,16 @@ static void ResetTxTsEntry(struct tx_ts_record *pTS)
 	pTS->add_ba_req_in_progress =3D false;
 	pTS->add_ba_req_delayed =3D false;
 	pTS->using_ba =3D false;
-	ResetBaEntry(&pTS->tx_admitted_ba_record); //For BA Originator
+	ResetBaEntry(&pTS->tx_admitted_ba_record); /* For BA Originator */
 	ResetBaEntry(&pTS->tx_pending_ba_record);
 }

 static void ResetRxTsEntry(struct rx_ts_record *pTS)
 {
 	ResetTsCommonInfo(&pTS->ts_common_info);
-	pTS->rx_indicate_seq =3D 0xffff; // This indicate the rx_indicate_seq is=
 not used now!!
-	pTS->rx_timeout_indicate_seq =3D 0xffff; // This indicate the rx_timeout=
_indicate_seq is not used now!!
-	ResetBaEntry(&pTS->rx_admitted_ba_record);	  // For BA Recipient
+	pTS->rx_indicate_seq =3D 0xffff; /* This indicate the rx_indicate_seq is=
 not used now!! */
+	pTS->rx_timeout_indicate_seq =3D 0xffff; /* This indicate the rx_timeout=
_indicate_seq is not used now!! */
+	ResetBaEntry(&pTS->rx_admitted_ba_record);	  /* For BA Recipient */
 }

 void TSInitialize(struct ieee80211_device *ieee)
@@ -136,16 +136,15 @@ void TSInitialize(struct ieee80211_device *ieee)
 	struct rx_reorder_entry	*pRxReorderEntry =3D ieee->RxReorderEntry;
 	u8				count =3D 0;
 	IEEE80211_DEBUG(IEEE80211_DL_TS, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>%s()\n"=
, __func__);
-	// Initialize Tx TS related info.
+	/* Initialize Tx TS related info. */
 	INIT_LIST_HEAD(&ieee->Tx_TS_Admit_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Tx_TS_Unused_List);

 	for (count =3D 0; count < TOTAL_TS_NUM; count++) {
-		//
 		pTxTS->num =3D count;
-		// The timers for the operation of Traffic Stream and Block Ack.
-		// DLS related timer will be add here in the future!!
+		/* The timers for the operation of Traffic Stream and Block Ack. */
+		/* DLS related timer will be add here in the future!! */
 		timer_setup(&pTxTS->ts_common_info.setup_timer, TsSetupTimeOut,
 			    0);
 		timer_setup(&pTxTS->ts_common_info.inact_timer, TsInactTimeout,
@@ -160,7 +159,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		pTxTS++;
 	}

-	// Initialize Rx TS related info.
+	/* Initialize Rx TS related info. */
 	INIT_LIST_HEAD(&ieee->Rx_TS_Admit_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Pending_List);
 	INIT_LIST_HEAD(&ieee->Rx_TS_Unused_List);
@@ -178,7 +177,7 @@ void TSInitialize(struct ieee80211_device *ieee)
 		list_add_tail(&pRxTS->ts_common_info.list, &ieee->Rx_TS_Unused_List);
 		pRxTS++;
 	}
-	// Initialize unused Rx Reorder List.
+	/* Initialize unused Rx Reorder List. */
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
 //#ifdef TO_DO_LIST
 	for (count =3D 0; count < REORDER_ENTRY_NUM; count++) {
@@ -209,9 +208,9 @@ static struct ts_common_info *SearchAdmitTRStream(stru=
ct ieee80211_device *ieee,
 	//DIRECTION_VALUE	dir;
 	u8	dir;
 	bool				search_dir[4] =3D {0};
-	struct list_head		*psearch_list; //FIXME
+	struct list_head		*psearch_list; /* FIXME */
 	struct ts_common_info	*pRet =3D NULL;
-	if (ieee->iw_mode =3D=3D IW_MODE_MASTER) { //ap mode
+	if (ieee->iw_mode =3D=3D IW_MODE_MASTER) { /* ap mode */
 		if (TxRxSelect =3D=3D TX_DIR) {
 			search_dir[DIR_DOWN] =3D true;
 			search_dir[DIR_BI_DIR] =3D true;
@@ -291,15 +290,15 @@ bool GetTs(
 	struct ts_common_info		**ppTS,
 	u8				*Addr,
 	u8				TID,
-	enum tr_select			TxRxSelect,  //Rx:1, Tx:0
+	enum tr_select			TxRxSelect,  /* Rx:1, Tx:0 */
 	bool				bAddNewTs
 	)
 {
 	u8	UP =3D 0;
-	//
-	// We do not build any TS for Broadcast or Multicast stream.
-	// So reject these kinds of search here.
-	//
+	/*
+	 * We do not build any TS for Broadcast or Multicast stream.
+	 * So reject these kinds of search here.
+	 */
 	if (is_multicast_ether_addr(Addr)) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "get TS for Broadcast or Multicast\n"=
);
 		return false;
@@ -308,7 +307,7 @@ bool GetTs(
 	if (ieee->current_network.qos_data.supported =3D=3D 0) {
 		UP =3D 0;
 	} else {
-		// In WMM case: we use 4 TID only
+		/* In WMM case: we use 4 TID only */
 		if (!is_ac_valid(TID)) {
 			IEEE80211_DEBUG(IEEE80211_DL_ERR, " in %s(), TID(%d) is not valid\n", =
__func__, TID);
 			return false;
@@ -349,11 +348,11 @@ bool GetTs(
 			IEEE80211_DEBUG(IEEE80211_DL_TS, "add new TS failed(tid:%d)\n", UP);
 			return false;
 		} else {
-			//
-			// Create a new Traffic stream for current Tx/Rx
-			// This is for EDCA and WMM to add a new TS.
-			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
-			//
+			/*
+			 * Create a new Traffic stream for current Tx/Rx
+			 * This is for EDCA and WMM to add a new TS.
+			 * For HCCA or WMMSA, TS cannot be addmit without negotiation.
+			 */
 			struct tspec_body	TSpec;
 			struct qos_tsinfo	*pTSInfo =3D &TSpec.ts_info;
 			struct list_head	*pUnusedList =3D
@@ -382,21 +381,21 @@ bool GetTs(
 				}

 				IEEE80211_DEBUG(IEEE80211_DL_TS, "to init current TS, UP:%d, Dir:%d, =
addr:%pM\n", UP, Dir, Addr);
-				// Prepare TS Info releated field
-				pTSInfo->uc_traffic_type =3D 0;		// Traffic type: WMM is reserved in =
this field
-				pTSInfo->uc_tsid =3D UP;			// TSID
-				pTSInfo->uc_direction =3D Dir;		// Direction: if there is DirectLink,=
 this need additional consideration.
-				pTSInfo->uc_access_policy =3D 1;		// Access policy
-				pTSInfo->uc_aggregation =3D 0;		// Aggregation
-				pTSInfo->uc_psb =3D 0;			// Aggregation
-				pTSInfo->uc_up =3D UP;			// User priority
-				pTSInfo->uc_ts_info_ack_policy =3D 0;	// Ack policy
-				pTSInfo->uc_schedule =3D 0;		// Schedule
+				/* Prepare TS Info releated field */
+				pTSInfo->uc_traffic_type =3D 0;		/* Traffic type: WMM is reserved in =
this field */
+				pTSInfo->uc_tsid =3D UP;			/* TSID */
+				pTSInfo->uc_direction =3D Dir;		/* Direction: if there is DirectLink,=
 this need additional consideration. */
+				pTSInfo->uc_access_policy =3D 1;		/* Access policy */
+				pTSInfo->uc_aggregation =3D 0;		/* Aggregation */
+				pTSInfo->uc_psb =3D 0;			/* Aggregation */
+				pTSInfo->uc_up =3D UP;			/* User priority */
+				pTSInfo->uc_ts_info_ack_policy =3D 0;	/* Ack policy */
+				pTSInfo->uc_schedule =3D 0;		/* Schedule */

 				MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
 				AdmitTS(ieee, *ppTS, 0);
 				list_add_tail(&((*ppTS)->list), pAddmitList);
-				// if there is DirectLink, we need to do additional operation here!!
+				/* if there is DirectLink, we need to do additional operation here!! =
*/

 				return true;
 			} else {
@@ -530,7 +529,7 @@ void TsStartAddBaProcess(struct ieee80211_device *ieee=
, struct tx_ts_record *pTx
 				  jiffies + msecs_to_jiffies(TS_ADDBA_DELAY));
 		} else {
 			IEEE80211_DEBUG(IEEE80211_DL_BA, "TsStartAddBaProcess(): Immediately S=
tart ADDBA now!!\n");
-			mod_timer(&pTxTS->ts_add_ba_timer, jiffies+10); //set 10 ticks
+			mod_timer(&pTxTS->ts_add_ba_timer, jiffies+10); /* set 10 ticks */
 		}
 	} else {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s()=3D=3D>BA timer is already added=
\n", __func__);
diff --git a/drivers/staging/rtl8192u/r8180_93cx6.c b/drivers/staging/rtl8=
192u/r8180_93cx6.c
index de83daa0c9ed..e76f1b2ea2e0 100644
=2D-- a/drivers/staging/rtl8192u/r8180_93cx6.c
+++ b/drivers/staging/rtl8192u/r8180_93cx6.c
@@ -154,7 +154,8 @@ int eprom_read(struct net_device *dev, u32 addr)
 	eprom_w(dev, 0);

 	for (i =3D 0; i < 16; i++) {
-		/* eeprom needs a clk cycle between writing opcode&adr
+		/*
+		 * eeprom needs a clk cycle between writing opcode&adr
 		 * and reading data. (eeprom outs a dummy 0)
 		 */
 		eprom_ck_cycle(dev);
diff --git a/drivers/staging/rtl8192u/r8180_93cx6.h b/drivers/staging/rtl8=
192u/r8180_93cx6.h
index 0cdd00a4f7b8..3dc3cdb2194e 100644
=2D-- a/drivers/staging/rtl8192u/r8180_93cx6.h
+++ b/drivers/staging/rtl8192u/r8180_93cx6.h
@@ -14,8 +14,8 @@
  *	project Authors.
  */

-/*This files contains card eeprom (93c46 or 93c56) programming routines*/
-/*memory is addressed by WORDS*/
+/* This files contains card eeprom (93c46 or 93c56) programming routines =
*/
+/* memory is addressed by WORDS */

 #include "r8192U.h"
 #include "r8192U_hw.h"
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rt=
l8192u/r8190_rtl8256.c
index 92de92a3325a..716be24bace6 100644
=2D-- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -19,14 +19,15 @@
  */
 static void phy_rf8256_config_para_file(struct net_device *dev);

-/*-----------------------------------------------------------------------=
---
+/*
+ * ----------------------------------------------------------------------=
----
  * Overview:	set RF band width (20M or 40M)
  * Input:       struct net_device*	dev
  *		WIRELESS_BANDWIDTH_E	Bandwidth	//20M or 40M
  * Output:      NONE
  * Return:      NONE
  * Note:	8226 support both 20M  and 40 MHz
- *-----------------------------------------------------------------------=
---
+ * ----------------------------------------------------------------------=
----
  */
 void phy_set_rf8256_bandwidth(struct net_device *dev, enum ht_channel_wid=
th Bandwidth)
 {
@@ -83,17 +84,19 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, =
enum ht_channel_width Band
 		}
 	}
 }
-/*-----------------------------------------------------------------------=
---
+/*
+ * ----------------------------------------------------------------------=
----
  * Overview:    Interface to config 8256
  * Input:       struct net_device*	dev
  * Output:      NONE
  * Return:      NONE
- *-----------------------------------------------------------------------=
---
+ * ----------------------------------------------------------------------=
----
  */
 void phy_rf8256_config(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
-	/* Initialize general global value
+	/*
+	 * Initialize general global value
 	 *
 	 * TODO: Extend RF_PATH_C and RF_PATH_D in the future
 	 */
@@ -101,12 +104,13 @@ void phy_rf8256_config(struct net_device *dev)
 	/* Config BB and RF */
 	phy_rf8256_config_para_file(dev);
 }
-/*-----------------------------------------------------------------------=
---
+/*
+ * ----------------------------------------------------------------------=
----
  * Overview:    Interface to config 8256
  * Input:       struct net_device*	dev
  * Output:      NONE
  * Return:      NONE
- *-----------------------------------------------------------------------=
---
+ * ----------------------------------------------------------------------=
----
  */
 static void phy_rf8256_config_para_file(struct net_device *dev)
 {
@@ -126,7 +130,8 @@ static void phy_rf8256_config_para_file(struct net_dev=
ice *dev)

 		pPhyReg =3D &priv->PHYRegDef[eRFPath];

-		/* Joseph test for shorten RF config
+		/*
+		 * Joseph test for shorten RF config
 		 * pHalData->RfReg0Value[eRFPath] =3D  rtl8192_phy_QueryRFReg(dev, (enu=
m rf90_radio_path_e)eRFPath, rGlobalCtrl, bMaskDWord);
 		 * ----Store original RFENV control type
 		 */
@@ -153,7 +158,8 @@ static void phy_rf8256_config_para_file(struct net_dev=
ice *dev)

 		rtl8192_phy_SetRFReg(dev, (enum rf90_radio_path_e) eRFPath, 0x0, bMask1=
2Bits, 0xbf);

-		/* Check RF block (for FPGA platform only)----
+		/*
+		 * Check RF block (for FPGA platform only)----
 		 * TODO: this function should be removed on ASIC , Emily 2007.2.2
 		 */
 		if (rtl8192_phy_checkBBAndRF(dev, HW90_BLOCK_RF, (enum rf90_radio_path_=
e)eRFPath)) {
@@ -163,7 +169,7 @@ static void phy_rf8256_config_para_file(struct net_dev=
ice *dev)

 		RetryTimes =3D ConstRetryTimes;
 		RF3_Final_Value =3D 0;
-		/*----Initialize RF fom connfiguration file----*/
+		/* ----Initialize RF fom connfiguration file---- */
 		switch (eRFPath) {
 		case RF90_PATH_A:
 			while (RF3_Final_Value !=3D RegValueToBeCheck && RetryTimes !=3D 0) {
@@ -199,7 +205,7 @@ static void phy_rf8256_config_para_file(struct net_dev=
ice *dev)
 			break;
 		}

-		/*----Restore RFENV control type----*/
+		/* ----Restore RFENV control type---- */
 		switch (eRFPath) {
 		case RF90_PATH_A:
 		case RF90_PATH_C:
@@ -283,8 +289,9 @@ void phy_set_rf8256_ofdm_tx_power(struct net_device *d=
ev, u8 powerlevel)
 		}

 		if (priv->bDynamicTxHighPower) {
-			/*Add by Jacken 2008/03/06
-			 *Emily, 20080613. Set low tx power for both MCS and legacy OFDM
+			/*
+			 * Add by Jacken 2008/03/06
+			 * Emily, 20080613. Set low tx power for both MCS and legacy OFDM
 			 */
 			writeVal =3D 0x03030303;
 		} else {
diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/=
r8192U.h
index ec33fb9122e9..610c23364e58 100644
=2D-- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -570,7 +570,8 @@ typedef struct Stats {
 	long signal_strength;
 	long signal_quality;
 	long last_signal_strength_inpercent;
-	/* Correct smoothed ss in dbm, only used in driver
+	/*
+	 * Correct smoothed ss in dbm, only used in driver
 	 * to report real power now
 	 */
 	long recv_signal_power;
@@ -615,38 +616,46 @@ typedef struct _BB_REGISTER_DEFINITION {
 	u32 rfLSSI_Select;
 	/* Tx gain stage:               0x80c~0x80f [4 bytes]  */
 	u32 rfTxGainStage;
-	/* wire parameter control1:     0x820~0x823, 0x828~0x82b,
+	/*
+	 * wire parameter control1:     0x820~0x823, 0x828~0x82b,
 	 *                              0x830~0x833, 0x838~0x83b [16 bytes]
 	 */
 	u32 rfHSSIPara1;
-	/* wire parameter control2:     0x824~0x827, 0x82c~0x82f,
+	/*
+	 * wire parameter control2:     0x824~0x827, 0x82c~0x82f,
 	 *                              0x834~0x837, 0x83c~0x83f [16 bytes]
 	 */
 	u32 rfHSSIPara2;
 	/* Tx Rx antenna control:       0x858~0x85f [16 bytes] */
 	u32 rfSwitchControl;
-	/* AGC parameter control1:	0xc50~0xc53, 0xc58~0xc5b,
+	/*
+	 * AGC parameter control1:	0xc50~0xc53, 0xc58~0xc5b,
 	 *                              0xc60~0xc63, 0xc68~0xc6b [16 bytes]
 	 */
 	u32 rfAGCControl1;
-	/* AGC parameter control2:      0xc54~0xc57, 0xc5c~0xc5f,
+	/*
+	 * AGC parameter control2:      0xc54~0xc57, 0xc5c~0xc5f,
 	 *                              0xc64~0xc67, 0xc6c~0xc6f [16 bytes]
 	 */
 	u32 rfAGCControl2;
-	/* OFDM Rx IQ imbalance matrix:	0xc14~0xc17, 0xc1c~0xc1f,
+	/*
+	 * OFDM Rx IQ imbalance matrix:	0xc14~0xc17, 0xc1c~0xc1f,
 	 *                              0xc24~0xc27, 0xc2c~0xc2f [16 bytes]
 	 */
 	u32 rfRxIQImbalance;
-	/* Rx IQ DC offset and Rx digital filter, Rx DC notch filter:
+	/*
+	 * Rx IQ DC offset and Rx digital filter, Rx DC notch filter:
 	 *                              0xc10~0xc13, 0xc18~0xc1b,
 	 *                              0xc20~0xc23, 0xc28~0xc2b [16 bytes]
 	 */
 	u32 rfRxAFE;
-	/* OFDM Tx IQ imbalance matrix:	0xc80~0xc83, 0xc88~0xc8b,
+	/*
+	 * OFDM Tx IQ imbalance matrix:	0xc80~0xc83, 0xc88~0xc8b,
 	 *                              0xc90~0xc93, 0xc98~0xc9b [16 bytes]
 	 */
 	u32 rfTxIQImbalance;
-	/* Tx IQ DC Offset and Tx DFIR type:
+	/*
+	 * Tx IQ DC Offset and Tx DFIR type:
 	 *                              0xc84~0xc87, 0xc8c~0xc8f,
 	 *                              0xc94~0xc97, 0xc9c~0xc9f [16 bytes]
 	 */
@@ -733,7 +742,8 @@ typedef struct _phy_ofdm_rx_status_report_819xusb {
 } phy_sts_ofdm_819xusb_t;

 typedef struct _phy_cck_rx_status_report_819xusb {
-	/* For CCK rate descriptor. This is an unsigned 8:1 variable.
+	/*
+	 * For CCK rate descriptor. This is an unsigned 8:1 variable.
 	 * LSB bit presend 0.5. And MSB 7 bts presend a signed value.
 	 * Range from -64~+63.5.
 	 */
@@ -800,12 +810,12 @@ typedef enum _tag_TxCmd_Config_Index {
 } DCMD_TXCMD_OP;

 enum version_819xu {
-	VERSION_819XU_A, // A-cut
-	VERSION_819XU_B, // B-cut
-	VERSION_819XU_C,// C-cut
+	VERSION_819XU_A, /* A-cut */
+	VERSION_819XU_B, /* B-cut */
+	VERSION_819XU_C,/* C-cut */
 };

-//added for different RF type
+/* added for different RF type */
 enum rt_rf_type {
 	RF_1T2R =3D 0,
 	RF_2T4R,
@@ -958,7 +968,8 @@ typedef struct r8192_priv {
 	/* 8190 40MHz mode */
 	/* Control channel sub-carrier */
 	u8	nCur40MhzPrimeSC;
-	/* Test for shorten RF configuration time.
+	/*
+	 * Test for shorten RF configuration time.
 	 * We save RF reg0 in this variable to reduce RF reading.
 	 */
 	u32					RfReg0Value[4];
@@ -977,12 +988,14 @@ typedef struct r8192_priv {
 	bool	bLastDTPFlag_Low;

 	bool	bstore_last_dtpflag;
-	/* Define to discriminate on High power State or
+	/*
+	 * Define to discriminate on High power State or
 	 * on sitesurvey to change Tx gain index
 	 */
 	bool	bstart_txctrl_bydtp;
 	rate_adaptive rate_adaptive;
-	/* TX power tracking
+	/*
+	 * TX power tracking
 	 * OPEN/CLOSE TX POWER TRACKING
 	 */
 	txbbgain_struct txbbgain_table[TxBBGainTableLength];
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8=
192u/r8192U_core.c
index 4065a4710142..410c8a3e56d7 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -194,7 +194,8 @@ static void rtl819x_set_channel_map(u8 channel_plan, s=
truct r8192_priv *priv)
 		break;

 	case COUNTRY_CODE_GLOBAL_DOMAIN:
-		/* this flag enabled to follow 11d country IE setting,
+		/*
+		 * this flag enabled to follow 11d country IE setting,
 		 * otherwise, it shall follow global domain settings.
 		 */
 		GET_DOT11D_INFO(ieee)->dot11d_enabled =3D 0;
@@ -213,7 +214,8 @@ static void rtl819x_set_channel_map(u8 channel_plan, s=
truct r8192_priv *priv)
 static void CamResetAllEntry(struct net_device *dev)
 {
 	u32 ulcommand =3D 0;
-	/* In static WEP, OID_ADD_KEY or OID_ADD_WEP are set before STA
+	/*
+	 * In static WEP, OID_ADD_KEY or OID_ADD_WEP are set before STA
 	 * associate to AP. However, ResetKey is called on
 	 * OID_802_11_INFRASTRUCTURE_MODE and MlmeAssociateRequest. In this
 	 * condition, Cam can not be reset because upper layer will not set
@@ -458,7 +460,8 @@ int read_nic_dword(struct net_device *dev, int indx, u=
32 *data)

 /* u8 read_phy_cck(struct net_device *dev, u8 adr); */
 /* u8 read_phy_ofdm(struct net_device *dev, u8 adr); */
-/* this might still called in what was the PHY rtl8185/rtl8192 common cod=
e
+/*
+ * this might still called in what was the PHY rtl8185/rtl8192 common cod=
e
  * plans are to possibility turn it again in one common code...
  */
 inline void force_pci_posting(struct net_device *dev)
@@ -669,7 +672,8 @@ void rtl8192_update_msr(struct net_device *dev)
 	read_nic_byte(dev, MSR, &msr);
 	msr &=3D ~MSR_LINK_MASK;

-	/* do not change in link_state !=3D WLAN_LINK_ASSOCIATED.
+	/*
+	 * do not change in link_state !=3D WLAN_LINK_ASSOCIATED.
 	 * msr must be updated if the state is ASSOCIATING.
 	 * this is intentional and make sense for ad-hoc and
 	 * master (see the create BSS/IBSS func)
@@ -921,7 +925,8 @@ static void rtl8192_data_hard_resume(struct net_device=
 *dev)
 	/* FIXME !! */
 }

-/* this function TX data frames when the ieee80211 stack requires this.
+/*
+ * this function TX data frames when the ieee80211 stack requires this.
  * It checks also if we need to stop the ieee tx queue, eventually do it
  */
 static void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device=
 *dev,
@@ -946,7 +951,8 @@ static void rtl8192_hard_data_xmit(struct sk_buff *skb=
, struct net_device *dev,
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 }

-/* This is a rough attempt to TX a frame
+/*
+ * This is a rough attempt to TX a frame
  * This is called by the ieee 80211 stack to TX management frames.
  * If the ring is full packet are dropped (for data frame the queue
  * is stopped before this can happen).
@@ -1191,7 +1197,8 @@ static void rtl8192_net_update(struct net_device *de=
v)
 	}
 }

-/* temporary hw beacon is not used any more.
+/*
+ * temporary hw beacon is not used any more.
  * open it when necessary
  */
 void rtl819xusb_beacon_tx(struct net_device *dev, u16  tx_rate)
@@ -1225,9 +1232,10 @@ short rtl819xU_tx_cmd(struct net_device *dev, struc=
t sk_buff *skb)
 	pdesc->OWN =3D 1;
 	pdesc->LINIP =3D tcb_desc->bLastIniPkt;

-	/*---------------------------------------------------------------------
+	/*
+	 * ---------------------------------------------------------------------
 	 * Fill up USB_OUT_CONTEXT.
-	 *---------------------------------------------------------------------
+	 * ---------------------------------------------------------------------
 	 */
 	idx_pipe =3D 0x04;
 	usb_fill_bulk_urb(tx_urb, priv->udev,
@@ -1435,7 +1443,8 @@ short rtl8192_tx(struct net_device *dev, struct sk_b=
uff *skb)
 	unsigned int idx_pipe;

 	pend =3D atomic_read(&priv->tx_pending[tcb_desc->queue_index]);
-	/* we are locked here so the two atomic_read and inc are executed
+	/*
+	 * we are locked here so the two atomic_read and inc are executed
 	 * without interleaves
 	 * !!! For debug purpose
 	 */
@@ -1505,7 +1514,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_b=
uff *skb)
 	tx_desc->Offset =3D  sizeof(struct tx_fwinfo_819x_usb) + 8;
 	tx_desc->PktSize =3D (skb->len - TX_PACKET_SHIFT_BYTES) & 0xffff;

-	/*DWORD 1*/
+	/* DWORD 1 */
 	tx_desc->SecCAMID =3D 0;
 	tx_desc->RATid =3D tcb_desc->RATRIndex;
 	tx_desc->NoEnc =3D 1;
@@ -1538,7 +1547,8 @@ short rtl8192_tx(struct net_device *dev, struct sk_b=
uff *skb)
 	tx_desc->DISFB =3D tcb_desc->bTxDisableRateFallBack;
 	tx_desc->USERATE =3D tcb_desc->bTxUseDriverAssingedRate;

-	/* Fill fields that are required to be initialized in
+	/*
+	 * Fill fields that are required to be initialized in
 	 * all of the descriptors
 	 */
 	/* DWORD 0 */
@@ -1557,7 +1567,8 @@ short rtl8192_tx(struct net_device *dev, struct sk_b=
uff *skb)

 	status =3D usb_submit_urb(tx_urb, GFP_ATOMIC);
 	if (!status) {
-		/* We need to send 0 byte packet whenever
+		/*
+		 * We need to send 0 byte packet whenever
 		 * 512N bytes/64N(HIGN SPEED/NORMAL SPEED) bytes packet has
 		 * been transmitted. Otherwise, it will be halt to wait for
 		 * another packet.
@@ -1721,7 +1732,8 @@ static void rtl8192_link_change(struct net_device *d=
ev)
 	if (ieee->state =3D=3D IEEE80211_LINKED) {
 		rtl8192_net_update(dev);
 		rtl8192_update_ratr_table(dev);
-		/* Add this as in pure N mode, wep encryption will use software
+		/*
+		 * Add this as in pure N mode, wep encryption will use software
 		 * way, but there is no chance to set this as wep will not set
 		 * group key in wext.
 		 */
@@ -1729,7 +1741,7 @@ static void rtl8192_link_change(struct net_device *d=
ev)
 		    ieee->pairwise_key_type =3D=3D KEY_TYPE_WEP104)
 			EnableHWSecurityConfig8192(dev);
 	}
-	/*update timing params*/
+	/* update timing params */
 	if (ieee->iw_mode =3D=3D IW_MODE_INFRA || ieee->iw_mode =3D=3D IW_MODE_A=
DHOC) {
 		u32 reg =3D 0;

@@ -1791,7 +1803,8 @@ static void rtl8192_qos_activate(struct work_struct =
*work)
 		goto success;
 	RT_TRACE(COMP_QOS,
 		 "qos active process with associate response received\n");
-	/* It better set slot time at first
+	/*
+	 * It better set slot time at first
 	 *
 	 * For we just support b/g mode at present, let the slot time at
 	 * 9/20 selection
@@ -1994,7 +2007,8 @@ static bool GetNmodeSupportBySecCfg8192(struct net_d=
evice *dev)
 	int encrypt;

 	crypt =3D ieee->crypt[ieee->tx_keyidx];
-	/* we use connecting AP's capability instead of only security config
+	/*
+	 * we use connecting AP's capability instead of only security config
 	 * on our driver to distinguish whether it should use N mode or G mode
 	 */
 	encrypt =3D (network->capability & WLAN_CAPABILITY_PRIVACY) ||
@@ -2028,7 +2042,8 @@ static bool GetHalfNmodeSupportByAPs819xUsb(struct n=
et_device *dev)
 static void rtl8192_refresh_supportrate(struct r8192_priv *priv)
 {
 	struct ieee80211_device *ieee =3D priv->ieee80211;
-	/* We do not consider set support rate for ABG mode, only
+	/*
+	 * We do not consider set support rate for ABG mode, only
 	 * HT MCS rate is set here.
 	 */
 	if (ieee->mode =3D=3D WIRELESS_MODE_N_24G ||
@@ -2085,7 +2100,8 @@ static void rtl8192_SetWirelessMode(struct net_devic=
e *dev, u8 wireless_mode)
 		}
 	}
 #ifdef TO_DO_LIST
-	/* TODO: this function doesn't work well at this time,
+	/*
+	 * TODO: this function doesn't work well at this time,
 	 * we should wait for FPGA
 	 */
 	ActUpdateChannelAccessSetting(
@@ -2194,21 +2210,25 @@ static void rtl8192_init_priv_variable(struct net_=
device *dev)
 			pHalData->CSMethod |
 			/* accept management/data */
 			RCR_AMF | RCR_ADF |
-			/* accept control frame for SW
+			/*
+			 * accept control frame for SW
 			 * AP needs PS-poll
 			 */
 			RCR_ACF |
 			/* accept BC/MC/UC */
 			RCR_AB | RCR_AM | RCR_APM |
-			/* accept ICV/CRC error
+			/*
+			 * accept ICV/CRC error
 			 * packet
 			 */
 			RCR_AICV | RCR_ACRC32 |
-			/* Max DMA Burst Size per Tx
+			/*
+			 * Max DMA Burst Size per Tx
 			 * DMA Burst, 7: unlimited.
 			 */
 			((u32)7 << RCR_MXDMA_OFFSET) |
-			/* Rx FIFO Threshold,
+			/*
+			 * Rx FIFO Threshold,
 			 * 7: No Rx threshold.
 			 */
 			(pHalData->EarlyRxThreshold << RCR_FIFO_OFFSET) |
@@ -2300,7 +2320,8 @@ static void rtl8192_get_eeprom_size(struct net_devic=
e *dev)
 		 "<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D%s(), epromtype:%d\n", __func__, pr=
iv->epromtype);
 }

-/* used to swap endian. as ntohl & htonl are not necessary
+/*
+ * used to swap endian. as ntohl & htonl are not necessary
  * to swap endian, so use this instead.
  */
 static inline u16 endian_swap(u16 *data)
@@ -2526,7 +2547,8 @@ static int rtl8192_read_eeprom_info(struct net_devic=
e *dev)
 			(priv->EEPROMTxPowerDiff & 0xf0) >> 4;
 		/* CrystalCap, bit12~15 */
 		priv->CrystalCap =3D priv->EEPROMCrystalCap;
-		/* ThermalMeter, bit0~3 for RFIC1, bit4~7 for RFIC2
+		/*
+		 * ThermalMeter, bit0~3 for RFIC1, bit4~7 for RFIC2
 		 * 92U does not enable TX power tracking.
 		 */
 		priv->ThermalMeter[0] =3D priv->EEPROMThermalMeter;
@@ -2567,7 +2589,8 @@ static int rtl8192_read_eeprom_info(struct net_devic=
e *dev)
 	else
 		RT_TRACE(COMP_EPROM, "\n2T4R config\n");

-	/* We can only know RF type in the function. So we have to init
+	/*
+	 * We can only know RF type in the function. So we have to init
 	 * DIG RATR table again.
 	 */
 	init_rate_adaptive(dev);
@@ -2681,7 +2704,8 @@ static void rtl8192_hwconfig(struct net_device *dev)
 		}
 		break;
 	case WIRELESS_MODE_N_24G:
-		/* It support CCK rate by default. CCK rate will be filtered
+		/*
+		 * It support CCK rate by default. CCK rate will be filtered
 		 * out only when associated AP does not support it.
 		 */
 		regBwOpMode =3D BW_OPMODE_20MHZ;
@@ -2855,7 +2879,8 @@ static bool rtl8192_adapter_start(struct net_device =
*dev)
 			RT_TRACE((COMP_INIT | COMP_RF), DBG_LOUD,
 				 ("InitializeAdapter819xUsb(): Turn off RF for RegRfOff ----------\n"=
));
 			MgntActSet_RF_State(Adapter, eRfOff, RF_CHANGE_BY_SW);
-			/* Those actions will be discard in MgntActSet_RF_State
+			/*
+			 * Those actions will be discard in MgntActSet_RF_State
 			 * because of the same state
 			 */
 			for (eRFPath =3D 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
@@ -2881,7 +2906,8 @@ static bool rtl8192_adapter_start(struct net_device =
*dev)
 			MgntActSet_RF_State(Adapter,
 					    eRfOff,
 					    pMgntInfo->RfOffReason);
-			/* Those actions will be discard in MgntActSet_RF_State
+			/*
+			 * Those actions will be discard in MgntActSet_RF_State
 			 * because of the same state
 			 */
 			for (eRFPath =3D 0; eRFPath < pHalData->NumTotalRFPath; eRFPath++)
@@ -2906,7 +2932,7 @@ static bool rtl8192_adapter_start(struct net_device =
*dev)


 	rtl8192_phy_updateInitGain(dev);
-	/*--set CCK and OFDM Block "ON"--*/
+	/* --set CCK and OFDM Block "ON"-- */
 	rtl8192_setBBreg(dev, rFPGA0_RFMOD, bCCKEn, 0x1);
 	rtl8192_setBBreg(dev, rFPGA0_RFMOD, bOFDMEn, 0x1);

@@ -2963,7 +2989,8 @@ static bool rtl8192_adapter_start(struct net_device =
*dev)
 	return init_status;
 }

-/* this configures registers for beacon tx and enables it via
+/*
+ * this configures registers for beacon tx and enables it via
  * rtl8192_beacon_tx_enable(). rtl8192_beacon_tx_disable() might
  * be used to stop beacon transmission
  */
@@ -3038,7 +3065,8 @@ static bool HalRxCheckStuck819xUsb(struct net_device=
 *dev)
 	RT_TRACE(COMP_RESET,
 		 "%s(): RegRxCounter is %d,RxCounter is %d\n", __func__,
 		 RegRxCounter, priv->RxCounter);
-	/* If rssi is small, we should check rx for long time because of bad rx.
+	/*
+	 * If rssi is small, we should check rx for long time because of bad rx.
 	 * or maybe it will continuous silent reset every 2 seconds.
 	 */
 	rx_chk_cnt++;
@@ -3116,7 +3144,8 @@ static RESET_TYPE rtl819x_ifcheck_resetornot(struct =
net_device *dev)
 	TxResetType =3D TxCheckStuck(dev);
 	if (rfState !=3D eRfOff ||
 	    (priv->ieee80211->iw_mode !=3D IW_MODE_ADHOC)) {
-		/* If driver is in the status of firmware download failure,
+		/*
+		 * If driver is in the status of firmware download failure,
 		 * driver skips RF initialization and RF is in turned off
 		 * state. Driver should check whether Rx stuck and do silent
 		 * reset. And if driver is in firmware download failure status,
@@ -3216,7 +3245,8 @@ static void CamRestoreAllEntry(struct net_device *de=
v)
 	}
 }

-/* This function is used to fix Tx/Rx stop bug temporarily.
+/*
+ * This function is used to fix Tx/Rx stop bug temporarily.
  * This function will do "system reset" to NIC when Tx or Rx is stuck.
  * The method checking Tx/Rx stuck of this function is supported by FW,
  * which reports Tx and Rx counter to register 0x128 and 0x130.
@@ -3527,7 +3557,8 @@ int rtl8192_down(struct net_device *dev)
 	for (i =3D 0; i < MAX_QUEUE_SIZE; i++)
 		skb_queue_purge(&priv->ieee80211->skb_drv_aggQ[i]);

-	/* as cancel_delayed_work will del work->timer, so if work is not
+	/*
+	 * as cancel_delayed_work will del work->timer, so if work is not
 	 * defined as struct delayed_work, it will corrupt
 	 */
 	rtl8192_cancel_deferred_work(priv);
@@ -3652,7 +3683,8 @@ static int rtl8192_ioctl(struct net_device *dev, str=
uct ifreq *rq, int cmd)
 				if (ieee->pairwise_key_type) {
 					memcpy((u8 *)key, ipw->u.crypt.key, 16);
 					EnableHWSecurityConfig8192(dev);
-					/* We fill both index entry and 4th
+					/*
+					 * We fill both index entry and 4th
 					 * entry for pairwise key as in IPW
 					 * interface, adhoc will only get here,
 					 * so we need index entry for its
@@ -3873,7 +3905,8 @@ static long rtl819x_translate_todbm(u8 signal_streng=
th_index)
 }


-/* We can not declare RSSI/EVM total value of sliding window to
+/*
+ * We can not declare RSSI/EVM total value of sliding window to
  * be a local static. Otherwise, it may increase when we return from S3/S=
4. The
  * value will be kept in memory or disk. Declare the value in the adaptor
  * and it will be reinitialized when returned from S3/S4.
@@ -3936,7 +3969,8 @@ static void rtl8192_process_phyinfo(struct r8192_pri=
v *priv, u8 *buffer,
 		return;


-	/* only rtl8190 supported
+	/*
+	 * only rtl8190 supported
 	 * rtl8190_process_cck_rxpathsel(priv,pprevious_stats);
 	 */

@@ -3946,7 +3980,8 @@ static void rtl8192_process_phyinfo(struct r8192_pri=
v *priv, u8 *buffer,
 	/* record the general signal strength to the sliding window. */


-	/* <2> Showed on UI for engineering
+	/*
+	 * <2> Showed on UI for engineering
 	 * hardware does not provide rssi information for each rf path in CCK
 	 */
 	if (!pprevious_stats->bIsCCK &&
@@ -4069,7 +4104,8 @@ static void rtl8192_process_phyinfo(struct r8192_pri=
v *priv, u8 *buffer,
 	}
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	rtl819x_query_rxpwrpercentage()
  *
  * Overview:
@@ -4079,7 +4115,7 @@ static void rtl8192_process_phyinfo(struct r8192_pri=
v *priv, u8 *buffer,
  * Output:		NONE
  *
  * Return:		0-100 percentage
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static u8 rtl819x_query_rxpwrpercentage(s8 antpower)
 {
@@ -4208,7 +4244,8 @@ static void rtl8192_query_rxphystatus(struct r8192_p=
riv *priv,
 	if (is_cck_rate) {
 		/* (1)Hardware does not provide RSSI for CCK */

-		/* (2)PWDB, Average PWDB calculated by hardware
+		/*
+		 * (2)PWDB, Average PWDB calculated by hardware
 		 * (for rate adaptive)
 		 */
 		u8 report;
@@ -4309,7 +4346,8 @@ static void rtl8192_query_rxphystatus(struct r8192_p=
riv *priv,
 		}


-		/* (2)PWDB, Average PWDB calculated by hardware
+		/*
+		 * (2)PWDB, Average PWDB calculated by hardware
 		 * (for rate adaptive)
 		 */
 		rx_pwr_all =3D (((pofdm_buf->pwdb_all) >> 1) & 0x7f) - 106;
@@ -4331,7 +4369,8 @@ static void rtl8192_query_rxphystatus(struct r8192_p=
riv *priv,
 			tmp_rxevm =3D	pofdm_buf->rxevm_X[i];
 			rx_evmX =3D (s8)(tmp_rxevm);

-			/* Do not use shift operation like "rx_evmX >>=3D 1"
+			/*
+			 * Do not use shift operation like "rx_evmX >>=3D 1"
 			 * because the compiler of free build environment will
 			 * set the most significant bit to "zero" when doing
 			 * shifting operation which may change a negative value
@@ -4342,7 +4381,8 @@ static void rtl8192_query_rxphystatus(struct r8192_p=
riv *priv,

 			evm =3D rtl819x_evm_dbtopercentage(rx_evmX);
 			if (i =3D=3D 0)
-				/* Fill value in RFD, Get the first spatial
+				/*
+				 * Fill value in RFD, Get the first spatial
 				 * stream only
 				 */
 				pstats->SignalQuality =3D
@@ -4364,7 +4404,8 @@ static void rtl8192_query_rxphystatus(struct r8192_p=
riv *priv,
 			priv->stats.received_bwtype[0]++;
 	}

-	/* UI BSS List signal strength(in percentage), make it good looking,
+	/*
+	 * UI BSS List signal strength(in percentage), make it good looking,
 	 * from 0~100. It is assigned to the BSS List in
 	 * GetValueFromBeaconOrProbeRsp().
 	 */
@@ -4396,7 +4437,8 @@ static void TranslateRxSignalStuff819xUsb(struct sk_=
buff *skb,
 					  struct ieee80211_rx_stats *pstats,
 					  struct rx_drvinfo_819x_usb  *pdrvinfo)
 {
-	/* TODO: We must only check packet for current MAC address.
+	/*
+	 * TODO: We must only check packet for current MAC address.
 	 * Not finish
 	 */
 	struct rtl8192_rx_info *info =3D (struct rtl8192_rx_info *)skb->cb;
@@ -4441,7 +4483,8 @@ static void TranslateRxSignalStuff819xUsb(struct sk_=
buff *skb,
 		priv->stats.numpacket_matchbssid++;
 	if (bpacket_toself)
 		priv->stats.numpacket_toself++;
-	/* Process PHY information for previous packet (RSSI/PWDB/EVM)
+	/*
+	 * Process PHY information for previous packet (RSSI/PWDB/EVM)
 	 * Because phy information is contained in the last packet of AMPDU
 	 * only, so driver should process phy information of previous packet
 	 */
@@ -4616,7 +4659,8 @@ static void query_rxdesc_status(struct sk_buff *skb,
 	if (stats->Length < 24 || stats->Length > MAX_8192U_RX_SIZE)
 		stats->bHwError |=3D 1;
 	/* Get Driver Info */
-	/* TODO: Need to verify it on FGPA platform
+	/*
+	 * TODO: Need to verify it on FGPA platform
 	 * Driver info are written to the RxBuffer following rx desc
 	 */
 	if (stats->RxDrvInfoSize !=3D 0) {
@@ -4633,7 +4677,8 @@ static void query_rxdesc_status(struct sk_buff *skb,
 			ret_rate =3D HwRateToMRate90(driver_info->RxHT,
 						   driver_info->RxRate);
 			if (ret_rate =3D=3D 0xff) {
-				/* Abnormal Case: Receive CRC OK packet with Rx
+				/*
+				 * Abnormal Case: Receive CRC OK packet with Rx
 				 * descriptor indicating non supported rate.
 				 * Special Error Handling here
 				 */
@@ -4744,7 +4789,8 @@ static void rtl819xusb_process_received_packet(
 #endif
 #ifdef ENABLE_PS  /* for adding ps function in future */
 	RT_RF_POWER_STATE rtState;
-	/* When RF is off, we should not count the packet for hw/sw synchronize
+	/*
+	 * When RF is off, we should not count the packet for hw/sw synchronize
 	 * reason, ie. there may be a duration while sw switch is changed and
 	 * hw switch is being changed.
 	 */
@@ -4926,7 +4972,8 @@ static int rtl8192_usb_probe(struct usb_interface *i=
ntf,
 	return ret;
 }

-/* detach all the work and timer structure declared or inititialize
+/*
+ * detach all the work and timer structure declared or inititialize
  * in r8192U_init function.
  */
 static void rtl8192_cancel_deferred_work(struct r8192_priv *priv)
@@ -5023,7 +5070,8 @@ void EnableHWSecurityConfig8192(struct net_device *d=
ev)
 		SECR_value |=3D SCR_RxUseDK;
 		SECR_value |=3D SCR_TxUseDK;
 	}
-	/* add HWSec active enable here.
+	/*
+	 * add HWSec active enable here.
 	 * default using hwsec. when peer AP is in N mode only and
 	 * pairwise_key_type is none_aes(which HT_IOT_ACT_PURE_N_MODE indicates
 	 * it), use software security. when peer AP is in b,g,n mode mixed and
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index 2ba01041406b..b15cf98281dd 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -21,7 +21,7 @@ Major Change History:
 #include "r819xU_phyreg.h"
 #include "r8190_rtl8256.h"
 #include "r819xU_cmdpkt.h"
-/*---------------------------Define Local Constant-----------------------=
----*/
+/* ---------------------------Define Local Constant----------------------=
----- */
 /* Indicate different AP vendor for IOT issue. */
 static u32 edca_setting_DL[HT_IOT_PEER_MAX] =3D {
 	0x5e4322, 0x5e4322, 0x5e4322, 0x604322, 0x00a44f, 0x5ea44f
@@ -32,10 +32,10 @@ static u32 edca_setting_UL[HT_IOT_PEER_MAX] =3D {

 #define RTK_UL_EDCA 0xa44f
 #define RTK_DL_EDCA 0x5e4322
-/*---------------------------Define Local Constant-----------------------=
----*/
+/* ---------------------------Define Local Constant----------------------=
----- */


-/*------------------------Define global variable-------------------------=
----*/
+/* ------------------------Define global variable------------------------=
----- */
 /* Debug variable ? */
 struct dig dm_digtable;
 /* Store current software write register content for MAC PHY. */
@@ -53,11 +53,11 @@ static	void	dm_init_bandwidth_autoswitch(struct net_de=
vice *dev);
 static	void	dm_bandwidth_autoswitch(struct net_device *dev);

 /* DM --> TX power control */
-/*static	void	dm_initialize_txpower_tracking(struct net_device *dev);*/
+/* static	void	dm_initialize_txpower_tracking(struct net_device *dev); */

 static	void	dm_check_txpower_tracking(struct net_device *dev);

-/*static	void	dm_txpower_reset_recovery(struct net_device *dev);*/
+/* static	void	dm_txpower_reset_recovery(struct net_device *dev); */

 /* DM --> Dynamic Init Gain by RSSI */
 static	void	dm_dig_init(struct net_device *dev);
@@ -89,16 +89,16 @@ static void dm_deInit_fsync(struct net_device *dev);
 /* Added by vivi, 20080522 */
 static	void	dm_check_txrateandretrycount(struct net_device *dev);

-/*---------------------Define local function prototype-------------------=
----*/
+/* ---------------------Define local function prototype------------------=
----- */

-/*---------------------Define of Tx Power Control For Near/Far Range ----=
----*/   /*Add by Jacken 2008/02/18 */
+/* ---------------------Define of Tx Power Control For Near/Far Range ---=
----- */   /* Add by Jacken 2008/02/18 */
 static	void	dm_init_dynamic_txpower(struct net_device *dev);
 static	void	dm_dynamic_txpower(struct net_device *dev);

 /* DM --> For rate adaptive and DIG, we must send RSSI to firmware */
 static	void dm_send_rssi_tofw(struct net_device *dev);
 static	void	dm_ctstoself(struct net_device *dev);
-/*---------------------------Define function prototype-------------------=
-----*/
+/* ---------------------------Define function prototype------------------=
------ */
 /*
  * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  *	HW Dynamic mechanism interface.
@@ -121,7 +121,7 @@ void init_hal_dm(struct net_device *dev)
 	/* Initial TX Power Control for near/far range , add by amy 2008/05/15, =
porting from windows code. */
 	dm_init_dynamic_txpower(dev);
 	init_rate_adaptive(dev);
-	/*dm_initialize_txpower_tracking(dev);*/
+	/* dm_initialize_txpower_tracking(dev); */
 	dm_dig_init(dev);
 	dm_init_edca_turbo(dev);
 	dm_init_bandwidth_autoswitch(dev);
@@ -195,11 +195,11 @@ void dm_CheckRxAggregation(struct net_device *dev)

 void hal_dm_watchdog(struct net_device *dev)
 {
-	/*struct r8192_priv *priv =3D ieee80211_priv(dev);*/
+	/* struct r8192_priv *priv =3D ieee80211_priv(dev); */

-	/*static u8	previous_bssid[6] =3D{0};*/
+	/* static u8	previous_bssid[6] =3D{0}; */

-	/*Add by amy 2008/05/15 ,porting from windows code.*/
+	/* Add by amy 2008/05/15 ,porting from windows code. */
 	dm_check_rate_adaptive(dev);
 	dm_dynamic_txpower(dev);
 	dm_check_txrateandretrycount(dev);
@@ -267,7 +267,8 @@ void init_rate_adaptive(struct net_device *dev)

 }	/* InitRateAdaptive */

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_check_rate_adaptive()
  *
  * Overview:
@@ -282,7 +283,8 @@ void init_rate_adaptive(struct net_device *dev)
  *	When		Who		Remark
  *	05/26/08	amy	Create version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_check_rate_adaptive(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
@@ -335,10 +337,13 @@ static void dm_check_rate_adaptive(struct net_device=
 *dev)
 				(pra->ping_rssi_ratr & (~BIT(31))) |
 				((bshort_gi_enabled) ? BIT(31) : 0);

-		/* 2007/10/08 MH We support RA smooth scheme now. When it is the first
-		   time to link with AP. We will not change upper/lower threshold. If
-		   STA stay in high or low level, we must change two different threshol=
d
-		   to prevent jumping frequently. */
+		/*
+		 * 2007/10/08 MH We support RA smooth scheme now. When it is the first
+		 * time to link with AP. We will not change upper/lower threshold. If
+		 * STA stay in high or low level, we must change two different threshol=
d
+		 * to prevent jumping frequently.
+		 *
+		 */
 		if (pra->ratr_state =3D=3D DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA	=3D pra->high2low_rssi_thresh_for_ra;
 			LowRSSIThreshForRA	=3D (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_2=
0) ?
@@ -1601,7 +1606,8 @@ static void dm_bb_initialgain_backup(struct net_devi=
ce *dev)
 }   /* dm_BBInitialGainBakcup */

 #endif
-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_dig_init()
  *
  * Overview:	Set DIG scheme init value.
@@ -1616,7 +1622,8 @@ static void dm_bb_initialgain_backup(struct net_devi=
ce *dev)
  *	When		Who		Remark
  *	05/15/2008	amy		Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_dig_init(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
@@ -1644,7 +1651,8 @@ static void dm_dig_init(struct net_device *dev)

 }	/* dm_dig_init */

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_ctrl_initgain_byrssi()
  *
  * Overview:	Driver must monitor RSSI and notify firmware to change initi=
al
@@ -1660,7 +1668,8 @@ static void dm_dig_init(struct net_device *dev)
  * Revised History:
  *	When		Who		Remark
  *	05/27/2008	amy		Create Version 0 porting from windows code.
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_ctrl_initgain_byrssi(struct net_device *dev)
 {
 	if (!dm_digtable.dig_enable_flag)
@@ -1747,11 +1756,15 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_ala=
rm(
 	/*DbgPrint("DIG Check\n\r RSSI=3D%d LOW=3D%d HIGH=3D%d STATE=3D%d",
 	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
 	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
-	/* 1. When RSSI decrease, We have to judge if it is smaller than a thres=
hold
-		  and then execute the step below. */
+	/*
+	 * 1. When RSSI decrease, We have to judge if it is smaller than a thres=
hold
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb <=3D dm_digtable.rssi_low_thresh) {
-		/* 2008/02/05 MH When we execute silent reset, the DIG PHY parameters
-		   will be reset to init value. We must prevent the condition. */
+		/*
+		 * 2008/02/05 MH When we execute silent reset, the DIG PHY parameters
+		 * will be reset to init value. We must prevent the condition.
+		 */
 		if (dm_digtable.dig_state =3D=3D DM_STA_DIG_OFF &&
 		    (priv->reset_count =3D=3D reset_cnt)) {
 			return;
@@ -1796,8 +1809,10 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alar=
m(

 	}

-	/* 2. When RSSI increase, We have to judge if it is larger than a thresh=
old
-		  and then execute the step below.  */
+	/*
+	 * 2. When RSSI increase, We have to judge if it is larger than a thresh=
old
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb >=3D dm_digtable.rssi_high_thresh) {
 		u8 reset_flag =3D 0;

@@ -1865,7 +1880,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(

 }	/* dm_CtrlInitGainByRssi */

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_ctrl_initgain_byrssi_highpwr()
  *
  * Overview:
@@ -1880,7 +1896,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
  *	When		Who		Remark
  *	05/28/2008	amy		Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_ctrl_initgain_byrssi_highpwr(
 	struct net_device *dev)
 {
@@ -2147,7 +2164,7 @@ static void dm_check_edca_turbo(
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
 	PRT_HIGH_THROUGHPUT	pHTInfo =3D priv->ieee80211->pHTInfo;
-	/*PSTA_QOS			pStaQos =3D pMgntInfo->pStaQos;*/
+	/* PSTA_QOS			pStaQos =3D pMgntInfo->pStaQos; */

 	/* Keep past Tx/Rx packet count for RT-to-RT EDCA turbo. */
 	static unsigned long			lastTxOkCnt;
@@ -2224,7 +2241,7 @@ static void dm_check_edca_turbo(
 			 * If it is set, immediately set ACM control bit to downgrading AC for=
 passing WMM testplan. Annie, 2005-12-13.
 			 */
 			{
-				/*  TODO:  Modified this part and try to set acm control in only 1 IO=
 processing!! */
+				/* TODO: Modified this part and try to set acm control in only 1 IO p=
rocessing!! */

 				struct aci_aifsn *pAciAifsn =3D (struct aci_aifsn *)&(qos_parameters-=
>aifs[0]);
 				u8		AcmCtrl;
@@ -2273,10 +2290,10 @@ static void dm_ctstoself(struct net_device *dev)
 		return;
 	}
 	/*
-	1. Uplink
-	2. Linksys350/Linksys300N
-	3. <50 disable, >55 enable
-	*/
+	 * 1. Uplink
+	 * 2. Linksys350/Linksys300N
+	 * 3. <50 disable, >55 enable
+	 */

 	if (pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt =3D priv->stats.txbytesunicast - lastTxOkCnt;
@@ -2293,7 +2310,8 @@ static void dm_ctstoself(struct net_device *dev)
 	}
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_check_pbc_gpio()
  *
  * Overview:	Check if PBC button is pressed.
@@ -2308,7 +2326,8 @@ static void dm_ctstoself(struct net_device *dev)
  *	When		Who		Remark
  *	05/28/2008	amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static	void	dm_check_pbc_gpio(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
@@ -2329,7 +2348,8 @@ static	void	dm_check_pbc_gpio(struct net_device *dev=
)

 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	DM_RFPathCheckWorkItemCallBack()
  *
  * Overview:	Check if Current RF RX path is enabled
@@ -2344,7 +2364,8 @@ static	void	dm_check_pbc_gpio(struct net_device *dev=
)
  *	When		Who		Remark
  *	01/30/2008	MHC		Create Version 0.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
 {
 	struct delayed_work *dwork =3D to_delayed_work(work);
@@ -2353,8 +2374,10 @@ void dm_rf_pathcheck_workitemcallback(struct work_s=
truct *work)
 	/*bool bactually_set =3D false;*/
 	u8 rfpath =3D 0, i;

-	/* 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register w=
ill
-	   always be the same. We only read 0xc04 now. */
+	/*
+	 * 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register w=
ill
+	 * always be the same. We only read 0xc04 now.
+	 */
 	read_nic_byte(dev, 0xc04, &rfpath);

 	/* Check Bit 0-3, it means if RF A-D is enabled. */
@@ -2579,7 +2602,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *=
dev)
 	}
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_check_rx_path_selection()
  *
  * Overview:	Call a workitem to check current RXRF path and Rx Path selec=
tion by RSSI.
@@ -2594,7 +2618,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *=
dev)
  *	When		Who		Remark
  *	05/28/2008	amy		Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_check_rx_path_selection(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
@@ -2901,7 +2926,8 @@ void dm_check_fsync(struct net_device *dev)
 	}
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	dm_shadow_init()
  *
  * Overview:	Store all NIC MAC/BB register content.
@@ -2916,7 +2942,8 @@ void dm_check_fsync(struct net_device *dev)
  *	When		Who		Remark
  *	05/29/2008	amy		Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 void dm_shadow_init(struct net_device *dev)
 {
 	u8	page;
@@ -2938,12 +2965,13 @@ void dm_shadow_init(struct net_device *dev)

 }   /* dm_shadow_init */

-/*---------------------------Define function prototype-------------------=
-----*/
-/*-----------------------------------------------------------------------=
------
+/* ---------------------------Define function prototype------------------=
------ */
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	DM_DynamicTxPower()
  *
  * Overview:	Detect Signal strength to control TX Registry
-			Tx Power Control For Near/Far Range
+ *			Tx Power Control For Near/Far Range
  *
  * Input:		NONE
  *
@@ -2955,7 +2983,8 @@ void dm_shadow_init(struct net_device *dev)
  *	When		Who		Remark
  *	03/06/2008	Jacken	Create Version 0.
  *
- *-----------------------------------------------------------------------=
----*/
+ * ----------------------------------------------------------------------=
-----
+ */
 static void dm_init_dynamic_txpower(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
@@ -3057,4 +3086,4 @@ static void dm_send_rssi_tofw(struct net_device *dev=
)
 	write_nic_byte(dev, DRIVER_RSSI, (u8)priv->undecorated_smoothed_pwdb);
 }

-/*---------------------------Define function prototype-------------------=
-----*/
+/* ---------------------------Define function prototype------------------=
------ */
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl819=
2u/r8192U_dm.h
index 0de0332906bd..d7ed0eb2fedb 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -21,7 +21,7 @@
 #ifndef	__R8192UDM_H__
 #define __R8192UDM_H__

-/*--------------------------Define Parameters----------------------------=
---*/
+/* --------------------------Define Parameters---------------------------=
---- */
 #define         DM_DIG_THRESH_HIGH                      40
 #define         DM_DIG_THRESH_LOW                       35

@@ -59,9 +59,9 @@
 #define         INITIAL_TX_RATE_REG                  0x1b9
 #define         TX_RETRY_COUNT_REG                   0x1ac
 #define         REG_C38_TH                              20
-/*--------------------------Define Parameters----------------------------=
---*/
+/* --------------------------Define Parameters---------------------------=
---- */

-/*------------------------------Define structure-------------------------=
---*/
+/* ------------------------------Define structure------------------------=
---- */

 enum dig_algorithm {
 	DIG_ALGO_BY_FALSE_ALARM =3D 0,
@@ -143,18 +143,18 @@ struct tx_config_cmd {
 	u32     cmd_value;
 };

-/*------------------------------Define structure-------------------------=
---*/
+/* ------------------------------Define structure------------------------=
---- */

-/*------------------------Export global variable-------------------------=
---*/
+/* ------------------------Export global variable------------------------=
---- */
 extern struct dig dm_digtable;
 extern u8 dm_shadow[16][256];
-/*------------------------Export global variable-------------------------=
---*/
+/* ------------------------Export global variable------------------------=
---- */

-/*------------------------Export Marco Definition------------------------=
---*/
+/* ------------------------Export Marco Definition-----------------------=
---- */

-/*------------------------Export Marco Definition------------------------=
---*/
+/* ------------------------Export Marco Definition-----------------------=
---- */

-/*--------------------------Exported Function prototype------------------=
---*/
+/* --------------------------Exported Function prototype-----------------=
---- */
 void init_hal_dm(struct net_device *dev);
 void deinit_hal_dm(struct net_device *dev);
 void hal_dm_watchdog(struct net_device *dev);
@@ -171,8 +171,8 @@ void dm_fsync_timer_callback(struct timer_list *t);
 void dm_cck_txpower_adjust(struct net_device *dev, bool  binch14);
 void dm_shadow_init(struct net_device *dev);
 void dm_initialize_txpower_tracking(struct net_device *dev);
-/*--------------------------Exported Function prototype------------------=
---*/
+/* --------------------------Exported Function prototype-----------------=
---- */

-#endif	/*__R8192UDM_H__ */
+#endif	/* __R8192UDM_H__ */

 /* End of r8192U_dm.h */
diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl819=
2u/r8192U_hw.h
index 95a2d2ee3c65..79d462894f1d 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -39,21 +39,21 @@

 #define EEPROM_TX_POWER_DIFF	0x1F
 #define EEPROM_THERMAL_METER	0x20
-#define EEPROM_PW_DIFF		0x21	//0x21
-#define EEPROM_CRYSTAL_CAP	0x22	//0x22
+#define EEPROM_PW_DIFF		0x21	/* 0x21 */
+#define EEPROM_CRYSTAL_CAP	0x22	/* 0x22 */

-#define EEPROM_TX_PW_INDEX_CCK	0x23	//0x23
-#define EEPROM_TX_PW_INDEX_OFDM_24G	0x24	//0x24~0x26
-#define EEPROM_TX_PW_INDEX_CCK_V1	0x29	//0x29~0x2B
-#define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	//0x2C~0x2E
-#define EEPROM_TX_PW_INDEX_VER		0x27	//0x27
+#define EEPROM_TX_PW_INDEX_CCK	0x23	/* 0x23 */
+#define EEPROM_TX_PW_INDEX_OFDM_24G	0x24	/* 0x24~0x26 */
+#define EEPROM_TX_PW_INDEX_CCK_V1	0x29	/* 0x29~0x2B */
+#define EEPROM_TX_PW_INDEX_OFDM_24G_V1	0x2C	/* 0x2C~0x2E */
+#define EEPROM_TX_PW_INDEX_VER		0x27	/* 0x27 */

 #define EEPROM_DEFAULT_THERNAL_METER		0x7
 #define EEPROM_DEFAULT_PW_DIFF			0x4
 #define EEPROM_DEFAULT_CRYSTAL_CAP		0x5
 #define EEPROM_DEFAULT_TX_POWER		0x1010
-#define EEPROM_CUSTOMER_ID			0x7B	//0x7B:CustomerID
-#define EEPROM_CHANNEL_PLAN			0x16	//0x7C
+#define EEPROM_CUSTOMER_ID			0x7B	/* 0x7B:CustomerID */
+#define EEPROM_CHANNEL_PLAN			0x16	/* 0x7C */

 #define EEPROM_CID_RUNTOP				0x2
 #define EEPROM_CID_DLINK				0x8
@@ -63,25 +63,24 @@
 #define AC_PARAM_ECW_MIN_OFFSET		8
 #define AC_PARAM_AIFS_OFFSET		0

-//#endif
 enum _RTL8192Usb_HW {
 	MAC0			=3D 0x000,
 	MAC4			=3D 0x004,

 #define	BB_GLOBAL_RESET_BIT	0x1
-	BB_GLOBAL_RESET		=3D 0x020, // BasebandGlobal Reset Register
-	BSSIDR			=3D 0x02E, // BSSID Register
-	CMDR			=3D 0x037, // Command register
+	BB_GLOBAL_RESET		=3D 0x020, /* BasebandGlobal Reset Register */
+	BSSIDR			=3D 0x02E, /* BSSID Register */
+	CMDR			=3D 0x037, /* Command register */
 #define CR_RE			0x08
 #define CR_TE			0x04
-	SIFS			=3D 0x03E, // SIFS register
+	SIFS			=3D 0x03E, /* SIFS register */

 #define TCR_MXDMA_2048		7
 #define TCR_LRL_OFFSET		0
 #define TCR_SRL_OFFSET		8
 #define TCR_MXDMA_OFFSET	21
-#define TCR_SAT			BIT(24)	// Enable Rate depedent ack timeout timer
-	RCR			=3D 0x044, // Receive Configuration Register
+#define TCR_SAT			BIT(24)	/* Enable Rate depedent ack timeout timer */
+	RCR			=3D 0x044, /* Receive Configuration Register */
 #define MAC_FILTER_MASK (BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(5) | \
 			 BIT(12) | BIT(18) | BIT(19) | BIT(20) | BIT(21) | \
 			 BIT(22) | BIT(23))
@@ -91,45 +90,47 @@ enum _RTL8192Usb_HW {
 #define MAX_RX_DMA_MASK 	(BIT(8) | BIT(9) | BIT(10))
 #define RCR_MXDMA_OFFSET	8
 #define RCR_FIFO_OFFSET		13
-#define RCR_ONLYERLPKT		BIT(31)			// Early Receiving based on Packet Size=
.
-#define RCR_CBSSID		BIT(23)			// Accept BSSID match packet
-#define RCR_APWRMGT		BIT(22)			// Accept power management packet
-#define RCR_AMF			BIT(20)			// Accept management type frame
-#define RCR_ACF			BIT(19)			// Accept control type frame
-#define RCR_ADF			BIT(18)			// Accept data type frame
-#define RCR_AICV		BIT(12)			// Accept ICV error packet
-#define	RCR_ACRC32		BIT(5)			// Accept CRC32 error packet
-#define	RCR_AB			BIT(3)			// Accept broadcast packet
-#define	RCR_AM			BIT(2)			// Accept multicast packet
-#define	RCR_APM			BIT(1)			// Accept physical match packet
-#define	RCR_AAP			BIT(0)			// Accept all unicast packet
-	SLOT_TIME		=3D 0x049, // Slot Time Register
-	ACK_TIMEOUT		=3D 0x04c, // Ack Timeout Register
-	EDCAPARA_BE		=3D 0x050, // EDCA Parameter of AC BE
-	EDCAPARA_BK		=3D 0x054, // EDCA Parameter of AC BK
-	EDCAPARA_VO		=3D 0x058, // EDCA Parameter of AC VO
-	EDCAPARA_VI		=3D 0x05C, // EDCA Parameter of AC VI
-	BCN_TCFG		=3D 0x062, // Beacon Time Configuration
+#define RCR_ONLYERLPKT		BIT(31)			/* Early Receiving based on Packet Size=
. */
+#define RCR_CBSSID		BIT(23)			/* Accept BSSID match packet */
+#define RCR_APWRMGT		BIT(22)			/* Accept power management packet */
+#define RCR_AMF			BIT(20)			/* Accept management type frame */
+#define RCR_ACF			BIT(19)			/* Accept control type frame */
+#define RCR_ADF			BIT(18)			/* Accept data type frame */
+#define RCR_AICV		BIT(12)			/* Accept ICV error packet */
+#define	RCR_ACRC32		BIT(5)			/* Accept CRC32 error packet */
+#define	RCR_AB			BIT(3)			/* Accept broadcast packet */
+#define	RCR_AM			BIT(2)			/* Accept multicast packet */
+#define	RCR_APM			BIT(1)			/* Accept physical match packet */
+#define	RCR_AAP			BIT(0)			/* Accept all unicast packet */
+	SLOT_TIME		=3D 0x049, /* Slot Time Register */
+	ACK_TIMEOUT		=3D 0x04c, /* Ack Timeout Register */
+	EDCAPARA_BE		=3D 0x050, /* EDCA Parameter of AC BE */
+	EDCAPARA_BK		=3D 0x054, /* EDCA Parameter of AC BK */
+	EDCAPARA_VO		=3D 0x058, /* EDCA Parameter of AC VO */
+	EDCAPARA_VI		=3D 0x05C, /* EDCA Parameter of AC VI */
+	BCN_TCFG		=3D 0x062, /* Beacon Time Configuration */
 #define BCN_TCFG_CW_SHIFT		8
 #define BCN_TCFG_IFS			0
-	BCN_INTERVAL		=3D 0x070, // Beacon Interval (TU)
-	ATIMWND			=3D 0x072, // ATIM Window Size (TU)
-	BCN_DRV_EARLY_INT	=3D 0x074, // Driver Early Interrupt Time (TU). Time t=
o send interrupt to notify to change beacon content before TBTT
-	BCN_DMATIME		=3D 0x076, // Beacon DMA and ATIM interrupt time (US). Indi=
cates the time before TBTT to perform beacon queue DMA
-	BCN_ERR_THRESH		=3D 0x078, // Beacon Error Threshold
-	RWCAM			=3D 0x0A0, //IN 8190 Data Sheet is called CAMcmd
-	WCAMI			=3D 0x0A4, // Software write CAM input content
-	SECR			=3D 0x0B0, //Security Configuration Register
-#define	SCR_TxUseDK		BIT(0)			//Force Tx Use Default Key
-#define SCR_RxUseDK		BIT(1)			//Force Rx Use Default Key
-#define SCR_TxEncEnable		BIT(2)			//Enable Tx Encryption
-#define SCR_RxDecEnable		BIT(3)			//Enable Rx Decryption
-#define SCR_SKByA2		BIT(4)			//Search kEY BY A2
-#define SCR_NoSKMC		BIT(5)			//No Key Search for Multicast
-
-//-----------------------------------------------------------------------=
-----
-//       8190 CPU General Register		(offset 0x100, 4 byte)
-//-----------------------------------------------------------------------=
-----
+	BCN_INTERVAL		=3D 0x070, /* Beacon Interval (TU) */
+	ATIMWND			=3D 0x072, /* ATIM Window Size (TU) */
+	BCN_DRV_EARLY_INT	=3D 0x074, /* Driver Early Interrupt Time (TU). Time t=
o send interrupt to notify to change beacon content before TBTT */
+	BCN_DMATIME		=3D 0x076, /* Beacon DMA and ATIM interrupt time (US). Indi=
cates the time before TBTT to perform beacon queue DMA */
+	BCN_ERR_THRESH		=3D 0x078, /* Beacon Error Threshold */
+	RWCAM			=3D 0x0A0, /* IN 8190 Data Sheet is called CAMcmd */
+	WCAMI			=3D 0x0A4, /* Software write CAM input content */
+	SECR			=3D 0x0B0, /* Security Configuration Register */
+#define	SCR_TxUseDK		BIT(0)			/* Force Tx Use Default Key */
+#define SCR_RxUseDK		BIT(1)			/* Force Rx Use Default Key */
+#define SCR_TxEncEnable		BIT(2)			/* Enable Tx Encryption */
+#define SCR_RxDecEnable		BIT(3)			/* Enable Rx Decryption */
+#define SCR_SKByA2		BIT(4)			/* Search kEY BY A2 */
+#define SCR_NoSKMC		BIT(5)			/* No Key Search for Multicast */
+
+/*
+ * ----------------------------------------------------------------------=
------
+ *       8190 CPU General Register		(offset 0x100, 4 byte)
+ * ----------------------------------------------------------------------=
------
+ */
 #define	CPU_CCK_LOOPBACK	0x00030000
 #define	CPU_GEN_SYSTEM_RESET	0x00000001
 #define	CPU_GEN_FIRMWARE_RESET	0x00000008
@@ -138,37 +139,38 @@ enum _RTL8192Usb_HW {
 #define	CPU_GEN_PUT_CODE_OK	0x00000080
 #define	CPU_GEN_BB_RST		0x00000100
 #define	CPU_GEN_PWR_STB_CPU	0x00000004
-#define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF // Set bit18,17,16 to 0. Set b=
it19
-#define CPU_GEN_NO_LOOPBACK_SET	0x00080000 // Set BIT19 to 1
-	CPU_GEN			=3D 0x100, // CPU Reset Register
-
-	AcmHwCtrl		=3D 0x171, // ACM Hardware Control Register
-//-----------------------------------------------------------------------=
-----
-////
-////       8190 AcmHwCtrl bits                                    (offset=
 0x171, 1 byte)
-////---------------------------------------------------------------------=
-------
-//
+#define CPU_GEN_NO_LOOPBACK_MSK	0xFFF8FFFF /* Set bit18,17,16 to 0. Set b=
it19 */
+#define CPU_GEN_NO_LOOPBACK_SET	0x00080000 /* Set BIT19 to 1 */
+	CPU_GEN			=3D 0x100, /* CPU Reset Register */
+
+	AcmHwCtrl		=3D 0x171, /* ACM Hardware Control Register */
+/*
+ * ----------------------------------------------------------------------=
------
+ *
+ *         8190 AcmHwCtrl bits                                    (offset=
 0x171, 1 byte)
+ * ----------------------------------------------------------------------=
------
+ */
 #define AcmHw_BeqEn             BIT(1)

-	RQPN1			=3D 0x180, // Reserved Queue Page Number , Vo Vi, Be, Bk
-	RQPN2			=3D 0x184, // Reserved Queue Page Number, HCCA, Cmd, Mgnt, High
-	RQPN3			=3D 0x188, // Reserved Queue Page Number, Bcn, Public,
-	QPNR			=3D 0x1D0, //0x1F0, // Queue Packet Number report per TID
+	RQPN1			=3D 0x180, /* Reserved Queue Page Number , Vo Vi, Be, Bk */
+	RQPN2			=3D 0x184, /* Reserved Queue Page Number, HCCA, Cmd, Mgnt, High =
*/
+	RQPN3			=3D 0x188, /* Reserved Queue Page Number, Bcn, Public, */
+	QPNR			=3D 0x1D0, /* 0x1F0, Queue Packet Number report per TID */

 #define	BW_OPMODE_5G			BIT(1)
 #define	BW_OPMODE_20MHZ			BIT(2)
-	BW_OPMODE		=3D 0x300, // Bandwidth operation mode
-	MSR			=3D 0x303, // Media Status register
+	BW_OPMODE		=3D 0x300, /* Bandwidth operation mode */
+	MSR			=3D 0x303, /* Media Status register */
 #define MSR_LINK_MASK      (BIT(0)|BIT(1))
 #define MSR_LINK_MANAGED   2
 #define MSR_LINK_NONE      0
 #define MSR_LINK_SHIFT     0
 #define MSR_LINK_ADHOC     1
 #define MSR_LINK_MASTER    3
-	RETRY_LIMIT		=3D 0x304, // Retry Limit [15:8]-short, [7:0]-long
+	RETRY_LIMIT		=3D 0x304, /* Retry Limit [15:8]-short, [7:0]-long */
 #define RETRY_LIMIT_SHORT_SHIFT 8
 #define RETRY_LIMIT_LONG_SHIFT 0
-	RRSR			=3D 0x310, // Response Rate Set
+	RRSR			=3D 0x310, /* Response Rate Set */
 #define RRSR_1M						BIT(0)
 #define RRSR_2M						BIT(1)
 #define RRSR_5_5M					BIT(2)
@@ -181,19 +183,21 @@ enum _RTL8192Usb_HW {
 #define RRSR_36M					BIT(9)
 #define RRSR_48M					BIT(10)
 #define RRSR_54M					BIT(11)
-#define BRSR_AckShortPmb			BIT(23)		// CCK ACK: use Short Preamble or not=
.
+#define BRSR_AckShortPmb			BIT(23)		/* CCK ACK: use Short Preamble or not=
. */
 	UFWP			=3D 0x318,
-	RATR0			=3D 0x320, // Rate Adaptive Table register1
-	DRIVER_RSSI		=3D 0x32c,					// Driver tell Firmware current RSSI
-//-----------------------------------------------------------------------=
-----
-//       8190 Rate Adaptive Table Register	(offset 0x320, 4 byte)
-//-----------------------------------------------------------------------=
-----
-//CCK
+	RATR0			=3D 0x320, /* Rate Adaptive Table register1 */
+	DRIVER_RSSI		=3D 0x32c,					/* Driver tell Firmware current RSSI */
+/*
+ * ----------------------------------------------------------------------=
------
+ *        8190 Rate Adaptive Table Register	(offset 0x320, 4 byte)
+ * ----------------------------------------------------------------------=
------
+ */
+/* CCK */
 #define	RATR_1M			0x00000001
 #define	RATR_2M			0x00000002
 #define	RATR_55M		0x00000004
 #define	RATR_11M		0x00000008
-//OFDM
+/* OFDM */
 #define	RATR_6M			0x00000010
 #define	RATR_9M			0x00000020
 #define	RATR_12M		0x00000040
@@ -202,7 +206,7 @@ enum _RTL8192Usb_HW {
 #define	RATR_36M		0x00000200
 #define	RATR_48M		0x00000400
 #define	RATR_54M		0x00000800
-//MCS 1 Spatial Stream
+/* MCS 1 Spatial Stream */
 #define	RATR_MCS0		0x00001000
 #define	RATR_MCS1		0x00002000
 #define	RATR_MCS2		0x00004000
@@ -211,7 +215,7 @@ enum _RTL8192Usb_HW {
 #define	RATR_MCS5		0x00020000
 #define	RATR_MCS6		0x00040000
 #define	RATR_MCS7		0x00080000
-//MCS 2 Spatial Stream
+/* MCS 2 Spatial Stream */
 #define	RATR_MCS8		0x00100000
 #define	RATR_MCS9		0x00200000
 #define	RATR_MCS10		0x00400000
@@ -220,7 +224,7 @@ enum _RTL8192Usb_HW {
 #define	RATR_MCS13		0x02000000
 #define	RATR_MCS14		0x04000000
 #define	RATR_MCS15		0x08000000
-// ALL CCK Rate
+/* ALL CCK Rate */
 #define RATE_ALL_CCK		RATR_1M|RATR_2M|RATR_55M|RATR_11M
 #define RATE_ALL_OFDM_AG	RATR_6M|RATR_9M|RATR_12M|RATR_18M|RATR_24M\
 							|RATR_36M|RATR_48M|RATR_54M
@@ -239,8 +243,10 @@ enum _RTL8192Usb_HW {
 #define EPROM_W_BIT  BIT(1)
 #define EPROM_R_BIT  BIT(0)
 };
-//-----------------------------------------------------------------------=
-----
-//       818xB AnaParm & AnaParm2 Register
-//-----------------------------------------------------------------------=
-----
+/*
+ * ----------------------------------------------------------------------=
------
+ *       818xB AnaParm & AnaParm2 Register
+ * ----------------------------------------------------------------------=
------
+ */
 #define GPI 0x108
 #endif
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl819=
2u/r8192U_wx.c
index 5822bb7984b9..adb9fe8a79da 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -200,7 +200,8 @@ static int r8192_wx_set_mode(struct net_device *dev, s=
truct iw_request_info *a,
 struct  iw_range_with_scan_capa {
 	/* Informative stuff (to choose between different interface) */
 	__u32           throughput;     /* To give an idea... */
-	/* In theory this value should be the maximum benchmarked
+	/*
+	 * In theory this value should be the maximum benchmarked
 	 * TCP/IP throughput, because with most of these devices the
 	 * bit rate is meaningless (overhead an co) to estimate how
 	 * fast the connection will go and pick the fastest one.
@@ -231,11 +232,13 @@ static int rtl8180_wx_get_range(struct net_device *d=
ev,
 	wrqu->data.length =3D sizeof(*range);
 	memset(range, 0, sizeof(*range));

-	/* Let's try to keep this struct in the same order as in
+	/*
+	 * Let's try to keep this struct in the same order as in
 	 * linux/include/wireless.h
 	 */

-	/* TODO: See what values we can set, and remove the ones we can't
+	/*
+	 * TODO: See what values we can set, and remove the ones we can't
 	 * set, or fill them with some default data.
 	 */

@@ -644,7 +647,8 @@ static int r8192_wx_set_retry(struct net_device *dev,
 		DMESG("Setting retry for non RTS/CTS data to %d", wrqu->retry.value);
 	}

-	/* FIXME !
+	/*
+	 * FIXME !
 	 * We might try to write directly the TX config register
 	 * or to restart just the (R)TX process.
 	 * I'm unsure if whole reset is really needed
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.c b/drivers/staging/rt=
l8192u/r819xU_cmdpkt.c
index e064f43fd8b6..1fd596f09241 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_cmdpkt.c
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.c
@@ -33,7 +33,8 @@ rt_status SendTxCommandPacket(struct net_device *dev, vo=
id *pData, u32 DataLen)
 	struct sk_buff	    *skb;
 	struct cb_desc	    *tcb_desc;

-	/* Get TCB and local buffer from common pool.
+	/*
+	 * Get TCB and local buffer from common pool.
 	 * (It is shared by CmdQ, MgntQ, and USB coalesce DataQ)
 	 */
 	skb  =3D dev_alloc_skb(USB_HWDESC_HEADER_LEN + DataLen + 4);
@@ -69,7 +70,8 @@ static void cmpk_count_txstatistic(struct net_device *de=
v, struct cmd_pkt_tx_fee
 	pAdapter->HalFunc.GetHwRegHandler(pAdapter, HW_VAR_RF_STATE,
 					  (pu1Byte)(&rtState));

-	/* When RF is off, we should not count the packet for hw/sw synchronize
+	/*
+	 * When RF is off, we should not count the packet for hw/sw synchronize
 	 * reason, ie. there may be a duration while sw switch is changed and
 	 * hw switch is being changed.
 	 */
@@ -81,7 +83,8 @@ static void cmpk_count_txstatistic(struct net_device *de=
v, struct cmd_pkt_tx_fee
 	if (pAdapter->bInHctTest)
 		return;
 #endif
-	/* We can not know the packet length and transmit type:
+	/*
+	 * We can not know the packet length and transmit type:
 	 * broadcast or uni or multicast. So the relative statistics
 	 * must be collected in tx feedback info.
 	 */
@@ -120,7 +123,8 @@ static void cmpk_count_txstatistic(struct net_device *=
dev, struct cmd_pkt_tx_fee
 	priv->stats.txfeedbackretry +=3D pstx_fb->retry_cnt;
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:    cmpk_handle_tx_feedback()
  *
  * Overview:	The function is responsible for extract the message inside T=
X
@@ -140,7 +144,7 @@ static void cmpk_count_txstatistic(struct net_device *=
dev, struct cmd_pkt_tx_fee
  *  When		Who	Remark
  *  05/08/2008		amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_handle_tx_feedback(struct net_device *dev, u8 *pmsg)
 {
@@ -150,7 +154,8 @@ static void cmpk_handle_tx_feedback(struct net_device =
*dev, u8 *pmsg)
 	priv->stats.txfeedback++;

 	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
-	/* It seems that FW use big endian(MIPS) and DRV use little endian in
+	/*
+	 * It seems that FW use big endian(MIPS) and DRV use little endian in
 	 * windows OS. So we have to read the content byte by byte or transfer
 	 * endian type before copy the message copy.
 	 */
@@ -160,7 +165,8 @@ static void cmpk_handle_tx_feedback(struct net_device =
*dev, u8 *pmsg)
 	cmpk_count_txstatistic(dev, &rx_tx_fb);
 	/* Comment previous method for TX statistic function. */
 	/* Collect info TX feedback packet to fill TCB. */
-	/* We can not know the packet length and transmit type: broadcast or uni
+	/*
+	 * We can not know the packet length and transmit type: broadcast or uni
 	 * or multicast.
 	 */
 }
@@ -184,7 +190,8 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct=
 net_device *dev)
 		rtl819xusb_beacon_tx(dev, tx_rate); /* HW Beacon */
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:    cmpk_handle_interrupt_status()
  *
  * Overview:    The function is responsible for extract the message from
@@ -203,7 +210,7 @@ static void cmdpkt_beacontimerinterrupt_819xusb(struct=
 net_device *dev)
  *  When		Who	Remark
  *  05/12/2008		amy	Add this for rtl8192 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_handle_interrupt_status(struct net_device *dev, u8 *pmsg=
)
 {
@@ -213,7 +220,8 @@ static void cmpk_handle_interrupt_status(struct net_de=
vice *dev, u8 *pmsg)
 	DMESG("---> cmpk_Handle_Interrupt_Status()\n");

 	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
-	/* It seems that FW use big endian(MIPS) and DRV use little endian in
+	/*
+	 * It seems that FW use big endian(MIPS) and DRV use little endian in
 	 * windows OS. So we have to read the content byte by byte or transfer
 	 * endian type before copy the message copy.
 	 */
@@ -248,7 +256,8 @@ static void cmpk_handle_interrupt_status(struct net_de=
vice *dev, u8 *pmsg)
 	DMESG("<---- cmpk_handle_interrupt_status()\n");
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:    cmpk_handle_query_config_rx()
  *
  * Overview:    The function is responsible for extract the message from
@@ -266,14 +275,15 @@ static void cmpk_handle_interrupt_status(struct net_=
device *dev, u8 *pmsg)
  *  When		Who	Remark
  *  05/12/2008		amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_handle_query_config_rx(struct net_device *dev, u8 *pmsg)
 {
 	struct cmpk_query_cfg	rx_query_cfg;

 	/* 1. Extract TX feedback info from RFD to temp structure buffer. */
-	/* It seems that FW use big endian(MIPS) and DRV use little endian in
+	/*
+	 * It seems that FW use big endian(MIPS) and DRV use little endian in
 	 * windows OS. So we have to read the content byte by byte or transfer
 	 * endian type before copy the message copy.
 	 */
@@ -288,7 +298,8 @@ static void cmpk_handle_query_config_rx(struct net_dev=
ice *dev, u8 *pmsg)
 					  (pmsg[14] <<  8) | (pmsg[15] <<  0);
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	cmpk_count_tx_status()
  *
  * Overview:	Count aggregated tx status from firmwar of one type rx comma=
nd
@@ -304,7 +315,7 @@ static void cmpk_handle_query_config_rx(struct net_dev=
ice *dev, u8 *pmsg)
  *	When		Who	Remark
  *	05/12/2008	amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_count_tx_status(struct net_device *dev,
 				 cmpk_tx_status_t *pstx_status)
@@ -318,7 +329,8 @@ static void cmpk_count_tx_status(struct net_device *de=
v,
 	pAdapter->HalFunc.GetHwRegHandler(pAdapter, HW_VAR_RF_STATE,
 					  (pu1Byte)(&rtState));

-	/* When RF is off, we should not count the packet for hw/sw synchronize
+	/*
+	 * When RF is off, we should not count the packet for hw/sw synchronize
 	 * reason, ie. there may be a duration while sw switch is changed and
 	 * hw switch is being changed.
 	 */
@@ -351,7 +363,8 @@ static void cmpk_count_tx_status(struct net_device *de=
v,
 	priv->stats.last_packet_rate	=3D pstx_status->rate;
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	cmpk_handle_tx_status()
  *
  * Overview:	Firmware add a new tx feedback status to reduce rx command
@@ -367,7 +380,7 @@ static void cmpk_count_tx_status(struct net_device *de=
v,
  *	When		Who	Remark
  *	05/12/2008	amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_handle_tx_status(struct net_device *dev, u8 *pmsg)
 {
@@ -378,7 +391,8 @@ static void cmpk_handle_tx_status(struct net_device *d=
ev, u8 *pmsg)
 	cmpk_count_tx_status(dev, &rx_tx_sts);
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:	cmpk_handle_tx_rate_history()
  *
  * Overview:	Firmware add a new tx rate history
@@ -393,7 +407,7 @@ static void cmpk_handle_tx_status(struct net_device *d=
ev, u8 *pmsg)
  *	When		Who	Remark
  *	05/12/2008	amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 static void cmpk_handle_tx_rate_history(struct net_device *dev, u8 *pmsg)
 {
@@ -407,7 +421,8 @@ static void cmpk_handle_tx_rate_history(struct net_dev=
ice *dev, u8 *pmsg)
 	pAdapter->HalFunc.GetHwRegHandler(pAdapter, HW_VAR_RF_STATE,
 					  (pu1Byte)(&rtState));

-	/* When RF is off, we should not count the packet for hw/sw synchronize
+	/*
+	 * When RF is off, we should not count the packet for hw/sw synchronize
 	 * reason, ie. there may be a duration while sw switch is changed and
 	 * hw switch is being changed.
 	 */
@@ -417,7 +432,8 @@ static void cmpk_handle_tx_rate_history(struct net_dev=
ice *dev, u8 *pmsg)

 	ptemp =3D (u32 *)pmsg;

-	/* Do endian transfer to word alignment(16 bits) for windows system.
+	/*
+	 * Do endian transfer to word alignment(16 bits) for windows system.
 	 * You must do different endian transfer for linux and MAC OS
 	 */
 	for (i =3D 0; i < (length/4); i++) {
@@ -447,7 +463,8 @@ static void cmpk_handle_tx_rate_history(struct net_dev=
ice *dev, u8 *pmsg)
 	}
 }

-/*-----------------------------------------------------------------------=
------
+/*
+ * ----------------------------------------------------------------------=
-------
  * Function:    cmpk_message_handle_rx()
  *
  * Overview:    In the function, we will capture different RX command pac=
ket
@@ -466,7 +483,7 @@ static void cmpk_handle_tx_rate_history(struct net_dev=
ice *dev, u8 *pmsg)
  *  When		Who	Remark
  *  05/06/2008		amy	Create Version 0 porting from windows code.
  *
- *-----------------------------------------------------------------------=
----
+ * ----------------------------------------------------------------------=
-----
  */
 u32 cmpk_message_handle_rx(struct net_device *dev,
 			   struct ieee80211_rx_stats *pstats)
@@ -476,7 +493,8 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 	u8			element_id;
 	u8			*pcmd_buff;

-	/* 0. Check inpt arguments. It is a command queue message or
+	/*
+	 * 0. Check inpt arguments. It is a command queue message or
 	 * pointer is null.
 	 */
 	if (pstats =3D=3D NULL)
@@ -491,11 +509,13 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 	/* 3. Read command packet element id and length. */
 	element_id =3D pcmd_buff[0];

-	/* 4. Check every received command packet content according to different
+	/*
+	 * 4. Check every received command packet content according to different
 	 *    element type. Because FW may aggregate RX command packet to
 	 *    minimize transmit time between DRV and FW.
 	 */
-	/* Add a counter to prevent the lock in the loop from being held too
+	/*
+	 * Add a counter to prevent the lock in the loop from being held too
 	 * long
 	 */
 	while (total_length > 0 && exe_cnt++ < 100) {
@@ -524,7 +544,8 @@ u32 cmpk_message_handle_rx(struct net_device *dev,
 			break;

 		case RX_TX_PER_PKT_FEEDBACK:
-			/* You must at lease add a switch case element here,
+			/*
+			 * You must at lease add a switch case element here,
 			 * Otherwise, we will jump to default case.
 			 */
 			cmd_length =3D CMPK_RX_TX_FB_SIZE;
diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rt=
l8192u/r819xU_cmdpkt.h
index be45cd609d67..6498b4625254 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -52,7 +52,8 @@ struct cmd_pkt_tx_feedback {
 	u16	duration;
 };

-/* 2. RX side: Interrupt status packet. It includes Beacon State,
+/*
+ * 2. RX side: Interrupt status packet. It includes Beacon State,
  * Beacon Timer Interrupt and other useful information in MAC ISR Reg.
  */
 struct cmd_pkt_interrupt_status {
@@ -80,15 +81,17 @@ struct cmd_pkt_set_configuration {
 	u32	mask;
 };

-/* 4. Both side : TX/RX query configuration packet. The query structure i=
s the
+/*
+ * 4. Both side : TX/RX query configuration packet. The query structure i=
s the
  *    same as set configuration.
  */
 #define		cmpk_query_cfg	cmd_pkt_set_configuration

 /* 5. Multi packet feedback status. */
 typedef struct tag_tx_stats_feedback {
-	/* For endian transfer --> Driver will not the same as
-	 *  firmware structure.
+	/*
+	 * For endian transfer --> Driver will not the same as
+	 * firmware structure.
 	 */
 	/* DW 0 */
 	u16	reserve1;
@@ -154,7 +157,8 @@ typedef struct tag_tx_rate_history {
 	/* DW 3-6 */
 	u16	ofdm[8];

-	/* DW 7-14	BW=3D0 SG=3D0
+	/*
+	 * DW 7-14	BW=3D0 SG=3D0
 	 * DW 15-22	BW=3D1 SG=3D0
 	 * DW 23-30	BW=3D0 SG=3D1
 	 * DW 31-38	BW=3D1 SG=3D1
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/=
rtl8192u/r819xU_firmware.c
index 153d4ee0ec07..e9511b829b05 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -61,7 +61,8 @@ static bool fw_download_code(struct net_device *dev, u8 =
*code_virtual_address,

 		}

-		/* Allocate skb buffer to contain firmware info and tx descriptor info
+		/*
+		 * Allocate skb buffer to contain firmware info and tx descriptor info
 		 * add 4 to avoid packet appending overflow.
 		 */
 		skb  =3D dev_alloc_skb(USB_HWDESC_HEADER_LEN + frag_length + 4);
@@ -273,7 +274,8 @@ bool init_firmware(struct net_device *dev)
 		}

 		/* Download image file */
-		/* The firmware download process is just as following,
+		/*
+		 * The firmware download process is just as following,
 		 * 1. that is each packet will be segmented and inserted to the wait qu=
eue.
 		 * 2. each packet segment will be put in the skb_buff packet.
 		 * 3. each skb_buff packet data content will already include the firmwa=
re info
@@ -288,7 +290,8 @@ bool init_firmware(struct net_device *dev)

 		switch (init_step) {
 		case FW_INIT_STEP0_BOOT:
-			/* Download boot
+			/*
+			 * Download boot
 			 * initialize command descriptor.
 			 * will set polling bit when firmware code is also configured
 			 */
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl81=
92u/r819xU_phy.c
index 5f04afe53d69..5445ea092130 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -426,7 +426,8 @@ static void phy_FwRFSerialWrite(struct net_device *dev=
,
 	u8	time =3D 0;
 	u32	tmp;

-	/* Firmware RF Write control.
+	/*
+	 * Firmware RF Write control.
 	 * We can not execute the scheme in the initial step.
 	 * Otherwise, RF-R/W will waste much time.
 	 * This is only for site survey.
@@ -445,7 +446,8 @@ static void phy_FwRFSerialWrite(struct net_device *dev=
,
 	/* 6. Write operation. We can not write if bit 31 is 1. */
 	read_nic_dword(dev, QPNR, &tmp);
 	while (tmp & 0x80000000) {
-		/* If FW can not finish RF-R/W for more than ?? times.
+		/*
+		 * If FW can not finish RF-R/W for more than ?? times.
 		 * We must reset FW.
 		 */
 		if (time++ < 100) {
@@ -455,11 +457,13 @@ static void phy_FwRFSerialWrite(struct net_device *d=
ev,
 			break;
 		}
 	}
-	/* 7. No matter check bit. We always force the write.
+	/*
+	 * 7. No matter check bit. We always force the write.
 	 * Because FW will not accept the command.
 	 */
 	write_nic_dword(dev, QPNR, data);
-	/* According to test, we must delay 20us to wait firmware
+	/*
+	 * According to test, we must delay 20us to wait firmware
 	 * to finish RF write operation.
 	 */
 	/* We support delay in firmware side now. */
@@ -828,7 +832,8 @@ static void rtl8192_BB_Config_ParaFile(struct net_devi=
ce *dev)
 				 reg_u32);
 	}

-	/* Check if the CCK HighPower is turned ON.
+	/*
+	 * Check if the CCK HighPower is turned ON.
 	 * This is used to calculate PWDB.
 	 */
 	priv->bCckHighPower =3D (u8)rtl8192_QueryBBReg(dev,
@@ -847,7 +852,8 @@ static void rtl8192_BB_Config_ParaFile(struct net_devi=
ce *dev)
 void rtl8192_BBConfig(struct net_device *dev)
 {
 	rtl8192_InitBBRFRegDef(dev);
-	/* config BB&RF. As hardCode based initialization has not been well
+	/*
+	 * config BB&RF. As hardCode based initialization has not been well
 	 * implemented, so use file first.
 	 * FIXME: should implement it for hardcode?
 	 */
@@ -1168,7 +1174,8 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 		case RF_8256:
 			switch (pHalData->eRFPowerState) {
 			case eRfOff:
-				/* If Rf off reason is from IPS,
+				/*
+				 * If Rf off reason is from IPS,
 				 * LED should blink with no link
 				 */
 				if (pMgntInfo->RfOffReason =3D=3D RF_CHANGE_BY_IPS)
@@ -1179,7 +1186,8 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
 				break;

 			case eRfOn:
-				/* Turn on RF we are still linked, which might
+				/*
+				 * Turn on RF we are still linked, which might
 				 * happen when we quickly turn off and on HW RF.
 				 */
 				if (pMgntInfo->bMediaConnect)
@@ -1274,7 +1282,8 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_de=
vice *dev, u8 channel,
 		 __func__, *stage, *step, channel);
 	if (!is_legal_channel(priv->ieee80211, channel)) {
 		RT_TRACE(COMP_ERR, "set to illegal channel: %d\n", channel);
-		/* return true to tell upper caller function this channel
+		/*
+		 * return true to tell upper caller function this channel
 		 * setting is finished! Or it will in while loop.
 		 */
 		return true;
@@ -1621,7 +1630,8 @@ void rtl8192_SetBWModeWorkItem(struct net_device *de=
v)
 		break;

 	}
-	/* Skip over setting of J-mode in BB register here.
+	/*
+	 * Skip over setting of J-mode in BB register here.
 	 * Default value is "None J mode".
 	 */

diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl81=
92u/r819xU_phy.h
index 8c2933264407..b1974671fdc9 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -8,8 +8,8 @@
 #define MAX_POSTCMD_CNT 16

 enum baseband_config_type {
-	BASEBAND_CONFIG_PHY_REG =3D 0,			//Radio Path A
-	BASEBAND_CONFIG_AGC_TAB =3D 1,			//Radio Path B
+	BASEBAND_CONFIG_PHY_REG =3D 0,			/* Radio Path A */
+	BASEBAND_CONFIG_AGC_TAB =3D 1,			/* Radio Path B */
 };

 enum switch_chan_cmd_id {
diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rt=
l8192u/r819xU_phyreg.h
index dc9ddf100eab..af7d9b8fee7f 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -96,7 +96,8 @@
 #define rTxAGC_Mcs15_Mcs12			0xe1c


-/* RF
+/*
+ * RF
  * Zebra1
  */
 #define rZebra1_Channel				0x7
@@ -104,7 +105,8 @@
 /* Zebra4 */
 #define rGlobalCtrl				0

-/* Bit Mask
+/*
+ * Bit Mask
  * page-8
  */
 #define bRFMOD						0x1
@@ -126,7 +128,8 @@
 /* page e */
 #define bTxAGCRateCCK			0x7f00

-/* RF
+/*
+ * RF
  * Zebra1
  */
 #define bZebra1_ChannelNum        0xf80
=2D-
2.17.1

