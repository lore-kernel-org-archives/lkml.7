Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8781C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910A72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578942;
	bh=O6UEEo/zGvoIBNO4EsHN7w9mQZU/RUghaUQl9UygnBU=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=sfbvBmp1wkNu8KWFlETQsxsGNWpz6g4LW5rVfhF0FLxFhlAXvKMM7rog/Kv9DXHmF
	 0Pfynb7MrWUMwUl7gtDSe8S3QAUf/B//00zB/qqcVcmm6Ulbhm1CLCueBUlvOu95cW
	 69d1+yrmD57x94bkACjl8+rz6VHzBcGbfNg2asBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfD2XCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 19:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfD2XCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:02:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99D8205C9;
        Mon, 29 Apr 2019 23:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556578940;
        bh=O6UEEo/zGvoIBNO4EsHN7w9mQZU/RUghaUQl9UygnBU=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=1bOW8te1N67kB2Vip49FLUpOMq/xVr3IASCSAe872Am6NMcN8qy/MGCP6sPpSx5s3
         N5FQlXV1oI8H2vUMcO5GMHW1Tj4GctTR6wYzkgA07KGk104C5ErLA6A6gn/xzqLF2E
         zmXmtsvsACyrijVaCatbUL0xfWZIRWoDn7oStYYI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190430074024.40bf4c99@canb.auug.org.au>
References: <20190430074024.40bf4c99@canb.auug.org.au>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the clk tree
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <155657893986.168659.2434361291862731523@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 16:02:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-04-29 14:40:24)
> Hi all,
>=20
> Commit
>=20
>   01d0a541ff4b ("clk: imx: correct i.MX7D AV PLL num/denom offset")
>=20
> is missing a Signed-off-by from its committer.
>=20

Thanks. Fixed.

