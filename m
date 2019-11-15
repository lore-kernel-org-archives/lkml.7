Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ADF20733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573853816;
	bh=c00SBY9DvhMN/W9wlPdp0qkZRm/U1JUYVVaAiMZWyLg=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=po1LWkSiuezOkNf3u/8X9dBc2sFo/j2KU8T6pCTvU3niqQ4G/FdchqBPOChkyAp7D
	 Wy7YjTsISbxM1DViuNEUt1d3v7i3q+TH7e4yrUsLgO9FedCs3UXGveJEkRUgDcn53N
	 HpF5yNTQ4mnum25oAMJoIiK2exA+dM9oes4ojRrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKOVgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfKOVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:36:55 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9187920730;
        Fri, 15 Nov 2019 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573853814;
        bh=c00SBY9DvhMN/W9wlPdp0qkZRm/U1JUYVVaAiMZWyLg=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=2lgi1iSe2d+iphVSpDGMqfbcUFkVBa3ag9zQBM2th8z7PMmqY/6oA15yffPKRVbs1
         583pLQcmupcHeyVCNVVKbBpWMp3961zIf7/xEkGeQPAJPzwqFs97vvMkapYEV2nGCc
         ZTXAGvyktPceWkHoYlsRe+v9R0HVrS6m9qPohWiQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ec7062cf-a246-8b95-dca7-34e2b957d691@gmail.com>
References: <20191030004813.9187-1-digetx@gmail.com> <20191113230303.726AE206E3@mail.kernel.org> <02df00b3-5e23-441f-b2d5-b84fdb411e98@gmail.com> <20191114115656.GC5690@aiwendil> <ec7062cf-a246-8b95-dca7-34e2b957d691@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit state on rate's recalculation
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 13:36:53 -0800
Message-Id: <20191115213654.9187920730@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2019-11-14 04:10:51)
> >=20
> > It's not so much that I missed to pick this up. It's just that it didn't
> > make it in time. This was posted just a couple of days before v5.4-rc6
> > and I had already finalized the branches at that point. Given that this
> > doesn't fix any actual issues it didn't seem worth to force it in at
> > that point.
> >=20
> > That said, I don't have any objections if Stephen wants to pick this up
> > on top of the pull requests.
>=20
> Thanks!

I'm fine to wait for it to come through a pull request next time. I just
wanted to know what to do with this patch in my queue.

