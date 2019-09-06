Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8309C43140
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A139B2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567804835;
	bh=MQt++sVNBB2fzbH/p8lHsEpraval7qpthWJQ2mg7J/k=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=kILotCH9bc7hAmomWDtruvcHgFlw9gp83egc5+UmWSsZDqG28Vl+fmUNrdoCJTjwV
	 had3wftrvsl+Btx9d39yQUfA3CRwYId82rkd0p/nAt/2BKISiNbDB29/kHAbksN9ak
	 aPXxnUYMzDKiM2PArHY2JY4/uwNIMLScbA2Kuv4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404063AbfIFVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 17:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388619AbfIFVUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 17:20:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D002070C;
        Fri,  6 Sep 2019 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567804834;
        bh=MQt++sVNBB2fzbH/p8lHsEpraval7qpthWJQ2mg7J/k=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=EqJe/rsxG28z3OlZyW6hNJXnxqdnkuKY2us5bqWi8O6pFdveNEugWZ3i3SRE/tDOr
         qxVzhWXSx3LtazqgVHz4pdnKzP/QUj3TNviWsTKyaDi/a4KQkvArJj+/cqG6NuqnfE
         sKQSdB4kTDa/I/44zDFi/UKTstRtzYIqCJfNJhtA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190703162700.32091-1-huangfq.daxian@gmail.com>
References: <20190703162700.32091-1-huangfq.daxian@gmail.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH v2 05/35] clk/ti: Use kmemdup rather than duplicating its implementation
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 14:20:33 -0700
Message-Id: <20190906212033.E6D002070C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fuqian Huang (2019-07-03 09:27:00)
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistake=
s.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>=20
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---

Applied to clk-next

