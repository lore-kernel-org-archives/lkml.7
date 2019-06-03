Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D1C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB17A27C95
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LZoD3S5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFCHRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:17:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18654 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfFCHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:17:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf4c9950001>; Mon, 03 Jun 2019 00:17:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Jun 2019 00:17:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Jun 2019 00:17:53 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Jun
 2019 07:17:53 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id CED9E43068; Mon,  3 Jun 2019 10:17:50 +0300 (EEST)
Date:   Mon, 3 Jun 2019 10:17:50 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Subject: Re: [PATCH v3 0/8] NVIDIA Tegra clocksource driver improvements
Message-ID: <20190603071750.GA29894@pdeschrijver-desktop.Nvidia.com>
References: <20190524153253.28564-1-digetx@gmail.com>
 <20190531082634.GA6070@pdeschrijver-desktop.Nvidia.com>
 <c686aae8-3be0-805e-265b-a7f16f2a6c02@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c686aae8-3be0-805e-265b-a7f16f2a6c02@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL108.nvidia.com (172.18.146.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559546261; bh=a37niGOpSiUOzqAL8lSPqZSbY8EBi/kHt4NfhyqtnxM=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=LZoD3S5qfj4ORc7lr68N5p/NbgDnnmLeHtvjtWvH9Apn+cWoQXoJQLkIzvNagOuv5
         ZT24T3ZbPA4QxnuKnKym24oRsNcvTHDvJpC2G1VQGAyVx7rbkUuafsFZQk5CoTbfEb
         Jo617lMOeKx7OEgOgBbxTOfBLQsU6eYMaFPTG+K0gMUAUyxvhYFwQoBFgX6ZqkmewQ
         rA5QSL3Qm4qce57ofGuDT6XEZ4yIwt8N401fpNWQHX3wJ8yboPPDC1JIp9yVCXwIEV
         5y/sQ9VnR+Lc4vUKFzfmhH02oJW7dRJYEXQ7zq9F6BYFuSAsndBZ7C2KcZRNgcD5Cg
         EHbYTZB82j32w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 03:33:41PM +0300, Dmitry Osipenko wrote:
> 31.05.2019 11:26, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, May 24, 2019 at 06:32:45PM +0300, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> This series primarily unifies the driver code across all Tegra SoC
> >> generations. In a result the clocksources are allocated per-CPU on
> >> older Tegra's and have a higher rating than the arch-timer, the newer
> >> Tegra210 is getting support for microsecond clocksource and the driver=
's
> >> code is getting much cleaner. Note that arch-timer usage is discourage=
d on
> >> all Tegra's due to the time jitter caused by the CPU frequency scaling=
.
> >=20
> > I think the limitations are more as follows:
> >=20
> > Chip	timer		suffers cpu dvfs jitter		can wakeup from cc7
> > T20	us-timer	No				Yes
> > T20	twd timer	Yes				No?
> > T30	us-timer	No				Yes
> > T30	twd timer	Yes				No?
> > T114	us-timer	No				Yes
> > T114	arch timer	No				Yes
> > T124	us-timer	No				Yes
> > T124	arch timer	No				Yes
> > T210	us-timer	No				Yes
> > T210	arch timer	No				No
> > T210	clk_m timer	No				Yes
> >=20
> > right?
>=20
> Doesn't arch timer run off the CPU clock? If yes (that's what I
> assumed), then it should be affected by the DVFS. Otherwise I'll lower
> the clocksource's rating for T114/124/132.
>=20

No. It doesn't. This is the big change between A9 and later CPUs.=20

Peter.

> TWD can't wake CPU from the power-down state, so it's a solid "No" for
> TWD in the "can wakeup from cc7" column.
