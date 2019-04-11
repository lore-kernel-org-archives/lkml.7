Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71157C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330512184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013787;
	bh=NlldJB9LF1bkT1ZhVH7HKVJLPOXOfik2X0775xp5MY4=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=boYQQk6aPGjvqcYsViL/ryz2zJLEKiO4694Hnmgpx+XqLTodyBc4R/xpW1hE2jdml
	 0b6nZMHo/8ZieSM/WLGM+dNDWV1nGNsmTrPtKcwJCQODeEvZ7cNJGEkt+E5tWw+4vr
	 +YsxQN2r4RGRWMaZy/tUA3OcP3XIVIwIGNAejdu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDKUQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:16:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B5D20850;
        Thu, 11 Apr 2019 20:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013784;
        bh=NlldJB9LF1bkT1ZhVH7HKVJLPOXOfik2X0775xp5MY4=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=DGbAELa11rtUB9U7FByVVrVMIX8V5HFoB+yZCBrRYszBWVhpK0Biy3YHCsUpUrNmQ
         H7g2XWtWcTd0+GKku2fEpuByRN02Ygf/CHMLxxf7fX5l4FSdlrzF5JeamOIZY5MzJf
         wWyZttWmMjAQbXe808/HVPx0fzNMO7Rf1E+aU0lA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-5-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-5-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 3/9] clk: mediatek: Add configurable pcwibits and fmin to mtk_pll_data
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155501378408.20095.2407243439182851286@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:16:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:40)
> From: Owen Chen <owen.chen@mediatek.com>
>=20
> 1. pcwibits: The integer bits of pcw for plls is extend to 8 bits,
>    add a variable to indicate this change and
>    backward-compatible.
> 2. fmin: The pll freqency lower-bound is vary from 1GMhz to
>    1.5Ghz, add a variable to indicate platform-dependent.
>=20
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Acked-by: Sean Wang <sean.wang@kernel.org>
> ---

Applied to clk-next

