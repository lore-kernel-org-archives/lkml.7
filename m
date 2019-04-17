Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75924C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459BE2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555494520;
	bh=erVUsYbWvvAZ3gACxacWM7ll7hadAA8eMjpzOpHz6jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WZxiid4WZS2xOGp5QIe8DQuoFzR4gxnaLTdG7vluDcX+lpsvRQx96Uaevn+l1PSaR
	 C0iWEGj25qFNXqgrDkHYtJZ8lDUY/sUK262RBy3+N0QXZbuGaaVVyzP3ji7c3Qcn44
	 ck3CFmnetf5Ea+KMd/wuvUm6WS9CbxMElTiT6AZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbfDQJsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:48:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfDQJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=et9eXCe5ZAfSQ5mBgtr6YkPzKHB/bcQ3N5gbJc1LICw=; b=M9loXKwhDUJ/5g04e+LM81GOD9
        YYxJW+x6ca9seyVxSqxCgC8BSpvs+QbKVfWL+x62WyiDk15zxbAs2W/doSzXbQd7N1syeMQ4mLYbh
        8f5q4vJMStHM9zLz/75Gk6ZXY+Vd/VuIicVeVYlUw8WJwyp4rJjqru8TBmcKiD25TVhfb2hlRP5ZD
        XhbzQTgqFstXKfSmt4WIfotdleKQ6EpIHW6OT8ykdV315u5dwriIcripKsl7KRwkTkRlbp8pPu+EB
        OQr7LsF0vNGzJrsY9NtovVf4aZvDsprsw8IF2dd21ocUmT3WGuoIlCkGoyUabf4wi9U/egU0CZ2CY
        O3Rx2Qcg==;
Received: from 177.132.233.55.dynamic.adsl.gvt.net.br ([177.132.233.55] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGh9G-0000a5-JA; Wed, 17 Apr 2019 09:46:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGh9C-0003uO-St; Wed, 17 Apr 2019 06:46:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 05/21] docs: hwmon: emc2103: convert to ReST format
Date:   Wed, 17 Apr 2019 06:46:13 -0300
Message-Id: <cc31c66f94243742893b670a7e3363c104551481.1555494108.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555494108.git.mchehab+samsung@kernel.org>
References: <cover.1555494108.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert emc2103 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/emc2103 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/emc2103 b/Documentation/hwmon/emc2103
index a12b2c127140..6a6ca6d1b34e 100644
--- a/Documentation/hwmon/emc2103
+++ b/Documentation/hwmon/emc2103
@@ -2,13 +2,17 @@ Kernel driver emc2103
 ======================
 
 Supported chips:
+
   * SMSC EMC2103
+
     Addresses scanned: I2C 0x2e
+
     Prefix: 'emc2103'
+
     Datasheet: Not public
 
 Authors:
-        Steve Glendinning <steve.glendinning@smsc.com>
+	Steve Glendinning <steve.glendinning@smsc.com>
 
 Description
 -----------
-- 
2.20.1

