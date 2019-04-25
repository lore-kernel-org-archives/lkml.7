Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFB62067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556205253;
	bh=VKcQ7dtOO4etdLiKfe7TgJ5sgVICJSkgnBSL2us1BhQ=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=Xk295MMEXo/dDAW4bdT6EqLcTomcF/RFC/1iHcQ2ja5oZz637fKwvCG6h3rPefFwZ
	 CS1oRBBhofo+Ljt95iE1rYXnKjdiT9kZhaqR1mLbMADApEopOGiPc3VUgKqSR/YgPb
	 fRqtk93S1XmzBFg+Cy5zCnfddfQa+5FA5HZqqmog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfDYPOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfDYPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:14:10 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B792067D;
        Thu, 25 Apr 2019 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556205250;
        bh=VKcQ7dtOO4etdLiKfe7TgJ5sgVICJSkgnBSL2us1BhQ=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=tNQ0SxplcmnwUnNFpTfU28wCweR4RoNlCNIoPeuM7JWQwPw5J1pijXU3w3NpJRVBE
         ZsJpWFH2GyL4ok6WKCVdJgV43M1aF3HPOd2f3HTDTwS5k1cFSgdDwn6MNYe+W5qi7k
         uLtF7wE3Mw0BOEaU+DaO8ONqFFaHBQVXuhcaqgG4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d020b512-59be-51bd-39c1-4827e57b020c@gmail.com>
References: <20190411214835.19947-1-digetx@gmail.com> <46c12545-0e9e-93bf-2ccc-4577f4eb223e@gmail.com> <20190424083625.GQ12975@pdeschrijver-desktop.Nvidia.com> <d020b512-59be-51bd-39c1-4827e57b020c@gmail.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
To:     Dmitry Osipenko <digetx@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Message-ID: <155620524950.15276.14252541417126056267@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 08:14:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-25 06:50:39)
> 24.04.2019 11:36, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Apr 19, 2019 at 02:50:10PM +0300, Dmitry Osipenko wrote:
> >> 12.04.2019 0:48, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>
> >> The patches in this series are trivial and fixing the longstanding bug=
 on Tegra124. Could you please take a look and and ACK the series if it loo=
ks good to you?
> >=20
> > Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>                 =
                                            =20
>=20
> Thank you, Peter.
>=20
>=20
> Stephen, is yours maintainer-tool able to pick up the "Acked-By" for the =
whole series or do I need to resend the series with a proper "Acked-by" tag=
 added to every patch? Please let me know.

The maintainer-tool is me, but I don't require you to resend to collect
acks or other tags. I can do it and I'll do it today.

