Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCCAC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EEC20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 11:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgABL4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 06:56:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40023 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgABL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 06:56:38 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1imz5Z-0002We-MF; Thu, 02 Jan 2020 12:56:29 +0100
Message-ID: <f3a5ccdc211b5d94b1901e72cfc2ef57d4107054.camel@pengutronix.de>
Subject: Re: [PATCH v7 1/2] dt-bindings: mediatek: mt8183: Add #reset-cells
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, yong.liang@mediatek.com,
        wim@linux-watchdog.org, linux@roeck-us.net, matthias.bgg@gmail.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        chang-an.chen@mediatek.com, freddy.hsin@mediatek.com
Cc:     yingjoe.chen@mediatek.com, sboyd@kernel.org
Date:   Thu, 02 Jan 2020 12:56:27 +0100
In-Reply-To: <1577437494-738-2-git-send-email-jiaxin.yu@mediatek.com>
References: <1577437494-738-1-git-send-email-jiaxin.yu@mediatek.com>
         <1577437494-738-2-git-send-email-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-27 at 17:04 +0800, Jiaxin Yu wrote:
> Add #reset-cells property and update example
> 
> Signed-off-by: yong.liang <yong.liang@mediatek.com>
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to be merged together with patch 2.

regards
Philipp

