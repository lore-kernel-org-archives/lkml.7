Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A95C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078A3206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 23:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IN3ylqNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLPXIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:08:09 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:44234 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726487AbfLPXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 18:08:09 -0500
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 456FF30C352;
        Mon, 16 Dec 2019 15:03:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 456FF30C352
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1576537400;
        bh=DjLnM+MErrP1BNFwRNMg+raNJmSUHkPT8G5uPAXYc5w=;
        h=From:To:Cc:Subject:Date:From;
        b=IN3ylqNIf57uqiiBHcDOZlRzvZk6oYxJ7Bv9zteS6nfV944RYebTI4lDu7zDrLV93
         7GmhqFBKScSj4+cSVlc0HjrgbuDgK843kzkD7SfihnhAxUaAN/msqtLkBdKL0IXc7v
         +t3YW4iHT0lnWkVUpuQRUn3ZA7fneR8HpRADU5lI=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 84466140069;
        Mon, 16 Dec 2019 15:08:06 -0800 (PST)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH v2 0/1] spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER
Date:   Mon, 16 Dec 2019 18:08:01 -0500
Message-Id: <20191216230802.45715-1-jquinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- use dev_dbg() for -EPROBE_DEFER, dev_err() for other errors.

Jim Quinlan (1):
  spi: bcm2835: no dev_err() on clk_get() -EPROBE_DEFER

 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

