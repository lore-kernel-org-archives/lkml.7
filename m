Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1289EC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB15621925
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787888;
	bh=AzxsXXZ+4rwsMsucUf565KiJ1jMGaniIf3q1kRZYdb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hHmu5ra6rgFP41JsRR1ucWarRu4E+4iXm5lsiajzxBaz/8mw8j/8x0Xk9OZsRHnw
	 nl+UhlrTJtkrhICuuzmp/+AU9cd5P/UgQMrXg8ZPYSHIMJKvbSKLzTD0uY27f5eY3A
	 Sm25/p5m9egQr2eoof502mNeZbIGLyfxsVvKiNnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfIRGYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfIRGYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:24:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C71A218AF;
        Wed, 18 Sep 2019 06:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787882;
        bh=AzxsXXZ+4rwsMsucUf565KiJ1jMGaniIf3q1kRZYdb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pXxcoZjLy/0+KPN7RTe3LG6KRr2XOhclUU4ZJbusirh2Tfe0tdWT2L/gGlRMGa806
         wHRidZYek4V4G8at9bHhr3w5M26wiDWozsP4PQEBWxDOTC3K/DcT6F3mHpcdyFzVzL
         HnlxTiJPKcu3AFaZ/m0hq/nhyw8liMhdhebp7DuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 19/85] net: fixed_phy: Add forward declaration for struct gpio_desc;
Date:   Wed, 18 Sep 2019 08:18:37 +0200
Message-Id: <20190918061234.756865751@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061234.107708857@linuxfoundation.org>
References: <20190918061234.107708857@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>

[ Upstream commit ebe26aca98fcf9fbe5017b5cbe216413cee69df5 ]

Add forward declaration for struct gpio_desc in order to address
the following:

./include/linux/phy_fixed.h:48:17: error: 'struct gpio_desc' declared inside parameter list [-Werror]
./include/linux/phy_fixed.h:48:17: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]

Fixes: 71bd106d2567 ("net: fixed-phy: Add fixed_phy_register_with_gpiod() API")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/phy_fixed.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -11,6 +11,7 @@ struct fixed_phy_status {
 };
 
 struct device_node;
+struct gpio_desc;
 
 #if IS_ENABLED(CONFIG_FIXED_PHY)
 extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);


