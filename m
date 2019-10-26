Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AB7CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFD2214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572089013;
	bh=a6AuJJ6j/hBbd4+u1gXjHtd0PGYlinfGMuAbGY+jJXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vTBGOkrcbwPm6A0QYM3l0/uh6+ZjgkVjyXp2gBa3AXm+BrgFLK/Z4RM+ktpQytsFB
	 AzKS26HcU3m2jUD+lgYJCXksvAaaHs2f3Snumf8swPGqCA0O3rdZzBY2ZyOV/inHFu
	 Ry8Rtlw3QJDc8g4eWAz2jA5CsesT+seL+Ktae+R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJZLXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfJZLXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:23:31 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAEE20867;
        Sat, 26 Oct 2019 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572089011;
        bh=a6AuJJ6j/hBbd4+u1gXjHtd0PGYlinfGMuAbGY+jJXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCOBUqx1iIKckbn2Jwm7z7gr5LJTK1iLVXkplhVBGyHWYYsX5IrlsSxk9PUKecrme
         t1fZMXLAqMq0t2OfZ15lf+ILz3K7lnbjQynn3TaLDDpzCGVo6BqC2V/yYl5mRz14P3
         6T5GBRnRX9NBbqNwWXMVv2756UlcthIbP5pQuZZE=
Date:   Sat, 26 Oct 2019 19:23:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux@rempel-privat.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: imx: Remove call to devm_of_platform_populate
Message-ID: <20191026112314.GG14401@dragon>
References: <20191014153228.25167-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014153228.25167-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 06:32:28PM +0300, Daniel Baluta wrote:
> IMX DSP device is created by SOF layer. The current call to
> devm_of_platform_populate is not needed and it doesn't produce
> any effects.
> 
> Fixes: ffbf23d50353915d ("firmware: imx: Add DSP IPC protocol interface)
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
