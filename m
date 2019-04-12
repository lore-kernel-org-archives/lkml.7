Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494AC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6289820869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555087318;
	bh=fBkKq/VD/Aw0EkJyQYz3MKt6DHb/MUqbt1u3277+TKI=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=fPIcXFvbiZylsai3VSk/usuAKbL4LG0e0/w1UPne90C4raTKwuX2WSZZE43LGRDXN
	 QEID9zWoF6P5HWMFVXL0gkdkobZDOlrfztw4Qaua/aDGxSPfqiYLTaBaT7ZOd+Gl9y
	 7uoVLu0qb1DYYItYJsKauzHzXj4gxXCgZTlMJ+14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDLQl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLQl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:41:57 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A4862077C;
        Fri, 12 Apr 2019 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555087316;
        bh=fBkKq/VD/Aw0EkJyQYz3MKt6DHb/MUqbt1u3277+TKI=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=ysw599tVKv5IAT0V069DFpQt92AtCfMmTuVFK+mVXN0ZU7xjcfeF9d5CGHG19NkP+
         kK8iNsh/5aDy/U1WU1OuD5wRZg9BVQrCBv2fZyIzkcSckNeZFlVKVTN7aFGr+2LyOx
         jtlX7ZxXL2p0Lm8vSWDG5fRSP5cXq2IazVCS4LPQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412033027.3516-1-weiyi.lu@mediatek.com>
References: <20190412033027.3516-1-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1] clk: mediatek: fix clk-gate flag setting
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155508731571.20095.11067229428863866325@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 12 Apr 2019 09:41:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-04-11 20:30:27)
> CLK_SET_RATE_PARENT would be dropped.
> Merge two flag setting together to correct the error.
>=20
> Fixes: 5a1cc4c27ad2 ("clk: mediatek: Add flags to mtk_gate")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-fixes

