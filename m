Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1D720880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDIMJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:09:19 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37393 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDIMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:09:19 -0400
X-Originating-IP: 109.213.33.177
Received: from localhost (alyon-652-1-42-177.w109-213.abo.wanadoo.fr [109.213.33.177])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 313861BF214;
        Tue,  9 Apr 2019 12:09:12 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] usb: gadget: udc: lpc32xx: add stotg04 phy support
Date:   Tue,  9 Apr 2019 14:09:03 +0200
Message-Id: <20190409120908.12079-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series starts to clean up the lpc32xx udc driver and also repairs
interrupt handling so hotplugging actually works. The design I tested
that on uses an stotg04 instead of the usual isp1301 so support for that
is also added.

A bit more work is needed to get the RNDIS gadget driver to work.

Alexandre Belloni (5):
  usb: gadget: udc: lpc32xx: simplify probe
  usb: gadget: udc: lpc32xx: simplify vbus handling
  usb: gadget: udc: lpc32xx: properly setup phy interrupts
  usb: gadget: udc: lpc32xx: add support for stotg04 phy
  usb: gadget: udc: lpc32xx: rework interrupt handling

 drivers/usb/gadget/udc/lpc32xx_udc.c | 167 +++++++++++----------------
 1 file changed, 66 insertions(+), 101 deletions(-)

-- 
2.20.1

