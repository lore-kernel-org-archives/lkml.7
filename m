Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8981C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D3A206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 00:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfHXA0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 20:26:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44089 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHXA0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 20:26:40 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1Jt4-0004mc-Tb; Sat, 24 Aug 2019 02:26:34 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i1Jt4-0000Br-38; Sat, 24 Aug 2019 02:26:34 +0200
Date:   Sat, 24 Aug 2019 02:26:34 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] pwm: mxs: use devm_platform_ioremap_resource() to
 simplify code
Message-ID: <20190824002634.nfrhof3kpsrcc742@pengutronix.de>
References: <20190718013205.24919-1-Anson.Huang@nxp.com>
 <AM0PR04MB42116F0753C9C6A619A2D8EC80C80@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB3PR0402MB3916423A6E334EDD4C06B884F5AB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 20, 2019 at 05:56:40AM +0000, Anson Huang wrote:
> Gentle ping...

My impression[1] is that Thierry collects patches in bulk once or twice
per release cycle. The last two such bulks were between 5.2-rc6 and
5.2-rc7 and in the 5.2 merge window. So given we're at v5.3-rc5 now I
expect some action soon :-)

> > > From: Anson.Huang@nxp.com <Anson.Huang@nxp.com>
> > > Sent: Thursday, July 18, 2019 9:32 AM
> > >
> > > Use the new helper devm_platform_ioremap_resource() which wraps the
> > > platform_get_resource() and devm_ioremap_resource() together, to
> > > simplify the code.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

[1] from git log --committer=Thierry --format=%ci drivers/pwm | cut -d\  -f1 | uniq -c
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
