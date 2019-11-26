Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847752080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791625;
	bh=fUb787PA4PU2tCTtKmzIE+OJKmh/ygl+a3Ywi9ivz2g=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=qNTcA4A8SSHPq72XLdrpVuffcpSwG3V3K4QoEuLr4KLL1ICHDZDuoG3v3o6QOTyPW
	 c7rFYvhQ1GFK4RnlkquGGicJH3yMZTci/pgL/+8KpaYAuXACbLxhl3CC5X4qA0qPH7
	 gYr5de7Q2Aunh17YTCVN5mRbHlJ4WgKwuXNjlLQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfKZSHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfKZSHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:07:03 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CBB20835;
        Tue, 26 Nov 2019 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791623;
        bh=fUb787PA4PU2tCTtKmzIE+OJKmh/ygl+a3Ywi9ivz2g=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=f1rAbsh/XSiuNfa5kcGPvM42m60hlvVGV1t9LjFcMKMhyEoQrbArljGWG7zH04Whk
         7nVY/Twk2qkieexUGjOpPOOgPOBct9KSfFFqLK8k9E06FK/lqBQ1p9lKimDjGM67Np
         BPT0oSFK16T3PJTaE29DVDyWwOCsA8NHPCAdjf4o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115162901.17456-4-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org> <20191115162901.17456-4-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 3/7] dt-bindings: clock: Add devicetree binding for BM1880 SoC
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:07:02 -0800
Message-Id: <20191126180702.D8CBB20835@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-15 08:28:57)
> Add YAML devicetree binding for Bitmain BM1880 SoC.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

