Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED7BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ED521473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDHNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:32:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47035 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfDHNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:32:00 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDUNS-0006xP-7y; Mon, 08 Apr 2019 15:31:58 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hDUNR-0006OS-NT; Mon, 08 Apr 2019 15:31:57 +0200
Date:   Mon, 8 Apr 2019 15:31:57 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Gavin Schenk <g.schenk@eckelmann.de>, linux-kernel@vger.kernel.org,
        t.scherer@eckelmann.de, kernel@pengutronix.de
Subject: Re: [PATCH] MAINTAINERS / Documentation: Thorsten Scherer is the
 successor of Gavin Schenk
Message-ID: <20190408133157.ykuprwtve7bmavbq@pengutronix.de>
References: <20190408123208.10965-1-g.schenk@eckelmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408123208.10965-1-g.schenk@eckelmann.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Mon, Apr 08, 2019 at 02:32:08PM +0200, Gavin Schenk wrote:
> Due to new challenges in my life I can no longer take care of SIOX.
> Thorsten takes over my SIOX tasks.
> 
> Signed-off-by: Gavin Schenk <g.schenk@eckelmann.de>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I assume it will be you who picks up this patch? I suggest waiting a bit
for Thorsten to give his ack, then this can go in from my side.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
