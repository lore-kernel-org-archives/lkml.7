Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C831020823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hqBb0WXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbfCZCRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:17:34 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15727 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730691AbfCZCRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:17:34 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c998bc00000>; Mon, 25 Mar 2019 19:17:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 19:17:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Mar 2019 19:17:33 -0700
Received: from [10.19.225.182] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 02:17:30 +0000
Subject: Re: [PATCH v2 00/12] Add some functionalities for Tegra soctherm
To:     <daniel.lezcano@linaro.org>, <edubezval@gmail.com>,
        <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <linux-tegra@vger.kernel.org>,
        <rui.zhang@intel.com>, <srikars@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <31c0ee3b-a8a1-ded3-0cb6-cffab8db58d8@nvidia.com>
Date:   Tue, 26 Mar 2019 10:17:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550744327-4677-1-git-send-email-wni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553566656; bh=PEHgFA0ZGJ2auUAkA1qny9nsnNc3eQsU1h5no6ZG9fY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hqBb0WXYzMo+hpmi1/yq0P3V/aCPeIc4OMkaLtWpYvIb8vDHzjZpFcw0beO9qEFJw
         HJ2K/eMFAOxixg0jucVtalvRXA1f01b6uCf2NxazXIO9afllgSvDyncWrJ7838EjzA
         k2tRTbYSajxOAtlp56Zjfw0FBILt/yOd/rMCM0cfsn8VnCigVoCbPk4nNEHnJW8W/V
         DNE8oYxUOX7TkbitLgOy96uW2igf1FkNWVq36iMrrGkS4e6L56m2Dems9skYYjsWYX
         Z+En1TOjxbDlVNzwD/fzOZPFSMDn91AiMAjFiF6OShDenZp8hKQkZV1/XTNDb/Gu7j
         PgjEyFTbzySEQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Does there have any comments on this serial?

Thanks.
Wei.

On 21/2/2019 6:18 PM, Wei Ni wrote:
> Move the hw/sw shutdown patches into this serial. There already have
> some discussion for it in https://lkml.org/lkml/2018/12/7/225.
> Support GPU HW throttle, thermal IRQ, set_trips(), EDP IRQ and OC
> hw throttle.
> 
> Main change from v1:
> 1. Use boolean for "nvidia,polarity-active-low".
> 2. Add suffix "-us" for "nvidia,throttle-period".
> 
> 
> Wei Ni (12):
>   of: Add bindings of thermtrip for Tegra soctherm
>   thermal: tegra: support hw and sw shutdown
>   arm64: dts: tegra210: set thermtrip
>   of: Add bindings of gpu hw throttle for Tegra soctherm
>   thermal: tegra: add support for gpu hw-throttle
>   arm64: dts: tegra210: set gpu hw throttle level
>   thermal: tegra: add support for thermal IRQ
>   thermal: tegra: add set_trips functionality
>   thermal: tegra: add support for EDP IRQ
>   arm64: dts: tegra210: set EDP interrupt line
>   of: Add bindings of OC hw throttle for Tegra soctherm
>   thermal: tegra: enable OC hw throttle
> 
>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  62 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  20 +-
>  drivers/thermal/tegra/soctherm.c                   | 961 +++++++++++++++++++--
>  drivers/thermal/tegra/soctherm.h                   |  16 +
>  drivers/thermal/tegra/tegra124-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra132-soctherm.c          |   7 +-
>  drivers/thermal/tegra/tegra210-soctherm.c          |  15 +-
>  include/dt-bindings/thermal/tegra124-soctherm.h    |   8 +-
>  8 files changed, 1020 insertions(+), 76 deletions(-)
> 
