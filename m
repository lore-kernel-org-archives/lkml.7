Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64CAC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44A3214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="eAGsxofi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfH1Efz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:35:55 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21529 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfH1Efz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:35:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566966948; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=X6DnzLSx8G2a/jySG0yb7J60Z8D1bHd2/Lm/YPy3ugOc5wMW9zRhtl6gFraZETyP9MHCBctG36DObB41f9kuw3sSz8cPMQz7c2NKwwHSJ8NnCXSZVVD91LDYR7XDn+/dBd1QhINgFnF4fYBYW08avlEb0aqq5F4/LxYyQ7w1iqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566966948; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=kikqoJ0TjtZ4CxrJtQaQAaZ7Aru+k2N4yAWG/ret9Ew=; 
        b=dCsQY/ozqjt4FX+BNzGeJG0ro4aMEorhkxzuPbmrcUJSJrmbGSKuEpHDx5FiEYRqwEFM2q15sgpgcoYcxTJKHKHkeHvJXkqEPXJPcXwXvLSuxq3r63ssz1WusRZV+oRdY2QBs5qfnq9eFARj1ypAV8sZGyKyaemCTneNWTZQh/E=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566966948;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=13438; bh=kikqoJ0TjtZ4CxrJtQaQAaZ7Aru+k2N4yAWG/ret9Ew=;
        b=eAGsxofiBkvhWH5n2u9yNqeIWyP/8diHLsenF+0RsexZoevc7sl2rLeqAabrom5f
        Wx2KFeWTLGEelb3ohzBC+Og+y29R8Boa013wMwyxzvmTED4jJYrbYJbNLOBFffcb0A/
        +qKHp//6aMkBnsbyxqoSTmdNM1ihjUH71jt0DbOk=
Received: from localhost (c-73-241-204-195.hsd1.ca.comcast.net [73.241.204.195]) by mx.zohomail.com
        with SMTPS id 1566966947446263.7104538757318; Tue, 27 Aug 2019 21:35:47 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <20190828043542.3753-1-stephen@brennan.io>
Subject: [PATCH v2] staging: rtl8192u: Fix indentation
Date:   Tue, 27 Aug 2019 21:35:42 -0700
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch reports WARNING:SUSPECT_CODE_INDENT in several places. Fix
this by aligning code properly with tabs.

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---

Changes in v2: rebase on next-20190827, fixing conflict with spacing fixes.

 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 112 +++++++++---------
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   8 +-
 drivers/staging/rtl8192u/r819xU_firmware.c    |   2 +-
 5 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/dr=
ivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index a43a5d617bd9..c241cf484023 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -345,7 +345,7 @@ static int ieee80211_ccmp_set_key(void *key, int len, u=
8 *seq, void *priv)
 =09=09}
 =09=09if (crypto_aead_setauthsize(tfm, CCMP_MIC_LEN) ||
 =09=09    crypto_aead_setkey(tfm, data->key, CCMP_TK_LEN))
-=09=09=09=09return -1;
+=09=09=09return -1;
 =09} else if (len =3D=3D 0) {
 =09=09data->key_set =3D 0;
 =09} else {
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_rx.c
index a1462ec55767..5c33bcb0db2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -103,17 +103,17 @@ ieee80211_frag_cache_get(struct ieee80211_device *iee=
e,
 =09u8 tid;
=20
 =09if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE=
80211_QOS_HAS_SEQ(fc)) {
-=09  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
-=09  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
+=09=09tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else if (IEEE80211_QOS_HAS_SEQ(fc)) {
-=09  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
-=09  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
+=09=09tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else {
-=09  tid =3D 0;
+=09=09tid =3D 0;
 =09}
=20
 =09if (frag =3D=3D 0) {
@@ -170,17 +170,17 @@ static int ieee80211_frag_cache_invalidate(struct iee=
e80211_device *ieee,
 =09u8 tid;
=20
 =09if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE=
80211_QOS_HAS_SEQ(fc)) {
-=09  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
-=09  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
+=09=09tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else if (IEEE80211_QOS_HAS_SEQ(fc)) {
-=09  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
-=09  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)hdr;
+=09=09tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else {
-=09  tid =3D 0;
+=09=09tid =3D 0;
 =09}
=20
 =09entry =3D ieee80211_frag_cache_find(ieee, seq, -1, tid, hdr->addr2,
@@ -425,17 +425,17 @@ static int is_duplicate_packet(struct ieee80211_devic=
e *ieee,
=20
 =09//TO2DS and QoS
 =09if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE=
80211_QOS_HAS_SEQ(fc)) {
-=09  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
-=09  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
+=09=09tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else if (IEEE80211_QOS_HAS_SEQ(fc)) { //QoS
-=09  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
-=09  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
-=09  tid =3D UP2AC(tid);
-=09  tid++;
+=09=09hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
+=09=09tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
+=09=09tid =3D UP2AC(tid);
+=09=09tid++;
 =09} else { // no QoS
-=09  tid =3D 0;
+=09=09tid =3D 0;
 =09}
=20
 =09switch (ieee->iw_mode) {
@@ -993,7 +993,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct =
sk_buff *skb,
 =09// if QoS enabled, should check the sequence for each of the AC
 =09if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos=
_data.active || !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
 =09=09if (is_duplicate_packet(ieee, hdr))
-=09=09goto rx_dropped;
+=09=09=09goto rx_dropped;
=20
 =09} else {
 =09=09struct rx_ts_record *pRxTS =3D NULL;
@@ -1211,10 +1211,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 #ifdef CONFIG_IEEE80211_DEBUG
 =09if (crypt && !(fc & IEEE80211_FCTL_WEP) &&
 =09    ieee80211_is_eapol_frame(ieee, skb, hdrlen)) {
-=09=09=09struct eapol *eap =3D (struct eapol *)(skb->data +
-=09=09=09=0924);
-=09=09=09IEEE80211_DEBUG_EAP("RX: IEEE 802.1X EAPOL frame: %s\n",
-=09=09=09=09=09=09eap_get_type(eap->type));
+=09=09struct eapol *eap =3D (struct eapol *)(skb->data +
+=09=09=0924);
+=09=09IEEE80211_DEBUG_EAP("RX: IEEE 802.1X EAPOL frame: %s\n",
+=09=09=09=09=09eap_get_type(eap->type));
 =09}
 #endif
=20
@@ -1770,13 +1770,13 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09   info_element->data[2] =3D=3D 0x4c &&
 =09=09=09=09   info_element->data[3] =3D=3D 0x033){
=20
-=09=09=09=09=09=09tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN)=
;
-=09=09=09=09=09=09if (tmp_htcap_len !=3D 0) {
-=09=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-=09=09=09=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(=
network->bssht.bdHTCapBuf) ? \
-=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf) : tmp_htcap_len;
-=09=09=09=09=09=09=09memcpy(network->bssht.bdHTCapBuf, info_element->data,=
 network->bssht.bdHTCapLen);
-=09=09=09=09=09=09}
+=09=09=09=09=09tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+=09=09=09=09=09if (tmp_htcap_len !=3D 0) {
+=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
+=09=09=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(net=
work->bssht.bdHTCapBuf) ? \
+=09=09=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf) : tmp_htcap_len;
+=09=09=09=09=09=09memcpy(network->bssht.bdHTCapBuf, info_element->data, ne=
twork->bssht.bdHTCapLen);
+=09=09=09=09=09}
 =09=09=09=09}
 =09=09=09=09if (tmp_htcap_len !=3D 0)
 =09=09=09=09=09network->bssht.bdSupportHT =3D true;
@@ -1792,17 +1792,17 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09=09info_element->data[2] =3D=3D 0x4c &&
 =09=09=09=09=09info_element->data[3] =3D=3D 0x034){
=20
-=09=09=09=09=09=09tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN=
);
-=09=09=09=09=09=09if (tmp_htinfo_len !=3D 0) {
-=09=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-=09=09=09=09=09=09=09if (tmp_htinfo_len) {
-=09=09=09=09=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > si=
zeof(network->bssht.bdHTInfoBuf) ? \
-=09=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf) : tmp_htinfo=
_len;
-=09=09=09=09=09=09=09=09memcpy(network->bssht.bdHTInfoBuf, info_element->d=
ata, network->bssht.bdHTInfoLen);
-=09=09=09=09=09=09=09}
-
+=09=09=09=09=09tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+=09=09=09=09=09if (tmp_htinfo_len !=3D 0) {
+=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
+=09=09=09=09=09=09if (tmp_htinfo_len) {
+=09=09=09=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeo=
f(network->bssht.bdHTInfoBuf) ? \
+=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf) : tmp_htinfo_le=
n;
+=09=09=09=09=09=09=09memcpy(network->bssht.bdHTInfoBuf, info_element->data=
, network->bssht.bdHTInfoLen);
 =09=09=09=09=09=09}
=20
+=09=09=09=09=09}
+
 =09=09=09=09}
 =09=09=09}
=20
@@ -1822,7 +1822,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09=09=09=09network->bssht.bdRT2RTAggregation =3D true;
=20
 =09=09=09=09=09=09if ((ht_realtek_agg_buf[4] =3D=3D 1) && (ht_realtek_agg_=
buf[5] & 0x02))
-=09=09=09=09=09=09network->bssht.bdRT2RTLongSlotTime =3D true;
+=09=09=09=09=09=09=09network->bssht.bdRT2RTLongSlotTime =3D true;
 =09=09=09=09=09}
 =09=09=09=09}
=20
@@ -1843,7 +1843,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09=09=09 info_element->data[1] =3D=3D 0x10 &&
 =09=09=09=09=09 info_element->data[2] =3D=3D 0x18)){
=20
-=09=09=09=09=09=09network->broadcom_cap_exist =3D true;
+=09=09=09=09=09network->broadcom_cap_exist =3D true;
=20
 =09=09=09=09}
 =09=09=09}
@@ -2262,7 +2262,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
 =09   src->wmm_param[1].aci_aifsn || \
 =09   src->wmm_param[2].aci_aifsn || \
 =09   src->wmm_param[3].aci_aifsn) {
-=09  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
+=09=09memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 =09}
 =09//dst->QoS_Enable =3D src->QoS_Enable;
 #ifdef THOMAS_TURBO
@@ -2401,11 +2401,11 @@ static inline void ieee80211_process_probe_response=
(
 =09if (is_same_network(&ieee->current_network, network, ieee)) {
 =09=09update_network(&ieee->current_network, network);
 =09=09if ((ieee->current_network.mode =3D=3D IEEE_N_24G || ieee->current_n=
etwork.mode =3D=3D IEEE_G)
-=09=09&& ieee->current_network.berp_info_valid){
-=09=09if (ieee->current_network.erp_value & ERP_UseProtection)
-=09=09=09ieee->current_network.buseprotection =3D true;
-=09=09else
-=09=09=09ieee->current_network.buseprotection =3D false;
+=09=09    && ieee->current_network.berp_info_valid){
+=09=09=09if (ieee->current_network.erp_value & ERP_UseProtection)
+=09=09=09=09ieee->current_network.buseprotection =3D true;
+=09=09=09else
+=09=09=09=09ieee->current_network.buseprotection =3D false;
 =09=09}
 =09=09if (is_beacon(beacon->header.frame_ctl)) {
 =09=09=09if (ieee->state =3D=3D IEEE80211_LINKED)
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_tx.c
index 140e3cb66a2e..f0b6b8372f91 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -488,7 +488,7 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 =09=09tcb_desc->bUseShortPreamble =3D true;
 =09if (ieee->mode =3D=3D IW_MODE_MASTER)
-=09=09=09goto NO_PROTECTION;
+=09=09goto NO_PROTECTION;
 =09return;
 NO_PROTECTION:
 =09tcb_desc->bRTSEnable=09=3D false;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_wx.c
index 8ca7a7fd74f9..9dd5c04181ea 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -177,7 +177,7 @@ static inline char *rtl819x_translate_scan(struct ieee8=
0211_device *ieee,
=20
 =09iwe.u.data.length =3D p - custom;
 =09if (iwe.u.data.length)
-=09    start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
+=09=09start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
=20
 =09if (ieee->wpa_enabled && network->wpa_ie_len) {
 =09=09char buf[MAX_WPA_IE_LEN * 2 + 30];
@@ -218,7 +218,7 @@ static inline char *rtl819x_translate_scan(struct ieee8=
0211_device *ieee,
 =09=09      " Last beacon: %lums ago", (jiffies - network->last_scanned) /=
 (HZ / 100));
 =09iwe.u.data.length =3D p - custom;
 =09if (iwe.u.data.length)
-=09    start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
+=09=09start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
=20
 =09return start;
 }
@@ -785,8 +785,8 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *ie=
ee, u8 *ie, size_t len)
 =09u8 *buf;
=20
 =09if (len > MAX_WPA_IE_LEN || (len && !ie)) {
-=09//=09printk("return error out, len:%d\n", len);
-=09return -EINVAL;
+=09=09//printk("return error out, len:%d\n", len);
+=09=09return -EINVAL;
 =09}
=20
=20
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/r=
tl8192u/r819xU_firmware.c
index 153d4ee0ec07..dd81d210bd49 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -231,7 +231,7 @@ bool init_firmware(struct net_device *dev)
 =09=09rst_opt =3D OPT_FIRMWARE_RESET;
 =09=09starting_state =3D FW_INIT_STEP2_DATA;
 =09} else {
-=09=09 RT_TRACE(COMP_FIRMWARE, "PlatformInitFirmware: undefined firmware s=
tate\n");
+=09=09RT_TRACE(COMP_FIRMWARE, "PlatformInitFirmware: undefined firmware st=
ate\n");
 =09}
=20
 =09/*
--=20
2.23.0



