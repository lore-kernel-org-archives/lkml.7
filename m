Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 02:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D697420709
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 02:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575860083;
	bh=IiKeChNrtz/p4Aq7d3yVyybl+heL9RFk0ZAzNPQG1Gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aeRnJZPtxNwFHtLM8B2+xvkAM/EJqNnM35B7nSgtLLJzyELewgLZN2PxH1ijjGzkb
	 0tpxtIQDzEv3Pda9dbJ5gJXM7jiK/vgDVI0PUO1i/HLB13HO0xQwdh31v42ekhKwnU
	 cJkoGHYM4Xi9EMe4NSbZyWG2vl2PVgha6bn2dyAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfLICym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 21:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfLICym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 21:54:42 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD05E20692;
        Mon,  9 Dec 2019 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575860081;
        bh=IiKeChNrtz/p4Aq7d3yVyybl+heL9RFk0ZAzNPQG1Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JaetPVHtG558XXBCJass8k6qiJ2BAGyXNmZtm1j9zhSpZ590C4I6hV2eqsEbd7gqQ
         Cu2pdg2Ryk5JWHQ2HaKYGZPyDOoSwwmWPBQebOho2kHB9eTRiblJuxWxc5om6CVOq2
         EVMDdWutnd6DYlz4q0vXjHTQvKb/tgOy9G7/zJ1Y=
Date:   Mon, 9 Dec 2019 10:54:26 +0800
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
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-imx7ulp: Add missing sentinel of
 ulp_div_table
Message-ID: <20191209025425.GW3365@dragon>
References: <1574402986-11117-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574402986-11117-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 06:11:42AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There should be a sentinel of ulp_div_table, otherwise _get_table_div
> may access data out of the array.
> 
> Fixes: b1260067ac3d ("clk: imx: add imx7ulp clk driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
