Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC878C47409
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8959F207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 06:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578380292;
	bh=r57OXMTW/rp5NqmDpT8iWPL+VJQ5kIcqOdlXlx92phs=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=Lr0F0XFdHa1dHDqaeTlxrKn2qEb4nSXeiB8+pKbAfAhYeROy6ut3YSgfNMEL0OWSM
	 BapF9/zigg4qYdRRnG1kp6f6x9HFC4hW0yVSDdlJkMCDI1Rkr4gUgLWquvXD477+tH
	 TYX5FGrTUF/drGwajk6VmX8xEnuz9ljtBakIR0yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgAGG6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:58:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAGG6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:58:04 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33FC206DB;
        Tue,  7 Jan 2020 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578380283;
        bh=r57OXMTW/rp5NqmDpT8iWPL+VJQ5kIcqOdlXlx92phs=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=Z4T1T4wiJ7mKB7CvWNcvHVYMyFfA6+qUXaayuVdlt/QR6fcvgAUbnF16EoeSx/CWO
         ba/SBBKlb9oOfNWV3M1bH4i90EX0nuJaSV0o4vFN4n0PcBsgHJbjFmfKKoBf6UhblS
         +acPDA7mKJqAnnkCUm2uzdo+lAWUCu8H0btD2OKY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190830150923.259497-12-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org> <20190830150923.259497-12-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 11/12] clk: gate: Add support for specifying parents via DT/pointers
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 06 Jan 2020 22:58:02 -0800
Message-Id: <20200107065803.C33FC206DB@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-30 08:09:22)
> After commit fc0c209c147f ("clk: Allow parents to be specified without
> string names") we can use DT or direct clk_hw pointers to specify
> parents. Create a generic function that shouldn't be used very often to
> encode the multitude of ways of registering a gate clk with different
> parent information. Then add a bunch of wrapper macros that only pass
> down what needs to be passed down to the generic function to support
> this with less arguments.
>=20
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

