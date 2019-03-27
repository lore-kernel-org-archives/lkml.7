Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1FBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1736520651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H2YmVlEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbfC0NS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:18:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15352 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0NS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:18:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b783b0000>; Wed, 27 Mar 2019 06:18:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 27 Mar 2019 06:18:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 27 Mar 2019 06:18:56 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 13:18:55 +0000
Subject: Re: [PATCH v2 1/2] bus: tegra-aconnect: use devm_clk_*() helpers
To:     Sameer Pujar <spujar@nvidia.com>, <treding@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1552452119-6574-1-git-send-email-spujar@nvidia.com>
 <32ab970f-d6a3-1232-77f1-41f97cc04f9a@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <67a87b1d-b22f-f1c6-b792-cf180797409a@nvidia.com>
Date:   Wed, 27 Mar 2019 13:18:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <32ab970f-d6a3-1232-77f1-41f97cc04f9a@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553692731; bh=cjZ8oHzfhyVcFuraclhEkZKli7qmH7JS4sX23B2VYm4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=H2YmVlEdZ3OfNJa04GjqDE5RU22c5f1dkrN96PqWSr/YUBsdoskH57eibURoQc36G
         xHA1JXHsqhqq2XS1q9izi9WCt/WDdBWA2l9OgfYTff5aqM1syoLbV+xPSpYo+Gu8lc
         fXHfy1Ko7ii/70ShEpUiMNyftzbQrcKB7GSrDKLOAcvL/6QhHHzHOfdKv87VL8riNS
         tcmkhbXLh/8RKKRoXDeAO/hR4gbmPsrHM+40sMsxAhlOOXwTaE4GxrWrgiyxq8JSWr
         0xV7yvxCrYCyRMYndixEjn6l01XYKHXebrhCTPUa7Orqh3/e1gmnqnx7XRuTD2AtR5
         Zp7Yg+FoYlPtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/03/2019 11:10, Sameer Pujar wrote:
> Hi Reviewers,
> 
> Request for review and approval.

Fine with me. I think you have my reviewed/acked-by.

If there are any changes we need to make, we could also use the clk_bulk
APIs here too. However, not critical.

Cheers
Jon

-- 
nvpublic
