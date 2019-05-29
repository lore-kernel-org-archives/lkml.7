Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD4C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32F724328
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559172253;
	bh=RauTk6zDcnEzAN5gFXGQBD1Cu4Rkvpe7xvJa/l3w5pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHK+XMF8/SWa/oeFqytIIb1TY5Hb3ob46shURB91fhXiPgyRypX7rLk6Q8OAAkfNL
	 7KrDT+/deQylWcMW41GH8jjhjWs3QbdaXX5Le0X20BwHdUNNny43wMtKDnlXRP2MlH
	 AJoGtJ0HYgloLF+4KXCafAWmVtvjClrKrIE8gHRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfE2XYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:24:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfE2XYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BkcoBEULBcLylfJQMb1h3qgxJnYCmoC/K1f+BmwyR9I=; b=r5i5VQ2cBMCv2EpcPr3ofx6HpS
        irJQbeS1vjKNMguKpEIJQQLvLu9RqSxXiDl6mgMN26pJnXpvlwNAUfcLSnEP8ldsDBd5C1T80uP4U
        yOfJzr1iIX3FneURlgBQunwcTr+kqrilagWsEBpwfbsHPlYPQ2JFAk8zqFuDGXpVpJTD8LTCqXs4m
        fi5MaEM0Q/g2RSfQW4eUKPYP/eIAOjYHYYRwzC2DZFcuT53LI5rORE79gj/B/XPmhOYUR4J1uLtJo
        o9NfLbaFCQfUb0KIqRnL2/fDO/hdIssAFpzvbdxjAW+5XXPsYVRsSAV9gUZJrpHdzAJqbQ0aHjqDR
        PhXzsWFg==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7vL-0005Rj-9C; Wed, 29 May 2019 23:23:59 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7vI-0007x2-K4; Wed, 29 May 2019 20:23:56 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Otto Sabart <ottosabart@seberm.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 05/22] mfd: madera: Fix bad reference to pinctrl.txt file
Date:   Wed, 29 May 2019 20:23:36 -0300
Message-Id: <36c1c04d050fa3f4f56efd306e59f5eeeccf4015.1559171394.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559171394.git.mchehab+samsung@kernel.org>
References: <cover.1559171394.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Otto Sabart <ottosabart@seberm.com>

The pinctrl.txt file was converted into reStructuredText and moved into
driver-api folder. This patch updates the broken reference.

Fixes: 5a9b73832e9e ("pinctrl.txt: move it to the driver-api book")
Signed-off-by: Otto Sabart <ottosabart@seberm.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 include/linux/mfd/madera/pdata.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index 8dc852402dbb..dd00ab824e5b 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -34,7 +34,8 @@ struct madera_codec_pdata;
  * @micvdd:	    Substruct of pdata for the MICVDD regulator
  * @irq_flags:	    Mode for primary IRQ (defaults to active low)
  * @gpio_base:	    Base GPIO number
- * @gpio_configs:   Array of GPIO configurations (See Documentation/pinctrl.txt)
+ * @gpio_configs:   Array of GPIO configurations (See
+ *		    Documentation/driver-api/pinctl.rst)
  * @n_gpio_configs: Number of entries in gpio_configs
  * @gpsw:	    General purpose switch mode setting. Depends on the external
  *		    hardware connected to the switch. (See the SW1_MODE field
-- 
2.21.0

