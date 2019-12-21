Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E99C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 05:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C915C21775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 05:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfLUF3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 00:29:21 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUF3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 00:29:20 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 80A41153D31DC;
        Fri, 20 Dec 2019 21:29:19 -0800 (PST)
Date:   Fri, 20 Dec 2019 21:29:18 -0800 (PST)
Message-Id: <20191220.212918.1661751615125167321.davem@davemloft.net>
To:     p.rajanbabu@samsung.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        Jose.Abreu@synopsys.com, stable@vger.kernel.org,
        jayati.sahu@samsung.com, pankaj.dubey@samsung.com,
        rcsekar@samsung.com, sriram.dash@samsung.com
Subject: Re: [PATCH] net: stmmac: platform: Fix MDIO init for platforms
 without PHY
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576750621-78066-1-git-send-email-p.rajanbabu@samsung.com>
References: <CGME20191219102407epcas5p103b26e6fb191f7135d870a3449115c89@epcas5p1.samsung.com>
        <1576750621-78066-1-git-send-email-p.rajanbabu@samsung.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 20 Dec 2019 21:29:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Date: Thu, 19 Dec 2019 15:47:01 +0530

> The current implementation of "stmmac_dt_phy" function initializes
> the MDIO platform bus data, even in the absence of PHY. This fix
> will skip MDIO initialization if there is no PHY present.
> 
> Fixes: 7437127 ("net: stmmac: Convert to phylink and remove phylib logic")
> Acked-by: Jayati Sahu <jayati.sahu@samsung.com>
> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>

Applied and queued up for -stable, thanks.
