Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E173C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214EF214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbfGWPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:32:58 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:33161 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfGWPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:32:56 -0400
Received: from [67.219.250.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id AA/43-10746-6A8273D5; Tue, 23 Jul 2019 15:32:54 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsXi5LtOQHeZhnm
  swbYprBYPr/pbrJq6k8Vi0+NrrBZdv1YyW1zeNYfN4u/2TSwWL7aIW7QdO8bqwOGxc9Zddo9N
  qzrZPO5c28PmsXlJvcfGdzuYPPr/Gnh83iQXwB7FmpmXlF+RwJrRvn4KW8F0noqe3RfYGhhbu
  boYuTiEBFYzSqy8upUNwlnDKLF4yQlWuMz6b1sYuxg5OdgETCSuzNjJ3MXIwSEiIC9x4ok3SJ
  hZ4AmjRN9qexBbWMBTYs6eL+wgNouAqsSPV4vBWnmB4m/3zWADsSUE5CRunusEG8Mp4CWx4Vw
  JSFgIqOTGx5NsEOWCEidnPmGBGC8hcfDFC2aIGjWJtjkTwFolgC7421s2gVFgFpKOWUg6FjAy
  rWK0SCrKTM8oyU3MzNE1NDDQNTQ00jU0BtJGBnqJVbqJeqXFuuWpxSW6RnqJ5cV6xZW5yTkpe
  nmpJZsYgdGRUtBUsYPx6JHXeocYJTmYlER5X30yixXiS8pPqcxILM6ILyrNSS0+xCjDwaEkwX
  tV2jxWSLAoNT21Ii0zBxipMGkJDh4lEV4rkDRvcUFibnFmOkTqFKOilDjvW5CEAEgiozQPrg2
  WHC4xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuZ1BpnCk5lXAjf9FdBiJqDFe1XMQBaXJCKk
  pBqYGg2W+ba0/7z+r+zd1fUCpR227C/CxC9+klofXBS+9eWUTt6N7ws3flr7y3B157PEBVZZr
  qXsEcEP37zd3CFuzby8XYTl2b9vU/8fjppvFsZwPrn67yyvb2zLPnrtVXkV1Ov5Zk5nhFpePV
  PKnUkHNqwV3/TbgPPrPLMggQsuv5JNVfxlEpuWP2vo9twYsE5Sbkfhse+6V+etSBWrnqVzucm
  8fd3XQx9txX8y9t09Gf61YMutuy5xlVuX3U31vSjHevXm5zCmrUs22DHvOrRfMzBsnf/U4x94
  xSwyZp7werG0010pu5bLY7bZ4zLxp5K7Ko6kOIRdWnmMbQbbVsM3waoZgc/bBFs2TP++advW6
  UosxRmJhlrMRcWJAAwv9FmJAwAA
X-Env-Sender: Jose.DiazdeGrenu@digi.com
X-Msg-Ref: server-32.tower-325.messagelabs.com!1563895972!30385!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1081 invoked from network); 23 Jul 2019 15:32:53 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-32.tower-325.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 23 Jul 2019 15:32:53 -0000
Received: from MTK-SMS-XCH03.digi.com (10.10.8.197) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul 2019
 10:32:52 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH03.digi.com
 (10.10.8.197) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul
 2019 10:32:52 -0500
Received: from localhost.localdomain (10.101.2.92) by dor-sms-xch01.digi.com
 (10.49.8.99) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul 2019
 17:32:50 +0200
From:   Jose Diaz de Grenu <Jose.DiazdeGrenu@digi.com>
To:     <Jose.DiazdeGrenu@digi.com>
CC:     <srinivas.kandagatla@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] nvmem: imx-ocotp: use constant for write restriction
Date:   Tue, 23 Jul 2019 17:32:42 +0200
Message-ID: <1563895963-19526-2-git-send-email-Jose.DiazdeGrenu@digi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
References: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.92]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a new constant instead of reusing config->word_size, which applies
both to read and writes. This allows to change config->word_size without
affecting to the write size restriction.

Signed-off-by: Jose Diaz de Grenu <Jose.DiazdeGrenu@digi.com>
---
 drivers/nvmem/imx-ocotp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 42d4451e7d67..dc86d863563a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -29,6 +29,7 @@
 #define IMX_OCOTP_OFFSET_PER_WORD	0x10  /* Offset between the start addr
 					       * of two consecutive OTP words.
 					       */
+#define IMX_OTP_WORD_SIZE		4
 
 #define IMX_OCOTP_ADDR_CTRL		0x0000
 #define IMX_OCOTP_ADDR_CTRL_SET		0x0004
@@ -252,8 +253,8 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 	u8 word = 0;
 
 	/* allow only writing one complete OTP word at a time */
-	if ((bytes != priv->config->word_size) ||
-	    (offset % priv->config->word_size))
+	if ((bytes != IMX_OTP_WORD_SIZE) ||
+	    (offset % IMX_OTP_WORD_SIZE))
 		return -EINVAL;
 
 	mutex_lock(&ocotp_mutex);
@@ -293,7 +294,7 @@ static int imx_ocotp_write(void *context, unsigned int offset, void *val,
 		 * see i.MX 7Solo Applications Processor Reference Manual, Rev.
 		 * 0.1 section 6.4.3.1
 		 */
-		offset = offset / priv->config->word_size;
+		offset = offset / IMX_OTP_WORD_SIZE;
 		waddr = offset / priv->params->bank_address_words;
 		word  = offset & (priv->params->bank_address_words - 1);
 	} else {
