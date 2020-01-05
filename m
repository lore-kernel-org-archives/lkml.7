Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4337AC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BCD2465E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578207561;
	bh=Dz8BMkWPePwNlSRW+VsrOys9MKhbsKCrsIWV/XdLeuw=;
	h=In-Reply-To:References:Subject:To:From:Date:List-ID:From;
	b=UHCjjhl2mUBrc8sQO3+Cq1IHL0rVC5wQPefIQHNWzfVeg+TvXsaTWn8/ZuIru7Mvx
	 W61otWP5teAQpAT1nngxf02ExbAGFe1e9ffpkbuyxibwaHj4QcMES5IVpg+zrUCWk5
	 BehHKgvtHn0CRRi0rgItnQNLwUJPPwOWGVnxlfx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgAEG7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 01:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAEG7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 01:59:20 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A548207FD;
        Sun,  5 Jan 2020 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578207559;
        bh=Dz8BMkWPePwNlSRW+VsrOys9MKhbsKCrsIWV/XdLeuw=;
        h=In-Reply-To:References:Subject:To:From:Date:From;
        b=o3Hd5C5hc7S50UyYcrHmiXYihlPT19KyrK8iG0dwWfVqn0kJU4wElPsL6mL16zaSW
         bVk+IOsIoByWDis6bhcO8OofVb+14c6xWfWrSMhkXyc9U1AHbSvC6NaNRoAI2AVCL5
         ZrRsrzrLz/BfJM/fSGMs8px2gBP0f7s13xKFDAAE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1578050744-3761-1-git-send-email-sricharan@codeaurora.org>
References: <1578050744-3761-1-git-send-email-sricharan@codeaurora.org>
Subject: Re: [PATCH 0/2] Add Global clock controller support for IPQ6018
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-soc@vger.kernel.org, robh+dt@kernel.org,
        sivaprak@codeaurora.org, sricharan@codeaurora.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 22:59:18 -0800
Message-Id: <20200105065919.4A548207FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sricharan R (2020-01-03 03:25:42)
> The IPQ6018 is Qualcomm\u2019s 802.11ax SoC for Routers,
> Gateways and Access Points.
>=20
> This series adds Global clock controller support for ipq6018.

Can you fold the fixes in?

>=20
> The patches were a part of https://patchwork.kernel.org/cover/11303075/,
> now moved it outside based on Stephen's suggestion.

Thanks, but I still got the other pinctrl patches :(

