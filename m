Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E223C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D3221926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="waFQTHr1";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="waFQTHr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfGXOwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:52:36 -0400
Received: from node.akkea.ca ([192.155.83.177]:58462 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:52:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 9FD424E2010;
        Wed, 24 Jul 2019 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979955; bh=+2e6JvgeBJMYL6tuzdR0QNS5B6RGy+3p+M0wb5aTC+8=;
        h=From:To:Cc:Subject:Date;
        b=waFQTHr1Yg8fj0ck5KBtd4B4akQsnqM2x9n84mzsuLcH0v2FN7IjE/JHFAvmUvNKn
         khj++FFvgxLJMfKELQkB4N9ypDMZ8jOZvZnXazaauhtlvjhFvS4lCsGUZa6r+cTzGY
         QTZuLQ7csi1bmHmINYI75ZAcKM16FL4hckGkPqFc=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pm5yXsXOHYYl; Wed, 24 Jul 2019 14:52:35 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id D8A874E2003;
        Wed, 24 Jul 2019 14:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979955; bh=+2e6JvgeBJMYL6tuzdR0QNS5B6RGy+3p+M0wb5aTC+8=;
        h=From:To:Cc:Subject:Date;
        b=waFQTHr1Yg8fj0ck5KBtd4B4akQsnqM2x9n84mzsuLcH0v2FN7IjE/JHFAvmUvNKn
         khj++FFvgxLJMfKELQkB4N9ypDMZ8jOZvZnXazaauhtlvjhFvS4lCsGUZa6r+cTzGY
         QTZuLQ7csi1bmHmINYI75ZAcKM16FL4hckGkPqFc=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/2] Add the BroadMobi BM818 card
Date:   Wed, 24 Jul 2019 07:52:25 -0700
Message-Id: <20190724145227.27169-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qmi_wwan and option support for the BroadMobi BM818

Bob Ham (2):
  usb: serial: option: Add the BroadMobi BM818 card
  net: usb: qmi_wwan: Add the BroadMobi BM818 card

 drivers/net/usb/qmi_wwan.c  | 1 +
 drivers/usb/serial/option.c | 2 ++
 2 files changed, 3 insertions(+)

-- 
2.17.1

