Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79C7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139E92067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205456;
	bh=DOu32qWfw+/nvGXXIM3Kh1JnVH5LE+57kCAc7oSlCTI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=ztcV0Ab2D8j/xsatbW0LPpFCi9CWwRQBbrIDDxmSk+L87hfMxqbDrx0mhqbN8+GAG
	 vYPtAznhOcJbRZiKY805FZISINBBq5mikx4r51dWOJA4G9FUgpYPfO+vs1N/+fQiCo
	 TY5vN+uRp8r1h8WMVWkm1P1x0prYtHu0xvvLz9aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfDYPRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfDYPRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:17:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD9292067D;
        Thu, 25 Apr 2019 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556205453;
        bh=DOu32qWfw+/nvGXXIM3Kh1JnVH5LE+57kCAc7oSlCTI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=wrRZxXubOpjiXt361Gr/UB4aUmZTM359yiaj9LJjcvSeHIt/+0PdyVJX8XwyQ7FPJ
         kJAPOfIArg2GmahYw5HxW1JV4lBnRykXTCEpa8r7O3DMqustQcSWpvcA6o3fIJ9GjC
         Q3oBGj6DEy+f16kqxXgvvlmZ2uhvJjb4ytRJcWs4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190411214835.19947-2-digetx@gmail.com>
References: <20190411214835.19947-1-digetx@gmail.com> <20190411214835.19947-2-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 1/2] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155620545264.15276.2161212955972224165@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 08:17:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-11 14:48:34)
> There are wrongly set parenthesis in the code that are resulting in a
> wrong configuration being programmed for PLLM. The original fix was made
> by Danny Huang in the downstream kernel. The patch was tested on Nyan Big
> Tegra124 chromebook, PLLM rate changing works correctly now and system
> doesn't lock up after changing the PLLM rate due to EMC scaling.
>=20
> Cc: <stable@vger.kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

