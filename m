Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA88C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9906206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568664945;
	bh=IfZPB1lLT7YeN1wvqbbr7rMvQbP3HHxIn8t188n52Uw=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=QHJsXo0ulutsDO5GAGTpWw9mFCgtcprXyigS6h5vouL0kmlDPvzw/KS3jpYc1MGEe
	 prLK170LFe+McaVuutEOxazPu1jhvGmCzKPKGPbGUi0RY/53Y/ZheSwh0lgnBtK3dd
	 l6O+GGz++3Wf+PcbI9aDTa/KjJdv1djHCi91dzio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfIPUPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfIPUPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:15:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29BC520665;
        Mon, 16 Sep 2019 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568664944;
        bh=IfZPB1lLT7YeN1wvqbbr7rMvQbP3HHxIn8t188n52Uw=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=Y+tiHc3sqmYd6W6rVYLK6Wx+1jPZ7D2jID/2awAYMFomgESxl/P7YiBdjnyE9OufO
         avZkTd+5wrOebkenaN7MoJFydzkwjYfMklwHkdc1upzF3oyahtikMJcdatPBSY477P
         VsMvsvdWIZYfkdX43Mbyd1utI8VVnQV09PzcJkCU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
References: <1568042692-11784-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: at91: fix update bit maps on CFG_MOR write
User-Agent: alot/0.8.1
Date:   Mon, 16 Sep 2019 13:15:43 -0700
Message-Id: <20190916201544.29BC520665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-09-09 08:30:31)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The regmap update bits call was not selecting the proper mask, considering
> the bits which was updating.
> Update the mask from call to also include OSCBYPASS.
> Removed MOSCEN which was not updated.
>=20
> Fixes: 1bdf02326b71 ("clk: at91: make use of syscon/regmap internally")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

