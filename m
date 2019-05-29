Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881D9C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBA024352
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172307;
	bh=48XGtTc0lTxanYsIUhRC88FUvVDLfp3UqQDfLE6hKn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D6rIh8OOeR6djFETU0vjdQ20ewz9aTETK8LCeQtg5q/N1FD+mRRj4c3ZgtoGa9t9B
	 W/kkLsBx/dHJIKY9/zu3VDjsT/mweWCLnKSTCJfvzFFytSwixynejv4tX4GFXCuzSd
	 8yhrLKOhVwLmtgNsqb4nt6iq/dlmTygLbfKz5ycU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfE2XZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:25:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfE2XYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WyA/RRUzEMCNSDUX0J/2kOmsPoE/y5/FaiFLeEY8Z7g=; b=aYTl3npF4LlQZKeDyPRwLg34H0
        G8e5U7nggFTMGsoNcVKt31YDcsS6nLfFNUrdrdpSkpvGsaz6xCYElTpoHg1tarxew76Tp7ud4N2eB
        oSgAWYBenTJRB6NzX82lQyjt9023+kI5ZmM/QiI6+/urjq4jOcow7Q7HGgqHrLv1nC4yU/dHFJqc9
        6N+WeUZCjTJSvWqYrFLivTgbE1EFwdh7pv/DroKFnjDiTwF80nRUBJAAuJHD5eqv2mj34IFoVjeWW
        UAaqwExS0j3bq9Pm3FRPwpRxPrf/WwMxfiBfOiJnTeyqaa+igxSrdRdrj1i8B8o55g8eKtDroR93Q
        6VlxSrow==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rv-I7; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vJ-0007y3-0E; Wed, 29 May 2019 20:23:57 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Subject: [PATCH 20/22] docs: net: dpio-driver.rst: fix two codeblock warnings
Date:   Wed, 29 May 2019 20:23:51 -0300
Message-Id: <204c59d60da045c82d7a1a9a318fc437dbcb44ed.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:43: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst:63: WARNING: Unexpected indentation. looking for now-outdated files... none found

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../networking/device_drivers/freescale/dpaa2/dpio-driver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst b/Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst
index 5045df990a4c..17dbee1ac53e 100644
--- a/Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst
+++ b/Documentation/networking/device_drivers/freescale/dpaa2/dpio-driver.rst
@@ -39,8 +39,7 @@ The Linux DPIO driver consists of 3 primary components--
 
    DPIO service-- provides APIs to other Linux drivers for services
 
-   QBman portal interface-- sends portal commands, gets responses
-::
+   QBman portal interface-- sends portal commands, gets responses::
 
           fsl-mc          other
            bus           drivers
@@ -60,6 +59,7 @@ The Linux DPIO driver consists of 3 primary components--
 
 The diagram below shows how the DPIO driver components fit with the other
 DPAA2 Linux driver components::
+
                                                    +------------+
                                                    | OS Network |
                                                    |   Stack    |
-- 
2.21.0

