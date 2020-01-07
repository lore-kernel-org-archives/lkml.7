Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED866C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9461206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380290;
	bh=eUsS+9OV8oq4r1RDOOiNxN07Oc34uXxH50jSTlZHufo=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=BzS1UVfcIMnpxAliZQZIlqgHqQfpKDgTMcht8QX7MfsWE/X9DUJ9xmdXYm3gNl4eX
	 U0CXHHlc+AVodI84ubMXlRlOK7/J2FAR5xhYRC1NDbRl32Fi6Uri+jgm0BihMmw6NH
	 DYbib/wChSyPs1uWIPg9ROqH27+74Xh/d4XmDy5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgAGG6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:58:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727555AbgAGG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:07 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A80206DB;
        Tue,  7 Jan 2020 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380287;
        bh=eUsS+9OV8oq4r1RDOOiNxN07Oc34uXxH50jSTlZHufo=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=ddRYLEmAZuWH4qyfENa3JG5jla+w6ORViKKSqK7qj9qiZ77lzs96YQkq3xos+4pOh
         bI5Vat4S6q/r0Nw3ULpSA8jpg5tUBWtAZrAAVtJI1SbALEoIZ1GY1uIfUu+whGPaMR
         X36tcRBzzu/gd9xO1zhVwphGgELZO2aPwhV2iAXI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-13-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-13-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 12/12] clk: divider: Add support for specifying parents via DT/pointers
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:58:06 -0800
Message-Id: <20200107065807.44A80206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:23)
> After commit fc0c209c147f ("clk: Allow parents to be specified without
> string names") we can use DT or direct clk_hw pointers to specify
> parents. Create a generic function that shouldn't be used very often to
> encode the multitude of ways of registering a divider clk with different
> parent information. Then add a bunch of wrapper macros that only pass
> down what needs to be passed down to the generic function to support
> this with less arguments.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

