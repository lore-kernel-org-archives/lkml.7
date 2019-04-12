Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4277C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F33E20651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i6nn7qoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDLIGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:06:09 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13846 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfDLIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:06:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb046f50000>; Fri, 12 Apr 2019 01:06:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 01:06:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Apr 2019 01:06:08 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 08:06:08 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 12B3741B40; Fri, 12 Apr 2019 11:06:06 +0300 (EEST)
Date:   Fri, 12 Apr 2019 11:06:06 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] ARM: dts: tegra30: Add External Memory Controller
 node
Message-ID: <20190412080606.GH12975@pdeschrijver-desktop.Nvidia.com>
References: <20190411230221.31362-1-digetx@gmail.com>
 <20190411230221.31362-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190411230221.31362-4-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555056373; bh=SmLTyxJ/kG/C3uULw3dWHbWaOocdnH3aZYPuwV3G89o=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=i6nn7qoBvahm5OVAE5xk4loFB1Nx+i3OcJ9tP6fSxJCs6RDKRUP6XdXWD5C9qfpk/
         zrMVEKFNTcRB4plYa2Og3/Ov/vUZMwk1P6QL6a72LJEXVkpK7nXZNAguP2e3/Slijp
         MVXodKDJc6tGrBV7oxpBd54DjDTASvAPj1gVhKLFATKdxlvS8j9xhvFEUe2sUMIN7O
         aV14QEuNPm76+QKodKkpyFzhwi43r9xG2Cwze8w/dsOOWdujJ/aqzXa55OuaU1q7qS
         OnYM+VW6bUBmqDCv99jSloBklppXpSXcsNo8droy2BeTiYBKrjwJs4Q7BK8FIb2wA+
         b9n0C+waXJGZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:02:21AM +0300, Dmitry Osipenko wrote:
> Add Add External Memory Controller node to the device-tree.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
..
> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
> index 38ebdb076ccd..defdb38bde54 100644
> --- a/drivers/memory/tegra/tegra30-emc.c
> +++ b/drivers/memory/tegra/tegra30-emc.c
> @@ -980,7 +980,8 @@ static long emc_round_rate(unsigned long rate,
>  	}
>  
>  	if (!timing) {
> -		dev_err(emc->dev, "no timing for rate %lu\n", rate);
> +		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
> +			rate, min_rate, max_rate);
>  		return -EINVAL;
>  	}

This doesn't seem to belong to this patch?

Peter.

>  
> -- 
> 2.21.0
> 
