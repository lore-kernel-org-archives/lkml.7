Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9572BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6604F2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="crDdlRSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfHEId3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 04:33:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15502 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 04:33:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d47e9e20000>; Mon, 05 Aug 2019 01:33:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 05 Aug 2019 01:33:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 05 Aug 2019 01:33:28 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 5 Aug 2019 08:33:27 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id BB5BF42845; Mon,  5 Aug 2019 11:33:25 +0300 (EEST)
Date:   Mon, 5 Aug 2019 11:33:25 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Mark Brown" <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] soc/tegra: regulators: Add regulators coupler for
 Tegra30
Message-ID: <20190805083325.GE3883@pdeschrijver-desktop.Nvidia.com>
References: <20190725151832.9802-1-digetx@gmail.com>
 <20190725151832.9802-4-digetx@gmail.com>
 <20190802140512.GD3883@pdeschrijver-desktop.Nvidia.com>
 <c537fbea-5884-03db-305f-6ab3d553f7ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c537fbea-5884-03db-305f-6ab3d553f7ab@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564994018; bh=mWdZVci7AOyAKC8AqAypHQ9t/8NzQXkYTYcm5zqhMdI=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=crDdlRSVjTJgr074oPgSg+8KGNVt+bKhAYMwVXEkzOzeUsj9mXJUFPCVDGgNs55ZS
         81EQyIcxJGKLxW3oOnNi+kJMdNI4HksxcC686y51lAGz22R/ZuhLqx5/9yOLRWhgvw
         4i6WPydkHRZY4qMp9mXm4rv4MbsOYy9PXd/Op/P/ymGdvVrvE8NH+TD9Vuk3IDjDDb
         74ip7JXTRxV2vGCmpAdZNZ4BoiQJNagTPt31MG+q6zaG6kD5zjqPfDHh7KM7++xhHA
         iO9yUgk5QV03msHFngZzGKobeabNbdHjS1AUYcDFwAEfgqiUCqchkviQZYjoMogCDu
         7YGI9W4N9pFVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 05:39:23PM +0300, Dmitry Osipenko wrote:
> 02.08.2019 17:05, Peter De Schrijver =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Jul 25, 2019 at 06:18:32PM +0300, Dmitry Osipenko wrote:
> >> Add regulators coupler for Tegra30 SoCs that performs voltage balancin=
g
> >> of a coupled regulators and thus provides voltage scaling functionalit=
y.
> >>
> >> There are 2 coupled regulators on all Tegra30 SoCs: CORE and CPU. The
> >> coupled regulator voltages shall be in a range of 300mV from each othe=
r
> >> and CORE voltage shall be higher than the CPU by N mV, where N depends
> >> on the CPU voltage.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/soc/tegra/Kconfig              |   4 +
> >>  drivers/soc/tegra/Makefile             |   1 +
> >>  drivers/soc/tegra/regulators-tegra30.c | 316 ++++++++++++++++++++++++=
+
> >>  3 files changed, 321 insertions(+)
> >>  create mode 100644 drivers/soc/tegra/regulators-tegra30.c
> >>
> > ...
> >=20
> >> +
> >> +static int tegra30_core_cpu_limit(int cpu_uV)
> >> +{
> >> +	if (cpu_uV < 800000)
> >> +		return 950000;
> >> +
> >> +	if (cpu_uV < 900000)
> >> +		return 1000000;
> >> +
> >> +	if (cpu_uV < 1000000)
> >> +		return 1100000;
> >> +
> >> +	if (cpu_uV < 1100000)
> >> +		return 1200000;
> >> +
> >> +	if (cpu_uV < 1250000) {
> >> +		switch (tegra_sku_info.cpu_speedo_id) {
> >> +		case 0 ... 1:
> > Aren't we supposed to add /* fall through */ here now?
>=20
> There is no compiler warning if there is nothing in-between of the
> case-switches, so annotation isn't really necessary here. Of course it
> is possible to add an explicit annotation just to make clear the
> fall-through intention.
>=20

Ah. Ok. Whatever you want then :)

> >> +		case 4:
> >> +		case 7 ... 8:
> >> +			return 1200000;
> >> +
> >> +		default:
> >> +			return 1300000;
> >> +		}
> >> +	}
> >> +
> >=20
> > Other than that, this looks ok to me.
>=20
> Awesome, thank you very much! Explicit ACK will be appreciated as well.

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

