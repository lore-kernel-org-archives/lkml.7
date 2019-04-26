Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34EEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD599206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556248834;
	bh=doT94EsfN4oZ0Ad7UzKtW97ysKR4N5ATd2SRdRFi9hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQ+RpVgxX32Q2xbDPwR84qoYSWtIqBaBon71M/LIM9Hb8SGpGgjAVFzAL4ILd203V
	 w1U7ZXQWIauo0O4rtVtuBhkO5GHSCKCwM4Yvs7Sfq/nbadQE0kc4eRCMtXTyB56YVs
	 GTEcnPFKaiMerVIURA+FzEaLLB9zZ6cNtULjJAPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfDZDUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 23:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfDZDUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 23:20:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A466620675;
        Fri, 26 Apr 2019 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556248832;
        bh=doT94EsfN4oZ0Ad7UzKtW97ysKR4N5ATd2SRdRFi9hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akrkvNjrnCviZez/ibMSc+UYrOnLdUjkJHNbuPhL1jdNoZTbSOZt9tG3LoSFMz8ov
         m7XoVRtjjWfbK1HFZAe75nia0U12dd97dPKMfVki9wNL3BVjcW3N7esPErc0iExfju
         lGBtS/YJZ4HtZvaKOc4Lxj7w23LD73iTzCog2qf8=
Date:   Fri, 26 Apr 2019 11:20:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "festevam@gmail.com" <festevam@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx7ulp: update nic1_bus_clk parent info
Message-ID: <20190426032003.GC7980@dragon>
References: <1556169264-31683-1-git-send-email-Anson.Huang@nxp.com>
 <155623701103.15276.18082131746292726812@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155623701103.15276.18082131746292726812@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 05:03:31PM -0700, Stephen Boyd wrote:
> Quoting Anson Huang (2019-04-24 22:19:07)
> > Since i.MX7ULP B0 chip, nic1_bus_clk's parent is changed to
> > from nic0_clk directly, update it accordingly.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Looks ok. Shawn, will you pick it up?

Stephen,

I prefer you directly pick up any i.MX clock patches that look good,
after I already send you PR.  I will start again for next cycle
around -rc1.

Shawn
