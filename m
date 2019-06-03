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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5869C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46556280CD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="j73KmU7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfFCMVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:21:52 -0400
Received: from mout.web.de ([212.227.17.11]:44355 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbfFCMVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1559564487;
        bh=/eQ95LpGYN6ssdyeQO7P3QDNFxd7n6uJ+Wb0LzndARY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=j73KmU7xIruFHCOe+IBnpRAhOLrmGPlrDkOfiNjYaZXB42bD85xRmuikRFiptvaV1
         HthJvYyfb5GH1gM9BAEuUBJHYhxi4EbK518oV1yEOf3Dm8L5XCz/DJtNQs4P84MdKY
         wvJY6zNp+bOjrqH2Qz01DqOVuSnOZfisIXkQ0/2Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LbrUu-1goqqA3ljQ-00jMIW; Mon, 03 Jun 2019 14:21:27 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        felix.trommer@hotmail.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
Subject: [PATCH 2/3] drivers/staging/rtl8192u: Remove comment-out code
Date:   Mon,  3 Jun 2019 14:21:03 +0200
Message-Id: <20190603122104.2564-3-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603122104.2564-1-muellerch-privat@web.de>
References: <20190603122104.2564-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4iFATFFZVO/MGV4esxoYcW9LbhGCigJsHCfS49YiFcbQLGl1rUC
 iLwq+EYfNhC4uyM7K+XA05V7f0xJiinI+exQQXa1dgjgITNErSnwMUwBK+20p6mX2aH8hLX
 HnMRtV4DSpZtPTCraKHqG0WnmRYwQg3hh2Vy0qcG1fWHHW52lmsHxITFz6Q+6qyDaZMzrUj
 3FMxqWSRAvuaj4EEFkTfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oa4PPW0lA9s=:737GOfXbZFK6bkI10o6SgR
 W6lc6O+E2o9cr0PMFmX58YpI0/kwV0Lz66b9uQu/Cwjyp9EaiT8IpnKI8XbNPWhVi2ubKN8/Y
 QMhxDgAKTxvLQaGrkMxI48S7+TIO+Y5L6puph68NGpIdzkGLnbBwXpsgTs+xIj3RLn9Bh7yDV
 enC0nVwsMrx42xEzfb3g6us9TnPJGqh4PmFumQen9mgMzatt8PYshvo3sQVYjIqYR7dCRpSNa
 Ib42B7713CtWmUlkg85Ng5IfpyREu78Crl6ROgnilR+5xXIVP5Y+TunNSyavEyn6GqsNUiVIy
 +WmZAfTBqeNMoiYBrYrSA4WMpvjtYBOLQP49CCBK/qUSBb4+KH/u1bRMjLSgKtH+2zmS7LP07
 UsU8eOkYgYmNVIOa9vJ4FbXXImDCQg/22koYnUj2xiVXwmBlFXJkdePrHTRa2RzYx9cpg0xY+
 ZZG9tSuc1sMQvHVX3xjnC5uZ5snLDxXrJQYzE6XHYrh+4FtpjJmyZqtyklQl0oDnbRpZ3vXp7
 m5jNvIqijCf9I6po6sDPnDSaM52nnUWZZkEcOb4g4NCIDZe35p3ShOG5GE9n3w8gFPU2F3WU2
 MCuVLry3CieG2z/vi79JjynKDaopB1G5425zlf3YRcWIRfGiEfoRrI3yGI//JSgEkglBcxNMj
 93FZdAyjN2gkpDf9iBf++AFCXPEz8KUCTbsnKd+Z2TGItCK46fFM4XaDI/YkaNc3ZXMF+hM7m
 Z86HjnZ22hVovv88cXejb3I5PMaihuneU5HIFzKgbe391cBmAOweYsAQEf9UyxFeqq19c2aDq
 Xzd1XTtsCr5jYYwtl4bFivZt1yfUonrB48Ogkwbg2usnLsSCvQH536BkmpakmJgop4nUV72Dh
 PHCoqcW4MoPajWY/3m9o8K/oZmjHbwAf3+7V0kHidPrkVjbnLPHVINiRkx4s0TDTjIaUbpHLz
 KxrC151LPvO2P5bzC2egxAiIbw6QQOKuA7a+spnqUZH3/W42dCBsa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Trommer <felix.trommer@hotmail.de>

Remove the majority of all commented-out code. Commented out code, that
was adressed by a comment itself is not removed. The code that we left
in as comments was mostly due to the "pseudo-code"-like nature of the
code that helped to clarify certain functionalities.

Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
=2D--
 drivers/staging/rtl8192u/ieee80211/dot11d.h   |  2 +-
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 35 ++-----
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |  1 -
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c |  1 -
 .../rtl8192u/ieee80211/ieee80211_module.c     |  2 -
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 50 +---------
 .../rtl8192u/ieee80211/ieee80211_softmac.c    | 93 +++----------------
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c | 13 +--
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  3 +-
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c | 19 +---
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  3 -
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  2 -
 .../rtl8192u/ieee80211/rtl819x_HTProc.c       | 54 ++---------
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  |  4 +-
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 11 ---
 drivers/staging/rtl8192u/r8190_rtl8256.c      |  3 -
 drivers/staging/rtl8192u/r8192U_core.c        |  5 +-
 drivers/staging/rtl8192u/r8192U_dm.c          | 60 ------------
 drivers/staging/rtl8192u/r8192U_wx.c          |  2 -
 drivers/staging/rtl8192u/r819xU_firmware.c    |  1 -
 20 files changed, 38 insertions(+), 326 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging=
/rtl8192u/ieee80211/dot11d.h
index 8b485fa18089..f27267307b3f 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -54,4 +54,4 @@ void dot11d_scan_complete(struct ieee80211_device *dev);
 int is_legal_channel(struct ieee80211_device *dev, u8 channel);
 int to_legal_channel(struct ieee80211_device *dev, u8 channel);

-#endif /* #ifndef __INC_DOT11D_H */
+#endif
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stag=
ing/rtl8192u/ieee80211/ieee80211.h
index 8be8a94a2253..d110e9333799 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -106,17 +106,13 @@ struct cb_desc {
 	u8 bRTSUseShortGI:1;
 	u8 bMulticast:1;
 	u8 bBroadcast:1;
-	/* u8 reserved2:2; */
 	u8 drv_agg_enable:1;
 	u8 reserved2:1;

 	/* Tx Desc related element(12-19) */
 	u8 rata_index;
 	u8 queue_index;
-	/* u8 reserved3; */
-	/* u8 reserved4; */
 	u16 txbuf_size;
-	/* u8 reserved5; */
 	u8 RATRIndex;
 	u8 reserved6;
 	u8 reserved7;
@@ -127,9 +123,6 @@ struct cb_desc {
 	u8 rts_rate;
 	u8 ampdu_factor;
 	u8 ampdu_density;
-	/* u8 reserved9; */
-	/* u8 reserved10; */
-	/* u8 reserved11; */
 	u8 DrvAggrNum;
 	u16 pkt_size;
 	u8 reserved12;
@@ -883,7 +876,8 @@ enum ieee80211_mfie {
 	MFIE_TYPE_QOS_PARAMETER =3D 222,
 };

-/* Minimal header; can be used for passing 802.11 frames with sufficient
+/*
+ * Minimal header; can be used for passing 802.11 frames with sufficient
  * information to determine what type of underlying data type is actually
  * stored in the data.
  */
@@ -1144,7 +1138,6 @@ struct ieee80211_tim_parameters {
 	u8 tim_period;
 } __packed;

-//#else
 struct ieee80211_wmm_ts_info {
 	u8 ac_dir_tid;
 	u8 ac_up_psb;
@@ -1274,7 +1267,6 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, =
WMM_six_frame};
 #define IEEE80211_PS_MBCAST IEEE80211_DTIM_MBCAST

 /* added by David for QoS 2006/6/30 */
-//#define WMM_Hang_8187
 #ifdef WMM_Hang_8187
 #undef WMM_Hang_8187
 #endif
@@ -1290,7 +1282,6 @@ enum {WMM_all_frame, WMM_two_frame, WMM_four_frame, =
WMM_six_frame};
 #define MAX_RECEIVE_BUFFER_SIZE 9100

 /* UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DS=
CP */
-//#define UP2AC(up)	((up<3) ? ((up=3D=3D0)?1:0) : (up>>1))
 #define UP2AC(up) (		   \
 	((up) < 1) ? WME_AC_BE : \
 	((up) < 3) ? WME_AC_BK : \
@@ -1392,7 +1383,6 @@ struct ieee80211_network {
 	bool atheros_cap_exist;
 	bool cisco_cap_exist;
 	bool unknown_cap_exist;
-//	u8	berp_info;
 	bool	berp_info_valid;
 	bool buseprotection;
 	/* put at the end of the structure. */
@@ -1607,7 +1597,7 @@ struct ieee80211_device {
 	struct ieee80211_security sec;

 	/* hw security related */
-//	u8 hwsec_support; //support?
+	/* u8 hwsec_support; //support? */
 	u8 hwsec_active;  /* hw security active. */
 	bool is_silent_reset;
 	bool ieee_up;
@@ -1623,8 +1613,6 @@ struct ieee80211_device {

 	/* 11n HT below */
 	PRT_HIGH_THROUGHPUT	pHTInfo;
-	//struct timer_list		SwBwTimer;
-//	spinlock_t chnlop_spinlock;
 	spinlock_t bw_spinlock;

 	spinlock_t reorder_spinlock;
@@ -1640,8 +1628,6 @@ struct ieee80211_device {
 	u8	bTxUseDriverAssingedRate;
 	atomic_t	atm_chnlop;
 	atomic_t	atm_swbw;
-//	u8	HTHighestOperaRate;
-//	u8	HTCurrentOperaRate;

 	/* 802.11e and WMM Traffic Stream Info (TX) */
 	struct list_head		Tx_TS_Admit_List;
@@ -1653,12 +1639,10 @@ struct ieee80211_device {
 	struct list_head		Rx_TS_Pending_List;
 	struct list_head		Rx_TS_Unused_List;
 	struct rx_ts_record		RxTsRecord[TOTAL_TS_NUM];
-//#ifdef TO_DO_LIST
 	struct rx_reorder_entry	RxReorderEntry[128];
 	struct list_head		RxReorder_Unused_List;
-//#endif
 	/* Qos related. Added by Annie, 2005-11-01. */
-//	PSTA_QOS			pStaQos;
+	/* PSTA_QOS			pStaQos; */
 	u8				ForcedPriority;		/* Force per-packet priority 1~7. (default: 0, no=
t to force it.) */


@@ -1898,9 +1882,6 @@ struct ieee80211_device {
 	/* Qos related. Added by Annie, 2005-11-01. */
 	/* STA_QOS  StaQos; */

-	/* u32 STA_EDCA_PARAM[4]; */
-	/* CHANNEL_ACCESS_SETTING ChannelAccessSetting; */
-
 	struct ieee80211_rxb *stats_IndicateArray[REORDER_WIN_SIZE];

 	/* Callback functions */
@@ -2002,15 +1983,16 @@ struct ieee80211_device {
 	/* check whether Tx hw resource available */
 	short (*check_nic_enough_desc)(struct net_device *dev, int queue_index);
 	/* added by wb for HT related */
-//	void (*SwChnlByTimerHandler)(struct net_device *dev, int channel);
+	/* void (*SwChnlByTimerHandler)(struct net_device *dev, int channel); */
 	void (*SetBWModeHandler)(struct net_device *dev, enum ht_channel_width B=
andwidth, enum ht_extension_chan_offset Offset);
-//	void (*UpdateHalRATRTableHandler)(struct net_device* dev, u8* pMcsRate=
);
+	/* void (*UpdateHalRATRTableHandler)(struct net_device* dev, u8* pMcsRat=
e); */
 	bool (*GetNmodeSupportBySecCfg)(struct net_device *dev);
 	void (*SetWirelessMode)(struct net_device *dev, u8 wireless_mode);
 	bool (*GetHalfNmodeSupportByAPsHandler)(struct net_device *dev);
 	void (*InitialGainHandler)(struct net_device *dev, u8 Operation);

-	/* This must be the last item so that it points to the data
+	/*
+	 * This must be the last item so that it points to the data
 	 * allocated beyond this structure by alloc_ieee80211
 	 */
 	u8 priv[0];
@@ -2326,7 +2308,6 @@ int ieee80211_wx_get_freq(struct ieee80211_device *i=
eee,
 int ieee80211_debug_init(void);
 void ieee80211_debug_exit(void);

-//extern void ieee80211_wx_sync_scan_wq(struct ieee80211_device *ieee);
 void ieee80211_wx_sync_scan_wq(struct work_struct *work);


diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index ad0b918ecf0d..7ec24120d871 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -201,7 +201,6 @@ static int ieee80211_ccmp_encrypt(struct sk_buff *skb,=
 int hdr_len, void *priv)
 	pos =3D skb_push(skb, CCMP_HDR_LEN);
 	memmove(pos, pos + CCMP_HDR_LEN, hdr_len);
 	pos +=3D hdr_len;
-	/* mic =3D skb_put(skb, CCMP_MIC_LEN); */

 	i =3D CCMP_PN_LEN - 1;
 	while (i >=3D 0) {
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index db4b640d1d8c..564a6d67de88 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -773,6 +773,5 @@ void __exit ieee80211_crypto_tkip_exit(void)

 void ieee80211_tkip_null(void)
 {
-//    printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>%s()\n", __func__);
 	return;
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drive=
rs/staging/rtl8192u/ieee80211/ieee80211_module.c
index dd7ff7e84bd0..954e43af494b 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -194,8 +194,6 @@ void free_ieee80211(struct net_device *dev)
 {
 	struct ieee80211_device *ieee =3D netdev_priv(dev);
 	int i;
-	/* struct list_head *p, *q; */
-//	del_timer_sync(&ieee->SwBwTimer);
 	kfree(ieee->pHTInfo);
 	ieee->pHTInfo =3D NULL;
 	RemoveAllTS(ieee);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_rx.c
index eebd8deb0087..af8546ad12af 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -329,7 +329,6 @@ static int ieee80211_is_eapol_frame(struct ieee80211_d=
evice *ieee,
 		return 0;

 	/* check for port access entity Ethernet type */
-//	pos =3D skb->data + 24;
 	pos =3D skb->data + hdrlen;
 	ethertype =3D (pos[6] << 8) | pos[7];
 	if (ethertype =3D=3D ETH_P_PAE)
@@ -490,9 +489,6 @@ static int is_duplicate_packet(struct ieee80211_device=
 *ieee,
 		return 0;
 	}

-//	if(tid !=3D 0) {
-//		printk(KERN_WARNING ":)))))))))))%x %x %x, fc(%x)\n", tid, *last_seq,=
 seq, header->frame_ctl);
-//	}
 	if ((*last_seq =3D=3D seq) &&
 	    time_after(*last_time + IEEE_PACKET_RETRY_TIME, jiffies)) {
 		if (*last_frag =3D=3D frag)
@@ -508,8 +504,6 @@ static int is_duplicate_packet(struct ieee80211_device=
 *ieee,
 	return 0;

 drop:
-//	BUG_ON(!(fc & IEEE80211_FCTL_RETRY));
-
 	return 1;
 }

@@ -537,8 +531,6 @@ void ieee80211_indicate_packets(struct ieee80211_devic=
e *ieee, struct ieee80211_
 {
 	u8 i =3D 0 , j=3D0;
 	u16 ethertype;
-//	if(index > 1)
-//		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): hahahahhhh, We indicate p=
acket from reorder list, index is %u\n",__func__,index);
 	for(j =3D 0; j<index; j++)
 	{
 /* added by amy for reorder */
@@ -565,8 +557,6 @@ void ieee80211_indicate_packets(struct ieee80211_devic=
e *ieee, struct ieee80211_
 				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->src, ETH_ALEN);
 				memcpy(skb_push(sub_skb, ETH_ALEN), prxb->dst, ETH_ALEN);
 			}
-			//stats->rx_packets++;
-			//stats->rx_bytes +=3D sub_skb->len;

 		/* Indicat the packets to upper layer */
 			if (sub_skb) {
@@ -658,11 +648,9 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
 		IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! IndicateSeq=
: %d, NewSeq: %d\n",\
 				pTS->rx_indicate_seq, SeqNum);
 		prxbIndicateArray[0] =3D prxb;
-//		printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D>%s(): SeqNum is %d\n",__func__,SeqNum);
 		index =3D 1;
 	} else {
 		/* Current packet is going to be inserted into pending list.*/
-		/* IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): We RX no ordered packed,=
 insert to ordered list\n",__func__); */
 		if(!list_empty(&ieee->RxReorder_Unused_List)) {
 			pReorderEntry =3D list_entry(ieee->RxReorder_Unused_List.next, struct =
rx_reorder_entry, List);
 			list_del_init(&pReorderEntry->List);
@@ -670,7 +658,6 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 			/* Make a reorder entry and insert into a the packet list.*/
 			pReorderEntry->SeqNum =3D SeqNum;
 			pReorderEntry->prxb =3D prxb;
-	//		IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pREorderEntry->SeqNum is=
 %d\n",__func__,pReorderEntry->SeqNum);

 			if(!AddReorderEntry(pTS, pReorderEntry)) {
 				IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Duplicate packet is drop=
ped!! IndicateSeq: %d, NewSeq: %d\n",
@@ -728,7 +715,6 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,

 			IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packets indication!! IndicateSeq=
: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
 			prxbIndicateArray[index] =3D pReorderEntry->prxb;
-		//	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D>%s(): pReorderEntry->SeqNum is %d\n",__func__,pReorderEntry->=
SeqNum);
 			index++;

 			list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_List);
@@ -741,7 +727,6 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 	/* Handling pending timer. Set this timer to prevent from long time Rx b=
uffering.*/
 	if (index>0) {
 		/* Cancel previous pending timer. */
-	//	del_timer_sync(&pTS->rx_pkt_pending_timer);
 		pTS->rx_timeout_indicate_seq =3D 0xffff;

 		/* Indicate packets */
@@ -798,7 +783,7 @@ static u8 parse_subframe(struct sk_buff *skb,
 		LLCOffset +=3D HTCLNG;
 	}
 	/* Null packet, don't indicate it to upper layer */
-	ChkLength =3D LLCOffset;/* + (Frame_WEP(frame)!=3D0 ?Adapter->MgntInfo.S=
ecurityInfo.EncryptionHeadOverhead:0);*/
+	ChkLength =3D LLCOffset;

 	if (skb->len <=3D ChkLength)
 		return 0;
@@ -815,7 +800,6 @@ static u8 parse_subframe(struct sk_buff *skb,

 		memcpy(rxb->src,src,ETH_ALEN);
 		memcpy(rxb->dst,dst,ETH_ALEN);
-		//IEEE80211_DEBUG_DATA(IEEE80211_DL_RX,skb->data,skb->len);
 		return 1;
 	} else {
 		rxb->nr_subframes =3D 0;
@@ -891,7 +875,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 {
 	struct net_device *dev =3D ieee->dev;
 	struct rtl_80211_hdr_4addr *hdr;
-	//struct rtl_80211_hdr_3addrqos *hdr;

 	size_t hdrlen;
 	u16 fc, type, stype, sc;
@@ -902,7 +885,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 	u8	TID =3D 0;
 	u16	SeqNum =3D 0;
 	struct rx_ts_record *pTS =3D NULL;
-	//bool bIsAggregateFrame =3D false;
 	/* added by amy for reorder */
 #ifdef NOT_YET
 	struct net_device *wds =3D NULL;
@@ -910,7 +892,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 	int from_assoc_ap =3D 0;
 	void *sta =3D NULL;
 #endif
-//	u16 qos_ctl =3D 0;
 	u8 dst[ETH_ALEN];
 	u8 src[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
@@ -945,7 +926,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct=
 sk_buff *skb,
 		rx_stats->bContainHTC =3D true;
 	}

-	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
 #ifdef NOT_YET
 	/*
 	 * Put this code here so that we avoid duplicating it in all
@@ -1028,7 +1008,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	else
 	{
 		struct rx_ts_record *pRxTS =3D NULL;
-			//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): QOS ENABLE AND RECEIVE Q=
OS DATA , we will get Ts, tid:%d\n",__func__, tid);
 		if(GetTs(
 				ieee,
 				(struct ts_common_info **) &pRxTS,
@@ -1038,7 +1017,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 				true))
 		{

-		//	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->rx_last_frag_num =
is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pRxTS-=
>rx_last_frag_num,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
 			if ((fc & (1<<11)) &&
 			    (frag =3D=3D pRxTS->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) =3D=3D pRxTS->rx_last_seq_num)) {
@@ -1059,7 +1037,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 	if (type =3D=3D IEEE80211_FTYPE_MGMT) {


-	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
 		if (ieee80211_rx_frame_mgmt(ieee, skb, rx_stats, type, stype))
 			goto rx_dropped;
 		else
@@ -1125,7 +1102,6 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 		}
 	}
 #endif
-	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
 	/*
 	 * Nullfunc frames may have PS-bit set, so they must be passed to
 	 * hostap_handle_sta_rx() before being dropped here.
@@ -1487,8 +1463,6 @@ static int ieee80211_qos_convert_ac_to_parameters(st=
ruct
 	int i;
 	struct ieee80211_qos_ac_parameter *ac_params;
 	u8 aci;
-	//u8 cw_min;
-	//u8 cw_max;

 	for (i =3D 0; i < QOS_QUEUE_NUM; i++) {
 		ac_params =3D &(param_elm->ac_params_record[i]);
@@ -1583,7 +1557,6 @@ static const char *get_info_element_string(u16 id)
 		MFIE_STRING(MEASURE_REPORT);
 		MFIE_STRING(QUIET);
 		MFIE_STRING(IBSS_DFS);
-	       // MFIE_STRING(ERP_INFO);
 		MFIE_STRING(RSN);
 		MFIE_STRING(RATES_EX);
 		MFIE_STRING(GENERIC);
@@ -1639,7 +1612,6 @@ int ieee80211_parse_info_param(struct ieee80211_devi=
ce *ieee,
 	u16	tmp_htinfo_len=3D0;
 	u16 ht_realtek_agg_len=3D0;
 	u8  ht_realtek_agg_buf[MAX_IE_LEN];
-//	u16 broadcom_len =3D 0;
 #ifdef CONFIG_IEEE80211_DEBUG
 	char rates_str[64];
 	char *p;
@@ -1777,12 +1749,11 @@ int ieee80211_parse_info_param(struct ieee80211_de=
vice *ieee,

 				break;

-			offset =3D (ieee->assoc_id / 8) - offset;// + ((aid % 8)? 0 : 1) ;
+			offset =3D (ieee->assoc_id / 8) - offset;

 			if(info_element->data[3+offset] & (1<<(ieee->assoc_id%8)))
 				network->dtim_data |=3D IEEE80211_DTIM_UCAST;

-			//IEEE80211_DEBUG_MGMT("MFIE_TYPE_TIM: partially ignored\n");
 			break;

 		case MFIE_TYPE_ERP:
@@ -2162,12 +2133,9 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 	{
 		RetSS =3D CurrSS;
 	}
-	//RT_TRACE(COMP_DBG, DBG_LOUD, ("##### After Mapping:  LastSS: %d, CurrS=
S: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));

 	/* Step 2. Smoothing. */

-	//RT_TRACE(COMP_DBG, DBG_LOUD, ("$$$$$ After Smoothing:  LastSS: %d, Cur=
rSS: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));
-
 	return RetSS;
 }

@@ -2189,10 +2157,6 @@ static inline int ieee80211_network_init(
 	struct ieee80211_network *network,
 	struct ieee80211_rx_stats *stats)
 {
-#ifdef CONFIG_IEEE80211_DEBUG
-	//char rates_str[64];
-	//char *p;
-#endif

 	network->qos_data.active =3D 0;
 	network->qos_data.supported =3D 0;
@@ -2226,8 +2190,7 @@ static inline int ieee80211_network_init(
 #endif
 	network->CountryIeLen =3D 0;
 	memset(network->CountryIeBuf, 0, MAX_IE_LEN);
-/* Initialize HT parameters */
-	//ieee80211_ht_initialize(&network->bssht);
+	/* Initialize HT parameters */
 	HTInitializeBssDesc(&network->bssht);
 	if (stats->freq =3D=3D IEEE80211_52GHZ_BAND) {
 		/* for A band (No DS info) */
@@ -2271,7 +2234,6 @@ static inline int ieee80211_network_init(
 		network->flags |=3D NETWORK_EMPTY_ESSID;

 	stats->signal =3D 30 + (stats->SignalStrength * 70) / 100;
-	//stats->signal =3D ieee80211_SignalStrengthTranslate(stats->signal);
 	stats->noise =3D ieee80211_translate_todbm((u8)(100-stats->signal)) -25;

 	memcpy(&network->stats, stats, sizeof(network->stats));
@@ -2356,9 +2318,7 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,

 	dst->last_scanned =3D jiffies;
 	/* qos related parameters */
-	//qos_active =3D src->qos_data.active;
 	qos_active =3D dst->qos_data.active;
-	//old_param =3D dst->qos_data.old_param_count;
 	old_param =3D dst->qos_data.param_count;
 	if(dst->flags & NETWORK_HAS_QOS_MASK)
 		memcpy(&dst->qos_data, &src->qos_data,
@@ -2389,7 +2349,6 @@ static inline void update_network(struct ieee80211_n=
etwork *dst,
 	   src->wmm_param[3].aci_aifsn) {
 	  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 	}
-	//dst->QoS_Enable =3D src->QoS_Enable;
 #ifdef THOMAS_TURBO
 	dst->Turbo_Enable =3D src->Turbo_Enable;
 #endif
@@ -2430,7 +2389,6 @@ static inline void ieee80211_process_probe_response(
 	unsigned long flags;
 	short renew;
 	u16 capability;
-	//u8 wmm_info;

 	network =3D kzalloc(sizeof(*network), GFP_ATOMIC);
 	if (!network)
@@ -2617,8 +2575,6 @@ static inline void ieee80211_process_probe_response(
 		/* YJ,add,080819,for hidden ap */
 		if(is_beacon(beacon->header.frame_ctl) =3D=3D 0)
 			network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWORK_EM=
PTY_ESSID & target->flags);
-		//if(strncmp(network->ssid, "linksys-c",9) =3D=3D 0)
-		//	printk("=3D=3D=3D=3D>2 network->ssid=3D%s FLAG=3D%d target.ssid=3D%s=
 FLAG=3D%d\n", network->ssid, network->flags, target->ssid, target->flags)=
;
 		if(((network->flags & NETWORK_EMPTY_ESSID) =3D=3D NETWORK_EMPTY_ESSID) =
\
 		    && (((network->ssid_len > 0) && (strncmp(target->ssid, network->ssi=
d, network->ssid_len)))\
 		    ||((ieee->current_network.ssid_len =3D=3D network->ssid_len)&&(strn=
cmp(ieee->current_network.ssid, network->ssid, network->ssid_len) =3D=3D 0=
)&&(ieee->state =3D=3D IEEE80211_NOLINK))))
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/driv=
ers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 27e81a1de51e..4f649fcc7c1d 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -153,7 +153,6 @@ static void enqueue_mgmt(struct ieee80211_device *ieee=
, struct sk_buff *skb)
 	ieee->mgmt_queue_head =3D nh;
 	ieee->mgmt_queue_ring[nh] =3D skb;

-	//return 0;
 }

 static struct sk_buff *dequeue_mgmt(struct ieee80211_device *ieee)
@@ -245,7 +244,6 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, str=
uct ieee80211_device *ieee
 			/* avoid watchdog triggers */
 			netif_trans_update(ieee->dev);
 			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
-			//dev_kfree_skb_any(skb);//edit by thomas
 		}

 		spin_unlock_irqrestore(&ieee->lock, flags);
@@ -273,7 +271,6 @@ inline void softmac_mgmt_xmit(struct sk_buff *skb, str=
uct ieee80211_device *ieee
 			skb_queue_tail(&ieee->skb_waitQ[tcb_desc->queue_index], skb);
 		} else {
 			ieee->softmac_hard_start_xmit(skb, ieee->dev);
-			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 		spin_unlock_irqrestore(&ieee->mgmt_tx_lock, flags);
 	}
@@ -307,7 +304,6 @@ softmac_ps_mgmt_xmit(struct sk_buff *skb, struct ieee8=
0211_device *ieee)

 		ieee->softmac_hard_start_xmit(skb, ieee->dev);
 	}
-	//dev_kfree_skb_any(skb);//edit by thomas
 }

 static inline struct sk_buff *ieee80211_probe_req(struct ieee80211_device=
 *ieee)
@@ -356,25 +352,17 @@ static void ieee80211_send_beacon(struct ieee80211_d=
evice *ieee)

 	if (!ieee->ieee_up)
 		return;
-	//unsigned long flags;
 	skb =3D ieee80211_get_beacon_(ieee);

 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
 		ieee->softmac_stats.tx_beacons++;
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
-//	ieee->beacon_timer.expires =3D jiffies +
-//		(MSECS( ieee->current_network.beacon_interval -5));

-	//spin_lock_irqsave(&ieee->beacon_lock,flags);
 	if (ieee->beacon_txing && ieee->ieee_up) {
-//		if(!timer_pending(&ieee->beacon_timer))
-//			add_timer(&ieee->beacon_timer);
 		mod_timer(&ieee->beacon_timer,
 			  jiffies + msecs_to_jiffies(ieee->current_network.beacon_interval - 5=
));
 	}
-	//spin_unlock_irqrestore(&ieee->beacon_lock,flags);
 }

 static void ieee80211_send_beacon_cb(struct timer_list *t)
@@ -396,7 +384,6 @@ static void ieee80211_send_probe(struct ieee80211_devi=
ce *ieee)
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
 		ieee->softmac_stats.tx_probe_rq++;
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }

@@ -559,12 +546,7 @@ EXPORT_SYMBOL(ieee80211_start_send_beacons);

 static void ieee80211_softmac_stop_scan(struct ieee80211_device *ieee)
 {
-//	unsigned long flags;
-
-	//ieee->sync_scan_hurryup =3D 1;
-
 	mutex_lock(&ieee->scan_mutex);
-//	spin_lock_irqsave(&ieee->lock, flags);

 	if (ieee->scanning =3D=3D 1) {
 		ieee->scanning =3D 0;
@@ -572,7 +554,6 @@ static void ieee80211_softmac_stop_scan(struct ieee802=
11_device *ieee)
 		cancel_delayed_work(&ieee->softmac_scan_wq);
 	}

-//	spin_unlock_irqrestore(&ieee->lock, flags);
 	mutex_unlock(&ieee->scan_mutex);
 }

@@ -644,7 +625,6 @@ ieee80211_authentication_req(struct ieee80211_network =
*beacon,
 	memcpy(auth->header.addr2, ieee->dev->dev_addr, ETH_ALEN);
 	memcpy(auth->header.addr3, beacon->bssid, ETH_ALEN);

-	//auth->algorithm =3D ieee->open_wep ? WLAN_AUTH_OPEN : WLAN_AUTH_SHARED=
_KEY;
 	if (ieee->auth_mode =3D=3D 0)
 		auth->algorithm =3D WLAN_AUTH_OPEN;
 	else if (ieee->auth_mode =3D=3D 1)
@@ -715,7 +695,6 @@ static struct sk_buff *ieee80211_probe_resp(struct iee=
e80211_device *ieee, u8 *d
 		tmp_generic_ie_len =3D sizeof(ieee->pHTInfo->szRT2RTAggBuffer);
 		HTConstructRT2RTAggElement(ieee, tmp_generic_ie_buf, &tmp_generic_ie_le=
n);
 	}
-//	printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>tmp_ht_cap_len i=
s %d,tmp_ht_info_len is %d, tmp_generic_ie_len is %d\n",tmp_ht_cap_len,tmp=
_ht_info_len,tmp_generic_ie_len);
 	beacon_size =3D sizeof(struct ieee80211_probe_response) + 2
 		+ ssid_len
 		+ 3 /* channel */
@@ -802,7 +781,6 @@ static struct sk_buff *ieee80211_probe_resp(struct iee=
e80211_device *ieee, u8 *d
 		tag +=3D wpa_ie_len;
 	}

-	//skb->dev =3D ieee->dev;
 	return skb;
 }

@@ -943,15 +921,9 @@ ieee80211_association_req(struct ieee80211_network *b=
eacon,
 			  struct ieee80211_device *ieee)
 {
 	struct sk_buff *skb;
-	//unsigned long flags;

 	struct ieee80211_assoc_request_frame *hdr;
-	u8 *tag;//,*rsn_ie;
-	//short info_addr =3D 0;
-	//int i;
-	//u16 suite_count =3D 0;
-	//u8 suit_select =3D 0;
-	//unsigned int wpa_len =3D beacon->wpa_ie_len;
+	u8 *tag;
 	/* for HT */
 	u8 *ht_cap_buf =3D NULL;
 	u8 ht_cap_len =3D 0;
@@ -1159,8 +1131,7 @@ ieee80211_association_req(struct ieee80211_network *=
beacon,
 			memcpy(tag, realtek_ie_buf, realtek_ie_len - 2);
 		}
 	}
-//	printk("<=3D=3D=3D=3D=3D%s(), %p, %p\n", __func__, ieee->dev, ieee->de=
v->dev_addr);
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, skb->data, skb->len);
+
 	return skb;
 }

@@ -1222,7 +1193,6 @@ static void ieee80211_associate_step1(struct ieee802=
11_device *ieee)
 			ieee->associate_timer.expires =3D jiffies + (HZ / 2);
 			add_timer(&ieee->associate_timer);
 		}
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }

@@ -1233,7 +1203,6 @@ static void ieee80211_auth_challenge(struct ieee8021=
1_device *ieee,
 	u8 *c;
 	struct sk_buff *skb;
 	struct ieee80211_network *beacon =3D &ieee->current_network;
-//	int hlen =3D sizeof(struct ieee80211_authentication);

 	ieee->associate_seq++;
 	ieee->softmac_stats.tx_auth_rq++;
@@ -1253,7 +1222,6 @@ static void ieee80211_auth_challenge(struct ieee8021=
1_device *ieee,

 		softmac_mgmt_xmit(skb, ieee);
 		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 	kfree(challenge);
 }
@@ -1274,7 +1242,6 @@ static void ieee80211_associate_step2(struct ieee802=
11_device *ieee)
 	} else {
 		softmac_mgmt_xmit(skb, ieee);
 		mod_timer(&ieee->associate_timer, jiffies + (HZ / 2));
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }
 static void ieee80211_associate_complete_wq(struct work_struct *work)
@@ -1295,7 +1262,6 @@ static void ieee80211_associate_complete_wq(struct w=
ork_struct *work)
 	} else {
 		printk("Successfully associated, ht not enabled(%d, %d)\n", ieee->pHTIn=
fo->bCurrentHTSupport, ieee->pHTInfo->bEnableHT);
 		memset(ieee->dot11HTOperationalRateSet, 0, 16);
-		//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EX=
T);
 	}
 	ieee->LinkDetectInfo.SlotNum =3D 2 * (1 + ieee->current_network.beacon_i=
nterval / 500);
 	/* To prevent the immediately calling watch_dog after association. */
@@ -1319,12 +1285,9 @@ static void ieee80211_associate_complete_wq(struct =
work_struct *work)

 static void ieee80211_associate_complete(struct ieee80211_device *ieee)
 {
-//	int i;
-//	struct net_device* dev =3D ieee->dev;
 	del_timer_sync(&ieee->associate_timer);

 	ieee->state =3D IEEE80211_LINKED;
-	//ieee->UpdateHalRATRTableHandler(dev, ieee->dot11HTOperationalRateSet);
 	schedule_work(&ieee->associate_complete_wq);
 }

@@ -1339,7 +1302,6 @@ static void ieee80211_associate_procedure_wq(struct =
work_struct *work)

 	ieee80211_stop_scan(ieee);
 	printk("=3D=3D=3D>%s(), chan:%d\n", __func__, ieee->current_network.chan=
nel);
-	//ieee->set_chan(ieee->dev, ieee->current_network.channel);
 	HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT);

 	ieee->associate_seq =3D 1;
@@ -1374,8 +1336,8 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee
 		 * This could be obtained by beacons or, if the network does not
 		 * broadcast it, it can be put manually.
 		 */
-		apset =3D ieee->wap_set;//(memcmp(ieee->current_network.bssid, zero,ETH=
_ALEN)!=3D0 );
-		ssidset =3D ieee->ssid_set;//ieee->current_network.ssid[0] !=3D '\0';
+		apset =3D ieee->wap_set;
+		ssidset =3D ieee->ssid_set;
 		ssidbroad =3D  !(net->ssid_len =3D=3D 0 || net->ssid[0] =3D=3D '\0');
 		apmatch =3D (memcmp(ieee->current_network.bssid, net->bssid, ETH_ALEN) =
=3D=3D 0);
 		ssidmatch =3D (ieee->current_network.ssid_len =3D=3D net->ssid_len) &&
@@ -1413,7 +1375,6 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee
 			       ieee->pHTInfo->bEnableHT,
 			       ieee->current_network.bssht.bdSupportHT);

-			//ieee->pHTInfo->IOTAction =3D 0;
 			HTResetIOTSetting(ieee->pHTInfo);
 			if (ieee->iw_mode =3D=3D IW_MODE_INFRA) {
 				/* Join the network for the first time */
@@ -1422,8 +1383,13 @@ inline void ieee80211_softmac_new_net(struct ieee80=
211_device *ieee, struct ieee
 				if ((ieee->current_network.qos_data.supported =3D=3D 1) &&
 				    // (ieee->pHTInfo->bEnableHT && ieee->current_network.bssht.bdSup=
portHT))
 				    ieee->current_network.bssht.bdSupportHT) {
-/*WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going to p=
ut together to check whether we are in HT now, so needn't to check bEnable=
HT flags here. That's is to say we will set to HT support whenever joined =
AP has the ability to support HT. And whether we are in HT or not, please =
check bCurrentHTSupport&&bEnableHT now please.*/
-					//	ieee->pHTInfo->bCurrentHTSupport =3D true;
+				/*
+				 * WB, 2008.09.09:bCurrentHTSupport and bEnableHT two flags are going=
 to put
+				 * together to check whether we are in HT now,
+				 * so needn't to check bEnableHT flags here. That's is to say we will=
 set to HT
+				 * support whenever joined AP has the ability to support HT. And whet=
her we
+				 * are in HT or not, please check bCurrentHTSupport&&bEnableHT now pl=
ease.
+				 */
 					HTResetSelfAndSavePeerSetting(ieee, &ieee->current_network);
 				} else {
 					ieee->pHTInfo->bCurrentHTSupport =3D false;
@@ -1443,7 +1409,6 @@ inline void ieee80211_softmac_new_net(struct ieee802=
11_device *ieee, struct ieee
 					printk(KERN_INFO"Using B rates\n");
 				}
 				memset(ieee->dot11HTOperationalRateSet, 0, 16);
-				//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_=
EXT);
 				ieee->state =3D IEEE80211_LINKED;
 			}
 		}
@@ -1545,7 +1510,6 @@ static short probe_rq_parse(struct ieee80211_device =
*ieee, struct sk_buff *skb,
 		tag++; /* point to the next tag */
 	}

-	//IEEE80211DMESG("Card MAC address is "MACSTR, MAC2STR(src));
 	if (ssidlen =3D=3D 0)
 		return 1;

@@ -1604,11 +1568,8 @@ ieee80211_rx_probe_rq(struct ieee80211_device *ieee=
, struct sk_buff *skb)
 {
 	u8 dest[ETH_ALEN];

-	//IEEE80211DMESG("Rx probe");
 	ieee->softmac_stats.rx_probe_rq++;
-	//DMESG("Dest is "MACSTR, MAC2STR(dest));
 	if (probe_rq_parse(ieee, skb, dest)) {
-		//IEEE80211DMESG("Was for me!");
 		ieee->softmac_stats.tx_probe_rs++;
 		ieee80211_resp_to_probe(ieee, dest);
 	}
@@ -1619,20 +1580,17 @@ ieee80211_rx_auth_rq(struct ieee80211_device *ieee=
, struct sk_buff *skb)
 {
 	u8 dest[ETH_ALEN];
 	int status;
-	//IEEE80211DMESG("Rx probe");
 	ieee->softmac_stats.rx_auth_rq++;

 	status =3D auth_rq_parse(skb, dest);
 	if (status !=3D -1)
 		ieee80211_resp_to_auth(ieee, status, dest);
-	//DMESG("Dest is "MACSTR, MAC2STR(dest));
 }

 static inline void
 ieee80211_rx_assoc_rq(struct ieee80211_device *ieee, struct sk_buff *skb)
 {
 	u8 dest[ETH_ALEN];
-	//unsigned long flags;

 	ieee->softmac_stats.rx_ass_rq++;
 	if (assoc_rq_parse(skb, dest) !=3D -1)
@@ -1657,12 +1615,7 @@ static short ieee80211_sta_ps_sleep(struct ieee8021=
1_device *ieee, u32 *time_h,
 {
 	int timeout;
 	u8 dtim;
-	/*if(ieee->ps =3D=3D IEEE80211_PS_DISABLED ||
-		ieee->iw_mode !=3D IW_MODE_INFRA ||
-		ieee->state !=3D IEEE80211_LINKED)

-		return 0;
-	*/
 	dtim =3D ieee->current_network.dtim_data;
 	if (!(dtim & IEEE80211_DTIM_VALID))
 		return 0;
@@ -1728,7 +1681,6 @@ static inline void ieee80211_sta_ps(struct ieee80211=
_device *ieee)
 		if (ieee->sta_sleep =3D=3D 1) {
 			ieee->enter_sleep_state(ieee->dev, th, tl);
 		} else if (ieee->sta_sleep =3D=3D 0) {
-		//	printk("send null 1\n");
 			spin_lock_irqsave(&ieee->mgmt_tx_lock, flags2);

 			if (ieee->ps_is_queue_empty(ieee->dev)) {
@@ -1811,7 +1763,6 @@ static void ieee80211_process_action(struct ieee8021=
1_device *ieee,
 	struct rtl_80211_hdr *header =3D (struct rtl_80211_hdr *)skb->data;
 	u8 *act =3D ieee80211_get_payload(header);
 	u8 tmp =3D 0;
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb=
->len);
 	if (act =3D=3D NULL) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR, "error to get payload of action frame=
\n");
 		return;
@@ -1901,7 +1852,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 	u16 errcode;
 	int aid;
 	struct ieee80211_assoc_response_frame *assoc_resp;
-//	struct ieee80211_info_element *info_element;

 	if (!ieee->proto_started)
 		return 0;
@@ -2005,7 +1955,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 			ieee->softmac_stats.reassoc++;

 			notify_wx_assoc_event(ieee);
-			//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_E=
XT);
 			RemovePeerTS(ieee, header->addr2);
 			schedule_work(&ieee->associate_procedure_wq);
 		}
@@ -2017,7 +1966,6 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *=
ieee, struct sk_buff *skb,
 		return -1;
 	}

-	//dev_kfree_skb_any(skb);
 	return 0;
 }

@@ -2083,9 +2031,6 @@ void ieee80211_softmac_xmit(struct ieee80211_txb *tx=
b, struct ieee80211_device *
 		} else {
 			ieee->softmac_data_hard_start_xmit(txb->fragments[i],
 							   ieee->dev, ieee->rate);
-			//ieee->stats.tx_packets++;
-			//ieee->stats.tx_bytes +=3D txb->fragments[i]->len;
-			//ieee->dev->trans_start =3D jiffies;
 		}
 	}
 	ieee80211_txb_free(txb);
@@ -2106,7 +2051,6 @@ static void ieee80211_resume_tx(struct ieee80211_dev=
ice *ieee)
 		} else {
 			ieee->softmac_data_hard_start_xmit(ieee->tx_pending.txb->fragments[i],
 							   ieee->dev, ieee->rate);
-			//(i+1)<ieee->tx_pending.txb->nr_frags);
 			ieee->stats.tx_packets++;
 			netif_trans_update(ieee->dev);
 		}
@@ -2155,7 +2099,6 @@ void ieee80211_wake_queue(struct ieee80211_device *i=
eee)
 				ieee->seq_ctrl[0]++;

 			ieee->softmac_data_hard_start_xmit(skb, ieee->dev, ieee->basic_rate);
-			//dev_kfree_skb_any(skb);//edit by thomas
 		}
 	}
 	if (!ieee->queue_stop && ieee->tx_pending.txb)
@@ -2172,15 +2115,12 @@ EXPORT_SYMBOL(ieee80211_wake_queue);

 void ieee80211_stop_queue(struct ieee80211_device *ieee)
 {
-	//unsigned long flags;
-	//spin_lock_irqsave(&ieee->lock,flags);

 	if (!netif_queue_stopped(ieee->dev)) {
 		netif_stop_queue(ieee->dev);
 		ieee->softmac_stats.swtxstop++;
 	}
 	ieee->queue_stop =3D 1;
-	//spin_unlock_irqrestore(&ieee->lock,flags);
 }
 EXPORT_SYMBOL(ieee80211_stop_queue);

@@ -2383,7 +2323,6 @@ void ieee80211_disassociate(struct ieee80211_device =
*ieee)
 	ieee->state =3D IEEE80211_NOLINK;
 	ieee->is_set_key =3D false;
 	ieee->link_change(ieee->dev);
-	//HTSetConnectBwMode(ieee, HT_CHANNEL_WIDTH_20, HT_EXTCHNL_OFFSET_NO_EXT=
);
 	notify_wx_assoc_event(ieee);
 }
 EXPORT_SYMBOL(ieee80211_disassociate);
@@ -2525,8 +2464,6 @@ void ieee80211_start_protocol(struct ieee80211_devic=
e *ieee)

 	if (ieee->current_network.beacon_interval =3D=3D 0)
 		ieee->current_network.beacon_interval =3D 100;
-//	printk("=3D=3D=3D>%s(), chan:%d\n", __func__, ieee->current_network.ch=
annel);
-//	ieee->set_chan(ieee->dev,ieee->current_network.channel);

 	for (i =3D 0; i < 17; i++) {
 		ieee->last_rxseq_num[i] =3D -1;
@@ -2732,8 +2669,6 @@ static int ieee80211_wpa_set_auth_algs(struct ieee80=
211_device *ieee, int value)

 	if (ieee->set_security)
 		ieee->set_security(ieee->dev, &sec);
-	//else
-	//	ret =3D -EOPNOTSUPP;

 	return 0;
 }
@@ -2849,7 +2784,7 @@ static int ieee80211_wpa_set_encryption(struct ieee8=
0211_device *ieee,
 		if (crypt) {
 			sec.enabled =3D 0;
 			/* FIXME FIXME */
-			//sec.encrypt =3D 0;
+			/* sec.encrypt =3D 0; */
 			sec.level =3D SEC_LEVEL_0;
 			sec.flags |=3D SEC_ENABLED | SEC_LEVEL;
 			ieee80211_crypt_delayed_deinit(ieee, crypt);
@@ -2858,7 +2793,7 @@ static int ieee80211_wpa_set_encryption(struct ieee8=
0211_device *ieee,
 	}
 	sec.enabled =3D 1;
 /* FIXME FIXME */
-//	sec.encrypt =3D 1;
+/*	sec.encrypt =3D 1; */
 	sec.flags |=3D SEC_ENABLED;

 	/* IPW HW cannot build TKIP MIC, host decryption still needed. */
@@ -3000,7 +2935,6 @@ SendDisassociation(struct ieee80211_device *ieee,
 	skb =3D ieee80211_disassociate_skb(beacon, ieee, asRsn);
 	if (skb) {
 		softmac_mgmt_xmit(skb, ieee);
-		//dev_kfree_skb_any(skb);//edit by thomas
 	}
 }
 EXPORT_SYMBOL(SendDisassociation);
@@ -3011,7 +2945,6 @@ int ieee80211_wpa_supplicant_ioctl(struct ieee80211_=
device *ieee, struct iw_poin
 	int ret =3D 0;

 	mutex_lock(&ieee->wx_mutex);
-	//IEEE_DEBUG_INFO("wpa_supplicant: len=3D%d\n", p->length);

 	if (p->length < sizeof(struct ieee_param) || !p->pointer) {
 		ret =3D -EINVAL;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/d=
rivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index 2bf333c12bbc..2f25eae5e8c0 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -94,8 +94,6 @@ int ieee80211_wx_get_freq(struct ieee80211_device *ieee,
 	/* NM 0.7.0 will not accept channel any more. */
 	fwrq->m =3D ieee80211_wlan_frequencies[ieee->current_network.channel-1] =
* 100000;
 	fwrq->e =3D 1;
-	/* fwrq->m =3D ieee->current_network.channel; */
-	/* fwrq->e =3D 0; */

 	return 0;
 }
@@ -139,7 +137,7 @@ int ieee80211_wx_set_wap(struct ieee80211_device *ieee=
,
 	int ret =3D 0;
 	unsigned long flags;

-	short ifup =3D ieee->proto_started; /* dev->flags & IFF_UP; */
+	short ifup =3D ieee->proto_started;
 	struct sockaddr *temp =3D (struct sockaddr *)awrq;

 	ieee->sync_scan_hurryup =3D 1;
@@ -522,16 +520,11 @@ int ieee80211_wx_set_power(struct ieee80211_device *=
ieee,
 		goto exit;
 	}
 	if (wrqu->power.flags & IW_POWER_TIMEOUT) {
-		/* ieee->ps_period =3D wrqu->power.value / 1000; */
 		ieee->ps_timeout =3D wrqu->power.value / 1000;
 	}

 	if (wrqu->power.flags & IW_POWER_PERIOD) {
-
-		/* ieee->ps_timeout =3D wrqu->power.value / 1000; */
 		ieee->ps_period =3D wrqu->power.value / 1000;
-		/* wrq->value / 1024; */
-
 	}
 	switch (wrqu->power.flags & IW_POWER_MODE) {
 	case IW_POWER_UNICAST_R:
@@ -545,7 +538,6 @@ int ieee80211_wx_set_power(struct ieee80211_device *ie=
ee,
 		break;

 	case IW_POWER_ON:
-		/* ieee->ps =3D IEEE80211_PS_DISABLED; */
 		break;

 	default:
@@ -578,11 +570,8 @@ int ieee80211_wx_get_power(struct ieee80211_device *i=
eee,
 		wrqu->power.flags =3D IW_POWER_TIMEOUT;
 		wrqu->power.value =3D ieee->ps_timeout * 1000;
 	} else {
-		/* ret =3D -EOPNOTSUPP; */
-		/* goto exit; */
 		wrqu->power.flags =3D IW_POWER_PERIOD;
 		wrqu->power.value =3D ieee->ps_period * 1000;
-		/* ieee->current_network.dtim_period * ieee->current_network.beacon_int=
erval * 1024; */
 	}

 	if ((ieee->ps & (IEEE80211_PS_MBCAST | IEEE80211_PS_UNICAST)) =3D=3D (IE=
EE80211_PS_MBCAST | IEEE80211_PS_UNICAST))
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_tx.c
index f5c991f6d34f..320021752f28 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -218,7 +218,6 @@ int ieee80211_encrypt_fragment(


 void ieee80211_txb_free(struct ieee80211_txb *txb) {
-	//int i;
 	if (unlikely(!txb))
 		return;
 	kfree(txb);
@@ -767,7 +766,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_dev=
ice *dev)
 			skb_frag =3D txb->fragments[i];
 			tcb_desc =3D (struct cb_desc *)(skb_frag->cb + MAX_DEV_ADDR_SIZE);
 			if(qos_actived){
-				skb_frag->priority =3D skb->priority;//UP2AC(skb->priority);
+				skb_frag->priority =3D skb->priority;
 				tcb_desc->queue_index =3D  UP2AC(skb->priority);
 			} else {
 				skb_frag->priority =3D WME_AC_BK;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/s=
taging/rtl8192u/ieee80211/ieee80211_wx.c
index 6cf9e25d6607..b09fd717b760 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -60,7 +60,6 @@ static inline char *rtl819x_translate_scan(struct ieee80=
211_device *ieee,
 	/* Add the ESSID */
 	iwe.cmd =3D SIOCGIWESSID;
 	iwe.u.data.flags =3D 1;
-//	if (network->flags & NETWORK_EMPTY_ESSID) {
 	if (network->ssid_len =3D=3D 0) {
 		iwe.u.data.length =3D sizeof("<hidden>");
 		start =3D iwe_stream_add_point(info, start, stop, &iwe, "<hidden>");
@@ -92,8 +91,6 @@ static inline char *rtl819x_translate_scan(struct ieee80=
211_device *ieee,

 	/* Add frequency/channel */
 	iwe.cmd =3D SIOCGIWFREQ;
-/*	iwe.u.freq.m =3D ieee80211_frequency(network->channel, network->mode);
-	iwe.u.freq.e =3D 3; */
 	iwe.u.freq.m =3D network->channel;
 	iwe.u.freq.e =3D 0;
 	iwe.u.freq.i =3D 0;
@@ -182,7 +179,6 @@ static inline char *rtl819x_translate_scan(struct ieee=
80211_device *ieee,

 	if (ieee->wpa_enabled && network->wpa_ie_len) {
 		char buf[MAX_WPA_IE_LEN * 2 + 30];
-	//	printk("WPA IE\n");
 		u8 *p =3D buf;
 		p +=3D sprintf(p, "wpa_ie=3D");
 		for (i =3D 0; i < network->wpa_ie_len; i++) {
@@ -234,9 +230,7 @@ int ieee80211_wx_get_scan(struct ieee80211_device *iee=
e,
 	unsigned long flags;

 	char *ev =3D extra;
-//	char *stop =3D ev + IW_SCAN_MAX_DATA;
 	char *stop =3D ev + wrqu->data.length;/* IW_SCAN_MAX_DATA; */
-	//char *stop =3D ev + IW_SCAN_MAX_DATA;
 	int i =3D 0;
 	int err =3D 0;
 	IEEE80211_DEBUG_WX("Getting scan\n");
@@ -541,7 +535,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_devic=
e *ieee,
 			return -EINVAL;
 	}

-	sec.flags |=3D SEC_ENABLED;// | SEC_ENCRYPT;
+	sec.flags |=3D SEC_ENABLED;
 	if ((encoding->flags & IW_ENCODE_DISABLED) ||
 	    ext->alg =3D=3D IW_ENCODE_ALG_NONE) {
 		if (*crypt)
@@ -555,7 +549,6 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_devic=
e *ieee,

 		if (i =3D=3D WEP_KEYS) {
 			sec.enabled =3D 0;
-		      //  sec.encrypt =3D 0;
 			sec.level =3D SEC_LEVEL_0;
 			sec.flags |=3D SEC_LEVEL;
 		}
@@ -563,7 +556,6 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_devic=
e *ieee,
 	}

 	sec.enabled =3D 1;
-    //    sec.encrypt =3D 1;
 	switch (ext->alg) {
 	case IW_ENCODE_ALG_WEP:
 		alg =3D "WEP";
@@ -631,19 +623,15 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_dev=
ice *ieee,
 	}

 	if (ext->alg !=3D IW_ENCODE_ALG_NONE) {
-		//memcpy(sec.keys[idx], ext->key, ext->key_len);
 		sec.key_sizes[idx] =3D ext->key_len;
 		sec.flags |=3D BIT(idx);
 		if (ext->alg =3D=3D IW_ENCODE_ALG_WEP) {
-		      //  sec.encode_alg[idx] =3D SEC_ALG_WEP;
 			sec.flags |=3D SEC_LEVEL;
 			sec.level =3D SEC_LEVEL_1;
 		} else if (ext->alg =3D=3D IW_ENCODE_ALG_TKIP) {
-		      //  sec.encode_alg[idx] =3D SEC_ALG_TKIP;
 			sec.flags |=3D SEC_LEVEL;
 			sec.level =3D SEC_LEVEL_2;
 		} else if (ext->alg =3D=3D IW_ENCODE_ALG_CCMP) {
-		       // sec.encode_alg[idx] =3D SEC_ALG_CCMP;
 			sec.flags |=3D SEC_LEVEL;
 			sec.level =3D SEC_LEVEL_3;
 		}
@@ -761,8 +749,6 @@ int ieee80211_wx_set_auth(struct ieee80211_device *iee=
e,
 		break;

 	case IW_AUTH_80211_AUTH_ALG:
-		//printk("=3D=3D=3D=3D=3D=3D>%s():data->value is %d\n",__func__,data->v=
alue);
-	//	ieee->open_wep =3D (data->value&IW_AUTH_ALG_OPEN_SYSTEM)?1:0;
 		if (data->value & IW_AUTH_ALG_SHARED_KEY) {
 			ieee->open_wep =3D 0;
 			ieee->auth_mode =3D 1;
@@ -800,8 +786,7 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *i=
eee, u8 *ie, size_t len)

 	if (len>MAX_WPA_IE_LEN || (len && ie =3D=3D NULL))
 	{
-	//	printk("return error out, len:%d\n", len);
-	return -EINVAL;
+		return -EINVAL;
 	}


diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index adfe1878f36d..aed114573edb 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -164,7 +164,6 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee8021=
1_device *ieee, u8 *Dst, s

 	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb->=
len);
 	return skb;
-	//return NULL;
 }


@@ -205,7 +204,6 @@ static struct sk_buff *ieee80211_DELBA(
 	skb =3D dev_alloc_skb(len + sizeof(struct rtl_80211_hdr_3addr)); /* need=
 to add something others? FIXME */
 	if (!skb)
 		return NULL;
-//	memset(skb->data, 0, len+sizeof( struct rtl_80211_hdr_3addr));
 	skb_reserve(skb, ieee->tx_headroom);

 	Delba =3D skb_put(skb, sizeof(struct rtl_80211_hdr_3addr));
@@ -598,7 +596,6 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, =
struct sk_buff *skb)
 		pTxTs->add_ba_req_in_progress =3D false;
 		pTxTs->add_ba_req_delayed =3D false;
 		del_timer_sync(&pTxTs->ts_add_ba_timer);
-		//PlatformCancelTimer(Adapter, &pTxTs->ts_add_ba_timer);
 		TxTsDeleteBA(ieee, pTxTs);
 	}
 	return 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/sta=
ging/rtl8192u/ieee80211/rtl819x_HT.h
index 5691de03e740..71665b3da617 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -233,8 +233,6 @@ typedef struct _BSS_HT {
 	u16					bdHTInfoLen;

 	HT_SPEC_VER				bdHTSpecVer;
-	//struct ht_capability_ele              bdHTCapEle;
-	//HT_INFORMATION_ELE		bdHTInfoEle;

 	u8					bdRT2RTAggregation;
 	u8					bdRT2RTLongSlotTime;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 4359d6f5735c..c3b6687024cd 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -42,7 +42,6 @@ static u8 BELKINF5D82334V3_RALINK[3] =3D {0x00, 0x1c, 0x=
df};
 static u8 PCI_RALINK[3] =3D {0x00, 0x90, 0xcc};
 static u8 EDIMAX_RALINK[3] =3D {0x00, 0x0e, 0x2e};
 static u8 AIRLINK_RALINK[3] =3D {0x00, 0x18, 0x02};
-//static u8 DLINK_ATHEROS[3] =3D {0x00, 0x1c, 0xf0};
 static u8 CISCO_BROADCOM[3] =3D {0x00, 0x17, 0x94};
 /*
  * 2008/04/01 MH For Cisco G mode RX TP We need to change FW duration. Sh=
ould we
@@ -59,10 +58,7 @@ static u8 CISCO_BROADCOM[3] =3D {0x00, 0x17, 0x94};
 void HTUpdateDefaultSetting(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo =3D ieee->pHTInfo;
-	//const typeof( ((struct ieee80211_device *)0)->pHTInfo ) *__mptr =3D &p=
HTInfo;

-	//printk("pHTinfo:%p, &pHTinfo:%p, mptr:%p,  offsetof:%x\n", pHTInfo, &p=
HTInfo, __mptr, offsetof(struct ieee80211_device, pHTInfo));
-	//printk("=3D=3D=3D>ieee:%p,\n", ieee);
 	/* ShortGI support */
 	pHTInfo->bRegShortGI20MHz =3D 1;
 	pHTInfo->bRegShortGI40MHz =3D 1;
@@ -237,7 +233,6 @@ static u16 HTMcsToDataRate(struct ieee80211_device *ie=
ee, u8 nMcsRate)
  */
 u16  TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate)
 {
-	//PRT_HIGH_THROUGHPUT	pHTInfo =3D ieee->pHTInfo;
 	u16		CCKOFDMRate[12] =3D {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18, 0x24=
, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz =3D 0;
 	u8	isShortGI =3D 0;
@@ -248,23 +243,15 @@ u16  TxCountToDataRate(struct ieee80211_device *ieee=
, u8 nDataRate)
 		if (nDataRate >=3D 0x10 && nDataRate <=3D 0x1f) { //if(nDataRate > 11 &=
& nDataRate < 28 )
 			is40MHz =3D 0;
 			isShortGI =3D 0;
-
-		      // nDataRate =3D nDataRate - 12;
 		} else if (nDataRate >=3D 0x20  && nDataRate <=3D 0x2f) { //(27, 44)
 			is40MHz =3D 1;
 			isShortGI =3D 0;
-
-			//nDataRate =3D nDataRate - 28;
 		} else if (nDataRate >=3D 0x30  && nDataRate <=3D 0x3f) { //(43, 60)
 			is40MHz =3D 0;
 			isShortGI =3D 1;
-
-			//nDataRate =3D nDataRate - 44;
 		} else if (nDataRate >=3D 0x40  && nDataRate <=3D 0x4f) { //(59, 76)
 			is40MHz =3D 1;
 			isShortGI =3D 1;
-
-			//nDataRate =3D nDataRate - 60;
 		}
 		return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 	}
@@ -374,10 +361,7 @@ static bool HTIOTActIsDisableMCS15(struct ieee80211_d=
evice *ieee)
 	retValue =3D true;
 #elif (DEV_BUS_TYPE =3D=3D PCI_INTERFACE)
 	/* Enable MCS15 if the peer is Cisco AP. by Emily, 2008.05.12 */
-//	if(pBssDesc->bCiscoCapExist)
-//		retValue =3D false;
-//	else
-		retValue =3D false;
+	retValue =3D false;
 #endif
 #endif
 #endif
@@ -474,7 +458,6 @@ void HTConstructCapabilityElement(struct ieee80211_dev=
ice *ieee, u8 *posHTCap, u
 {
 	PRT_HIGH_THROUGHPUT	pHT =3D ieee->pHTInfo;
 	struct ht_capability_ele   *pCapELE =3D NULL;
-	//u8 bIsDeclareMCS13;

 	if (!posHTCap || !pHT) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,
@@ -499,13 +482,10 @@ void HTConstructCapabilityElement(struct ieee80211_d=
evice *ieee, u8 *posHTCap, u
 	else
 		pCapELE->ChlWidth =3D (pHT->bRegBW40MHz ? 1 : 0);

-//	pCapELE->ChlWidth		=3D (pHT->bRegBW40MHz?1:0);
 	pCapELE->MimoPwrSave		=3D pHT->SelfMimoPs;
 	pCapELE->GreenField		=3D 0; /* This feature is not supported now!! */
 	pCapELE->ShortGI20Mhz		=3D 1; /* We can receive Short GI!! */
 	pCapELE->ShortGI40Mhz		=3D 1; /* We can receive Short GI!! */
-	//DbgPrint("TX HT cap/info ele BW=3D%d SG20=3D%d SG40=3D%d\n\r",
-	//pCapELE->ChlWidth, pCapELE->ShortGI20Mhz, pCapELE->ShortGI40Mhz);
 	pCapELE->TxSTBC			=3D 1;
 	pCapELE->RxSTBC			=3D 0;
 	pCapELE->DelayBA		=3D 0;	/* Do not support now!! */
@@ -564,13 +544,12 @@ void HTConstructCapabilityElement(struct ieee80211_d=
evice *ieee, u8 *posHTCap, u
 	else
 		*len =3D 26 + 2;

-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTCap, *l=
en -2);

 	/*
 	 * Print each field in detail. Driver should not print out this message
 	 * by default
 	 */
-//	HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()");
+	/* HTDebugHTCapability(posHTCap, (u8*)"HTConstructCapability()"); */
 }

 /*
@@ -621,8 +600,6 @@ void HTConstructInfoElement(struct ieee80211_device *i=
eee, u8 *posHTInfo, u8 *le
 		/* STA should not generate High Throughput Information Element */
 		*len =3D 0;
 	}
-	//IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, posHTInfo, *=
len - 2);
-	//HTDebugHTInfo(posHTInfo, "HTConstructInforElement");
 }

 /*
@@ -667,10 +644,10 @@ void HTConstructRT2RTAggElement(struct ieee80211_dev=
ice *ieee, u8 *posRT2RTAgg,
 	*posRT2RTAgg++ =3D 0x4c;
 	*posRT2RTAgg++ =3D 0x02;
 	*posRT2RTAgg++ =3D 0x01;
-	*posRT2RTAgg =3D 0x10;//*posRT2RTAgg =3D 0x02;
+	*posRT2RTAgg =3D 0x10;

 	if (ieee->bSupportRemoteWakeUp)
-		*posRT2RTAgg |=3D 0x08;//RT_HT_CAP_USE_WOW;
+		*posRT2RTAgg |=3D 0x08;

 	*len =3D 6 + 2;
 	return;
@@ -855,11 +832,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 		return;
 	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "=3D=3D=3D> HTOnAssocRsp_wq(): HT_ENABL=
E\n");
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, pHTInfo->PeerHTCapBuf, sizeof(=
struct ht_capability_ele));
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA, pHTInfo->PeerHTInfoBuf, sizeof=
(HT_INFORMATION_ELE));

-//	HTDebugHTCapability(pHTInfo->PeerHTCapBuf,"HTOnAssocRsp_wq");
-//	HTDebugHTInfo(pHTInfo->PeerHTInfoBuf,"HTOnAssocRsp_wq");
 	if (!memcmp(pHTInfo->PeerHTCapBuf, EWC11NHTCap, sizeof(EWC11NHTCap)))
 		pPeerHTCap =3D (struct ht_capability_ele *)(&pHTInfo->PeerHTCapBuf[4]);
 	else
@@ -874,8 +847,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	 * Configurations:
 	 */
 	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_HT, pPeerHTCap, si=
zeof(struct ht_capability_ele));
-//	IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_HT, pPeerHTInfo, s=
izeof(HT_INFORMATION_ELE));
-	// Config Supported Channel Width setting
+	/* Config Supported Channel Width setting */
 	HTSetConnectBwMode(ieee, (enum ht_channel_width)(pPeerHTCap->ChlWidth), =
(enum ht_extension_chan_offset)(pPeerHTInfo->ExtChlOffset));

 	pHTInfo->bCurTxBW40MHz =3D (pPeerHTInfo->RecommemdedTxWidth =3D=3D 1);
@@ -999,7 +971,7 @@ void HTOnAssocRsp(struct ieee80211_device *ieee)
 	else
 		pMcsFilter =3D MCS_FILTER_ALL;
 	/* WB add for MCS8 bug */
-//	pMcsFilter =3D MCS_FILTER_1SS;
+	/* pMcsFilter =3D MCS_FILTER_1SS; */
 	ieee->HTHighestOperaRate =3D HTGetHighestMCSRate(ieee, ieee->dot11HTOper=
ationalRateSet, pMcsFilter);
 	ieee->HTCurrentOperaRate =3D ieee->HTHighestOperaRate;

@@ -1114,10 +1086,6 @@ void HTInitializeBssDesc(PBSS_HT pBssHT)
 void HTResetSelfAndSavePeerSetting(struct ieee80211_device *ieee,	struct =
ieee80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT		pHTInfo =3D ieee->pHTInfo;
-//	u16						nMaxAMSDUSize;
-//	struct ht_capability_ele       *pPeerHTCap =3D (struct ht_capability_e=
le *)pNetwork->bssht.bdHTCapBuf;
-//	PHT_INFORMATION_ELE		pPeerHTInfo =3D (PHT_INFORMATION_ELE)pNetwork->bs=
sht.bdHTInfoBuf;
-//	u8*	pMcsFilter;
 	u8	bIOTAction =3D 0;

 	/*
@@ -1189,7 +1157,6 @@ void HTResetSelfAndSavePeerSetting(struct ieee80211_=
device *ieee,	struct ieee802
 void HTUpdateSelfAndPeerSetting(struct ieee80211_device *ieee,	struct iee=
e80211_network *pNetwork)
 {
 	PRT_HIGH_THROUGHPUT	        pHTInfo =3D ieee->pHTInfo;
-//	struct ht_capability_ele       *pPeerHTCap =3D (struct ht_capability_e=
le *)pNetwork->bssht.bdHTCapBuf;
 	PHT_INFORMATION_ELE		pPeerHTInfo =3D (PHT_INFORMATION_ELE)pNetwork->bssh=
t.bdHTInfoBuf;

 	if (pHTInfo->bCurrentHTSupport) {
@@ -1254,19 +1221,11 @@ static void HTSetConnectBwModeCallback(struct ieee=
80211_device *ieee)
 void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_wi=
dth Bandwidth, enum ht_extension_chan_offset Offset)
 {
 	PRT_HIGH_THROUGHPUT pHTInfo =3D ieee->pHTInfo;
-//	u32 flags =3D 0;

 	if (!pHTInfo->bRegBW40MHz)
 		return;

-	/* To reduce dummy operation */
-//	if((pHTInfo->bCurBW40MHz=3D=3Dfalse && Bandwidth=3D=3DHT_CHANNEL_WIDTH=
_20) ||
-//	   (pHTInfo->bCurBW40MHz=3D=3Dtrue && Bandwidth=3D=3DHT_CHANNEL_WIDTH_=
20_40 && Offset=3D=3DpHTInfo->CurSTAExtChnlOffset))
-//		return;
-
-//	spin_lock_irqsave(&(ieee->bw_spinlock), flags);
 	if (pHTInfo->bSwBwInProgress) {
-//		spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
 		return;
 	}
 	/* if in half N mode, set to 20M bandwidth please 09.08.2008 WB. */
@@ -1296,5 +1255,4 @@ void HTSetConnectBwMode(struct ieee80211_device *iee=
e, enum ht_channel_width Ban
 	 */
 	HTSetConnectBwModeCallback(ieee);

-//	spin_unlock_irqrestore(&(ieee->bw_spinlock), flags);
 }
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/st=
aging/rtl8192u/ieee80211/rtl819x_Qos.h
index 44418a284fe9..c5692e5414ec 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -51,7 +51,7 @@ struct qos_tsinfo {
  * Note: sizeof 55 bytes
  */
 struct tspec_body {
-	struct qos_tsinfo	ts_info;	//u8	TSInfo[3];
+	struct qos_tsinfo	ts_info;
 	u16	nominal_msd_usize;
 	u16	max_msd_usize;
 	u32	min_service_itv;
@@ -79,4 +79,4 @@ struct octet_string {

 #define is_ac_valid(ac)			(((ac) <=3D 7) ? true : false)

-#endif // #ifndef __INC_QOS_TYPE_H
+#endif
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers=
/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 469d6ab3dc8e..903373769464 100644
=2D-- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -30,7 +30,6 @@ static void RxPktPendingTimeout(struct timer_list *t)

 	struct rx_reorder_entry	*pReorderEntry =3D NULL;

-	//u32 flags =3D 0;
 	unsigned long flags =3D 0;
 	u8 index =3D 0;
 	bool bPktInBuf =3D false;
@@ -179,14 +178,12 @@ void TSInitialize(struct ieee80211_device *ieee)
 	}
 	/* Initialize unused Rx Reorder List. */
 	INIT_LIST_HEAD(&ieee->RxReorder_Unused_List);
-//#ifdef TO_DO_LIST
 	for (count =3D 0; count < REORDER_ENTRY_NUM; count++) {
 		list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
 		if (count =3D=3D (REORDER_ENTRY_NUM-1))
 			break;
 		pRxReorderEntry =3D &ieee->RxReorderEntry[count+1];
 	}
-//#endif
 }

 static void AdmitTS(struct ieee80211_device *ieee,
@@ -205,7 +202,6 @@ static struct ts_common_info *SearchAdmitTRStream(stru=
ct ieee80211_device *ieee,
 						  u8 *Addr, u8 TID,
 						  enum tr_select TxRxSelect)
 {
-	//DIRECTION_VALUE	dir;
 	u8	dir;
 	bool				search_dir[4] =3D {0};
 	struct list_head		*psearch_list; /* FIXME */
@@ -240,16 +236,13 @@ static struct ts_common_info *SearchAdmitTRStream(st=
ruct ieee80211_device *ieee,
 	else
 		psearch_list =3D &ieee->Rx_TS_Admit_List;

-	//for(dir =3D DIR_UP; dir <=3D DIR_BI_DIR; dir++)
 	for (dir =3D 0; dir <=3D DIR_BI_DIR; dir++) {
 		if (!search_dir[dir])
 			continue;
 		list_for_each_entry(pRet, psearch_list, list) {
-	//		IEEE80211_DEBUG(IEEE80211_DL_TS, "ADD:%pM, TID:%d, dir:%d\n", pRet->=
Addr, pRet->TSpec.ts_info.ucTSID, pRet->TSpec.ts_info.ucDirection);
 			if (memcmp(pRet->addr, Addr, 6) =3D=3D 0)
 				if (pRet->t_spec.ts_info.uc_tsid =3D=3D TID)
 					if (pRet->t_spec.ts_info.uc_direction =3D=3D dir) {
-	//					printk("Bingo! got it\n");
 						break;
 					}
 		}
@@ -409,14 +402,12 @@ bool GetTs(
 static void RemoveTsEntry(struct ieee80211_device *ieee, struct ts_common=
_info *pTs,
 			  enum tr_select TxRxSelect)
 {
-	//u32 flags =3D 0;
 	unsigned long flags =3D 0;
 	del_timer_sync(&pTs->setup_timer);
 	del_timer_sync(&pTs->inact_timer);
 	TsInitDelBA(ieee, pTs, TxRxSelect);

 	if (TxRxSelect =3D=3D RX_DIR) {
-//#ifdef TO_DO_LIST
 		struct rx_reorder_entry	*pRxReorderEntry;
 		struct rx_ts_record     *pRxTS =3D (struct rx_ts_record *)pTs;
 		if (timer_pending(&pRxTS->rx_pkt_pending_timer))
@@ -424,7 +415,6 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *

 		while (!list_empty(&pRxTS->rx_pending_pkt_list)) {
 			spin_lock_irqsave(&(ieee->reorder_spinlock), flags);
-			//pRxReorderEntry =3D list_entry(&pRxTS->rx_pending_pkt_list.prev,RX_R=
EORDER_ENTRY,List);
 			pRxReorderEntry =3D list_entry(pRxTS->rx_pending_pkt_list.prev, struct=
 rx_reorder_entry, List);
 			list_del_init(&pRxReorderEntry->List);
 			{
@@ -444,7 +434,6 @@ static void RemoveTsEntry(struct ieee80211_device *iee=
e, struct ts_common_info *
 			spin_unlock_irqrestore(&(ieee->reorder_spinlock), flags);
 		}

-//#endif
 	} else {
 		struct tx_ts_record *pTxTS =3D (struct tx_ts_record *)pTs;
 		del_timer_sync(&pTxTS->ts_add_ba_timer);
diff --git a/drivers/staging/rtl8192u/r8190_rtl8256.c b/drivers/staging/rt=
l8192u/r8190_rtl8256.c
index 716be24bace6..f8790ab16c61 100644
=2D-- a/drivers/staging/rtl8192u/r8190_rtl8256.c
+++ b/drivers/staging/rtl8192u/r8190_rtl8256.c
@@ -34,9 +34,6 @@ void phy_set_rf8256_bandwidth(struct net_device *dev, en=
um ht_channel_width Band
 	u8	eRFPath;
 	struct r8192_priv *priv =3D ieee80211_priv(dev);

-	/* for(eRFPath =3D RF90_PATH_A; eRFPath <pHalData->NumTotalRFPath;
-	 *  eRFPath++)
-	 */
 	for (eRFPath =3D 0; eRFPath < RF90_PATH_MAX; eRFPath++) {
 		if (!rtl8192_phy_CheckIsLegalRFPath(dev, eRFPath))
 			continue;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8=
192u/r8192U_core.c
index 410c8a3e56d7..85d476af0586 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -458,8 +458,6 @@ int read_nic_dword(struct net_device *dev, int indx, u=
32 *data)
 	return 0;
 }

-/* u8 read_phy_cck(struct net_device *dev, u8 adr); */
-/* u8 read_phy_ofdm(struct net_device *dev, u8 adr); */
 /*
  * this might still called in what was the PHY rtl8185/rtl8192 common cod=
e
  * plans are to possibility turn it again in one common code...
@@ -4747,7 +4745,7 @@ static void rtl8192_rx_nomal(struct sk_buff *skb)
 		/* TODO */
 		/* hardware related info */
 		/* Process the MPDU received */
-		skb_trim(skb, skb->len - 4/*sCrcLng*/);
+		skb_trim(skb, skb->len - 4);

 		rx_pkt_len =3D skb->len;
 		ieee80211_hdr =3D (struct rtl_80211_hdr_1addr *)skb->data;
@@ -4846,7 +4844,6 @@ static void rtl8192_rx_cmd(struct sk_buff *skb)

 	if ((skb->len >=3D (20 + sizeof(struct rx_desc_819x_usb))) && (skb->len =
< RX_URB_SIZE)) {
 		query_rx_cmdpkt_desc_status(skb, &stats);
-		/* prfd->queue_id =3D 1; */

 		/* Process the command packet received. */

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index b15cf98281dd..51dab0863b86 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -57,8 +57,6 @@ static	void	dm_bandwidth_autoswitch(struct net_device *d=
ev);

 static	void	dm_check_txpower_tracking(struct net_device *dev);

-/* static	void	dm_txpower_reset_recovery(struct net_device *dev); */
-
 /* DM --> Dynamic Init Gain by RSSI */
 static	void	dm_dig_init(struct net_device *dev);
 static	void	dm_ctrl_initgain_byrssi(struct net_device *dev);
@@ -73,7 +71,6 @@ static	void dm_init_ctstoself(struct net_device *dev);
 /* DM --> EDCA turbo mode control */
 static	void	dm_check_edca_turbo(struct net_device *dev);

-/*static	void	dm_gpio_change_rf(struct net_device *dev);*/
 /* DM --> Check PBC */
 static	void dm_check_pbc_gpio(struct net_device *dev);

@@ -121,7 +118,6 @@ void init_hal_dm(struct net_device *dev)
 	/* Initial TX Power Control for near/far range , add by amy 2008/05/15, =
porting from windows code. */
 	dm_init_dynamic_txpower(dev);
 	init_rate_adaptive(dev);
-	/* dm_initialize_txpower_tracking(dev); */
 	dm_dig_init(dev);
 	dm_init_edca_turbo(dev);
 	dm_init_bandwidth_autoswitch(dev);
@@ -195,10 +191,6 @@ void dm_CheckRxAggregation(struct net_device *dev)

 void hal_dm_watchdog(struct net_device *dev)
 {
-	/* struct r8192_priv *priv =3D ieee80211_priv(dev); */
-
-	/* static u8	previous_bssid[6] =3D{0}; */
-
 	/* Add by amy 2008/05/15 ,porting from windows code. */
 	dm_check_rate_adaptive(dev);
 	dm_dynamic_txpower(dev);
@@ -309,7 +301,6 @@ static void dm_check_rate_adaptive(struct net_device *=
dev)
 		return;

 	if (priv->ieee80211->state =3D=3D IEEE80211_LINKED) {
-		/*RT_TRACE(COMP_RATE, "dm_CheckRateAdaptive(): \t");*/

 		/* Check whether Short GI is enabled */
 		bshort_gi_enabled =3D (pHTInfo->bCurTxBW40MHz && pHTInfo->bCurShortGI40=
MHz) ||
@@ -358,36 +349,27 @@ static void dm_check_rate_adaptive(struct net_device=
 *dev)
 					(pra->low_rssi_thresh_for_ra40M):(pra->low_rssi_thresh_for_ra20M);
 		}

-		/*DbgPrint("[DM] THresh H/L=3D%d/%d\n\r", RATR.HighRSSIThreshForRA, RAT=
R.LowRSSIThreshForRA);*/
 		if (priv->undecorated_smoothed_pwdb >=3D (long)HighRSSIThreshForRA) {
-			/*DbgPrint("[DM] RSSI=3D%d STA=3DHIGH\n\r", pHalData->UndecoratedSmoot=
hedPWDB);*/
 			pra->ratr_state =3D DM_RATR_STA_HIGH;
 			targetRATR =3D pra->upper_rssi_threshold_ratr;
 		} else if (priv->undecorated_smoothed_pwdb >=3D (long)LowRSSIThreshForR=
A) {
-			/*DbgPrint("[DM] RSSI=3D%d STA=3DMiddle\n\r", pHalData->UndecoratedSmo=
othedPWDB);*/
 			pra->ratr_state =3D DM_RATR_STA_MIDDLE;
 			targetRATR =3D pra->middle_rssi_threshold_ratr;
 		} else {
-			/*DbgPrint("[DM] RSSI=3D%d STA=3DLOW\n\r", pHalData->UndecoratedSmooth=
edPWDB);*/
 			pra->ratr_state =3D DM_RATR_STA_LOW;
 			targetRATR =3D pra->low_rssi_threshold_ratr;
 		}

 		/* cosa add for test */
 		if (pra->ping_rssi_enable) {
-			/*pHalData->UndecoratedSmoothedPWDB =3D 19;*/
 			if (priv->undecorated_smoothed_pwdb < (long)(pra->ping_rssi_thresh_for=
_ra+5)) {
 				if ((priv->undecorated_smoothed_pwdb < (long)pra->ping_rssi_thresh_fo=
r_ra) ||
 					ping_rssi_state) {
-					/*DbgPrint("TestRSSI =3D %d, set RATR to 0x%x\n", pHalData->Undecora=
tedSmoothedPWDB, pRA->TestRSSIRATR);*/
 					pra->ratr_state =3D DM_RATR_STA_LOW;
 					targetRATR =3D pra->ping_rssi_ratr;
 					ping_rssi_state =3D 1;
 				}
-				/*else
-					DbgPrint("TestRSSI is between the range.\n");*/
 			} else {
-				/*DbgPrint("TestRSSI Recover to 0x%x\n", targetRATR);*/
 				ping_rssi_state =3D 0;
 			}
 		}
@@ -510,7 +492,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net=
_device *dev)
 	u32						Value;
 	u8						Pwr_Flag;
 	u16						Avg_TSSI_Meas, TSSI_13dBm, Avg_TSSI_Meas_from_driver =3D 0;
-	/*RT_STATUS				rtStatus =3D RT_STATUS_SUCCESS;*/
 	bool rtStatus =3D true;
 	u32						delta =3D 0;

@@ -532,7 +513,6 @@ static void dm_TXPowerTrackingCallback_TSSI(struct net=
_device *dev)
 		if (rtStatus =3D=3D RT_STATUS_FAILURE)
 			RT_TRACE(COMP_POWER_TRACKING, "Set configuration with tx cmd queue fai=
l!\n");
 		usleep_range(1000, 2000);
-		/*DbgPrint("hi, vivi, strange\n");*/
 		for (i =3D 0; i <=3D 30; i++) {
 			read_nic_byte(dev, 0x1ba, &Pwr_Flag);

@@ -684,7 +664,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(st=
ruct net_device *dev)
 			}
 		}
 		priv->btxpower_trackingInit =3D true;
-		/*pHalData->TXPowercount =3D 0;*/
 		return;
 	}

@@ -751,7 +730,6 @@ static void dm_TXPowerTrackingCallback_ThermalMeter(st=
ruct net_device *dev)
 	}

 	if (CCKSwingNeedUpdate) {
-		/*DbgPrint("Update CCK Swing, CCK_index =3D %d\n", pHalData->CCK_index)=
;*/
 		dm_cck_txpower_adjust(dev, priv->bcck_in_ch14);
 	}
 	if (priv->OFDM_index !=3D tmpOFDMindex) {
@@ -1326,7 +1304,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(str=
uct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
 	static u8	TM_Trigger;
-	/*DbgPrint("dm_CheckTXPowerTracking()\n");*/
 	if (!priv->btxpower_tracking)
 		return;
 	if (priv->txpower_count  <=3D 2) {
@@ -1347,7 +1324,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(str=
uct net_device *dev)
 		TM_Trigger =3D 1;
 		return;
 	}
-	/*DbgPrint("Schedule TxPowerTrackingWorkItem\n");*/
 		queue_delayed_work(priv->priv_wq, &priv->txpower_tracking_wq, 0);
 	TM_Trigger =3D 0;
 }
@@ -1355,7 +1331,6 @@ static void dm_CheckTXPowerTracking_ThermalMeter(str=
uct net_device *dev)
 static void dm_check_txpower_tracking(struct net_device *dev)
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
-	/*static u32 tx_power_track_counter =3D 0;*/

 #ifdef RTL8190P
 	dm_CheckTXPowerTracking_TSSI(dev);
@@ -1523,10 +1498,7 @@ void dm_restore_dynamic_mechanism_state(struct net_=
device *dev)
 			ratr_value =3D reg_ratr;
 			if (priv->rf_type =3D=3D RF_1T2R) {	/* 1T2R, Spatial Stream 2 should b=
e disabled */
 				ratr_value &=3D ~(RATE_ALL_OFDM_2SS);
-				/*DbgPrint("HW_VAR_TATR_0 from 0x%x =3D=3D> 0x%x\n", ((pu4Byte)(val))=
[0], ratr_value);*/
 			}
-			/*DbgPrint("set HW_VAR_TATR_0 =3D 0x%x\n", ratr_value);*/
-			/*cosa PlatformEFIOWrite4Byte(Adapter, RATR0, ((pu4Byte)(val))[0]);*/
 			write_nic_dword(dev, RATR0, ratr_value);
 			write_nic_byte(dev, UFWP, 1);
 	}
@@ -1588,7 +1560,6 @@ static void dm_bb_initialgain_backup(struct net_devi=
ce *dev)
 	if (dm_digtable.dig_algorithm =3D=3D DIG_ALGO_BY_RSSI)
 		return;

-	/*PHY_SetBBReg(Adapter, UFWP, bMaskLWord, 0x800);*/
 	rtl8192_setBBreg(dev, UFWP, bMaskByte1, 0x8);	/* Only clear byte 1 and r=
ewrite. */
 	priv->initgain_backup.xaagccore1 =3D (u8)rtl8192_QueryBBReg(dev, rOFDM0_=
XAAGCCore1, bit_mask);
 	priv->initgain_backup.xbagccore1 =3D (u8)rtl8192_QueryBBReg(dev, rOFDM0_=
XBAGCCore1, bit_mask);
@@ -1679,7 +1650,6 @@ static void dm_ctrl_initgain_byrssi(struct net_devic=
e *dev)
 		dm_ctrl_initgain_byrssi_by_fwfalse_alarm(dev);
 	else if (dm_digtable.dig_algorithm =3D=3D DIG_ALGO_BY_RSSI)
 		dm_ctrl_initgain_byrssi_by_driverrssi(dev);
-	/* ; */
 	else
 		return;
 }
@@ -1694,7 +1664,6 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 	if (!dm_digtable.dig_enable_flag)
 		return;

-	/*DbgPrint("Dig by Sw Rssi\n");*/
 	if (dm_digtable.dig_algorithm_switch)	/* if switched algorithm, we have =
to disable FW Dig. */
 		fw_dig =3D 0;

@@ -1715,7 +1684,6 @@ static void dm_ctrl_initgain_byrssi_by_driverrssi(
 		DM_DigTable.PreConnectState, DM_DigTable.CurConnectState);*/

 	dm_digtable.rssi_val =3D priv->undecorated_smoothed_pwdb;
-	/*DbgPrint("DM_DigTable.Rssi_val =3D %d\n", DM_DigTable.Rssi_val);*/
 	dm_initial_gain(dev);
 	dm_pd_th(dev);
 	dm_cs_ratio(dev);
@@ -1751,11 +1719,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alar=
m(
 	    (priv->undecorated_smoothed_pwdb < dm_digtable.rssi_high_thresh))
 		return;

-	/*DbgPrint("Dig by Fw False Alarm\n");*/
-	/*if (DM_DigTable.Dig_State =3D=3D DM_STA_DIG_OFF)*/
-	/*DbgPrint("DIG Check\n\r RSSI=3D%d LOW=3D%d HIGH=3D%d STATE=3D%d",
-	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
-	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
 	/*
 	 * 1. When RSSI decrease, We have to judge if it is smaller than a thres=
hold
 	 * and then execute the step below.
@@ -1827,7 +1790,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
 		reset_cnt =3D priv->reset_count;

 		dm_digtable.dig_state =3D DM_STA_DIG_ON;
-		/*DbgPrint("DIG ON\n\r");*/

 		/*
 		 * 2.1 Set initial gain.
@@ -1987,7 +1949,6 @@ static void dm_initial_gain(
 		dm_digtable.cur_ig_value =3D priv->DefaultInitialGain[0];
 		dm_digtable.pre_ig_value =3D 0;
 	}
-	/*DbgPrint("DM_DigTable.CurIGValue =3D 0x%x, DM_DigTable.PreIGValue =3D =
0x%x\n", DM_DigTable.CurIGValue, DM_DigTable.PreIGValue);*/

 	/* if silent reset happened, we should rewrite the values back */
 	if (priv->reset_count !=3D reset_cnt) {
@@ -2003,7 +1964,6 @@ static void dm_initial_gain(
 		if ((dm_digtable.pre_ig_value !=3D dm_digtable.cur_ig_value)
 			|| !initialized || force_write) {
 			initial_gain =3D (u8)dm_digtable.cur_ig_value;
-			/*DbgPrint("Write initial gain =3D 0x%x\n", initial_gain);*/
 			/*  Set initial gain. */
 			write_nic_byte(dev, rOFDM0_XAAGCCore1, initial_gain);
 			write_nic_byte(dev, rOFDM0_XBAGCCore1, initial_gain);
@@ -2055,7 +2015,6 @@ static void dm_pd_th(
 	{
 		if ((dm_digtable.prepd_thstate !=3D dm_digtable.curpd_thstate) ||
 		    (initialized <=3D 3) || force_write) {
-			/*DbgPrint("Write PD_TH state =3D %d\n", DM_DigTable.CurPD_THState);*/
 			if (dm_digtable.curpd_thstate =3D=3D DIG_PD_AT_LOW_POWER) {
 				/*  Lower PD_TH for OFDM. */
 				if (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_20) {
@@ -2135,7 +2094,6 @@ static	void dm_cs_ratio(
 	{
 		if ((dm_digtable.precs_ratio_state !=3D dm_digtable.curcs_ratio_state) =
||
 		    !initialized || force_write) {
-			/*DbgPrint("Write CS_ratio state =3D %d\n", DM_DigTable.CurCS_ratioSta=
te);*/
 			if (dm_digtable.curcs_ratio_state =3D=3D DIG_CS_RATIO_LOWER) {
 				/*  Lower CS ratio for CCK. */
 				write_nic_byte(dev, 0xa0a, 0x08);
@@ -2164,7 +2122,6 @@ static void dm_check_edca_turbo(
 {
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
 	PRT_HIGH_THROUGHPUT	pHTInfo =3D priv->ieee80211->pHTInfo;
-	/* PSTA_QOS			pStaQos =3D pMgntInfo->pStaQos; */

 	/* Keep past Tx/Rx packet count for RT-to-RT EDCA turbo. */
 	static unsigned long			lastTxOkCnt;
@@ -2182,20 +2139,17 @@ static void dm_check_edca_turbo(
 	if (priv->ieee80211->pHTInfo->IOTAction & HT_IOT_ACT_DISABLE_EDCA_TURBO)
 		goto dm_CheckEdcaTurbo_EXIT;

-	/*printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s():bis_any_nonbepkts is %d\n", __fu=
nc__, priv->bis_any_nonbepkts);*/
 	/* Check the status for current condition. */
 	if (!priv->ieee80211->bis_any_nonbepkts) {
 		curTxOkCnt =3D priv->stats.txbytesunicast - lastTxOkCnt;
 		curRxOkCnt =3D priv->stats.rxbytesunicast - lastRxOkCnt;
 		/* For RT-AP, we needs to turn it on when Rx>Tx */
 		if (curRxOkCnt > 4*curTxOkCnt) {
-			/*printk("%s():curRxOkCnt > 4*curTxOkCnt\n");*/
 			if (!priv->bis_cur_rdlstate || !priv->bcurrent_turbo_EDCA) {
 				write_nic_dword(dev, EDCAPARA_BE, edca_setting_DL[pHTInfo->IOTPeer]);
 				priv->bis_cur_rdlstate =3D true;
 			}
 		} else {
-			/*printk("%s():curRxOkCnt < 4*curTxOkCnt\n");*/
 			if (priv->bis_cur_rdlstate || !priv->bcurrent_turbo_EDCA) {
 				write_nic_dword(dev, EDCAPARA_BE, edca_setting_UL[pHTInfo->IOTPeer]);
 				priv->bis_cur_rdlstate =3D false;
@@ -2300,7 +2254,6 @@ static void dm_ctstoself(struct net_device *dev)
 		curRxOkCnt =3D priv->stats.rxbytesunicast - lastRxOkCnt;
 		if (curRxOkCnt > 4*curTxOkCnt) { /* downlink, disable CTS to self */
 			pHTInfo->IOTAction &=3D ~HT_IOT_ACT_FORCED_CTS2SELF;
-			/*DbgPrint("dm_CTSToSelf() =3D=3D> CTS to self disabled -- downlink\n"=
);*/
 		} else { /* uplink */
 			pHTInfo->IOTAction |=3D HT_IOT_ACT_FORCED_CTS2SELF;
 		}
@@ -2371,7 +2324,6 @@ void dm_rf_pathcheck_workitemcallback(struct work_st=
ruct *work)
 	struct delayed_work *dwork =3D to_delayed_work(work);
 	struct r8192_priv *priv =3D container_of(dwork, struct r8192_priv, rfpat=
h_check_wq);
 	struct net_device *dev =3D priv->ieee80211->dev;
-	/*bool bactually_set =3D false;*/
 	u8 rfpath =3D 0, i;

 	/*
@@ -2436,7 +2388,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *=
dev)

 	if (priv->ieee80211->mode =3D=3D WIRELESS_MODE_B) {
 		DM_RxPathSelTable.cck_method =3D CCK_RX_VERSION_2;	/* pure B mode, fixe=
d cck version2 */
-		/*DbgPrint("Pure B mode, use cck rx version2\n");*/
 	}

 	/* decide max/sec/min rssi index */
@@ -2591,7 +2542,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *=
dev)
 			if ((DM_RxPathSelTable.disabled_rf >> i) & 0x1) {	/* disabled rf */
 				if (tmp_max_rssi >=3D DM_RxPathSelTable.rf_enable_rssi_th[i]) {
 					/* enable the BB Rx path */
-					/*DbgPrint("RF-%d is enabled.\n", 0x1<<i);*/
 					rtl8192_setBBreg(dev, rOFDM0_TRxPathEnable, 0x1<<i, 0x1);	/* 0xc04[3=
:0] */
 					rtl8192_setBBreg(dev, rOFDM1_TRxPathEnable, 0x1<<i, 0x1);	/* 0xd04[3=
:0] */
 					DM_RxPathSelTable.rf_enable_rssi_th[i] =3D 100;
@@ -2823,7 +2773,6 @@ void dm_check_fsync(struct net_device *dev)
 #define	RegC38_NonFsync_Other_AP		1
 #define	RegC38_Fsync_AP_BCM			2
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
-	/*u32			framesyncC34;*/
 	static u8		reg_c38_State =3D RegC38_Default;
 	static u32	reset_cnt;

@@ -2898,14 +2847,12 @@ void dm_check_fsync(struct net_device *dev)
 					if (reg_c38_State) {
 						write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 						reg_c38_State =3D RegC38_Default;
-						/*DbgPrint("Fsync is idle, rssi>=3D40, write 0xc38 =3D 0x%x\n", pHa=
lData->framesync);*/
 					}
 				}
 			} else {
 				if (reg_c38_State) {
 					write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 					reg_c38_State =3D RegC38_Default;
-					/*DbgPrint("Fsync is idle, not connected, write 0xc38 =3D 0x%x\n", p=
HalData->framesync);*/
 				}
 			}
 		}
@@ -2915,13 +2862,11 @@ void dm_check_fsync(struct net_device *dev)
 			write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 			reg_c38_State =3D RegC38_Default;
 			reset_cnt =3D priv->reset_count;
-			/*DbgPrint("reg_c38_State =3D 0 for silent reset.\n");*/
 		}
 	} else {
 		if (reg_c38_State) {
 			write_nic_byte(dev, rOFDM0_RxDetector3, priv->framesync);
 			reg_c38_State =3D RegC38_Default;
-			/*DbgPrint("framesync no monitor, write 0xc38 =3D 0x%x\n", pHalData->f=
ramesync);*/
 		}
 	}
 }
@@ -2952,7 +2897,6 @@ void dm_shadow_init(struct net_device *dev)
 	for (page =3D 0; page < 5; page++)
 		for (offset =3D 0; offset < 256; offset++) {
 			read_nic_byte(dev, offset + page * 256, &dm_shadow[page][offset]);
-			/*DbgPrint("P-%d/O-%02x=3D%02x\r\n", page, offset, DM_Shadow[page][off=
set]);*/
 		}

 	for (page =3D 8; page < 11; page++)
@@ -3008,7 +2952,6 @@ static void dm_dynamic_txpower(struct net_device *de=
v)
 		priv->bDynamicTxLowPower =3D false;
 		return;
 	}
-	/*printk("priv->ieee80211->current_network.unknown_cap_exist is %d , pri=
v->ieee80211->current_network.broadcom_cap_exist is %d\n", priv->ieee80211=
->current_network.unknown_cap_exist, priv->ieee80211->current_network.broa=
dcom_cap_exist);*/
 	if ((priv->ieee80211->current_network.atheros_cap_exist) && (priv->ieee8=
0211->mode =3D=3D IEEE_G)) {
 		txhipower_threshold =3D TX_POWER_ATHEROAP_THRESH_HIGH;
 		txlowpower_threshold =3D TX_POWER_ATHEROAP_THRESH_LOW;
@@ -3017,7 +2960,6 @@ static void dm_dynamic_txpower(struct net_device *de=
v)
 		txlowpower_threshold =3D TX_POWER_NEAR_FIELD_THRESH_LOW;
 	}

-	/*printk("=3D=3D=3D=3D=3D=3D=3D>%s(): txhipower_threshold is %d, txlowpo=
wer_threshold is %d\n", __func__, txhipower_threshold, txlowpower_threshol=
d);*/
 	RT_TRACE(COMP_TXAGC, "priv->undecorated_smoothed_pwdb =3D %ld\n", priv->=
undecorated_smoothed_pwdb);

 	if (priv->ieee80211->state =3D=3D IEEE80211_LINKED) {
@@ -3036,7 +2978,6 @@ static void dm_dynamic_txpower(struct net_device *de=
v)
 				priv->bDynamicTxLowPower =3D false;
 		}
 	} else {
-		/*pHalData->bTXPowerCtrlforNearFarRange =3D !pHalData->bTXPowerCtrlforN=
earFarRange;*/
 		priv->bDynamicTxHighPower =3D false;
 		priv->bDynamicTxLowPower =3D false;
 	}
@@ -3065,7 +3006,6 @@ static void dm_check_txrateandretrycount(struct net_=
device *dev)
 	/* for 11n tx rate */
 	/*priv->stats.CurrentShowTxate =3D read_nic_byte(dev, CURRENT_TX_RATE_RE=
G);*/
 	read_nic_byte(dev, CURRENT_TX_RATE_REG, &ieee->softmac_stats.CurrentShow=
Txate);
-	/*printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>tx_rate_reg:%x\n", iee=
e->softmac_stats.CurrentShowTxate);*/
 	/* for initial tx rate */
 	/*priv->stats.last_packet_rate =3D read_nic_byte(dev, INITIAL_TX_RATE_RE=
G);*/
 	read_nic_byte(dev, INITIAL_TX_RATE_REG, &ieee->softmac_stats.last_packet=
_rate);
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl819=
2u/r8192U_wx.c
index adb9fe8a79da..839671cc7f96 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -470,7 +470,6 @@ static int r8192_wx_set_wap(struct net_device *dev,

 	int ret;
 	struct r8192_priv *priv =3D ieee80211_priv(dev);
-	/* struct sockaddr *temp =3D (struct sockaddr *)awrq; */
 	mutex_lock(&priv->wx_mutex);

 	ret =3D ieee80211_wx_set_wap(priv->ieee80211, info, awrq, extra);
@@ -746,7 +745,6 @@ static int r8192_wx_set_enc_ext(struct net_device *dev=
,
 			/* none is not allowed to use hwsec WB 2008.07.01 */
 			goto end_hw_sec;

-		/* as IW_ENCODE_ALG_CCMP is defined to be 3 and KEY_TYPE_CCMP is define=
d to 4; */
 		alg =3D  (ext->alg =3D=3D IW_ENCODE_ALG_CCMP)?KEY_TYPE_CCMP:ext->alg;
 		idx =3D encoding->flags & IW_ENCODE_INDEX;
 		if (idx)
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/=
rtl8192u/r819xU_firmware.c
index e9511b829b05..0e47b5f75695 100644
=2D-- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -296,7 +296,6 @@ bool init_firmware(struct net_device *dev)
 			 * will set polling bit when firmware code is also configured
 			 */
 			pfirmware->firmware_status =3D FW_STATUS_1_MOVE_BOOT_CODE;
-			/* mdelay(1000); */
 			/*
 			 * To initialize IMEM, CPU move code  from 0x80000080,
 			 * hence, we send 0x80 byte packet
=2D-
2.17.1

