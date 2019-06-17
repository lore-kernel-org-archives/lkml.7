Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11581C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D922621E6D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 08:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lns8r5gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfFQIVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 04:21:47 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1403 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfFQIVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:21:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d074d9a0000>; Mon, 17 Jun 2019 01:21:46 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 01:21:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 01:21:45 -0700
Received: from tbergstrom-lnx.Nvidia.com (172.20.13.39) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 17 Jun 2019 08:21:45 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 3EE624290D; Mon, 17 Jun 2019 11:21:43 +0300 (EEST)
Date:   Mon, 17 Jun 2019 11:21:43 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Prashant Gaikwad" <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] memory: tegra: Introduce Tegra30 EMC driver
Message-ID: <20190617082143.GM29894@pdeschrijver-desktop.Nvidia.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560759706; bh=q1GTVxxG4wQEkdmVxEanQhrDdAHn88DSedSSw0xO7FM=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=lns8r5gP5HFIRZUZ/RBQXPL7CD7SAWsEnS7ivj9HeLMiyfe30AZUYVdWXhPGMdeSJ
         EiYAC9g28wEZJBKkxj2RJaEON1xB3vtovK3tzeRmUkDyg24tUSxcJLSD/K9uLV3quy
         IKPBBScmpoClrfkX3yhbmbf2CVEImL4f0WnluwHZ+KbzICLJ3Qm49wmer0UULrPgEx
         Le9CZwUxP6ham7pXHCZEh9tFg8BWn7HEsoKVncFhDHNy80jX310EfJ8vQJVOYHYdQu
         FAiN86Oz9713BlTakFjtZ83ESdmw5HWzTCyYYuClmHFleDApinrzlW2N6VSyvhwlYU
         ycDx4Su27hTcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:35:41AM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This series introduces driver for the External Memory Controller (EMC)
> found on Tegra30 chips, it controls the external DRAM on the board. The
> purpose of this driver is to program memory timing for external memory on
> the EMC clock rate change. The driver was tested using the ACTMON devfreq
> driver that performs memory frequency scaling based on memory-usage load.

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

