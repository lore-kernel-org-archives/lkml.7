Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB183C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62320848
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551487555;
	bh=Dix9wYJZswox9q6lMBAmIBLAamPZesWSaBZcvyecDmk=;
	h=In-Reply-To:To:Subject:References:From:Cc:Date:List-ID:From;
	b=KC0OyTshvaFhqiYbTFAjCfQJvBrax3uSADk+19JnrIxViiL2BEUxsrcJ0aV1zy5N+
	 hxMqI80SvGRy1rsdtD17J6mMNBG3ami4VgS2wacHYPiYvwQfhNc0UtROwaAAZM0AGb
	 0o0bkF517syImH80GMec5ZFJc+sdLbgVkQ7eqV0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfCBApy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfCBApx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:45:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16F9520823;
        Sat,  2 Mar 2019 00:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551487553;
        bh=Dix9wYJZswox9q6lMBAmIBLAamPZesWSaBZcvyecDmk=;
        h=In-Reply-To:To:Subject:References:From:Cc:Date:From;
        b=WQ3DxGgrCgdby2yAjd7DkZv0tZTRB/eLf09w/3tpLgkDzPS9hoXcvVxc9BdQYXvvC
         8MIJqBBpN143pWKJGLOjLpXaaEXh8Jpr2IzZ3H0bVOTfSoxqqS0iRHzZtqbbDfKIBr
         UpT308iiV0Uyq4BUTquuQ6WHq6VYep3CqbhS+EnA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190226223429.193873-1-sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 0/8] Rewrite clk parent handling
Message-ID: <155148755222.16805.14783532568007890826@swboyd.mtv.corp.google.com>
References: <20190226223429.193873-1-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
User-Agent: alot/0.8
Date:   Fri, 01 Mar 2019 16:45:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-02-26 14:34:21)
>=20
> I plan to at least merge the early patches in this series into clk-next
> so we can clear the way for the later patches. I don't think anything is
> too controversial until we get to the new way of specifying parents
> at the end and of course, the sdm845 patch is incomplete so it's not
> going to be merged.

I've pushed the first 5 to clk-next.=20

