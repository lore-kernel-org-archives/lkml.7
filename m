Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511AEC468B0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2037E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560780854;
	bh=hg8zXu4lNwst1/gASH2kaLe0y4zZL5PBg8O20GVXn08=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=GdW2qsIR/zel1ljZ4ZEUfPl550hxD7O+EwkqkrjgWMwaXSHVR1awhWZNfsYD1R4Gx
	 iiicjFZjHXsoUVijXivjE+vjMiDyoAII27olwgGOE3iOhBC/WCohTmiTjE4Gpn5vZ1
	 AjcXt7rNbnVZfRl1qOTaKCdcgCJ0dxIUkJRMF1og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFQOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFQOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:14:12 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA46206B7;
        Mon, 17 Jun 2019 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560780851;
        bh=hg8zXu4lNwst1/gASH2kaLe0y4zZL5PBg8O20GVXn08=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=wTinsuIRCpvQbooqu3bbQ7Aap9ZuoAoFHUedLk18u8u1Or1ChyH7zbnrm+sJYDgxa
         a9MOLIXiIZ5pWYycmV3Et2b9iKVXyO2059eXyIs5vEnYYTg2ixDNhmkS+ZIWhoUnYC
         VU5XBoUbZe33q99nLf2EjztetykFo8rMKLEOvoeM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190614181040.67326-1-sboyd@kernel.org>
References: <20190614181040.67326-1-sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Do a DT parent lookup even when index < 0
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Chen-Yu Tsai <wens@csie.org>
User-Agent: alot/0.8.1
Date:   Mon, 17 Jun 2019 07:14:10 -0700
Message-Id: <20190617141411.5AA46206B7@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-06-14 11:10:40)
> We want to allow the parent lookup to happen even if the index is some
> value less than 0. This may be the case if a clk provider only specifies
> the .name member to match a string in the "clock-names" DT property. We
> shouldn't require that the index be >=3D 0 to make this use case work.
>=20
> Fixes: 601b6e93304a ("clk: Allow parents to be specified via clkspec inde=
x")
> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

