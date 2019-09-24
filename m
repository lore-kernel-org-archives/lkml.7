Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA16C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBE0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569326650;
	bh=Bi158SFtp+WLqXdnHUUCjzspp2068u5mA9BIfppnvEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4NdeyJyfeuKW3pnl3H9dfUjxe74mVkstEAxoYmhj3UTsucU822jPXIJk8dSBwdwH
	 skqUyeFD7XbJwdmR5w7GYrOjvklfr2WNcP3Bp9CzW/swIWVIssbxxG3TJAphLNvMtl
	 tz9VPKmCeSjFp7J9vUvLY772HNIvczD/HBktH9pU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfIXMEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:04:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfIXMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vfv7lYGujNr5uIH96XHMW+speXHOn/ZhV2QhILuvvL4=; b=WqWNV2OPbJkX162VFcnXZoxXuJ
        4fQboUoApvGr8FEB/i9cVsSe8aPfZ6sJUfxINZTHg9ui9Lpg9EmKmpc0XtBeX9SDdb7g7g3Lfqisc
        t3AQHmoTNEjkctbWmy7bKvAcs1jLQwBvIAheeSnEx+CHKUbFKPCW5lwJLH7HA2Avw2C13i5squc7b
        rsYRR2AosLwIarw2DlfouXh5cdH/QGakfBS0gQbmTZRwiGA1hr+s8c6eH3tWy8kEcwNUmgR2GSnt9
        OwDyrIebS0SjMVv9a8Tss3UZ1lzrY1mLpRSmhS9abkeNLA9urznvgM6EsgmUTbtI7sYqS7lV1yPg9
        kxxppJlA==;
Received: from 177.96.206.173.dynamic.adsl.gvt.net.br ([177.96.206.173] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCjY2-0005Nf-Fs; Tue, 24 Sep 2019 12:04:03 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.2)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1iCjY0-0000z3-2d; Tue, 24 Sep 2019 09:04:00 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2] media: v4l2-fwnode: fix location of acpi/dsd documentation
Date:   Tue, 24 Sep 2019 09:03:56 -0300
Message-Id: <1da96f12303328833d4f4064bc127337770bc4a7.1569326471.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924105038.GH9467@paasikivi.fi.intel.com>
References: <20190924105038.GH9467@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This got moved to the firmware-guide.

Fixes: f2dde1ed0f28 ("Documentation: ACPI: move dsd/graph.txt to firmware-guide/acpi and convert to reST")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---

v2: 

- Also replace *.txt -> *.rst. I opted to place the full file names there, as this allows
  ./scripts/documentation-file-ref-check to check if those files gets renamed. It
  also helps if some Sphinx would later convert those to hyperlinks (with was
  already discussed at linux-doc ML, although not implemented yet).

 drivers/media/v4l2-core/v4l2-fwnode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 3bd1888787eb..9387dcba8b59 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -819,8 +819,10 @@ static int v4l2_fwnode_reference_parse(struct device *dev,
  *
  * THIS EXAMPLE EXISTS MERELY TO DOCUMENT THIS FUNCTION. DO NOT USE IT AS A
  * REFERENCE IN HOW ACPI TABLES SHOULD BE WRITTEN!! See documentation under
- * Documentation/acpi/dsd instead and especially graph.txt,
- * data-node-references.txt and leds.txt .
+ * Documentation/firmware-guide/acpi/dsd instead and especially
+ * Documentation/firmware-guide/acpi/dsd/graph.rst,
+ * Documentation/firmware-guide/acpi/dsd/data-node-references.rst and
+ * Documentation/firmware-guide/acpi/dsd/leds.rst.
  *
  *	Scope (\_SB.PCI0.I2C2)
  *	{
-- 
2.21.0


