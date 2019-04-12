Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C29C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CC320818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="nUgw8Xfd";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="DN1Z/FtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDLNEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:04:38 -0400
Received: from node.akkea.ca ([192.155.83.177]:40760 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:04:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 2A9F24E204E;
        Fri, 12 Apr 2019 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555074277; bh=zGfXHziq97TcaeLejxiR3m6pxZuIKuRyT/AHaS38stw=;
        h=From:To:Cc:Subject:Date;
        b=nUgw8XfdKwdI/+brs+tQX9y6QRFfqpiqyIOqoYNUm2qL40oNziJBgrSUG67t3M01i
         MUVJx0IEoEOXzKJVibHx593j4+TXtTn6qpOa9d/pGT962ajAFfLSy9Ql6iGxaXysaK
         OYi/voLXTXzvusrcZh9jrbE1+jyiEC5BsDI2/P9A=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4-cOoHnXjdrh; Fri, 12 Apr 2019 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id E8A554E204B;
        Fri, 12 Apr 2019 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555074276; bh=zGfXHziq97TcaeLejxiR3m6pxZuIKuRyT/AHaS38stw=;
        h=From:To:Cc:Subject:Date;
        b=DN1Z/FtPDKmajOo9vS7+V5cI3n4ynV378hKLyhMLkPDoopfs4b+W9cK4rBBZKRr3L
         v56saT7kK+MC6ibHB10cXJ6OX5+e460nLN7SCTORZeQDFOFUafbPjqbTV+pd2Zvgq6
         yvEDO7icDxFNV7ojnuU51TICNvsnd+di1XSr6ewM=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for the Purism Librem5 devkit
Date:   Fri, 12 Apr 2019 07:04:25 -0600
Message-Id: <20190412130427.13418-1-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Librem5 devkit is based on the imx8mq from NXP. This is a default
devicetree to boot the board to a command prompt.

Changes since v1:
Dropped config file.
Updated the board compatible label.
Changed node names to follow naming conventions.
Added a more complete regulator hierachy.
Removed unused nodes.
Removed unknown devices.
Fixed comment style.
Dropped undocumented properties.

Angus Ainslie (Purism) (2):
  arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
  dt-bindings: Add an entry for Purism SPC

 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 850 ++++++++++++++++++
 3 files changed, 852 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

-- 
2.17.1

