Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808C7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502CE20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 05:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555393617;
	bh=1nzvhNEj29axDHbdzNQmA77QFU2UyFVqF9eNk5YUqBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JAB6F2tHAuFBNtWY1Xi4of4vrM3dbpZpr6xvVoUQeNYZcpi/FY3S8ktNZLsB8HtP2
	 cfg+OkeozD0f4RuGOIgTPIZ12g66Cx5STw4YozyM3j2Oxco/hDrIMsMAJ1fe8Idgd/
	 ze0W1bJIhjfkEt6w/3KNzVI55bjznxtbJw2E/kLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDPFq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 01:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfDPFqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 01:46:55 -0400
Received: from X250.skyworth_vap (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE4A22075B;
        Tue, 16 Apr 2019 05:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555393615;
        bh=1nzvhNEj29axDHbdzNQmA77QFU2UyFVqF9eNk5YUqBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YRolOO1JUkGat6DzRvzGrqyJXaLECUFv7NpVhebSTpLg1ajMwhDqbe+4cVVxtvEOX
         +HqrgL/3XmpKTyipR18L9HareX54lRlI8v0lM/bsvg7vxj64LoZxXKcMbeoDZpayPO
         GQlmGvvTOIZkovc1s9Zc4FDuWmKC3wD8S+t4Mpx4=
Date:   Tue, 16 Apr 2019 13:46:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     s.hauer@pengutronix.de, linux@armlinux.org.uk,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: use generic function to exit coherency
Message-ID: <20190416042337.GA4690@X250.skyworth_vap>
References: <3f58c55e48c28f41e92883e81c675b8478af6a5e.1554937960.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f58c55e48c28f41e92883e81c675b8478af6a5e.1554937960.git.stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:14:12AM +0200, Stefan Agner wrote:
> The common ARM architecture code provides a generic function to exit
> coherency called v7_exit_coherency_flush(). Replace the machine
> specific implementation using the generic function.
> 
> Tested on a i.MX 6Dual by hotplugging the secondary CPU under load
> through sysfs several 1000 times.
> 
> Tested-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
