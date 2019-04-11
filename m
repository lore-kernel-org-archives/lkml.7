Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D68AC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300852146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013779;
	bh=JOtCFg0doBLjq4X/eQlclJA/YGvreDJl+MF1NoEmd8Q=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=C+HmEo50FXgg+k/lVam8YMvqes0SD2xis4uV6EZX+5YtMCa68+f/YPWY4lECB7ybY
	 VzgwV8ax3E2XgtAiSiSI7kkU4bpp3ql3z+TQI0RjAiJsZgg9Q31TO1VA4JCny96O9+
	 cfr7hulDzlOCg7jKp7dkSCu7Dy0cpx7y8F8pMPlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDKUQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:16:17 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFE920850;
        Thu, 11 Apr 2019 20:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013777;
        bh=JOtCFg0doBLjq4X/eQlclJA/YGvreDJl+MF1NoEmd8Q=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=qMe8oQCv/OsQ8cPpVB+MSv8EKP3JfxczfSVxn7DzzOX9hF5Om/eqD099W9setkTgn
         zqjsFtv6dMzcEbdvs2BAC4RdvxWHDGVQZ/5BHKVIraJW+65zOztY87aO9cCjwjJ7xF
         /FQEddusEAJrv3s0AAeyfNMy1QlTX9IzjUOQZFx0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-3-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-3-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 1/9] clk: mediatek: Disable tuner_en before change PLL rate
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
Message-ID: <155501377617.20095.15654973603515721887@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:16:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:38)
> From: Owen Chen <owen.chen@mediatek.com>
>=20
> PLLs with tuner_en bit, such as APLL1, need to disable
> tuner_en before apply new frequency settings, or the new frequency
> settings (pcw) will not be applied.
> The tuner_en bit will be disabled during changing PLL rate
> and be restored after new settings applied.
>=20
> Fixes: e2f744a82d725 (clk: mediatek: Add MT2712 clock support)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

