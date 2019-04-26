Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CAAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E32520652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GqWDHh9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDZIkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:40:42 -0400
Received: from first.geanix.com ([116.203.34.67]:35998 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfDZIkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:40:41 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id E5E06308E73;
        Fri, 26 Apr 2019 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556267972; bh=Ngbcie60Cm8oQV1ShsGQ4elyXEYZvQSYZk262EQXbDg=;
        h=From:To:Cc:Subject:Date;
        b=GqWDHh9BETOd8EKc88xhTJ/3eIBxOFhEAWWy6bK1GWQjYe0Zk3vZboK9f+yJpwTWP
         EROPPzold9AAssj1gn7H4sDs8z2NxeIx2sPANQRqWctMcFuX4MeL7QTKdHEaqNXMzU
         qoY8R9LYcEcKDXLcvlGl9uQXKYHbUU0Se68P+b8wijr5CMPMSMqt8rD0+WKZaJo7eP
         7h2tE8jkso7ZKE5NIdLH74kb44k+FK2P5asgpdHe7DjZY8dbDROU+mi3P6tsQw5gis
         tHtkX/ywsZ9FkA7AMXNzXfn71wVREXW3p3OBBn7MfZ1Hg3ZO72w2e13fmCmjAXngw8
         Rre1F/Mxx9IdA==
From:   Esben Haabendal <esben@geanix.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] serial: 8250: Add support for 8250/16550 as MFD function
Date:   Fri, 26 Apr 2019 10:40:36 +0200
Message-Id: <20190426084038.6377-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a driver for adding 8250/16550 UART ports as functions to
MFD devices.

Esben Haabendal (2):
  serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
  serial: 8250: Add support for 8250/16550 as MFD function

 drivers/tty/serial/8250/8250_core.c |  36 ++++++-----
 drivers/tty/serial/8250/8250_mfd.c  | 119 ++++++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig     |  12 ++++
 drivers/tty/serial/8250/Makefile    |   1 +
 include/linux/serial_8250.h         |   2 +
 5 files changed, 155 insertions(+), 15 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mfd.c

-- 
2.4.11

