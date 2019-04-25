Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F52C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0F206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228538;
	bh=lstaYbFKz51ckNjQrG8PXrp8B5qwaZFeEn3qgtoJ28k=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=HnFd8GqK9NiviEyohl2bSSGmKf5eleuU5Gi/pH/9VnEQZlr5bOLU4JBN9fQiZJ8tD
	 1qgjKFzhUAuBvEMkvyDiXinofyP6ARWLeleit+yxDkLPLV6Xw1jngW2Wf9/iQVypAG
	 z4Prl3DqWqtE2AmetmrECCUVmJTezoa/SefiUkWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfDYVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfDYVmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:42:17 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D39206BF;
        Thu, 25 Apr 2019 21:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556228536;
        bh=lstaYbFKz51ckNjQrG8PXrp8B5qwaZFeEn3qgtoJ28k=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=YpxkvJubQLaAs4bxQDK5aJg31vbBoOMAsIIqJVbPT2IEfFv1HsunRbIxpZgQ1OXaz
         KJAtj5QEZhM1fwUnCojWZjTwSaiqf01ZAIxDz38zo/lLMk/t6XFmAhpFB2CFKncPBo
         z1KQxU22+WXKkXQkl2ulwKpcHadyysdt1bfeQa/4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190425102740.19286-1-peng.fan@nxp.com>
References: <20190425102740.19286-1-peng.fan@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: imx: pll14xx: drop unused variable
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Message-ID: <155622853547.15276.13713264032689161727@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:42:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-04-25 03:14:28)
> It does not make sense to only get value from pll->base and assign
> to a local variable when recalc_rate.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

