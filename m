Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85253C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D82217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfDRMUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:20:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37370 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:20:45 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hH61y-00063f-7z; Thu, 18 Apr 2019 12:20:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: fix spelling mistake "singal" -> "signal"
Date:   Thu, 18 Apr 2019 13:20:41 +0100
Message-Id: <20190418122041.12896-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are multiple spelling mistakes in variable names, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c      | 18 +++++++++---------
 drivers/staging/rtl8723bs/include/rtw_recv.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index f1c91483ca07..e5f1153527b9 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -1618,14 +1618,14 @@ void rtw_get_raw_rssi_info(void *sel, struct adapter *padapter)
 	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
 
 	if (isCCKrate)
-		psample_pkt_rssi->mimo_singal_strength[0] = psample_pkt_rssi->pwdball;
+		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
 		DBG_871X_SEL_NL(
 			sel,
-			"RF_PATH_%d =>singal_strength:%d(%%), singal_quality:%d(%%)\n",
-			rf_path, psample_pkt_rssi->mimo_singal_strength[rf_path],
-			psample_pkt_rssi->mimo_singal_quality[rf_path]
+			"RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)\n",
+			rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path],
+			psample_pkt_rssi->mimo_signal_quality[rf_path]
 		);
 
 		if (!isCCKrate) {
@@ -1651,11 +1651,11 @@ void rtw_dump_raw_rssi_info(struct adapter *padapter)
 	isCCKrate = psample_pkt_rssi->data_rate <= DESC_RATE11M;
 
 	if (isCCKrate)
-		psample_pkt_rssi->mimo_singal_strength[0] = psample_pkt_rssi->pwdball;
+		psample_pkt_rssi->mimo_signal_strength[0] = psample_pkt_rssi->pwdball;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		DBG_871X("RF_PATH_%d =>singal_strength:%d(%%), singal_quality:%d(%%)"
-			, rf_path, psample_pkt_rssi->mimo_singal_strength[rf_path], psample_pkt_rssi->mimo_singal_quality[rf_path]);
+		DBG_871X("RF_PATH_%d =>signal_strength:%d(%%), signal_quality:%d(%%)"
+			, rf_path, psample_pkt_rssi->mimo_signal_strength[rf_path], psample_pkt_rssi->mimo_signal_quality[rf_path]);
 
 		if (!isCCKrate) {
 			printk(", rx_ofdm_pwr:%d(dBm), rx_ofdm_snr:%d(dB)\n",
@@ -1682,8 +1682,8 @@ void rtw_store_phy_info(struct adapter *padapter, union recv_frame *prframe)
 	psample_pkt_rssi->pwr_all = pPhyInfo->recv_signal_power;
 
 	for (rf_path = 0; rf_path < pHalData->NumTotalRFPath; rf_path++) {
-		psample_pkt_rssi->mimo_singal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
-		psample_pkt_rssi->mimo_singal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
+		psample_pkt_rssi->mimo_signal_strength[rf_path] = pPhyInfo->rx_mimo_signal_strength[rf_path];
+		psample_pkt_rssi->mimo_signal_quality[rf_path] = pPhyInfo->rx_mimo_signal_quality[rf_path];
 		if (!isCCKrate) {
 			psample_pkt_rssi->ofdm_pwr[rf_path] = pPhyInfo->RxPwr[rf_path];
 			psample_pkt_rssi->ofdm_snr[rf_path] = pPhyInfo->RxSNR[rf_path];
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 7d54cf211315..5de946e66302 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -120,8 +120,8 @@ struct rx_raw_rssi
 	u8 pwdball;
 	s8 pwr_all;
 
-	u8 mimo_singal_strength[4];/*  in 0~100 index */
-	u8 mimo_singal_quality[4];
+	u8 mimo_signal_strength[4];/*  in 0~100 index */
+	u8 mimo_signal_quality[4];
 
 	s8 ofdm_pwr[4];
 	u8 ofdm_snr[4];
-- 
2.20.1

