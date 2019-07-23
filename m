Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B8C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ABC223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfGWPcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:32:54 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.208]:43681 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfGWPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:32:54 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-west-2.aws.symcld.net id B9/6F-15262-3A8273D5; Tue, 23 Jul 2019 15:32:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsXi5LtOQHexhnm
  sQeMeJYuHV/0tVk3dyWKx6fE1VouuXyuZLS7vmsNm8Xf7JhaLF1vELdqOHWN14PDYOesuu8em
  VZ1sHneu7WHz2Lyk3mPjux1MHv1/DTw+b5ILYI9izcxLyq9IYM24cK6RpeAUb8WOPb9ZGxinc
  ncxcnEICaxmlPj7ZS5rFyMnkLOGUeLOVSO4xI/eGewgCTYBE4krM3YydzFycIgIyEuceOINEm
  YWeMIo0bfaHsQWFgiUuL3+Blg5i4CqxOFXV5lAbF4BT4nu2w1gcQkBOYmb5zqZIeKCEidnPmG
  BmCMhcfDFC2aIG9Qk2uZMAFslAbTqb2/ZBEa+WUg6ZiHpWMDItIrRIqkoMz2jJDcxM0fX0MBA
  19DQSNfQ2FzXyMRQL7FKN1mvtFi3PLW4RNdIL7G8WK+4Mjc5J0UvL7VkEyMw2FMKOj/uYGya9
  UbvEKMkB5OSKO+rT2axQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4u9TNY4UEi1LTUyvSMnOAkQ
  eTluDgURLh3aYGlOYtLkjMLc5Mh0idYlSUEuctAUkIgCQySvPg2mDRfolRVkqYl5GBgUGIpyC
  1KDezBFX+FaM4B6OSMC87yHaezLwSuOmvgBYzAS3eq2IGsrgkESEl1cDkWu9pl+T6/sTnbdc+
  LA1M/rvuIacX1x9D4S/5t89pB35qNnSyusD72MtkUuLFtle5grv/zAjKWPWoOjhnjTDTh0eSy
  5jNrhyM1/9WzRripGzSVdhv7K1tN3Wz1p0fui+07q+c1sfife1okGDz3OQXB/xWF+Yw7V/79E
  10Dd+RVO+sbnEr1+u73+q5/dX6r1EaY2ZeZqmi6Rp/PJthpaTMjZMOwV/uTNpw6VX7luv/PJN
  Zzy158fLPTik247B/RfMFln9kPWj2oiYt/9yl8pX+7f1+xRXaf9aVyHE379YTS3rlPW1x3orF
  T6/ddE6/5LR0Qfy+lX3Hr0t1JpWV/H7wLU3sRNVfU9+UzfWr57xWYinOSDTUYi4qTgQAQxHm9
  HEDAAA=
X-Env-Sender: Jose.DiazdeGrenu@digi.com
X-Msg-Ref: server-33.tower-365.messagelabs.com!1563895970!28760!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13652 invoked from network); 23 Jul 2019 15:32:51 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-33.tower-365.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 23 Jul 2019 15:32:51 -0000
Received: from MTK-SMS-XCH02.digi.com (10.10.8.196) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul 2019
 10:32:50 -0500
Received: from DOR-SMS-XCH01.digi.com (10.49.8.99) by MTK-SMS-XCH02.digi.com
 (10.10.8.196) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul
 2019 10:32:49 -0500
Received: from localhost.localdomain (10.101.2.92) by dor-sms-xch01.digi.com
 (10.49.8.99) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 23 Jul 2019
 17:32:47 +0200
From:   Jose Diaz de Grenu <Jose.DiazdeGrenu@digi.com>
To:     <Jose.DiazdeGrenu@digi.com>
CC:     <srinivas.kandagatla@linaro.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] nvmem: imx-ocotp: allow reads with arbitrary size and offset
Date:   Tue, 23 Jul 2019 17:32:41 +0200
Message-ID: <1563895963-19526-1-git-send-email-Jose.DiazdeGrenu@digi.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.101.2.92]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the imx-ocotp driver does only allow reading complete OTP words
correcty aligned.

Usually OTP memory is limited, so the fields are stored using as few bits as
possible. This means that a given value rarely uses 32 bits and happens to be
aligned.

Even though the NVMEM API offers a way to define offset and size of each cell
(at bit level) this is not currently usable iwth the imx-ocotp driver, which
forces consumers to read complete words and then hardcode the necessary
shifting and masking in the driver code. 

As an example take the nvmem consumer imx_thermal.c, which reads nvmem cells
as uint32_t words:

	ret = nvmem_cell_read_u32(&pdev->dev, "calib", &val);
	if (ret)
		return ret;

	ret = imx_init_calib(pdev, val);
	if (ret)
		return ret;

	ret = nvmem_cell_read_u32(&pdev->dev, "temp_grade", &val);
	if (ret)
		return ret;
	imx_init_temp_grade(pdev, val);
	
but needs to later adjust the values in code:

	// Inside imx_init_calib()
	data->c1 = (ocotp_ana1 >> 9) & 0x1ff;

	// Inside imx_init_temp_grade()
	switch ((ocotp_mem0 >> 6) & 0x3) {
	
This patch adjusts the driver so that reads can be requested using any size
and offset. Then, for example the nvmem cell "calib" could use the 'bits'
property to specify size and offset in bits, removing the need to mask and
shift in the driver code.

This is specially useful when several drivers use the same nvmem cell and when
the specific size and offset of a OTP value depends on a hardware version.

Jose Diaz de Grenu (2):
  nvmem: imx-ocotp: use constant for write restriction
  nvmem: imx-ocotp: allow reads with arbitrary size and offset

 drivers/nvmem/imx-ocotp.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

