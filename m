Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E0CC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7652420863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 15:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDFPsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 11:48:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32843 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfDFPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 11:48:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hCnYm-00058y-K1; Sat, 06 Apr 2019 17:48:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hCnYl-0005GM-57; Sat, 06 Apr 2019 17:48:47 +0200
Date:   Sat, 6 Apr 2019 17:48:47 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     laurentiu.tudor@nxp.com, mojha@codeaurora.org,
        linux-i2c@vger.kernel.org, wsa+renesas@sang-engineering.com,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        leoyang.li@nxp.com
Subject: Re: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Message-ID: <20190406154847.gknmrvjzebih3tu5@pengutronix.de>
References: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
 <20190403204756.mbc7zc5klfd5zydg@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190403204756.mbc7zc5klfd5zydg@ninjato>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Wolfram,

On Wed, Apr 03, 2019 at 10:47:56PM +0200, Wolfram Sang wrote:
> On Mon, Apr 01, 2019 at 01:14:37PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > 
> > Make sure to free the i2c adapter on the error exit path.
> > 
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
> > Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_dma_request()")
> 
> Applied to for-current, thanks!

Is your tree already stable? If not, would you mind correcting my name
in 9b0a9982d8b465e0394db10f15ba53f1a8d60e21?

Best regards and thanks in advance from Freiburg
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
