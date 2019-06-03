Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8CC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFA24B2F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559560801;
	bh=51bKqvI2Kh1iIsbEEX1iYpa3HSCjXs9uBGXPd8wvuP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ItDoGUtW/jO8KME7RnnItQqbA5m61BjOmRfizjvbWzsGX8sr2w6UL8dgJLzw5XhJS
	 UzaJcLJZKNXnMRMRWcsTYgKvpUWS/FJtTyBzOlly+dKNhSIRUCllkDHUwUuDkdWjb/
	 eROjS+gNI6fFvjCNWHTJ9X4jdkvUVm3hJjAffdGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbfFCLUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 07:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfFCLUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 07:20:00 -0400
Received: from dragon (li1232-89.members.linode.com [45.79.133.89])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71F2248FE;
        Mon,  3 Jun 2019 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559560799;
        bh=51bKqvI2Kh1iIsbEEX1iYpa3HSCjXs9uBGXPd8wvuP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDVP7lay24TybY1VpQ1VnqW1oABadoI+k+LLsl4bRjiQuVoYsAN6y9COAJHDqlhZY
         m66hFh5zTqaZH2OU8SZO8qJ+xppQicaQatCPxa2bIw3z8tWX8xdxY0RnemDOxqZEfH
         vJVu95BZ8U90k63FFY6stxhTo+W4t4L86BD/VBKg=
Date:   Mon, 3 Jun 2019 19:19:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     peng.fan@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] clk: imx: imx8mm: correct audio_pll2_clk to
 audio_pll2_out
Message-ID: <20190603111947.GA15919@dragon>
References: <20190531075638.7892-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531075638.7892-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 03:56:38PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is no audio_pll2_clk registered, it should be audio_pll2_out.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
