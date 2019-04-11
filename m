Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21738C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E197520850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014002;
	bh=TdkN/2BSkfk9sxN8tMNAmraD+u4bEwK+dCSSufpZwIY=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=e3MD9LtVZTUI8LqoAMrUC+wzQ4AuyKOIjcxR96kDmzSWmHd/rR7xPE9eGX4ix6We2
	 hUoLJ2lFfYr2pucr8VlXWNm+4RdAL8jyzmUTPZjNuAEkeNbfvfiyoc+juERn44LrVQ
	 BFpfxV7/PXVV6YVYiCbFoZpX1LcFQnj15RTDoODE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDKUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKUUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:20:00 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC0720850;
        Thu, 11 Apr 2019 20:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013999;
        bh=TdkN/2BSkfk9sxN8tMNAmraD+u4bEwK+dCSSufpZwIY=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=EPRTwy7WQj0r1Htd4OkvLZaHyUKzelRlv9wvQi32UM7yVR6WUidu+mrZMNpu0r1mm
         ohoYltIVfAmELEaAd19be4Q1RbvmN5NL7ey9oMLbr2CIkHlG/roe9fc/qinheT2mVx
         qIjoLu7BzWJDLZaOIcxyHd5bMXXYYDCy0EPsqhos=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-8-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-8-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 6/9] clk: mediatek: Add flags support for mtk_gate data
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
Message-ID: <155501399858.20095.16525048679717411283@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:19:58 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:43)
> On some Mediatek platforms, there are critical clocks of
> clock gate type.
> To register clock gate with flags CLK_IS_CRITICAL,
> we need to add the flags field in mtk_gate data and register APIs.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

This patch doesn't apply, because it's already there via commit
5a1cc4c27ad2 ("clk: mediatek: Add flags to mtk_gate").

