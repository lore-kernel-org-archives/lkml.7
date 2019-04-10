Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD427C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0562075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924263;
	bh=5koruip/Ak43EWbkNK8Tc259xE2UnUvWruIb/ebxyko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opUJkFumYqpTrGve8i+FcK+/UfciPKF+2/48uLSTcUGH8HQXHzbYyfbwitwClkcC2
	 TGSvEn2QWVocmDfuIina9HVCUityhyveRIPUmc3+uxZj2XQ0LnrRIkCZKI7mKJ07xX
	 VrFNdC9MYELQ6N7A8xIr9KlVCwny9uLXCHABFvkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfDJTYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:24:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDJTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RmBdTZ6oZZ2ohazDbNmfaTnFHgD1lhGpRbyHozB19dY=; b=nOvrAq5S37WwJevtw+HTqm2/PA
        nOkxq9zrPgVHoWXLUOa0F4Roo8DZMYkkbU8W9L/W8TQq0duQW9Bz6D7U0G+g8WlQi2e8GX3K4271+
        W7ZSg12W0jSw+1SF7CLdcO6R9i5RKbZtp9Ogd1EVQrvI0Taf9EXeBUD+Tn+/hiXHcObPnrdc4L5XQ
        MHbGvrMl2wvw1tDQxVK8RpMKFMew1NqSlrLuT1N9YkpkfSPz3YUt6MnjyuG4MI6m+8wYZN0oe/QBL
        qRDEa0xetYFvgg/yYgNs7GcNX+96zsg1AeX8h2deinIciuvsaMZ8Yq9SX9a7tC4Xt8rVwdhiUbBff
        AB7JNCvg==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoQ-0003RG-OI; Wed, 10 Apr 2019 19:23:10 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoJ-0000z8-0K; Wed, 10 Apr 2019 16:23:03 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 11/21] docs: hwmon: ibmpowernv: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:48 -0300
Message-Id: <2f6f8109dfe2f212dfc1b9be7447c9b17a720bf8.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert ibmpowernv to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/ibmpowernv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 56468258711f..3f1feae3901c 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -2,6 +2,7 @@ Kernel Driver IBMPOWERNV
 ========================
 
 Supported systems:
+
   * Any recent IBM P servers based on POWERNV platform
 
 Author: Neelesh Gupta
@@ -29,6 +30,7 @@ CONFIG_SENSORS_IBMPOWERNV. It can also be built as module 'ibmpowernv'.
 Sysfs attributes
 ----------------
 
+======================= =======================================================
 fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
@@ -78,3 +80,4 @@ currX_enable		Enable/disable all current sensors belonging to the
 			0: Disable
 
 energyX_input		Cumulative energy (microJoule)
+======================= =======================================================
-- 
2.20.1

