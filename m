Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E69B2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554959464;
	bh=Nx4f5o51XDYUW/R0Rtmh3n/E180YsExi3vmjQZOcy04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hTs7xL0dM3fSk+jF2Ga0IBHRoo+Tv6HuJBGxiTVmB8goErKPW+wPtynUwXeWvQOe6
	 EU7ltPu2MmoYAkrCy9sr7bZdJ/kfKdBsQGb3I+DWmoCctrwqn/W52OP4w5HD1nqK4b
	 iGV6pxcJ7kcHMEiISPZRtNEggSjshns6KtrKiTmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKFLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfDKFLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:11:02 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47962083E;
        Thu, 11 Apr 2019 05:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554959462;
        bh=Nx4f5o51XDYUW/R0Rtmh3n/E180YsExi3vmjQZOcy04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdCpRU8vfIUExR9VmMYduxuBvNMcAgkhaTS66GX0EKxQcbByZKMtTacp0tx3NyizM
         QRiO1XrA6OFFJQQGsBPyHQ803L8880VACN0efdYqZIBXxZgLJZ64cKzX4Dze5uaTjm
         08Yhg1oEycA3YleZ58eh5BlpnEQ5gEGsofJa2eY0=
Date:   Thu, 11 Apr 2019 13:10:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] clk: imx: use devm_platform_ioremap_resource() to
 simplify code
Message-ID: <20190411051046.GQ26817@dragon>
References: <1554095298-15111-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554095298-15111-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 05:13:02AM +0000, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
