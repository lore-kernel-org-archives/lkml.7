Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BFAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C768F212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="IkYFfVuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfGAI10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:27:26 -0400
Received: from mout.web.de ([212.227.17.11]:54145 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfGAI1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561969633;
        bh=02cuFpCQqZnFO1LrXaoGg36v+QDasiq3YaR4M1tOKAc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IkYFfVuSgHf3f5R1hNFLMQ6kymi8AWiBB5fVjTRnnGep52j9uoW6F+im+4bwWuXSf
         aV3y0Yd/Bhyh9BGRwLF5uRzQyYpoEwCRryZSAJdagvPMqcj3j2Xpu9gSOWmHPNoMQm
         7wUibUAaZ7Z50VtprH3r3q+8Dwn3SFZJgXJmupik=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from lab-pc08.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M6mL2-1iVAxR13Js-00wUE7; Mon, 01 Jul 2019 10:27:13 +0200
From:   =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>
To:     gregkh@linuxfoundation.org
Cc:     johnfwhitmore@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
        =?UTF-8?q?Christian=20M=C3=BCller?= <muellerch-privat@web.de>,
        Felix Trommer <felix.trommer@hotmail.de>
Subject: [PATCH v3 2/2] drivers/staging/rtl8192u: style nonstyled comments
Date:   Mon,  1 Jul 2019 10:27:07 +0200
Message-Id: <20190701082707.25198-2-muellerch-privat@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701082707.25198-1-muellerch-privat@web.de>
References: <20190627164530.GD9692@kroah.com>
 <20190701082707.25198-1-muellerch-privat@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GS8N31xETnh19spqSJeYpK/W89WSeY77iIz8Fp4ayC05f0uFVnI
 VF0KayJKwYigiceBsJYTA3tAlNkYl/BrhMSSCUP5E2algFAUoP0cLYso4jG+0EBYdXF2Ium
 8CWXI8yGSOW6ElrJzYN7nIwpOur5O0ZwpbdTAjS4xeGygHDnmOREchYz5lrw+dJlSwiv5CP
 yy5294GPbomEj1a5CQYrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VpR4Xls1mio=:NFJdhI9qDSl0bbH5/DjfE8
 hHbpKkQ5W3Av3nAmwgdPtRsWk9VZAnlyWsHJGG3zRc0DoTnQVIx27rtUP7Oyc0hKSLOah/6v+
 NeXJxXGraM80qbSkGE3N9JbwGR6T8F6QsB4oPbIzMs9192YGlIrvXs3I1cSM9yzD5fmESQpC6
 OVjS1B4j9cg7qiNofdElFRG72M4lsXrS/HvuuElz7/vTR1NHO9IFAlwH48mkcRjs4CtsTDgtF
 ACr8T40gyRhDkR/gpq+3k+xAmYckXKgrXr+ho4rLASnjXv4R/KmtF/a2BQMT6w/3h7Rl9tulo
 Sj4602y0OaGS0//vSfJ7oV/LaNwxVubaag5IdwyzYV/bmjFgtp9jh8GW645315IJrs3vrapqx
 Dqk5Qxp96KQlbLd7Pnnb1gkdbtKe54MBGIYyXfa/8BRT/56yjIuBxT5641vI5VcXDjSMAYgI6
 jI0IadKlIIZ5q4EtVmY3l2pjHGeWDlRvmSFxkA0z6U4OsFtwSHZNzWylX0Drvdqb6zpDtHMK3
 Rxo1jxdUGRt1OoVKNa7aJX4ME4qsyDnMonYS9y3XEzbvHDr7YD4D0w2KulxDtjgONfLSDaiJk
 +35Bkm1oxsZ0UXBz/9wovkeKYMp8qrAGEGJtwUf2qYnNsEETuDGnV4hppnf0O0uKJf30WHwL1
 vdn+b3xfQEVJIHfbj0SU6hOF53DdoZ4uHDvuOEEiQeqNufn0MRuPW/ebX6ovXtOvz5A9gwXMd
 2t48zk8AHXmmk+YJrEVruKY2XCFEUo30XuIFkLzVFQWabViT+3ZjHvcoP2k4OHLuu5HN9cys4
 xf+5gMYluxFQDaqhvdJCI+6Xge40P/afmFO/eaXipk2uxmp22jExE09OVJQ5HK54LTNPLpXmR
 kZKTKL4HLzpr4V8wijc6CQ+q21aEuKOZeboQQ1m2ga9vbNDCdBvc5CwBVw3D8CktWMMEMQ5zC
 OJTOOWWlmqoKLbwuyAB+0LhUbEVF9EvNxlej7nWwZAJNtpkblZIT1s8NYGhaeEmevxvJjXvf3
 Fg+Scbqb4gBiYmHygprNm+/uytexwi8HMNHeFwvRYsHqH8XY7hQgbbjyX0ai0QnJRFbKFBfSX
 HMSJiHf6Ec6VginDQg17uDr1Aa0/KEfHD8T
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coding-styles.rst states, that multiline comments should
allways contain a leading "*" in each line.
For multiline comments in general they

/*
 * should look
 * like this.
 */

For multiline comments in either net/ or drivers/net/ however,
they should

/* omit
 * the first
 * empty line.
 */

Since this file is part of a networking driver, the goal for it would
be to reside in drivers/net/ one day.

This patch changes comments, that were in neither form of the two listed
above, to have the style that is specified for drivers/net/.

Signed-off-by: Christian M=C3=BCller <muellerch-privat@web.de>
Signed-off-by: Felix Trommer <felix.trommer@hotmail.de>
=2D--
 v1 contains the initial patch.

 v2 contains the same patch, but with a different subject to better distin=
guish
    this patch from the other one in this patch series.

 v3 contains the same patch again, but this time with this changelog appen=
ded.

 drivers/staging/rtl8192u/r8192U_dm.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl819=
2u/r8192U_dm.c
index 86215fee8f0b..cb6c653e624d 100644
=2D-- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -332,9 +332,10 @@ static void dm_check_rate_adaptive(struct net_device =
*dev)
 				((bshort_gi_enabled) ? BIT(31) : 0);

 		/* 2007/10/08 MH We support RA smooth scheme now. When it is the first
-		   time to link with AP. We will not change upper/lower threshold. If
-		   STA stay in high or low level, we must change two different threshol=
d
-		   to prevent jumping frequently. */
+		 * time to link with AP. We will not change upper/lower threshold. If
+		 * STA stay in high or low level, we must change two different threshol=
d
+		 * to prevent jumping frequently.
+		 */
 		if (pra->ratr_state =3D=3D DM_RATR_STA_HIGH) {
 			HighRSSIThreshForRA	=3D pra->high2low_rssi_thresh_for_ra;
 			LowRSSIThreshForRA	=3D (priv->CurrentChannelBW !=3D HT_CHANNEL_WIDTH_2=
0) ?
@@ -1738,10 +1739,12 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_ala=
rm(
 	pHalData->UndecoratedSmoothedPWDB, DM_DigTable.RssiLowThresh,
 	DM_DigTable.RssiHighThresh, DM_DigTable.Dig_State);*/
 	/* 1. When RSSI decrease, We have to judge if it is smaller than a thres=
hold
-		  and then execute the step below. */
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb <=3D dm_digtable.rssi_low_thresh) {
 		/* 2008/02/05 MH When we execute silent reset, the DIG PHY parameters
-		   will be reset to init value. We must prevent the condition. */
+		 * will be reset to init value. We must prevent the condition.
+		 */
 		if (dm_digtable.dig_state =3D=3D DM_STA_DIG_OFF &&
 		    (priv->reset_count =3D=3D reset_cnt)) {
 			return;
@@ -1786,7 +1789,8 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm=
(
 	}

 	/* 2. When RSSI increase, We have to judge if it is larger than a thresh=
old
-		  and then execute the step below.  */
+	 * and then execute the step below.
+	 */
 	if (priv->undecorated_smoothed_pwdb >=3D dm_digtable.rssi_high_thresh) {
 		u8 reset_flag =3D 0;

@@ -2252,11 +2256,10 @@ static void dm_ctstoself(struct net_device *dev)
 		pHTInfo->IOTAction &=3D ~HT_IOT_ACT_FORCED_CTS2SELF;
 		return;
 	}
-	/*
-	1. Uplink
-	2. Linksys350/Linksys300N
-	3. <50 disable, >55 enable
-	*/
+	/* 1. Uplink
+	 * 2. Linksys350/Linksys300N
+	 * 3. <50 disable, >55 enable
+	 */

 	if (pHTInfo->IOTPeer =3D=3D HT_IOT_PEER_BROADCOM) {
 		curTxOkCnt =3D priv->stats.txbytesunicast - lastTxOkCnt;
@@ -2333,7 +2336,8 @@ void dm_rf_pathcheck_workitemcallback(struct work_st=
ruct *work)
 	u8 rfpath =3D 0, i;

 	/* 2008/01/30 MH After discussing with SD3 Jerry, 0xc04/0xd04 register w=
ill
-	   always be the same. We only read 0xc04 now. */
+	 * always be the same. We only read 0xc04 now.
+	 */
 	read_nic_byte(dev, 0xc04, &rfpath);

 	/* Check Bit 0-3, it means if RF A-D is enabled. */
=2D-
2.17.1

