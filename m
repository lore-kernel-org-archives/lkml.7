Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE47C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A72054F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568752844;
	bh=zU0HD00NHDxc5VqtXTSUFWjVKlZEMVpOor9bnEEN6as=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=Lut87V/nicBZQyTFcyqNjRCKKoE9AzetqQPReE69nV5t6xlVMuSGZ0bjoPczZoUnV
	 b7ru0qKEwihOr4bpVQygZlbpNnGN2qlCLRDcwdk0YdQOVHo0+KuGXoZC7cwzgEVmGZ
	 GBcXIW3e1St1IooFcUtJ6ODNVMZtYbwhWgaubKgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfIQUkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfIQUkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:40:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69A52054F;
        Tue, 17 Sep 2019 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568752843;
        bh=zU0HD00NHDxc5VqtXTSUFWjVKlZEMVpOor9bnEEN6as=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=TzwJSuHtK9O6pP7iDKb0A8NndvJr/oVyOTYw79OI8o+5ptcNio8Fg80A43/+DW51X
         20kK+6EbMB6P/91fBEOHZMMa2E8Zx1CsSN9/MYFlIPV9a3uSNdCuCA1dq/zHi3JOy1
         NqwnirYyqXr6FWANRBgstIYTO8N8yVvIpS/4X9zQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190916161447.32715-4-manivannan.sadhasivam@linaro.org>
References: <20190916161447.32715-1-manivannan.sadhasivam@linaro.org> <20190916161447.32715-4-manivannan.sadhasivam@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 3/8] clk: Add clk_hw_unregister_composite helper function definition
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 13:40:42 -0700
Message-Id: <20190917204042.D69A52054F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-09-16 09:14:42)
> This function has been delcared but not defined anywhere. Hence, this
> commit adds definition for it.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Can you add a fixes tag?

Fixes: 49cb392d3639 ("clk: composite: Add hw based registration APIs")

