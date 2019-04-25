Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C148BC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02BA2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556225693;
	bh=9kPxeaHLTC5zEznVxhDzmnYyWY2CCYM1KXH0Csa7C5o=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=NP/4vV+hE8CUYBHz70b1W1bTTlzrn28ztfLrVrdIcrSJeyex8xx3MLGwWnQRRIIPG
	 5Lrnm5T8fv+djndPzemxzVUkN79EojaSSJ1nuOOMVQok8Q7gwNHH2gs4z2wH8vOOZx
	 bDumwTwIvQIXmXgGK/wjqJbz0KvT22GIaZ9dNNqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbfDYUyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbfDYUyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:54:52 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7432F206BF;
        Thu, 25 Apr 2019 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556225691;
        bh=9kPxeaHLTC5zEznVxhDzmnYyWY2CCYM1KXH0Csa7C5o=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=fLm7DoLrzXvm+baR3CxKAZTCqQb0KuQVZ9vL1st6KcsqWiAowiLcWM8zEBt5i0Zr0
         rUygrgfhHXR/EtEWhk9iYqsfQ1BzeLPIlbP/9h0VXSkvibVjxvnLU4xz3OC7FIg59J
         DwADhk/nWGw4r2ampPdtxMWpKC4mpw0VUbgjNDt0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190414192321.23294-2-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com> <20190414192321.23294-2-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/5] clk: tegra: emc: Don't enable EMC clock manually
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Message-ID: <155622569044.15276.18228580730419302688@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 13:54:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-04-14 12:23:17)
> The EMC clock marked as critical, hence it is already enabled at the
> registration time.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied to clk-next

