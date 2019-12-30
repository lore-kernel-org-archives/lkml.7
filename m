Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B6C2D0DA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D83206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 05:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="l6PFc2QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfL3FP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 00:15:28 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6044 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfL3FP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 00:15:27 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0987e00000>; Sun, 29 Dec 2019 21:15:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 29 Dec 2019 21:15:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 29 Dec 2019 21:15:26 -0800
Received: from [10.24.192.96] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 05:15:22 +0000
Subject: Re: [Patch V2 03/18] phy: tegra: xusb: Add usb-role-switch support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
 <1576660591-10383-4-git-send-email-nkristam@nvidia.com>
 <20191219132650.GJ1440537@ulmo>
 <74d94004-2022-3b04-6cd9-d6b1e9eca230@nvidia.com>
 <20191229093643.GA47966@mithrandir>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <ba264e94-33c9-41bb-be23-3a8cad6cef52@nvidia.com>
Date:   Mon, 30 Dec 2019 10:47:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191229093643.GA47966@mithrandir>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577682912; bh=kOikX3Ohu11K+j1p0uqOpCdOHAMVO4HLaWjD7fd+RKk=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=l6PFc2QDMZvneNFEDMYXYemt1bj6X/dIC9RV9ubaz7SIvn6TuSjlmF2jYusee6qzl
         Ar4BvNTxqASrcX4SezPxbU+lE+gHreBfXvWGevK23GUJeOotBkBGRy+HfGrRlylzEK
         l6pKhGtyX/RdMWXOUJ6P95oKRQMYQx4DSQfFGcSAT21jkq4Hnjb7kasqFttgZvreni
         mXKNZ8entjXiPtbfb67JLLhZDknC9K0DnOtChtpEfriQ39YGTiubIRxIuRtnWU6yaR
         dLT595IdkfvDJENm3U4Pzo7LzWqSoKcJk+1N6kWlm59m99NFtIvSf+BKLRlPiSowkm
         saSh+2ujydu0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29-12-2019 15:06, Thierry Reding wrote:
> On Fri, Dec 27, 2019 at 12:09:22PM +0530, Nagarjuna Kristam wrote:
>> On 19-12-2019 18:56, Thierry Reding wrote:
>>> On Wed, Dec 18, 2019 at 02:46:16PM +0530, Nagarjuna Kristam wrote:
> [...]
>>>> @@ -551,11 +556,42 @@ static const char *const modes[] = {
>>>>    	[USB_DR_MODE_OTG] = "otg",
>>>>    };
>>>> +static int tegra_xusb_role_sw_set(struct device *dev, enum usb_role role)
>>>> +{
>>>> +	dev_dbg(dev, "%s calling notifier for role is %d\n", __func__, role);
>>> I don't understand what "for role is %d" means here. I think perhaps you
>>> meant to simply say "for role %d"? Also, perhaps add parentheses after
>>> the "%s" to clarify that you're referring to a function.
>>>
>> Yes, intention is to print role, Will update as mentioned "for role %d"
> It might be better to print the name of the role here because I suspect
> very few people know the value of the role defines without looking them
> up. I thought there was already a function to return the role name for
> a given enum usb_role, but it seems like we only have name -> enum
> conversion. Might be worth adding that, but doesn't have to be as part
> of this series.
> 
> Thierry

Will add a structure to define strings for roles enums, similar to modes
usage in this driver.

-Nagarjuna
