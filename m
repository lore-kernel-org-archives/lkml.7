Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2261C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD272075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554924269;
	bh=2P2lKBaVgGqc/VwpNm7lbYIQ/rYFvspi1tNuAHD9W2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yeGI4ST7q9NDz8ON/PDb6OT5bFBKTZi/WilzWFaZHcaplpx+jq5MWvygOqy7WGUwy
	 rxomDRdvxaVys7nE2jAlEXO6cqwvHpvgRzol/XUC/UIQUu9Pcq3nR6TmXHMZrSHfZB
	 DubxLAue41ryPNC5/PhRjXFtv1Aky3C3c2gxOPdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfDJTXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:23:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDJTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xCuR65PtwgJBAPxgpGGXq1ybGkxNyklHVSry7KBSYD4=; b=RdKIJdjdLTqxlOT7YsdHYAFw0+
        Gx2xKX2/2jHacxlXS1WOd1jxZrZxsxUXKoXT9LvU8j+4ksg8diN/U2gUafSFwh+mXp1ZnstIjaGxn
        uqLXq8E+PV9j7z9TLYgQn7vk0YPptI5LWtK7xuHnLledNhWEjAkAkfjfk5YWPG5IX36eP6EnVOvvw
        zQX8AtNSnOPPT8hC6R5vfNEzK2Kq1lDJ2NZ+p7EWGCfDUa3DTGB8+7s58sU7D683O22/E07SqEGR6
        wZVWQiqPafBleKXaM7nqRwLMakIcJZRR+1Eeoddn94Bah8VyHrr5B3iPDyq8M/HH73JeDRUHk+Hee
        455ZsjWA==;
Received: from 177.41.129.23.dynamic.adsl.gvt.net.br ([177.41.129.23] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEIoM-0003R5-II; Wed, 10 Apr 2019 19:23:06 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hEIoI-0000yg-QA; Wed, 10 Apr 2019 16:23:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 04/21] docs: hwmon: sch5627: convert to ReST format
Date:   Wed, 10 Apr 2019 16:22:41 -0300
Message-Id: <e3ed1b3a5fafa05f13aef7891f11373b1b2e1d77.1554923967.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554923967.git.mchehab+samsung@kernel.org>
References: <cover.1554923967.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert sch5627 to ReST format, in order to allow it to
be parsed by Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/hwmon/sch5627 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/hwmon/sch5627 b/Documentation/hwmon/sch5627
index 0551d266c51c..187682e99114 100644
--- a/Documentation/hwmon/sch5627
+++ b/Documentation/hwmon/sch5627
@@ -2,9 +2,13 @@ Kernel driver sch5627
 =====================
 
 Supported chips:
+
   * SMSC SCH5627
+
     Prefix: 'sch5627'
+
     Addresses scanned: none, address read from Super I/O config space
+
     Datasheet: Application Note available upon request
 
 Author: Hans de Goede <hdegoede@redhat.com>
-- 
2.20.1

