Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA75C41514
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661B12339E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="mms6VgDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfHTXNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:13:01 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21563 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:13:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566342761; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=FLROwqRXFgTPOwcoX+//CTlu3gxawzFTUCSJ/EWcW9Pb8MeS3wle1QKgxrdpODxrc7g9zM2mMPOs53kRA5PqTicJJbpe3lyWIS2tO8WPoyYAqxlMqjDzoqMCd0OVr5j1A3k6Fx3Ysg6DVcoBaTZVSUWXwStV4EWXW5Pr18T6hWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566342761; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=/F1MzkEe+uDcUQiBqaQQOkIXEBgDwot60UzWsiVVtDA=; 
        b=EDRPYAXUKurC6MycyPnPZ9fqiqHS5mAXD3B67mtCOVJ+CtcMwMAeNBgBwHOw/mOwkdrWIVsvolztx6IUD7zwKeyypfPOEJh2mSLuFdQ7BRA3LUHWOWRKvtAWXatj/KG+JLedde23Z1MovcBbWBu4ojQeYgh6jGNWnc5L3sBDmc0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566342761;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=32757; bh=/F1MzkEe+uDcUQiBqaQQOkIXEBgDwot60UzWsiVVtDA=;
        b=mms6VgDarw2nPP5DNb5ls0XmoAddeQghfDSkvxyshHXehkJTt0ZSa8gK7c7hg1fF
        QQJBV6NAD/QHr8QUQ1Rie22WdiAOT+G05kLSXlP0ASFcL1w/Dgc5UUuFhU9K5GFf4OB
        ziZifDunB3ZndlUAirvfkGNgkPg9K3N3SD7ep6Cg=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566342759703781.3693302639834; Tue, 20 Aug 2019 16:12:39 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <20190820231156.30031-4-stephen@brennan.io>
Subject: [PATCH 3/3] staging: rtl8192u: fix spacing in ieee80211
Date:   Tue, 20 Aug 2019 16:11:56 -0700
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820231156.30031-1-stephen@brennan.io>
References: <20190820231156.30031-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.c   | 10 ++--
 .../staging/rtl8192u/ieee80211/ieee80211.h    |  4 +-
 .../rtl8192u/ieee80211/ieee80211_crypt.c      |  2 +-
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 22 ++++----
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c  |  4 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c | 14 +++---
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c | 50 +++++++++----------
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c | 32 ++++++------
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       | 12 ++---
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  6 +--
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 14 +++---
 12 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.c b/drivers/staging/=
rtl8192u/ieee80211/dot11d.c
index 130ddfe9868f..bc642076b96f 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.c
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.c
@@ -12,7 +12,7 @@ void rtl8192u_dot11d_init(struct ieee80211_device *ieee)
 =09dot11d_info->state =3D DOT11D_STATE_NONE;
 =09dot11d_info->country_ie_len =3D 0;
 =09memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
-=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
 =09RESET_CIE_WATCHDOG(ieee);
=20
 =09netdev_info(ieee->dev, "rtl8192u_dot11d_init()\n");
@@ -25,8 +25,8 @@ void dot11d_reset(struct ieee80211_device *ieee)
 =09u32 i;
 =09struct rt_dot11d_info *dot11d_info =3D GET_DOT11D_INFO(ieee);
 =09/* Clear old channel map */
-=09memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+=09memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
+=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
 =09/* Set new channel map */
 =09for (i =3D 1; i <=3D 11; i++)
 =09=09(dot11d_info->channel_map)[i] =3D 1;
@@ -56,8 +56,8 @@ void dot11d_update_country_ie(struct ieee80211_device *de=
v, u8 *pTaddr,
 =09u8 i, j, NumTriples, MaxChnlNum;
 =09struct chnl_txpower_triple *pTriple;
=20
-=09memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER+1);
-=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER+1);
+=09memset(dot11d_info->channel_map, 0, MAX_CHANNEL_NUMBER + 1);
+=09memset(dot11d_info->max_tx_pwr_dbm_list, 0xFF, MAX_CHANNEL_NUMBER + 1);
 =09MaxChnlNum =3D 0;
 =09NumTriples =3D (CoutryIeLen - 3) / 3; /* skip 3-byte country string. */
 =09pTriple =3D (struct chnl_txpower_triple *)(pCoutryIe + 3);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stagi=
ng/rtl8192u/ieee80211/ieee80211.h
index 6b7828a9e71d..daebbbd8f4dd 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -456,7 +456,7 @@ do { if (ieee80211_debug_level & (level)) \
 =09do { if ((ieee80211_debug_level & (level)) =3D=3D (level))             =
    \
 =09=09{                                                              \
 =09=09=09int i;                                                 \
-=09=09=09u8 *pdata =3D (u8 *) data;                               \
+=09=09=09u8 *pdata =3D (u8 *)data;                                \
 =09=09=09printk(KERN_DEBUG "ieee80211: %s()\n", __func__);      \
 =09=09=09for (i =3D 0; i < (int)(datalen); i++) {                 \
 =09=09=09=09printk("%2x ", pdata[i]);                      \
@@ -468,7 +468,7 @@ do { if (ieee80211_debug_level & (level)) \
 =09} while (0)
 #else
 #define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
-#define IEEE80211_DEBUG_DATA (level, data, datalen) do {} while(0)
+#define IEEE80211_DEBUG_DATA (level, data, datalen) do {} while (0)
 #endif=09/* CONFIG_IEEE80211_DEBUG */
=20
 /* debug macros not dependent on CONFIG_IEEE80211_DEBUG */
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c b/drivers=
/staging/rtl8192u/ieee80211/ieee80211_crypt.c
index 36987fccac5d..01012dddcd73 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
@@ -176,7 +176,7 @@ struct ieee80211_crypto_ops *ieee80211_get_crypto_ops(c=
onst char *name)
 }
=20
=20
-static void *ieee80211_crypt_null_init(int keyidx) { return (void *) 1; }
+static void *ieee80211_crypt_null_init(int keyidx) { return (void *)1; }
 static void ieee80211_crypt_null_deinit(void *priv) {}
=20
 static struct ieee80211_crypto_ops ieee80211_crypt_null =3D {
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/dr=
ivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 0927b2b15151..6f4710171151 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -160,7 +160,7 @@ static inline u16 Hi16(u32 val)
=20
 static inline u16 Mk16(u8 hi, u8 lo)
 {
-=09return lo | (((u16) hi) << 8);
+=09return lo | (((u16)hi) << 8);
 }
=20
 static const u16 Sbox[256] =3D {
@@ -238,7 +238,7 @@ static void tkip_mixing_phase2(u8 *WEPSeed, const u8 *T=
K, const u16 *TTAK,
 =09 * Make temporary area overlap WEP seed so that the final copy can be
 =09 * avoided on little endian hosts.
 =09 */
-=09u16 *PPK =3D (u16 *) &WEPSeed[4];
+=09u16 *PPK =3D (u16 *)&WEPSeed[4];
=20
 =09/* Step 1 - make copy of TTAK and bring in TSC */
 =09PPK[0] =3D TTAK[0];
@@ -299,7 +299,7 @@ static int ieee80211_tkip_encrypt(struct sk_buff *skb, =
int hdr_len, void *priv)
 =09    skb->len < hdr_len)
 =09=09return -1;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
=20
 =09if (!tcb_desc->bHwSec) {
 =09=09if (!tkey->tx_phase1_done) {
@@ -343,7 +343,7 @@ static int ieee80211_tkip_encrypt(struct sk_buff *skb, =
int hdr_len, void *priv)
 =09=09icv[2] =3D crc >> 16;
 =09=09icv[3] =3D crc >> 24;
 =09=09crypto_sync_skcipher_setkey(tkey->tx_tfm_arc4, rc4key, 16);
-=09=09sg_init_one(&sg, pos, len+4);
+=09=09sg_init_one(&sg, pos, len + 4);
 =09=09skcipher_request_set_sync_tfm(req, tkey->tx_tfm_arc4);
 =09=09skcipher_request_set_callback(req, 0, NULL, NULL);
 =09=09skcipher_request_set_crypt(req, &sg, &sg, len + 4, NULL);
@@ -383,7 +383,7 @@ static int ieee80211_tkip_decrypt(struct sk_buff *skb, =
int hdr_len, void *priv)
 =09if (skb->len < hdr_len + 8 + 4)
 =09=09return -1;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09pos =3D skb->data + hdr_len;
 =09keyidx =3D pos[3];
 =09if (!(keyidx & BIT(5))) {
@@ -435,7 +435,7 @@ static int ieee80211_tkip_decrypt(struct sk_buff *skb, =
int hdr_len, void *priv)
 =09=09plen =3D skb->len - hdr_len - 12;
=20
 =09=09crypto_sync_skcipher_setkey(tkey->rx_tfm_arc4, rc4key, 16);
-=09=09sg_init_one(&sg, pos, plen+4);
+=09=09sg_init_one(&sg, pos, plen + 4);
=20
 =09=09skcipher_request_set_sync_tfm(req, tkey->rx_tfm_arc4);
 =09=09skcipher_request_set_callback(req, 0, NULL, NULL);
@@ -523,7 +523,7 @@ static void michael_mic_hdr(struct sk_buff *skb, u8 *hd=
r)
 {
 =09struct rtl_80211_hdr_4addr *hdr11;
=20
-=09hdr11 =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr11 =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09switch (le16_to_cpu(hdr11->frame_ctl) &
 =09=09(IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS)) {
 =09case IEEE80211_FCTL_TODS:
@@ -556,7 +556,7 @@ static int ieee80211_michael_mic_add(struct sk_buff *sk=
b, int hdr_len, void *pri
 =09u8 *pos;
 =09struct rtl_80211_hdr_4addr *hdr;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
=20
 =09if (skb_tailroom(skb) < 8 || skb->len < hdr_len) {
 =09=09printk(KERN_DEBUG "Invalid packet for Michael MIC add "
@@ -599,7 +599,7 @@ static void ieee80211_michael_mic_failure(struct net_de=
vice *dev,
 =09memcpy(ev.src_addr.sa_data, hdr->addr2, ETH_ALEN);
 =09memset(&wrqu, 0, sizeof(wrqu));
 =09wrqu.data.length =3D sizeof(ev);
-=09wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *) &ev);
+=09wireless_send_event(dev, IWEVMICHAELMICFAILURE, &wrqu, (char *)&ev);
 }
=20
 static int ieee80211_michael_mic_verify(struct sk_buff *skb, int keyidx,
@@ -609,7 +609,7 @@ static int ieee80211_michael_mic_verify(struct sk_buff =
*skb, int keyidx,
 =09u8 mic[8];
 =09struct rtl_80211_hdr_4addr *hdr;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
=20
 =09if (!tkey->key_set)
 =09=09return -1;
@@ -626,7 +626,7 @@ static int ieee80211_michael_mic_verify(struct sk_buff =
*skb, int keyidx,
 =09=09return -1;
 =09if (memcmp(mic, skb->data + skb->len - 8, 8) !=3D 0) {
 =09=09struct rtl_80211_hdr_4addr *hdr;
-=09=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
=20
 =09=09printk(KERN_DEBUG "%s: Michael MIC verification failed for "
 =09=09       "MSDU from %pM keyidx=3D%d\n",
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/dri=
vers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 805493a0870d..26482c3dcd1c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -135,7 +135,7 @@ static int prism2_wep_encrypt(struct sk_buff *skb, int =
hdr_len, void *priv)
 =09=09icv[3] =3D crc >> 24;
=20
 =09=09crypto_sync_skcipher_setkey(wep->tx_tfm, key, klen);
-=09=09sg_init_one(&sg, pos, len+4);
+=09=09sg_init_one(&sg, pos, len + 4);
=20
 =09=09skcipher_request_set_sync_tfm(req, wep->tx_tfm);
 =09=09skcipher_request_set_callback(req, 0, NULL, NULL);
@@ -192,7 +192,7 @@ static int prism2_wep_decrypt(struct sk_buff *skb, int =
hdr_len, void *priv)
 =09=09SYNC_SKCIPHER_REQUEST_ON_STACK(req, wep->rx_tfm);
=20
 =09=09crypto_sync_skcipher_setkey(wep->rx_tfm, key, klen);
-=09=09sg_init_one(&sg, pos, plen+4);
+=09=09sg_init_one(&sg, pos, plen + 4);
=20
 =09=09skcipher_request_set_sync_tfm(req, wep->rx_tfm);
 =09=09skcipher_request_set_callback(req, 0, NULL, NULL);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_rx.c
index 9d8b2ff700fe..a1462ec55767 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1237,7 +1237,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09=09&& !is_multicast_ether_addr(hdr->addr1)) {
 =09=09TID =3D Frame_QoSTID(skb->data);
 =09=09SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
-=09=09GetTs(ieee, (struct ts_common_info **) &pTS, hdr->addr2, TID, RX_DIR=
, true);
+=09=09GetTs(ieee, (struct ts_common_info **)&pTS, hdr->addr2, TID, RX_DIR,=
 true);
 =09=09if (TID !=3D 0 && TID !=3D 3) {
 =09=09=09ieee->bis_any_nonbepkts =3D true;
 =09=09}
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c b/dr=
ivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
index 4a8d16a45fc5..b1baaa18b129 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
@@ -42,8 +42,8 @@ int ieee80211_wx_set_freq(struct ieee80211_device *ieee, =
struct iw_request_info
=20
 =09/* if setting by freq convert to channel */
 =09if (fwrq->e =3D=3D 1) {
-=09=09if ((fwrq->m >=3D (int) 2.412e8 &&
-=09=09     fwrq->m <=3D (int) 2.487e8)) {
+=09=09if ((fwrq->m >=3D (int)2.412e8 &&
+=09=09     fwrq->m <=3D (int)2.487e8)) {
 =09=09=09int f =3D fwrq->m / 100000;
 =09=09=09int c =3D 0;
=20
@@ -92,7 +92,7 @@ int ieee80211_wx_get_freq(struct ieee80211_device *ieee,
 =09if (ieee->current_network.channel =3D=3D 0)
 =09=09return -1;
 =09/* NM 0.7.0 will not accept channel any more. */
-=09fwrq->m =3D ieee80211_wlan_frequencies[ieee->current_network.channel-1]=
 * 100000;
+=09fwrq->m =3D ieee80211_wlan_frequencies[ieee->current_network.channel - =
1] * 100000;
 =09fwrq->e =3D 1;
 =09/* fwrq->m =3D ieee->current_network.channel; */
 =09/* fwrq->e =3D 0; */
@@ -220,7 +220,7 @@ int ieee80211_wx_set_rate(struct ieee80211_device *ieee=
,
=20
 =09u32 target_rate =3D wrqu->bitrate.value;
=20
-=09ieee->rate =3D target_rate/100000;
+=09ieee->rate =3D target_rate / 100000;
 =09/* FIXME: we might want to limit rate also in management protocols. */
 =09return 0;
 }
@@ -415,9 +415,9 @@ int ieee80211_wx_set_essid(struct ieee80211_device *iee=
e,
=20
 =09if (wrqu->essid.flags && wrqu->essid.length) {
 =09=09/* first flush current network.ssid */
-=09=09len =3D ((wrqu->essid.length-1) < IW_ESSID_MAX_SIZE) ? (wrqu->essid.=
length-1) : IW_ESSID_MAX_SIZE;
-=09=09strncpy(ieee->current_network.ssid, extra, len+1);
-=09=09ieee->current_network.ssid_len =3D len+1;
+=09=09len =3D ((wrqu->essid.length - 1) < IW_ESSID_MAX_SIZE) ? (wrqu->essi=
d.length - 1) : IW_ESSID_MAX_SIZE;
+=09=09strncpy(ieee->current_network.ssid, extra, len + 1);
+=09=09ieee->current_network.ssid_len =3D len + 1;
 =09=09ieee->ssid_set =3D 1;
 =09} else {
 =09=09ieee->ssid_set =3D 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_tx.c
index c49357067735..e76bdedc8409 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -294,7 +294,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211=
_device *ieee,
 =09struct tx_ts_record        *pTxTs =3D NULL;
 =09struct rtl_80211_hdr_1addr *hdr =3D (struct rtl_80211_hdr_1addr *)skb->=
data;
=20
-=09if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+=09if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 =09=09return;
 =09if (!IsQoSDataFrame(skb->data))
 =09=09return;
@@ -334,7 +334,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211=
_device *ieee,
 =09=09}
 =09}
 FORCED_AGG_SETTING:
-=09switch (pHTInfo->ForcedAMPDUMode ) {
+=09switch (pHTInfo->ForcedAMPDUMode) {
 =09=09case HT_AGG_AUTO:
 =09=09=09break;
=20
@@ -372,7 +372,7 @@ ieee80211_query_HTCapShortGI(struct ieee80211_device *i=
eee, struct cb_desc *tcb_
=20
 =09tcb_desc->bUseShortGI=09=09=3D false;
=20
-=09if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+=09if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 =09=09return;
=20
 =09if (pHTInfo->bForcedShortGI) {
@@ -380,9 +380,9 @@ ieee80211_query_HTCapShortGI(struct ieee80211_device *i=
eee, struct cb_desc *tcb_
 =09=09return;
 =09}
=20
-=09if ((pHTInfo->bCurBW40MHz=3D=3Dtrue) && pHTInfo->bCurShortGI40MHz)
+=09if ((pHTInfo->bCurBW40MHz =3D=3D true) && pHTInfo->bCurShortGI40MHz)
 =09=09tcb_desc->bUseShortGI =3D true;
-=09else if ((pHTInfo->bCurBW40MHz=3D=3Dfalse) && pHTInfo->bCurShortGI20MHz=
)
+=09else if ((pHTInfo->bCurBW40MHz =3D=3D false) && pHTInfo->bCurShortGI20M=
Hz)
 =09=09tcb_desc->bUseShortGI =3D true;
 }
=20
@@ -393,16 +393,16 @@ static void ieee80211_query_BandwidthMode(struct ieee=
80211_device *ieee,
=20
 =09tcb_desc->bPacketBW =3D false;
=20
-=09if (!pHTInfo->bCurrentHTSupport||!pHTInfo->bEnableHT)
+=09if (!pHTInfo->bCurrentHTSupport || !pHTInfo->bEnableHT)
 =09=09return;
=20
 =09if (tcb_desc->bMulticast || tcb_desc->bBroadcast)
 =09=09return;
=20
-=09if ((tcb_desc->data_rate & 0x80)=3D=3D0) // If using legacy rate, it sh=
all use 20MHz channel.
+=09if ((tcb_desc->data_rate & 0x80) =3D=3D 0) // If using legacy rate, it =
shall use 20MHz channel.
 =09=09return;
 =09//BandWidthAutoSwitch is for auto switch to 20 or 40 in long distance
-=09if(pHTInfo->bCurBW40MHz && pHTInfo->bCurTxBW40MHz && !ieee->bandwidth_a=
uto_switch.bforced_tx20Mhz)
+=09if (pHTInfo->bCurBW40MHz && pHTInfo->bCurTxBW40MHz && !ieee->bandwidth_=
auto_switch.bforced_tx20Mhz)
 =09=09tcb_desc->bPacketBW =3D true;
 =09return;
 }
@@ -418,10 +418,10 @@ static void ieee80211_query_protectionmode(struct iee=
e80211_device *ieee,
 =09tcb_desc->RTSSC=09=09=09=09=3D 0;=09=09// 20MHz: Don't care;  40MHz: Du=
plicate.
 =09tcb_desc->bRTSBW=09=09=09=3D false; // RTS frame bandwidth is always 20=
MHz
=20
-=09if(tcb_desc->bBroadcast || tcb_desc->bMulticast)//only unicast frame wi=
ll use rts/cts
+=09if (tcb_desc->bBroadcast || tcb_desc->bMulticast) //only unicast frame =
will use rts/cts
 =09=09return;
=20
-=09if (is_broadcast_ether_addr(skb->data+16))  //check addr3 as infrastruc=
ture add3 is DA.
+=09if (is_broadcast_ether_addr(skb->data + 16))  //check addr3 as infrastr=
ucture add3 is DA.
 =09=09return;
=20
 =09if (ieee->mode < IEEE_N_24G) /* b, g mode */ {
@@ -451,9 +451,9 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09=09=09=09break;
 =09=09=09}
 =09=09=09//check HT op mode
-=09=09=09if(pHTInfo->bCurrentHTSupport  && pHTInfo->bEnableHT) {
+=09=09=09if (pHTInfo->bCurrentHTSupport && pHTInfo->bEnableHT) {
 =09=09=09=09u8 HTOpMode =3D pHTInfo->CurrentOpMode;
-=09=09=09=09if((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =3D=
=3D 3)) ||
+=09=09=09=09if ((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =
=3D=3D 3)) ||
 =09=09=09=09=09=09=09(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3)) {
 =09=09=09=09=09tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
 =09=09=09=09=09tcb_desc->bRTSEnable =3D true;
@@ -468,7 +468,7 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09=09=09}
 =09=09=09//to do list: check MIMO power save condition.
 =09=09=09//check AMPDU aggregation for TXOP
-=09=09=09if(tcb_desc->bAMPDUEnable) {
+=09=09=09if (tcb_desc->bAMPDUEnable) {
 =09=09=09=09tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
 =09=09=09=09// According to 8190 design, firmware sends CF-End only if RTS=
/CTS is enabled. However, it degrads
 =09=09=09=09// throughput around 10M, so we disable of this mechanism. 200=
7.08.03 by Emily
@@ -476,7 +476,7 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09=09=09=09break;
 =09=09=09}
 =09=09=09//check IOT action
-=09=09=09if(pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF) {
+=09=09=09if (pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF) {
 =09=09=09=09tcb_desc->bCTSEnable=09=3D true;
 =09=09=09=09tcb_desc->rts_rate  =3D=09MGN_24M;
 =09=09=09=09tcb_desc->bRTSEnable =3D true;
@@ -517,7 +517,7 @@ static void ieee80211_txrate_selectmode(struct ieee8021=
1_device *ieee,
 =09=09return;
 =09}
=20
-=09if (pMgntInfo->ForcedDataRate!=3D 0) {
+=09if (pMgntInfo->ForcedDataRate !=3D 0) {
 =09=09pTcb->bTxDisableRateFallBack =3D true;
 =09=09pTcb->bTxUseDriverAssingedRate =3D true;
 =09=09return;
@@ -576,7 +576,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09/* If there is no driver handler to take the TXB, dont' bother
 =09 * creating it...
 =09 */
-=09if ((!ieee->hard_start_xmit && !(ieee->softmac_features & IEEE_SOFTMAC_=
TX_QUEUE))||
+=09if ((!ieee->hard_start_xmit && !(ieee->softmac_features & IEEE_SOFTMAC_=
TX_QUEUE)) ||
 =09   ((!ieee->softmac_data_hard_start_xmit && (ieee->softmac_features & I=
EEE_SOFTMAC_TX_QUEUE)))) {
 =09=09printk(KERN_WARNING "%s: No xmit handler.\n",
 =09=09       ieee->dev->name);
@@ -615,7 +615,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
=20
 =09=09/* Save source and destination addresses */
 =09=09memcpy(&dest, skb->data, ETH_ALEN);
-=09=09memcpy(&src, skb->data+ETH_ALEN, ETH_ALEN);
+=09=09memcpy(&src, skb->data + ETH_ALEN, ETH_ALEN);
=20
 =09=09/* Advance the SKB to the start of the payload */
 =09=09skb_pull(skb, sizeof(struct ethhdr));
@@ -630,7 +630,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09=09=09fc =3D IEEE80211_FTYPE_DATA;
=20
 =09=09//if(ieee->current_network.QoS_Enable)
-=09=09if(qos_actived)
+=09=09if (qos_actived)
 =09=09=09fc |=3D IEEE80211_STYPE_QOS_DATA;
 =09=09else
 =09=09=09fc |=3D IEEE80211_STYPE_DATA;
@@ -724,7 +724,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09=09for (i =3D 0; i < nr_frags; i++) {
 =09=09=09skb_frag =3D txb->fragments[i];
 =09=09=09tcb_desc =3D (struct cb_desc *)(skb_frag->cb + MAX_DEV_ADDR_SIZE)=
;
-=09=09=09if(qos_actived){
+=09=09=09if (qos_actived) {
 =09=09=09=09skb_frag->priority =3D skb->priority;//UP2AC(skb->priority);
 =09=09=09=09tcb_desc->queue_index =3D  UP2AC(skb->priority);
 =09=09=09} else {
@@ -757,11 +757,11 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_de=
vice *dev)
 =09=09=09=09bytes =3D bytes_last_frag;
 =09=09=09}
 =09=09=09//if(ieee->current_network.QoS_Enable)
-=09=09=09if(qos_actived) {
+=09=09=09if (qos_actived) {
 =09=09=09=09// add 1 only indicate to corresponding seq number control 200=
6/7/12
-=09=09=09=09frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[UP2AC(skb->pr=
iority)+1]<<4 | i);
+=09=09=09=09frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[UP2AC(skb->pr=
iority) + 1] << 4 | i);
 =09=09=09} else {
-=09=09=09=09frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[0]<<4 | i);
+=09=09=09=09frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[0] << 4 | i);
 =09=09=09}
=20
 =09=09=09/* Put a SNAP header on the first fragment */
@@ -806,7 +806,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09=09}
=20
 =09=09txb =3D ieee80211_alloc_txb(1, skb->len, GFP_ATOMIC);
-=09=09if(!txb){
+=09=09if (!txb) {
 =09=09=09printk(KERN_WARNING "%s: Could not allocate TXB\n",
 =09=09=09ieee->dev->name);
 =09=09=09goto failed;
@@ -841,9 +841,9 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09spin_unlock_irqrestore(&ieee->lock, flags);
 =09dev_kfree_skb_any(skb);
 =09if (txb) {
-=09=09if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE){
+=09=09if (ieee->softmac_features & IEEE_SOFTMAC_TX_QUEUE) {
 =09=09=09ieee80211_softmac_xmit(txb, ieee);
-=09=09}else{
+=09=09} else {
 =09=09=09if ((*ieee->hard_start_xmit)(txb, dev) =3D=3D 0) {
 =09=09=09=09stats->tx_packets++;
 =09=09=09=09stats->tx_bytes +=3D __le16_to_cpu(txb->payload_size);
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_wx.c
index 8ad85331f020..8ca7a7fd74f9 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -70,10 +70,10 @@ static inline char *rtl819x_translate_scan(struct ieee8=
0211_device *ieee,
 =09}
 =09/* Add the protocol name */
 =09iwe.cmd =3D SIOCGIWNAME;
-=09for(i=3D0; i<ARRAY_SIZE(ieee80211_modes); i++) {
+=09for (i =3D 0; i < ARRAY_SIZE(ieee80211_modes); i++) {
 =09=09if (network->mode & BIT(i)) {
-=09=09=09sprintf(pname,ieee80211_modes[i].mode_string,ieee80211_modes[i].m=
ode_size);
-=09=09=09pname +=3Dieee80211_modes[i].mode_size;
+=09=09=09sprintf(pname, ieee80211_modes[i].mode_string, ieee80211_modes[i]=
.mode_size);
+=09=09=09pname +=3D ieee80211_modes[i].mode_size;
 =09=09}
 =09}
 =09*pname =3D '\0';
@@ -138,13 +138,13 @@ static inline char *rtl819x_translate_scan(struct iee=
e80211_device *ieee,
 =09=09=09ht_cap =3D (struct ht_capability_ele *)&network->bssht.bdHTCapBuf=
[4];
 =09=09else
 =09=09=09ht_cap =3D (struct ht_capability_ele *)&network->bssht.bdHTCapBuf=
[0];
-=09=09is40M =3D (ht_cap->ChlWidth)?1:0;
-=09=09isShortGI =3D (ht_cap->ChlWidth)?
-=09=09=09=09=09=09((ht_cap->ShortGI40Mhz)?1:0):
-=09=09=09=09=09=09((ht_cap->ShortGI20Mhz)?1:0);
+=09=09is40M =3D (ht_cap->ChlWidth) ? 1 : 0;
+=09=09isShortGI =3D (ht_cap->ChlWidth) ?
+=09=09=09=09=09((ht_cap->ShortGI40Mhz) ? 1 : 0) :
+=09=09=09=09=09((ht_cap->ShortGI20Mhz) ? 1 : 0);
=20
 =09=09max_mcs =3D HTGetHighestMCSRate(ieee, ht_cap->MCS, MCS_FILTER_ALL);
-=09=09rate =3D MCS_DATA_RATE[is40M][isShortGI][max_mcs&0x7f];
+=09=09rate =3D MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 =09=09if (rate > max_rate)
 =09=09=09max_rate =3D rate;
 =09}
@@ -242,7 +242,7 @@ int ieee80211_wx_get_scan(struct ieee80211_device *ieee=
,
=20
 =09list_for_each_entry(network, &ieee->network_list, list) {
 =09=09i++;
-=09=09if((stop-ev)<200) {
+=09=09if ((stop - ev) < 200) {
 =09=09=09err =3D -E2BIG;
 =09=09=09break;
 =09=09}
@@ -453,7 +453,7 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ie=
ee,
=20
 =09IEEE80211_DEBUG_WX("GET_ENCODE\n");
=20
-=09if(ieee->iw_mode =3D=3D IW_MODE_MONITOR)
+=09if (ieee->iw_mode =3D=3D IW_MODE_MONITOR)
 =09=09return -1;
=20
 =09key =3D erq->flags & IW_ENCODE_INDEX;
@@ -570,7 +570,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_device=
 *ieee,
 =09=09ret =3D -EINVAL;
 =09=09goto done;
 =09}
-=09printk("alg name:%s\n",alg);
+=09printk("alg name:%s\n", alg);
=20
 =09ops =3D try_then_request_module(ieee80211_get_crypto_ops(alg), module);
 =09if (!ops) {
@@ -687,7 +687,7 @@ int ieee80211_wx_get_encode_ext(struct ieee80211_device=
 *ieee,
 =09=09ext->key_len =3D 0;
 =09=09encoding->flags |=3D IW_ENCODE_DISABLED;
 =09} else {
-=09=09if (strcmp(crypt->ops->name, "WEP") =3D=3D 0 )
+=09=09if (strcmp(crypt->ops->name, "WEP") =3D=3D 0)
 =09=09=09ext->alg =3D IW_ENCODE_ALG_WEP;
 =09=09else if (strcmp(crypt->ops->name, "TKIP"))
 =09=09=09ext->alg =3D IW_ENCODE_ALG_TKIP;
@@ -711,7 +711,7 @@ int ieee80211_wx_set_mlme(struct ieee80211_device *ieee=
,
 =09=09=09       struct iw_request_info *info,
 =09=09=09       union iwreq_data *wrqu, char *extra)
 {
-=09struct iw_mlme *mlme =3D (struct iw_mlme *) extra;
+=09struct iw_mlme *mlme =3D (struct iw_mlme *)extra;
 =09switch (mlme->cmd) {
 =09case IW_MLME_DEAUTH:
 =09case IW_MLME_DISASSOC:
@@ -764,7 +764,7 @@ int ieee80211_wx_set_auth(struct ieee80211_device *ieee=
,
 =09=09break;
=20
 =09case IW_AUTH_WPA_ENABLED:
-=09=09ieee->wpa_enabled =3D (data->value)?1:0;
+=09=09ieee->wpa_enabled =3D (data->value) ? 1 : 0;
 =09=09break;
=20
 =09case IW_AUTH_RX_UNENCRYPTED_EAPOL:
@@ -784,14 +784,14 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *=
ieee, u8 *ie, size_t len)
 {
 =09u8 *buf;
=20
-=09if (len>MAX_WPA_IE_LEN || (len && !ie)) {
+=09if (len > MAX_WPA_IE_LEN || (len && !ie)) {
 =09//=09printk("return error out, len:%d\n", len);
 =09return -EINVAL;
 =09}
=20
=20
 =09if (len) {
-=09=09if (len !=3D ie[1]+2) {
+=09=09if (len !=3D ie[1] + 2) {
 =09=09=09printk("len:%zu, ie:%d\n", len, ie[1]);
 =09=09=09return -EINVAL;
 =09=09}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/=
staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index 53869b3c985c..379a2ccf4d9f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -162,7 +162,7 @@ static struct sk_buff *ieee80211_ADDBA(struct ieee80211=
_device *ieee, u8 *Dst, s
 =09=09tag +=3D 2;
 =09}
=20
-=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb-=
>len);
+=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_BA, skb->data, sk=
b->len);
 =09return skb;
 =09//return NULL;
 }
@@ -229,7 +229,7 @@ static struct sk_buff *ieee80211_DELBA(
 =09put_unaligned_le16(ReasonCode, tag);
 =09tag +=3D 2;
=20
-=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb-=
>len);
+=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_BA, skb->data, sk=
b->len);
 =09if (net_ratelimit())
 =09=09IEEE80211_DEBUG(IEEE80211_DL_TRACE | IEEE80211_DL_BA,
 =09=09=09=09"<=3D=3D=3D=3D=3D%s()\n", __func__);
@@ -331,9 +331,9 @@ int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee=
, struct sk_buff *skb)
 =09=09return -1;
 =09}
=20
-=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb-=
>len);
+=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_BA, skb->data, sk=
b->len);
=20
-=09req =3D (struct rtl_80211_hdr_3addr *) skb->data;
+=09req =3D (struct rtl_80211_hdr_3addr *)skb->data;
 =09tag =3D (u8 *)req;
 =09dst =3D &req->addr2[0];
 =09tag +=3D sizeof(struct rtl_80211_hdr_3addr);
@@ -556,7 +556,7 @@ int ieee80211_rx_DELBA(struct ieee80211_device *ieee, s=
truct sk_buff *skb)
 =09=09return -1;
 =09}
=20
-=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA|IEEE80211_DL_BA, skb->data, skb-=
>len);
+=09IEEE80211_DEBUG_DATA(IEEE80211_DL_DATA | IEEE80211_DL_BA, skb->data, sk=
b->len);
 =09delba =3D (struct rtl_80211_hdr_3addr *)skb->data;
 =09dst =3D &delba->addr2[0];
 =09pDelBaParamSet =3D (union delba_param_set *)&delba->payload[2];
@@ -643,7 +643,7 @@ TsInitDelBA(struct ieee80211_device *ieee, struct ts_co=
mmon_info *pTsCommonInfo,
 =09=09=09ieee80211_send_DELBA(
 =09=09=09=09ieee,
 =09=09=09=09pTsCommonInfo->addr,
-=09=09=09=09(pTxTs->tx_admitted_ba_record.valid)?(&pTxTs->tx_admitted_ba_r=
ecord):(&pTxTs->tx_pending_ba_record),
+=09=09=09=09(pTxTs->tx_admitted_ba_record.valid) ? (&pTxTs->tx_admitted_ba=
_record) : (&pTxTs->tx_pending_ba_record),
 =09=09=09=09TxRxSelect,
 =09=09=09=09DELBA_REASON_END_BA);
 =09} else if (TxRxSelect =3D=3D RX_DIR) {
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/stag=
ing/rtl8192u/ieee80211/rtl819x_HT.h
index 586d93720e37..79346a00af09 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -270,7 +270,7 @@ typedef enum _HT_AGGRE_SIZE {
 =09HT_AGG_SIZE_16K =3D 1,
 =09HT_AGG_SIZE_32K =3D 2,
 =09HT_AGG_SIZE_64K =3D 3,
-}HT_AGGRE_SIZE_E, *PHT_AGGRE_SIZE_E;
+} HT_AGGRE_SIZE_E, *PHT_AGGRE_SIZE_E;
=20
 /* Indicate different AP vendor for IOT issue */
 typedef enum _HT_IOT_PEER {
@@ -281,7 +281,7 @@ typedef enum _HT_IOT_PEER {
 =09HT_IOT_PEER_ATHEROS =3D 4,
 =09HT_IOT_PEER_CISCO =3D 5,
 =09HT_IOT_PEER_MAX =3D 6
-}HT_IOT_PEER_E, *PHTIOT_PEER_E;
+} HT_IOT_PEER_E, *PHTIOT_PEER_E;
=20
 /*
  * IOT Action for different AP
@@ -297,6 +297,6 @@ typedef enum _HT_IOT_ACTION {
 =09HT_IOT_ACT_CDD_FSYNC =3D 0x00000080,
 =09HT_IOT_ACT_PURE_N_MODE =3D 0x00000100,
 =09HT_IOT_ACT_FORCED_CTS2SELF =3D 0x00000200,
-}HT_IOT_ACTION_E, *PHT_IOT_ACTION_E;
+} HT_IOT_ACTION_E, *PHT_IOT_ACTION_E;
=20
 #endif //_RTL819XU_HTTYPE_H_
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/=
staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 59d179ae7ad2..f4e5aa07421f 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -105,7 +105,7 @@ static void ResetTsCommonInfo(struct ts_common_info *pT=
sCommonInfo)
 {
 =09eth_zero_addr(pTsCommonInfo->addr);
 =09memset(&pTsCommonInfo->t_spec, 0, sizeof(struct tspec_body));
-=09memset(&pTsCommonInfo->t_class, 0, sizeof(union qos_tclas)*TCLAS_NUM);
+=09memset(&pTsCommonInfo->t_class, 0, sizeof(union qos_tclas) * TCLAS_NUM)=
;
 =09pTsCommonInfo->t_clas_proc =3D 0;
 =09pTsCommonInfo->t_clas_num =3D 0;
 }
@@ -183,9 +183,9 @@ void TSInitialize(struct ieee80211_device *ieee)
 //#ifdef TO_DO_LIST
 =09for (count =3D 0; count < REORDER_ENTRY_NUM; count++) {
 =09=09list_add_tail(&pRxReorderEntry->List, &ieee->RxReorder_Unused_List);
-=09=09if (count =3D=3D (REORDER_ENTRY_NUM-1))
+=09=09if (count =3D=3D (REORDER_ENTRY_NUM - 1))
 =09=09=09break;
-=09=09pRxReorderEntry =3D &ieee->RxReorderEntry[count+1];
+=09=09pRxReorderEntry =3D &ieee->RxReorderEntry[count + 1];
 =09}
 //#endif
 }
@@ -259,7 +259,7 @@ static struct ts_common_info *SearchAdmitTRStream(struc=
t ieee80211_device *ieee,
 =09}
=20
 =09if (&pRet->list  !=3D psearch_list)
-=09=09return pRet ;
+=09=09return pRet;
 =09else
 =09=09return NULL;
 }
@@ -367,8 +367,8 @@ bool GetTs(
 =09=09=09=09=09=09=09=09(&ieee->Rx_TS_Admit_List);
=20
 =09=09=09enum direction_value=09Dir =3D=09=09(ieee->iw_mode =3D=3D IW_MODE=
_MASTER) ?
-=09=09=09=09=09=09=09=09((TxRxSelect =3D=3D TX_DIR)?DIR_DOWN:DIR_UP) :
-=09=09=09=09=09=09=09=09((TxRxSelect =3D=3D TX_DIR)?DIR_UP:DIR_DOWN);
+=09=09=09=09=09=09=09=09((TxRxSelect =3D=3D TX_DIR) ? DIR_DOWN : DIR_UP) :
+=09=09=09=09=09=09=09=09((TxRxSelect =3D=3D TX_DIR) ? DIR_UP : DIR_DOWN);
 =09=09=09IEEE80211_DEBUG(IEEE80211_DL_TS, "to add Ts\n");
 =09=09=09if (!list_empty(pUnusedList)) {
 =09=09=09=09(*ppTS) =3D list_entry(pUnusedList->next, struct ts_common_inf=
o, list);
@@ -530,7 +530,7 @@ void TsStartAddBaProcess(struct ieee80211_device *ieee,=
 struct tx_ts_record *pTx
 =09=09=09=09  jiffies + msecs_to_jiffies(TS_ADDBA_DELAY));
 =09=09} else {
 =09=09=09IEEE80211_DEBUG(IEEE80211_DL_BA, "%s: Immediately Start ADDBA now=
!!\n", __func__);
-=09=09=09mod_timer(&pTxTS->ts_add_ba_timer, jiffies+10); //set 10 ticks
+=09=09=09mod_timer(&pTxTS->ts_add_ba_timer, jiffies + 10); //set 10 ticks
 =09=09}
 =09} else {
 =09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s()=3D=3D>BA timer is already ad=
ded\n", __func__);
--=20
2.22.0



