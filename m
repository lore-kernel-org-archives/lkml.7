Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D17C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A421880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564169375;
	bh=KFOZssiYH5r++KiSWweD0Gz2GtaeqF7rPsazVa48kyE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=crFlvlUjOfL65htKhF/7RQbW6QiD2dfCxX/gzJA1p7nzx5cxJi9VSNTdT6+R9vgyx
	 ILj0WUlh49L69uFZjmSS2JBGH6Ft1t7a826+kMtLT/G8vM22BSl89S1okalfZLMk7P
	 jJGmf15c2sOdVkMkp3G2Ey5JuLG9yhGzeetKXC5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGZT3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:29:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfGZT3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oaP33TUD0GPNPC3aziO7sbnb5RBnJ34Mg4kqpJwklQA=; b=Tz2O93fXP7Gl0lBjDsAO3/uUk
        IbG/Lm/dnbvEOdcJexAA04Xu/KLHMZAC+FYa4YXHGTTVkreccAV8m+eN9lzcE7ojiULAx63ljqU1q
        lCFJTxFVQHLT08mGbAqHcn8H+ar3W7mWUJhj5bXmYLtDdX1SWn4DfIPNzNvUoPR/B4EhXKVP6dlVz
        o3RrX0oqtEOzvtYmMEznl47f5ZCUFu7vSCQZ1lP5RZpsNfWbL8CC2PXtJMXNoTggSQNirpd378R6b
        t0m9iomuPpUYvWgq1SDWeKDYmS8d0cbT/nREPZBTSQm93C5mVTw95wExZyJ25EN7sxQOiTaEwLeT2
        T8pi7BLGQ==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hr5u2-00046u-6u; Fri, 26 Jul 2019 19:29:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hr5tz-0004yb-J3; Fri, 26 Jul 2019 16:29:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/5] MAINTAINERS: fix broken ref for ABI sysfs-bus-counter-ftm-quaddec
Date:   Fri, 26 Jul 2019 16:29:10 -0300
Message-Id: <5c44856436bbaeb4f2d4b750365b82de973ad054.1564169297.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a typo here:

	sysfs-bus-counter-ftm-quadddec -> sysfs-bus-counter-ftm-quaddec

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b59bdc1aaf2..506ac266cf57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6317,7 +6317,7 @@ FLEXTIMER FTM-QUADDEC DRIVER
 M:	Patrick Havelange <patrick.havelange@essensium.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quadddec
+F:	Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
 F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 F:	drivers/counter/ftm-quaddec.c
 
-- 
2.21.0

