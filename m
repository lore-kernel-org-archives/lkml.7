Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6251BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFEF20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="W20NgDaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfC1Ioj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:44:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14040 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfC1Ioj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:44:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9c89790000>; Thu, 28 Mar 2019 01:44:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 01:44:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 01:44:38 -0700
Received: from [10.19.64.157] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 08:44:36 +0000
Subject: Re: [PATCH] regulator: rc5t583: Get rid of struct rc5t583_regulator
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
References: <20190327115413.11155-1-axel.lin@ingics.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
From:   Laxman Dewangan <ldewangan@nvidia.com>
Message-ID: <e205a6df-36d5-110c-bced-dfb2d1f13744@nvidia.com>
Date:   Thu, 28 Mar 2019 14:14:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20190327115413.11155-1-axel.lin@ingics.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553762682; bh=M0wlhYkj7Z5+AkKrIkjyD2syLjqNlz5nLW8K0KfqX5o=;
        h=X-PGP-Universal:Subject:To:References:CC:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding;
        b=W20NgDaY5zuaLWdiLknmL5UDXXwyUlhdWDJOoXj0I0xsz7BAbVXlZFT7zGDj49Jry
         1PB6mtjmMS/JJsubPpT6SXljXbLA+woJUas/1ZiZrCuoreKikZxEd0Fp2D/ePDKRMT
         sNAvGP4NCNO63k3eAkuR5X4PLItszsvwejcsX0W+9P4kMbfErPgarkU/tLW8wYiUHC
         nmjIiZCpR0ZW72K0IReCljwyGGCkx3sQuiPkjyo6UwPYSyEizMfOo0/xK9dhBF2o81
         N6asLNSuY9oDqQTf4oBUWCBR38vo4qY96GusuXGl6f7NCrNcjvsPOSYkcAISiPX906
         MhyQTKDDXV53Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 27 March 2019 05:24 PM, Axel Lin wrote:
> The struct rc5t583_regulator only has 2 members, the *rdev is no longer
> used because this driver is using devm_regulator_register now. After remove
> *rdev, only *reg_info left. We can use struct rc5t583_regulator_info
> directly, so remove struct rc5t583_regulator.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>

Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
