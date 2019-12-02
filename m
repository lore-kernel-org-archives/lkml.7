Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05327C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81B12073C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 15:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="YEu6o5Iw";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="YEu6o5Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfLBPel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 10:34:41 -0500
Received: from node.akkea.ca ([192.155.83.177]:57858 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfLBPel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 10:34:41 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 10:34:40 EST
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5E0E94E2010;
        Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=SRlLW1ZF40agOMpOXjZbip0TWQHQvK7ikhKiQ8zf5fI=;
        h=From:To:Cc:Subject:Date;
        b=YEu6o5IwAZWA6sJuSU/ES9a9wn22E4Bq5gW8IrGSp34c6AUwu/6BHKMY5voAS15jZ
         iE7IcHlIOSAHkiRxkr9BLgLeLGkIP4RUAMzdxhC5BcrpI3dKvXqLC1z2+UoZfa+ABt
         WkfuuJYc8hMgMr0brddBVooHmIIsFJlyzJ3uxuw8=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e-8yhoq18yFP; Mon,  2 Dec 2019 15:25:29 +0000 (UTC)
Received: from thinkpad-tablet.cg.shawcable.net (S0106905851b613e9.cg.shawcable.net [70.77.244.40])
        by node.akkea.ca (Postfix) with ESMTPSA id 727FE4E2003;
        Mon,  2 Dec 2019 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1575300329; bh=SRlLW1ZF40agOMpOXjZbip0TWQHQvK7ikhKiQ8zf5fI=;
        h=From:To:Cc:Subject:Date;
        b=YEu6o5IwAZWA6sJuSU/ES9a9wn22E4Bq5gW8IrGSp34c6AUwu/6BHKMY5voAS15jZ
         iE7IcHlIOSAHkiRxkr9BLgLeLGkIP4RUAMzdxhC5BcrpI3dKvXqLC1z2+UoZfa+ABt
         WkfuuJYc8hMgMr0brddBVooHmIIsFJlyzJ3uxuw8=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/2] Add MAX17055 fuel guage
Date:   Mon,  2 Dec 2019 08:25:18 -0700
Message-Id: <20191202152520.27558-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the max17042_battery driver to include the MAX17055.

Angus Ainslie (Purism) (2):
  power: supply: max17042: add MAX17055 support
  dts: bindings: max17042_battery: add all of the compatible strings

 .../power/supply/max17042_battery.txt         |  6 ++-
 drivers/power/supply/max17042_battery.c       | 15 ++++--
 include/linux/power/max17042_battery.h        | 48 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.17.1

