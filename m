Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02BDC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A21E205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221066;
	bh=6892bPLRC7WUKYCZH00/muHQj6Yv66ifsW2MgknkWLM=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=Fg/UfYSMj/dcuidMVDop8SoblTvQwtHSS2TbdhRi6gyFzKFaU4oybhi6KgsihsSys
	 3oGetTVC7dZPYAFeR1STFVZu57D1rV/54ct9/NwZH2PmaFIh43kII/impqiQ188422
	 Cmyyq+lxVStUyL0jlFes4NQNWkQKq25nfUiVuPyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfDYTho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfDYThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:41 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D0ED2077C;
        Thu, 25 Apr 2019 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221061;
        bh=6892bPLRC7WUKYCZH00/muHQj6Yv66ifsW2MgknkWLM=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=f3PMdChCaRXQVdroBfAMaHsCjdpYULz5oAt1Mh8boNdmbFskp9gyB1dRPnQRXeFCo
         5WzRDJgrgR6wNLYDlkclwEvj0WxN3/I1jwZFXwp6Kd4VxrjJ/gynB0RJw4ZiLbSaUq
         fPWYt4Y0BwssXkaXp6yMSQc3l4gIfCLvgLq7l7pA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190402125056.21509-6-alexandre.belloni@bootlin.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-6-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 5/7] clk: at91: add sam9x60 PLL driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622105997.15276.14140027068545843883@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:37:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-02 05:50:54)
> The PLLs on the sam9x60 (PLLA and USB PLL) use a different register set a=
nd
> programming model than the previous SoCs.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

