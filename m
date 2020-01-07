Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B8C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C692075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578379442;
	bh=p0c6Gq3wRaP4vH0cRO0el0O5I/OYXjzAebIaS3q4lS4=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=llBQF5pNh2W/P9MgOuLaxa1xy/lz4k1hKwkjynUeuP+c3K+RpC55YghWt5M9B3GkA
	 ow/8mq9OamGUoYVlgqPXEC4cCDtrSB8Ejqvvf8hfAlUVarvt78XZ41pQ81htcsOEZY
	 4CPOM0RiyBVK/SHoHWxzXVkVmqQwO3AFH7DPxkYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgAGGoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGGoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:44:01 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837792075A;
        Tue,  7 Jan 2020 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578379440;
        bh=p0c6Gq3wRaP4vH0cRO0el0O5I/OYXjzAebIaS3q4lS4=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=0eNFeD0akDRFK2rCPONoCuJVGFNJy2xPYCvFoLB9l+rr0iOs9FUCFwICfsek951aB
         fozvwIYPGQPubYT/qz0xoa2aTBD43wsAgdCvQsVzU/wms40qh4o+12eFLRwCyIqGl+
         YNcLIwSPrP+SZ+pGkCLFZw9QP3h2zBUnKBkKYTN8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-4-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-4-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 03/12] clk: fixed-rate: Remove clk_register_fixed_rate_with_accuracy()
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:43:59 -0800
Message-Id: <20200107064400.837792075A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:14)
> There aren't any users of this API anymore. Remove it.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

