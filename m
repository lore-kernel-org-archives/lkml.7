Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBEDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6D320850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014078;
	bh=UIiOHtwWJTiwcVqvVfNwKJQL+vVjDCl5qohHfM7e/Fo=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=hJNTrEy0OHRcEXLf1eqguRf3sGyXwTUKT95pzv5gga5rcm7uZ3wMI86Y9iNnlv4yT
	 OA9Tc/02C3+lyuL7Dekkp25Fa0ZkuQCcLBZdVJseqXYmKBHXb+9bg2vJr+dFgiCUI+
	 fPuLd8U6p1jI/WWnZy1nh14iF/UqL8RROCcx6B4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfDKUVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:21:16 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAC120850;
        Thu, 11 Apr 2019 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555014076;
        bh=UIiOHtwWJTiwcVqvVfNwKJQL+vVjDCl5qohHfM7e/Fo=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=Gx5/qriMIVIlr6YU/ClRwbhTRaIdyJ3kg1VtkMK05hdiHpphs99ZrA+0SwmhzzJ9F
         xWUw8aTyhxKGadACor2dF3YoYfZdrUyiaRBZB8arHJ4rkSoLR0OKC095CGX2hCfPmR
         cwQZk8B/lwRl4CXzvHUAnYqKQ6135+ANUfUzb+zY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-9-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-9-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 7/9] clk: mediatek: Add configurable pcw_chg_reg to mtk_pll_data
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155501407511.20095.8651469793006948660@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:21:15 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:44)
> In previous MediaTek PLL design, it assumes the pcw change control
> is always on the CON1 register.
> However, the pcw change bit on MT8183 was moved onto CON0 because
> the the PCW length of audio PLLs are extended to 32-bit.
> Add configurable pcw_chg_reg to set the pcw change control register
> address or using the default control register CON1 if without
> setting in pll data.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

