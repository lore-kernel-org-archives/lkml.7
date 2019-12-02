Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356ACC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D522245C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575277356;
	bh=CafNsXgbcpGTq4EPfWUNnYuHlpgBrZvTanNi8nmiXC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fHbSkumpojnwwgagt1CPpH1pMwMQGuDsg23sqLA82R6jR9Ke/GIdD/c/iEvljNCia
	 CPtFj0xR/Fn0jBHO4vSbSTZiDO11btCcRI8hafZmDfIfUhjgNAlO6Vh1iCaftYmeZH
	 GrA0EMVVkMFV234/i23bpr39EPIcOXON4/EWldyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfLBJCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfLBJCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:02:34 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 159422231B;
        Mon,  2 Dec 2019 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575277354;
        bh=CafNsXgbcpGTq4EPfWUNnYuHlpgBrZvTanNi8nmiXC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CFGvjSCkXurEfZmHReMjMFe86+fDzm30O6vRGMIXlYrwg1aPhwX6ZvkJNl3+2uImW
         9W0D0jY3bpoRzDPiyfsb4jNQOJJ1z6pVe3XF1gDCcSexnIqyG42vbT4UmeGamvdSlT
         KF9vhJ2sjQ8EAuH7Nl7UPcJVP8ngd868EnVxkDrY=
Date:   Mon, 2 Dec 2019 17:02:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 2/2] clk: imx: clk-divider-gate: drop redundant
 initialization
Message-ID: <20191202090218.GH9767@dragon>
References: <1572862200-29923-1-git-send-email-peng.fan@nxp.com>
 <1572862200-29923-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572862200-29923-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:11:37AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There is no need to initialize flags as 0.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
