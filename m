Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9413217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b8+5rtYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfC1ICO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:02:14 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13709 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfC1ICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:02:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9c7f7e0000>; Thu, 28 Mar 2019 01:02:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 01:02:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 01:02:12 -0700
Received: from [10.19.64.157] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 08:02:09 +0000
Subject: Re: [PATCH 2/2] regulator: as3722: Slightly improve readability
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
References: <20190327012947.6029-1-axel.lin@ingics.com>
 <20190327012947.6029-2-axel.lin@ingics.com>
CC:     Florian Lobmaier <florian.lobmaier@ams.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Vince Hsu <vinceh@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <d7a159a5-30e5-c3b9-7382-41fc836a5011@nvidia.com>
Date:   Thu, 28 Mar 2019 13:32:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190327012947.6029-2-axel.lin@ingics.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553760126; bh=xc3KTpTqi8y/OZ9yHlwgfOmwWH75SaO/X9VksUHH3tA=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=b8+5rtYDHfBKj+eTbrPUKZR8J6XA/pBuDYydpr5C12jM6gs9dxW1X1C/shTrFHIP7
         S7+IGjcJ7KZq7rr+uas1RJzKDzcT8XsRlwo4IJ+4zRxPUKejyzjYVPV1Zdj124Entl
         ARMeSGL6KTM3o8f3fh7+LQw/Jnb4CGZi8Z1dPRbxAeqYcoE42hxEgZZukjVZKoJQIu
         jDtVmjhCF3IEjH1023IkWFOS5sdFPo1hXGgC7QVRcdDRum88/nujcFKedxUZS7HLpW
         OG2Nn8DhSl4ew2ZdlkiK2WTfB4p5e4WZ/u0tt7KYuVkeSm4qPqMSrbdjtVK5MSpFIZ
         Ys4Jz5YYHvg6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 March 2019 06:59 AM, Axel Lin wrote:
> Add a local variable *desc to avoid too many change lines due to over 80
> characters.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
