Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06A5C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED1F20818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894872;
	bh=vafN731gAsfL2AltzPZ7O7LqY3FUYKvNENGnnA0lnXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQKFBUQG42zuqkOOSFbhWM1qNwHJr6SDw1v7/IEsn3DAO852zLDw2f2ECiPw10tJx
	 c9M8B7dQ/aD9ZfTl45wB7mY8StgqH/MR2N6HbPFgULrltrOWqCzHOkiS7T1kmyGIRt
	 1CJKRep4oB0uWynMPLTVjPZ6lXR31oW64dLe7eRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfDJLOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:14:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731102AbfDJLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GAmzM2cQXLWEJG/VCTUREx7sgoG/8T2f7s+Ihg8HuYc=; b=f3CaF3S/gfxq47JrrdftjVQryg
        rHUwt5mvs91T7kBO0PJCa5t50YPpC1d8H8FIU8JT8MPF/ifN1I0eYY+ARihRu0+nUdpgmNtoTZ1PF
        wDZ5KFDgvA2JLrnZnjbMei3wNgYiolPNVyzGO3SG3TsWT4iXMax5pxchQqv7PmgAInFlJERlW5k3P
        Kz9EXss995H0uRpOQ5nIJPkVlfQB5zjFw/4TAxh401OHzMWQENznJkogGI7puOkiBzS2B+9Qk3orR
        wa6yn6D6RFjW3HP645g55reKhu8SknqPBprMh9btxwuAf0Yinm3fbFitHDSC9wMT2v5ED+/c8mzTl
        0WocNHeA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEB9L-0006mt-Ka; Wed, 10 Apr 2019 11:12:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEB9J-0007Sd-Ay; Wed, 10 Apr 2019 08:12:13 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH 05/21] docs: hwmon: emc2103: convert to ReST format
Date:   Wed, 10 Apr 2019 08:11:55 -0300
Message-Id: <b2b656a6d08c49aef83cd5aa06485596bbc93323.1554893882.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554893881.git.mchehab+samsung@kernel.org>
References: <cover.1554893881.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert emc2103 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org
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

