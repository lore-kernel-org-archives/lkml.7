Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50FBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84B2206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 22:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573683678;
	bh=5JhH5wXUGl6ui3+sVP/PrMjxe2XX9RlIT1LO4ZQTbhI=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=gfsIBZM3IVjjYCIAyaPPWVqwvxauc0j/IBPWGzRbZ9S8TI0Gv2eePUd2ySge7qHdT
	 P+KIxiPwizw8mZJHvggUetlaLOlj1hVbE+YmsKKYx6vbocytoR/lj+DAIUonkM8P62
	 VGCjz5Q5uCP0FV4qrul6EWSVZubMxPamS+aC6SJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKMWVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfKMWVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:21:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E9B206E3;
        Wed, 13 Nov 2019 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573683677;
        bh=5JhH5wXUGl6ui3+sVP/PrMjxe2XX9RlIT1LO4ZQTbhI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=e4e/6PYgxzaeEkTSAv029ucwYwUw/0EEl8yZ8uNtOFVbE2t/k1MvtzH9WiH/ztLoW
         RI0ArGrKfXTgi9YEU4FBYzitlv7tk6GNtsCb4xaSOTqKmKg9CgK1QTIdu+2xt90jFD
         OP3uy7xn/r1aBdS0+UcD6mBL/2QhslNKNaYpz8Wo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 0/7] Add Bitmain BM1880 clock driver
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 14:21:15 -0800
Message-Id: <20191113222116.E5E9B206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-10-26 04:02:46)
> Hello,
>=20
> This patchset adds common clock driver for Bitmain BM1880 SoC clock
> controller. The clock controller consists of gate, divider, mux
> and pll clocks with different compositions. Hence, the driver uses
> composite clock structure in place where multiple clocking units are
> combined together.
>=20
> This patchset also removes UART fixed clock and sources clocks from clock
> controller for Sophon Edge board where the driver has been validated.
>=20

Are you waiting for review here? I see some kbuild reports so I assumed
you would fix and resend.

