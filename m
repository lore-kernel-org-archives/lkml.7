Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE54FC6199
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAA52084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573250849;
	bh=gLwm52RY9G/9492fo3p2MflMQXw59u4hMZtGnCihRjI=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=Ds990VgnZicD64I1m+YQ4fckwnLz7TSj2wYFTzPJ4tlUEjD9k8pmKydLb2ecKj9nc
	 5OhjGriDuR38VowfGSvfDmO+EB+EiJU7sFbrGhHs2SWBd8QHPzrkbFKy9m3AGLVwMM
	 A2ShnOtkOEiu0gTkhpPUpbuvvu0fuFxZfRBDScHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfKHWH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730308AbfKHWH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:07:28 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7F321848;
        Fri,  8 Nov 2019 22:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573250848;
        bh=gLwm52RY9G/9492fo3p2MflMQXw59u4hMZtGnCihRjI=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=nX5Fa3AXOotSVNgz+B4jYyonyO9RE9BQ3kFBxu0zn8Q18WcuTvegmFPzPBt4AW4CJ
         EfRdNBOoGtyKd3Ry7sXe2l1NJGVMvJNNVFu2CjeLACYvPiXqeKhadRBcYuAF0k/+qF
         yZ3gj8Or59VrVJqO3VE5/YX41ow5SrsYAYpopDOE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191027162328.1177402-4-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com> <20191027162328.1177402-4-martin.blumenstingl@googlemail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/5] clk: meson: meson8b: use of_clk_hw_register to register the clocks
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 14:07:27 -0800
Message-Id: <20191108220727.DA7F321848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-10-27 09:23:26)
> Switch from clk_hw_register to of_clk_hw_register so we can use
> clk_parent_data.fw_name. This will be used to get the "xtal", "ddr_pll"
> and possibly others from the .dtb.
>=20
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

