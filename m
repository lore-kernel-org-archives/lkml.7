Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC31C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6248C2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="iC484pvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbfHVRwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:52:54 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21543 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393345AbfHVRwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566496365; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=njcRsPF/02yn6H0lZYcK+rcCJIm/AdP3uLokWD7X6U/uELuqpiNFQ9bnjoIXJZBOXo+D+TO4yB1FOHwzrzH22+YO2+yOHnMIk1iwIK8obB0kBxfO21EX9XJTZcEhF6pi5vI5H26FlhRdUxxTJ7LTt+eAXUsBhjEKnJZJeA5X/Oo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566496365; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=hajNLWDItg9LFXr1p/488VmQbRzQ2eUHYOM9UokpjIU=; 
        b=anaNHWVPRG5Dad0pAq1biqa7Sph3tYYO193Qg/EFu3XTD3GqqpR9jbnYchLrZWEZQL5hjfFe/KAZ7zeW2TYXa1CUCnPa9KeCEO79A4GdLdmx6Cynt9cGWlv/625/pA+oyrk3IAXVBk+uJdAB0eAIwvMLOPqA1zzCv0eGD0Mf45E=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566496365;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=14220; bh=hajNLWDItg9LFXr1p/488VmQbRzQ2eUHYOM9UokpjIU=;
        b=iC484pvuZYhLOkHtI3rDB5xjZHAPWhtsAVLo/0PIzaO7FTPe3XmoZEz0gIZU69ib
        n/vJLlqGVIS2TBRR0apTx73QgNEKl2SpiuXkmMjexrM4Et/9IRfvBo4ZViJLlkzM1Rj
        qwkVLSRzcN14KdKlI+6oi5y5ey040iKG6je4BmCY=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566496361624408.21571661497194; Thu, 22 Aug 2019 10:52:41 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <20190822175228.3419-1-stephen@brennan.io>
Subject: [PATCH] staging: rtl8192u: Fix indentation
Date:   Thu, 22 Aug 2019 10:52:28 -0700
X-Mailer: git-send-email 2.22.0
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
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c |   2 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 112 +++++++++---------
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  18 +--
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   8 +-
 drivers/staging/rtl8192u/r819xU_firmware.c    |   2 +-
 5 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/dr=
ivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index aecee42be95e..369c57b63350 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -346,7 +346,7 @@ static int ieee80211_ccmp_set_key(void *key, int len, u=
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
index 7ef1e89de269..643e40e4c5fe 100644
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
@@ -427,17 +427,17 @@ static int is_duplicate_packet(struct ieee80211_devic=
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
@@ -999,7 +999,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct =
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
@@ -1220,10 +1220,10 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
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
@@ -1785,13 +1785,13 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
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
@@ -1807,17 +1807,17 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
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
@@ -1837,7 +1837,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
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
@@ -1858,7 +1858,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09=09=09 info_element->data[1] =3D=3D 0x10 &&
 =09=09=09=09=09 info_element->data[2] =3D=3D 0x18)){
=20
-=09=09=09=09=09=09network->broadcom_cap_exist =3D true;
+=09=09=09=09=09network->broadcom_cap_exist =3D true;
=20
 =09=09=09=09}
 =09=09=09}
@@ -2289,7 +2289,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
 =09   src->wmm_param[1].aci_aifsn || \
 =09   src->wmm_param[2].aci_aifsn || \
 =09   src->wmm_param[3].aci_aifsn) {
-=09  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
+=09=09memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 =09}
 =09//dst->QoS_Enable =3D src->QoS_Enable;
 #ifdef THOMAS_TURBO
@@ -2436,11 +2436,11 @@ static inline void ieee80211_process_probe_response=
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
 =09=09if (is_beacon(beacon->header.frame_ctl))
 =09=09{
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_tx.c
index fc6eb97801e1..506de76a052f 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -508,7 +508,7 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09if (ieee->current_network.capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
 =09=09tcb_desc->bUseShortPreamble =3D true;
 =09if (ieee->mode =3D=3D IW_MODE_MASTER)
-=09=09=09goto NO_PROTECTION;
+=09=09goto NO_PROTECTION;
 =09return;
 NO_PROTECTION:
 =09tcb_desc->bRTSEnable=09=3D false;
@@ -808,15 +808,15 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_de=
vice *dev)
=20
 =09=09if(qos_actived)
 =09=09{
-=09=09  if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
-=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
-=09=09  else
-=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
+=09=09=09if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
+=09=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
+=09=09=09else
+=09=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
 =09=09} else {
-=09=09  if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
-=09=09=09ieee->seq_ctrl[0] =3D 0;
-=09=09  else
-=09=09=09ieee->seq_ctrl[0]++;
+=09=09=09if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
+=09=09=09=09ieee->seq_ctrl[0] =3D 0;
+=09=09=09else
+=09=09=09=09ieee->seq_ctrl[0]++;
 =09=09}
 =09} else {
 =09=09if (unlikely(skb->len < sizeof(struct rtl_80211_hdr_3addr))) {
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_wx.c
index be08cd1d37a7..4920c1b27b52 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -178,7 +178,7 @@ static inline char *rtl819x_translate_scan(struct ieee8=
0211_device *ieee,
=20
 =09iwe.u.data.length =3D p - custom;
 =09if (iwe.u.data.length)
-=09    start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
+=09=09start =3D iwe_stream_add_point(info, start, stop, &iwe, custom);
=20
 =09if (ieee->wpa_enabled && network->wpa_ie_len) {
 =09=09char buf[MAX_WPA_IE_LEN * 2 + 30];
@@ -219,7 +219,7 @@ static inline char *rtl819x_translate_scan(struct ieee8=
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
@@ -786,8 +786,8 @@ int ieee80211_wx_set_gen_ie(struct ieee80211_device *ie=
ee, u8 *ie, size_t len)
 =09u8 *buf;
=20
 =09if (len>MAX_WPA_IE_LEN || (len && !ie)) {
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
2.22.0



