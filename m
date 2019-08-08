Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BECCC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9F20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 04:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565240215;
	bh=fg5khFk3YuZBohTROE3ejwk+PldPzP9n0DbgnXjxBUo=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=c27B9VS3QqhF1VkJog6PJYq86r0Dx2/kMoxdNplzBppoLp+yTmA007ckDvAFigGrY
	 7I/d5PCQ1FiIDTevH7/9YFidbth7jNszI69y6ogGHJX8SkH5xyMY3utiIi6Zb+RfX9
	 zHfEBZpCjI0mu/1E0VyTzj5xGvuJX+aOLmh0Rq30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHHE4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfHHE4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 00:56:54 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3188220880;
        Thu,  8 Aug 2019 04:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565240213;
        bh=fg5khFk3YuZBohTROE3ejwk+PldPzP9n0DbgnXjxBUo=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=ZVvRL/+btScoFuQMMQikaqYRKNgzP3Kn/Fqby0QVXNbN+QrXEwOjOLZ+cjiGljQft
         Y7Q5pGfru4aTqCrHwTRE85JXbb4sEpChHXMnNpwp1r+91yfqNRJyu39dpXW4J8aizZ
         FGSE5fynKRNU2eNNM0Se8feioHbK2RYqPqankRTA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190717145651.17250-1-andrew.smirnov@gmail.com>
References: <20190717145651.17250-1-andrew.smirnov@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2] clk: Constify struct clk_bulk_data * where possible
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 21:56:52 -0700
Message-Id: <20190808045653.3188220880@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrey Smirnov (2019-07-17 07:56:51)
> The following functions:
>=20
>     - clk_bulk_enable()
>     - clk_bulk_prepare()
>     - clk_bulk_disable()
>     - clk_bulk_unprepare()
>=20
> already expect const clk_bulk_data * as a second parameter, however
> their no-op version have mismatching prototypes that don't. Fix that.
>=20
> While at it, constify the second argument of clk_bulk_prepare_enable()
> and clk_bulk_disable_unprepare(), since the functions they are
> comprised of already accept const clk_bulk_data *.
>=20
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Applied to clk-next

