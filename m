Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A5CC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761720883
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561498551;
	bh=XKjXGt7wBC/YazY7KhXqUWQeoN5TSITXr1HNZAKEqJ8=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=cYb80Zbrj/hGBf8OILaNo2EsCkYM88alIt7PIUf54HXjU9KU+pAn6vNd5ZsgB+fPH
	 yRUDPbf//YnhL+1WOjDQsZCncvd5S9gG4A72i7ZlR9DzEUsWm/K7XQDvSxjU7M7kEY
	 MsueWkqzbyKGvHnYgbaSBFOIi9X0EBy1jW6WjobA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfFYVfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFYVft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:35:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785BF2085A;
        Tue, 25 Jun 2019 21:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561498548;
        bh=XKjXGt7wBC/YazY7KhXqUWQeoN5TSITXr1HNZAKEqJ8=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=MhD7Oj77rhAVh4rKM8EbBRm++EskHFsfmlsSM/P9qlhtezwO43hkKOH3Tq/Vfh1gw
         T5ng2UlIuncLTuLaLuhLO374aHdGKnM0sMwKW7LiyXPWlOIZZyaqQhsdXobWykEgrk
         prG9p444fFRYfPs47oQnDSDH5iVNentt9Am5fTKw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190617215458.32688-5-chris.packham@alliedtelesis.co.nz>
References: <20190617215458.32688-1-chris.packham@alliedtelesis.co.nz> <20190617215458.32688-5-chris.packham@alliedtelesis.co.nz>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
        gregory.clement@bootlin.com, jason@lakedaemon.net,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        sebastian.hesselbarth@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/4] clk: kirkwood: Add support for MV98DX1135
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:35:47 -0700
Message-Id: <20190625213548.785BF2085A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Packham (2019-06-17 14:54:58)
> The 98DX1135 is a switch chip with an integrated CPU. This is similar to
> the 98DX4122 except that the core clock speed is fixed to 166Mhz.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Applied to clk-next

