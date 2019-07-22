Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C31C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E253221953
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563765911;
	bh=OuaSMyJ31uzehvilbNtzHBL2+HlRaa400vG7NlP8qIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VSya9wU4gYdWcOkaotZPg1WzxPgv3UYnFWNiz6t0UfXZSY+yFojCiohdzB8qSOOKt
	 GWp2XmyhwRlN8apvh9pqjPDfpEG5VIcn1L31HCxIcQEF1vjZqDKWq0pwwjcdomnAX8
	 je+bdEM98gapCOpSzGPk7vPF7P+HJlAQqrXuN5hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfGVDZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbfGVDZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:25:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F6721921;
        Mon, 22 Jul 2019 03:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563765908;
        bh=OuaSMyJ31uzehvilbNtzHBL2+HlRaa400vG7NlP8qIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gwMTXrZSxokCdVtYuEJue+C7vgSZRNLf9rreY8p7Za0B8QNrzynY3cO7taVJTFZs0
         tGTlH60d28O0DeEM8Wm5vMvTqlSFqaJeXYOCzEdzF/uhvTEzJUpbZLxznp2ZVe/qUY
         cG+sDYZUj4BSiTRGNlv995NBbvkfLRz3YAB5qgG0=
Date:   Mon, 22 Jul 2019 11:24:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, aisheng.dong@nxp.com,
        weiyongjun1@huawei.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shengjiu.wang@nxp.com
Subject: Re: [PATCH] clk: imx8: Add DSP related clocks
Message-ID: <20190722032441.GW3738@dragon>
References: <20190702152007.12190-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702152007.12190-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 06:20:07PM +0300, Daniel Baluta wrote:
> i.MX8QXP contains Hifi4 DSP. There are four clocks
> associated with DSP:
>   * dsp_lpcg_core_clk
>   * dsp_lpcg_ipg_clk
>   * dsp_lpcg_adb_aclk
>   * ocram_lpcg_ipg_clk
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
