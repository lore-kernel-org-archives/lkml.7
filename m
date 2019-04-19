Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5270CC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1670420652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555712376;
	bh=Wgn1Bm2KsMEmLef71LF0LP3eofx4Fd6JiGxK2wzIIoU=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=XL8HClQvPPn8LKREO/908DNDI+JqbZa1onbEYnfk4n88ilL/JVHvXYOunfnICKNBr
	 zXFjmIY6QMOhJ/3KsO9QqYYG2vFNhVn1Ez4WTF9svRef15rw+pGuUbxpXJixcgtag3
	 9L+I5LtzV8w2ma/gfDQtLemEaX+WlZ02OH0ahTjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDSWTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:19:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfDSWTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:19:34 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE35420652;
        Fri, 19 Apr 2019 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555712373;
        bh=Wgn1Bm2KsMEmLef71LF0LP3eofx4Fd6JiGxK2wzIIoU=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=urTrupY214KTgoq5+frWQTSgxZFD+Ilen1bwmuQoW8G+ruf1EkhzdgIy0iXOEzaaW
         sU43SmgrGIGUCic89YxMl43OoLXSuXBmEInqzDCLyUHIS3pwV5bFjTCnwmPZEbCD7T
         Pn6akEv2303g6qIwunvATvmR4OV9TcCyw0w1cfaY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190419114226.8066-1-digetx@gmail.com>
References: <20190419114226.8066-1-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH RESEND] clk: tegra: Don't enable already enabled PLLs
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155571237296.15276.7432257601401549388@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:19:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-19 04:42:26)
> Initially Common Clock Framework isn't aware of the clock-enable status,
> this results in enabling of clocks that were enabled by bootloader. This
> is not a big deal for a regular clock-gates, but for PLL's it may have
> some unpleasant consequences. Thus re-enabling PLLX (the main CPU parent
> clock) may result in extra long period of PLL re-locking.
>=20
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

