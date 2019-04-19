Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988DC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27453217FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711970;
	bh=kaSzwJDTXGZFymupTPyhSDpK6f/UG1pd+nTEkSMN0+8=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=aZ8rLmJJv+d0efpps3+qTe/Qfb7nixVtFXsSRfHTkI3uEoV+rJ1NME/NHcp4yqsSJ
	 PwEztiZNNRNeI516mBtjPuzekwXufgcgGLq1ejyiIiBOzNjD4x3j81nxCyqXfBYE7P
	 8pCwzhLiS165C3wVZJqoemOqQwJb9aObiZrqYgFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDSWMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:12:48 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA71221736;
        Fri, 19 Apr 2019 22:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711967;
        bh=kaSzwJDTXGZFymupTPyhSDpK6f/UG1pd+nTEkSMN0+8=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=q957O8FxsdkPTAveWjuXPe7RHgySsntD7T+oXU8db71Bj51U40UaNVAE9AGPFIjFS
         WH4sNHUbwZLmyD14Vvi9GiuTINfEUCoEnucocK61Trg9pCFI+9/Shnz1pDrSgqUjtu
         ibsJTojv2wKrkEKjBZZNAH4LXsQoxZArNA1CdRCA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-5-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-5-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 4/9] driver core: Let dev_of_node() accept a NULL dev
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571196705.15276.6186892352444233068@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:12:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:45)
> We'd like to chain this in places where the 'dev' argument might be
> NULL. Let this function take a NULL 'dev' so this can work.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

