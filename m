Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE30C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540CA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 00:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565742304;
	bh=kMTuZC80eujfNUpzbUmk1EP6sDX9LGAP44g7xC8ZoCw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0uSpSvrMYX6GOSxWBHLpRyJ1QG8vREv7E9t7QVQRo3cFoSMp6uckX8bJ3etFTEuSS
	 W3nAAuQ/nEgAq8mokJMNoOXwhtHaaJNYVkZlPIgF9IeV+1vN68rO7Ns6XejAWtoV+S
	 5yLFAgwH1O1k4swGBuAn2pwcgkRtS6tFs24uWErY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHNAZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 20:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfHNAZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 20:25:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A1C20665;
        Wed, 14 Aug 2019 00:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565742302;
        bh=kMTuZC80eujfNUpzbUmk1EP6sDX9LGAP44g7xC8ZoCw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Tc3er6/bATb/hEY7BmXvY0UMNaV9E/EBPf/HB9gEQ7Npza5O9to/AU0I0iB7TgHmV
         bvwezNsNWeZeFsHx4ABt7CvKjtIdJzBdAogvMK3g1N7fNYUgu0U80HDnqYfFC6lk2r
         xAdpUXueKURyKKuSKHcgc0CH3BKdVMbdcVUCfLLA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731193517.237136-6-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-6-sboyd@kernel.org>
Subject: Re: [PATCH 5/9] clk: sirf: Don't reference clk_init_data after registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Guo Zeng <Guo.Zeng@csr.com>, Barry Song <Baohua.Song@csr.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 17:25:01 -0700
Message-Id: <20190814002501.D6A1C20665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-07-31 12:35:13)
> A future patch is going to change semantics of clk_register() so that
> clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
> referencing this member here so that we don't run into NULL pointer
> exceptions.
>=20
> Cc: Guo Zeng <Guo.Zeng@csr.com>
> Cc: Barry Song <Baohua.Song@csr.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

