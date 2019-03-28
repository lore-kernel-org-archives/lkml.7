Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8409DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C6A2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dCOGhgYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfC1IAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:00:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11643 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1IAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:00:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9c7f380000>; Thu, 28 Mar 2019 01:00:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 01:00:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 01:00:52 -0700
Received: from [10.19.64.157] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 08:00:50 +0000
Subject: Re: [PATCH 1/2] regulator: as3722: Convert to use
 regulator_set/get_current_limit_regmap
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
References: <20190327012947.6029-1-axel.lin@ingics.com>
CC:     Florian Lobmaier <florian.lobmaier@ams.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Vince Hsu <vinceh@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <02990b42-5606-ce53-b4b6-5ceb03c2a4ae@nvidia.com>
Date:   Thu, 28 Mar 2019 13:30:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190327012947.6029-1-axel.lin@ingics.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553760056; bh=OeCdMx0TR0qwx6/1O1RkVEsbDxdLtQkXKTFOdReAb2Y=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=dCOGhgYlM/sWKBqxVACNdcRM5H9/U3yqfMfH/iFX7o3d1ADe/5JjBYLe5Oknajb1c
         XkfMQfRVwJZblKcEEha0g+zy+YMBeciUtVGqodUm59BVLkn0lJGdAeIQ9kzL82O1vE
         Ibfpn/KW87IsogJcvKnqyVg5J0QX+yaCYOm7C3ie3r1BgeBYjpzhizc199qYizgbfr
         A93EAkJ8CUzb8bxl+RSVTJiDWeiKlt5d6s86xJjpzqNNa7/Hp3eHJvvsq1vEJ8xIdm
         qy08d4TkdGZEYWE5+hysH6jNKE5LXcHGPsIFuNLwN0dHV7fhtfKvelv0BUsubFVL91
         MOQm23Cn0NevA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 March 2019 06:59 AM, Axel Lin wrote:
> Use regulator_set/get_current_limit_regmap helpers to save some code.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
