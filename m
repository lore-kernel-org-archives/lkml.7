Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22A7C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17DA21951
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563793257;
	bh=bz8L7Y4lQ/oG1EZPxMzmsi5kCGlXofk3qAQ79Iyho34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lS1SxmSdk91XosU8Im65wY1VjdmLdQWSJElL2Ura9wtyZy1XAp6H7rHql8Gigsi33
	 x8XkU4d5gFH5sxF8IygfOLqf3n7GYtBKSb90+IiWnrIMSuJiaIO7oQkN7qqpAxoZh3
	 FDLtuzZ7paZy3NtBeO95n/LepQGnDcnYCe6Oonjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfGVLA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfGVLA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:00:56 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037E521926;
        Mon, 22 Jul 2019 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563793255;
        bh=bz8L7Y4lQ/oG1EZPxMzmsi5kCGlXofk3qAQ79Iyho34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMZjrOV4kI/eXJyvtx7sF1ACqt/VSvQoy/KWW5oASQDX4MJoZA/LKl6rpCaleMLlX
         mbxXxBfaFZPOSK6ZVP4z1I7ShzeQVRiit45VA4YTEWb6OwMd0Y9FqjT7tMpYCp5lH/
         kElhVj70BaIk6J1ZEmmavXGYN6neCbSM8L73yfyI=
Date:   Mon, 22 Jul 2019 19:00:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx8mm: rename 'share_count_dcss' to
 'share_count_disp'
Message-ID: <20190722110025.GG3738@dragon>
References: <20190709071942.18109-1-chen.fang@nxp.com>
 <20190709071942.18109-2-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709071942.18109-2-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 07:18:01AM +0000, Fancy Fang wrote:
> Rename 'share_count_dcss' to 'share_count_disp', since the
> DCSS module does not exist on imx8mm platform. So rename it
> to avoid any unnecessary confusion.
> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>

Applied, thanks.
