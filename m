Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA676ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7221D79
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568184180;
	bh=5fDkxYy4jOJS/+QkDeYxCAE8Sxo/JVPofcF3L2N5Fic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UnD81iA2e7DHbsaaGenqy6lCyBwFRbhnrBKfHqg4kENzrZ6MzNYdlyR8oNji5LBGG
	 JxfYzhkfkDMTLhlw/b+oenbOwNoB12UlUu/OJTVFFv2gkbYOtodrSLuExcI4M9SqH3
	 RpLjXuxkHdGr/tYMY+TtU1E/ln76jzcwBB3tGPyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfIKGm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 02:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfIKGm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 02:42:59 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC7D21A4C;
        Wed, 11 Sep 2019 06:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568184179;
        bh=5fDkxYy4jOJS/+QkDeYxCAE8Sxo/JVPofcF3L2N5Fic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9IQJVh4gWWvNhP69nMQB9GqIa6147EQg+yKHp+8dtZOLWPT0SiiubwSFtWogeqKb
         WBEs+sFuXPJJjJZ36g1A4MkIszLObdh7dyzQ2eOGo5JR1AGBR69g4Vv5VuL/C+GNKX
         p3dFw6HxfOqh/ZGsP7fIeBC23ZkyR+j34Wmie6sw=
Date:   Wed, 11 Sep 2019 14:42:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>, Jana Build <jana.build@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx7ulp: remove mipi pll clock node
Message-ID: <20190911064246.GC17142@dragon>
References: <20190823003600.8317-1-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823003600.8317-1-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:37:30AM +0000, Fancy Fang wrote:
> According to the IMX7ULP reference manual, the mipi pll
> clock comes from the MIPI PHY PLL output. So it should
> not be defined as a fixed clock. So remove this clock
> node and all the references to it.
> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>

Applied, thanks.
