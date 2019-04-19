Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E354DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA8C217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711975;
	bh=Z8hP0iebDSEIbu86EUBRDbtX035ooxDZFP+g0dWHSB8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=0tHf5pH+fzCWVjjWSUzcplxKbSUakJfV+wi59GtjihBuqq1WsGI17HXwih9DN65KE
	 PfHX3MkdRnKrXvpu710S7KTBi4hw3iI9I1EgxGREUh+5wG0t0jFzPDg7b9oxO/my70
	 Vbwjvpw2bUDLvljr3N0N8YmjDWhwotgAYkG0HHcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfDSWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:12:54 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DC1221736;
        Fri, 19 Apr 2019 22:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711973;
        bh=Z8hP0iebDSEIbu86EUBRDbtX035ooxDZFP+g0dWHSB8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=slUjPGVegSh5psDUwPQjy2VPCsa9CWn9um5wIgHDZXzzol25wOwLoLppjrYk9TucI
         1kXPI0s9EbBZdUA+GzjV8aorsW8HvOIvtq8gceasFUdMikmZUUcsSXFomIXuDANLkU
         pK+gAHSnot0i4+0MMu+CltIlnA/Rs0I9+Fq4KESk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-6-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-6-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 5/9] clk: Add of_clk_hw_register() API for early clk drivers
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571197261.15276.5856728740743634102@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:12:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:46)
> In some circumstances drivers register clks early and don't have access
> to a struct device because the device model isn't initialized yet. Add
> an API to let drivers register clks associated with a struct device_node
> so that these drivers can participate in getting parent clks through DT.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

