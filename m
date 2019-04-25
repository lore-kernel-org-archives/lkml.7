Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C76C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3A520578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfDYIll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:41:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52587 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725959AbfDYIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:41:40 -0400
X-UUID: a12f9e5bd22d48c79e9f85fedd4b6787-20190425
X-UUID: a12f9e5bd22d48c79e9f85fedd4b6787-20190425
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 830914029; Thu, 25 Apr 2019 16:41:36 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 25 Apr 2019 16:41:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 25 Apr 2019 16:41:33 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jiri Slaby <jslaby@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Long Cheng <long.cheng@mediatek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Shih <pihsun@chromium.org>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Changqi Hu <changqi.hu@mediatek.com>
Subject: [PATCH 0/2] Perfect 8250 mtk uart function. 
Date:   Thu, 25 Apr 2019 16:41:29 +0800
Message-ID: <1556181691-10293-1-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 63F3EB361E0CC5D98E81A5E6A9DEBFA1D0C0011D96D48A198B0BE0DF6175839B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perfect 8250 mtk uart function,
1.Modify baudrate setting
2.Add follow control function

Long Cheng (2):
  serial: 8250-mtk: add follow control
  serial: 8250-mtk: modify baudrate setting

 drivers/tty/serial/8250/8250_mtk.c | 162 +++++++++++++++++++++++++++++++------
 1 file changed, 139 insertions(+), 23 deletions(-)

-- 
1.9.1

