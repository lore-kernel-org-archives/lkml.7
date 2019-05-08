Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5F3C004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E8F20C01
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b4FuaOqG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="b4FuaOqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEHAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:40:45 -0400
Received: from node.akkea.ca ([192.155.83.177]:43444 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfEHAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:40:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 8CA564E204E;
        Wed,  8 May 2019 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557276044; bh=ATtvWNypF9jkxTtLbyVCdjsZcpqcAr7BfsLqiE+XsH4=;
        h=From:To:Cc:Subject:Date;
        b=b4FuaOqGsMwMrPL1HEfOLKnamnnCax/1/yTUaiNZ9Xg6AY9QEDWz+ZHegYHOhhKs+
         /8i/g7Koo1+i/miE66BnOXsUwbTG/V2OiIXpCVUlugj+jvX/toIonI4eXSEngEtY+E
         pYYiNGyHAwQ9iXbhsNHBR2MbkSBH5y45ThGmcQ7s=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LGJys-91Z7q7; Wed,  8 May 2019 00:40:44 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 39A404E204B;
        Wed,  8 May 2019 00:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557276044; bh=ATtvWNypF9jkxTtLbyVCdjsZcpqcAr7BfsLqiE+XsH4=;
        h=From:To:Cc:Subject:Date;
        b=b4FuaOqGsMwMrPL1HEfOLKnamnnCax/1/yTUaiNZ9Xg6AY9QEDWz+ZHegYHOhhKs+
         /8i/g7Koo1+i/miE66BnOXsUwbTG/V2OiIXpCVUlugj+jvX/toIonI4eXSEngEtY+E
         pYYiNGyHAwQ9iXbhsNHBR2MbkSBH5y45ThGmcQ7s=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 0/1] usb: typec: tcpci: read the VBUS_VOLTAGE register
Date:   Tue,  7 May 2019 18:40:26 -0600
Message-Id: <20190508004027.16558-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have a setup that I can test this code right now.

I did test the tcpci_get_vbus_voltage and on my setup it is always 0.

I don't currently have setup that I can adjust the vbus voltage to
trigger the fault.

Angus Ainslie (Purism) (1):
  usb: typec: tcpci: add functions to read the VBUS voltage

 drivers/usb/typec/tcpm/tcpci.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.17.1

