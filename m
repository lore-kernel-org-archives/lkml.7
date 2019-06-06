Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA35C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C812089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559845782;
	bh=OoC4nuWJqWE5iN/x6Gw9nBBptIg/ze0etoB1mALTSr8=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=Ka5Gja+P8YwYkoMer+7DdgToZ44fJPafRuigFr2uXqTz8/0hSC4X7McOLu75PjTlg
	 SVR8dQ+q5nZn9pfDJaKU3CPj8DGJcNxni49vV+O7K4uDNEH3i/gHIwHuusT5dbswFq
	 Hn1mQmQPmGDH1yke8icvLSeD3APjcbSqTtKwE9uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbfFFS3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 14:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730630AbfFFS3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:29:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0D8C20872;
        Thu,  6 Jun 2019 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559845781;
        bh=OoC4nuWJqWE5iN/x6Gw9nBBptIg/ze0etoB1mALTSr8=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=P94sqtESM6b3xMQNPs2CjFLVowQJbk6VUGVSpv8guH7GwtldZ6lxKUVT+sP2mIDVj
         iwvC1wIFrZn6j796btdt+p6I/JHv9PyFivw6RXrRx8dq91v3LSpB9w5J/Sc8Xsn0QG
         lWrA74hFBsg/O/8mabbl8C3pIsOAZlwnyBQNQmmE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw based API
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:29:40 -0700
Message-Id: <20190606182940.F0D8C20872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-05-29 05:26:38)
> Resend for the following:
>=20
> https://lkml.org/lkml/2019/5/2/170

What's left after this series to convert over to clk_hw based APIs? I'm
happy to see this merge as long as we eventually delete the clk based
versions of the code in the imx driver so that we can complete the task.

I took a look over everything and nothing stuck out, so:

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

for the series.

