Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFC9C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409A26D36
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 22:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfFCWAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:00:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35948 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFCWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 18:00:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A6E78133E98DA;
        Mon,  3 Jun 2019 15:00:18 -0700 (PDT)
Date:   Mon, 03 Jun 2019 15:00:18 -0700 (PDT)
Message-Id: <20190603.150018.656008041790620010.davem@davemloft.net>
To:     sean.wang@mediatek.com
Cc:     john@phrozen.org, nbd@openwrt.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v1 0/6] Add MT7629 ethernet support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559347395-14058-1-git-send-email-sean.wang@mediatek.com>
References: <1559347395-14058-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Jun 2019 15:00:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <sean.wang@mediatek.com>
Date: Sat, 1 Jun 2019 08:03:09 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT7629 inlcudes two sets of SGMIIs used for external switch or PHY, and embedded
> switch (ESW) via GDM1, GePHY via GMAC2, so add several patches in the series to
> make the code base common with the old SoCs.
> 
> The patch 1, 3 and 6, adds extension for SGMII to have the hardware configured
> for 1G, 2.5G and AN to fit the capability of the target PHY. In patch 6 could be
> an example showing how to use these configurations for underlying PHY speed to
> match up the link speed of the target PHY.
> 
> The patch 4 is used for automatically configured the hardware path from GMACx to
> the target PHY by the description in deviceetree topology to determine the
> proper value for the corresponding MUX.
> 
> The patch 2 and 5 is for the update for MT7629 including dt-binding document and
> its driver.

Series applied.
