Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776EFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0BC2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfFXGEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:04:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49527 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:04:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfI5X-0006Iv-5o; Mon, 24 Jun 2019 08:04:23 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hfI5W-00082n-C6; Mon, 24 Jun 2019 08:04:22 +0200
Date:   Mon, 24 Jun 2019 08:04:22 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        t.scherer@eckelmann.de, kernel@pengutronix.de,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] siox: add helper macro to simplify driver
 registration
Message-ID: <20190624060422.ivwvn2jdw3ksq5s7@pengutronix.de>
References: <1561354834-22617-1-git-send-email-info@metux.net>
 <1561354834-22617-2-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561354834-22617-2-git-send-email-info@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:40:33AM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Add more helper macros for trivial driver init cases, similar to the
> already existing module_platform_driver() or module_i2c_driver().
> 
> This helps to reduce driver init boilerplate.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

@Linus: Feel free to apply both patches via your gpio tree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
