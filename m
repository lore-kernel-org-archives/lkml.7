Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F1C43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BF320828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567709500;
	bh=/M5vtmCXrJZ2Y/8dz6N+gt8X33XfB4PU4LvW9FAENFw=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=BBUY0XunMNnkXr584trnYdZyJMb2XUu689zGg0t3arjt9zRfNTdJXGdEWN+zPHbvp
	 JbdwF18zFrcPyyebr7sdO2yNun097p0SOCrotvyfjatJrt6hFN06MO3C2zp1ySUfQC
	 vSaTiOkFKl7w8scL5NQRrEt9IDYK0j0/D4dScnok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388876AbfIESvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfIESvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:51:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BB520825;
        Thu,  5 Sep 2019 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567709498;
        bh=/M5vtmCXrJZ2Y/8dz6N+gt8X33XfB4PU4LvW9FAENFw=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=C5/z6F/7aQ9evaZh/nFx7qV9hMzyCUHWE6dFzQHXHwOERFMhUvEjXyroRS1vegqR5
         eAWEabgpNQYZovf4dUJloyQEC4EOVnaTAonwqgJpUPBwXVhG8ovok84uXOCWSXCpe6
         Q9m7v2fdFXUYpEbQpMFMysy5j+icvHU1NbL1u2rs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190826212042.48642-1-sboyd@kernel.org>
References: <20190826212042.48642-1-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: Re: [PATCH v2] clk: Document of_parse_clkspec() some more
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 11:51:36 -0700
Message-Id: <20190905185138.C2BB520825@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-26 14:20:42)
> The return value of of_parse_clkspec() is peculiar. If the function is
> called with a NULL argument for 'name' it will return -ENOENT, but if
> it's called with a non-NULL argument for 'name' it will return -EINVAL.
> This peculiarity is documented by commit 5c56dfe63b6e ("clk: Add comment
> about __of_clk_get_by_name() error values").
>=20
> Let's further document this function so that it's clear what the return
> value is and how to use the arguments to parse clk specifiers.
>=20
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

