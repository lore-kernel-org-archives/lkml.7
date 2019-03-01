Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F195F218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551407604;
	bh=Kwke71XTGmX7EGnKWHiqzO556ravtOvwv8Amf8v/rc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=epyHLCQcUjsoeAshDXEKtTBqSDlPWbj8ka5HFPvCyuQZIvDNqQMS+WvxhEo2iPuAw
	 ewU0oqQwj3DHLKQIAxuy/C/VC0pZr6hijxHPdKVgOs63l2dq9xcmG3JLPGAo6uo9gw
	 Hzv3LJhn1TjukI/QtTnv53IrndRHFQI6MJOPVSTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfCACdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:33:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfCACdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:33:22 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C3320863;
        Fri,  1 Mar 2019 02:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551407601;
        bh=Kwke71XTGmX7EGnKWHiqzO556ravtOvwv8Amf8v/rc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFhRoion3+7LJhC9xFDfeSsXdugfYebV4GNH+R5hlhqX6JzyBltNFeUAhJd6aCdya
         uodvU6dT84g2ZkATsYChThdypFZDUexVO14B1YGzFQwgvYEWTi5VGI5tSmdeBCS2gC
         dSCq3fcjADcjvaJrJI0ULSievkimbqlod1+30IPA=
Date:   Fri, 1 Mar 2019 10:32:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: gpcv2: Make use of regmap_read_poll_timeout()
Message-ID: <20190301023226.GM26041@dragon>
References: <20190220021429.4910-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220021429.4910-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 06:14:29PM -0800, Andrey Smirnov wrote:
> Replace explicit polling loop with a call to
> regmap_read_poll_timeout() to avoid code repetition. Also fix
> misspelled "failed" while at it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Applied, thanks.
