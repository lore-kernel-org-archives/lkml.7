Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02231C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0254218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553168207;
	bh=6uLVc6TKrjL7EY3VdUDVoOiFY7Tbvr8pMpb7gwOaJec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oDK07ely491dUIEwAITv/qb4dJm1KXTZN3brqUyeIxLPrkl4WdP+DrN39DKVSuIAO
	 usQjoi+VyYcF0h1+SlSRoi2oI5i7QV1uCw6B1wptRrzw43QQ5ErVgcYkn9FNYQNmfy
	 iS4wdpf1HgmSrTnPzdBU215hJuq3Iy6/WseepMcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfCULgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfCULgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:36:45 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525DE218D8;
        Thu, 21 Mar 2019 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553168204;
        bh=6uLVc6TKrjL7EY3VdUDVoOiFY7Tbvr8pMpb7gwOaJec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ug0+hkvo1PbOOlJHr2WDD1ufms2MVRKrbgbdP+RG+IsInSqwcJzBfxXorFbS0xfl
         i0sjP5dhsOg84EMNkxtL5Bsv3S3hvfwVInsXLnl9SHeL4s0KGbiAxA2dk8yrF3SbPo
         mPSksFrpXQs+2l3eao4ceWTjHN7RmN9E2bQKhdho=
Date:   Thu, 21 Mar 2019 19:36:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Message-ID: <20190321113614.GJ12513@dragon>
References: <20190313093626.18589-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313093626.18589-1-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:24:19AM +0000, Peng Fan wrote:
> Currently lsio_mu1 is used by Linux Kernel with mbox-cells as 2, but
> actually mu0-4 could be used to communicate with SCU. So fix the
> mbox-cells.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks.
