Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CE1C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E859206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfKKPAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:00:21 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:50227 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:00:20 -0500
Received: from [192.168.0.108] (223.167.21.236) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 11 Nov
 2019 23:00:39 +0800
Subject: Re: [PATCH v4 3/4] soc: amlogic: Add support for Secure power domains
 controller
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-amlogic@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
References: <1572868028-73076-1-git-send-email-jianxin.pan@amlogic.com>
 <1572868028-73076-4-git-send-email-jianxin.pan@amlogic.com>
 <7hmud4stfo.fsf@baylibre.com>
 <57b9c706-c341-c7cf-698a-66335b34442b@amlogic.com>
 <7h36eucw1u.fsf@baylibre.com>
From:   Jianxin Pan <jianxin.pan@amlogic.com>
Message-ID: <8e227a22-97af-fbdf-945f-f99b12d736c2@amlogic.com>
Date:   Mon, 11 Nov 2019 23:00:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <7h36eucw1u.fsf@baylibre.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [223.167.21.236]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2019/11/11 22:44, Kevin Hilman wrote:
> Hi Jianxin,
> 
> Jianxin Pan <jianxin.pan@amlogic.com> writes:
> 
> [...]
> 
>>>> +	SEC_PD(RAMB,	GENPD_FLAG_ALWAYS_ON),
>>>> +	SEC_PD(IR,	0),
>>>> +	SEC_PD(SPICC,	0),
>>>> +	SEC_PD(SPIFC,	0),
>>>> +	SEC_PD(USB,	0),
>>>> +	/* NIC is for NIC400, and should be always on */
>>>
>>> Why?
>>>
>> NIC domain is for ARM CoreLink NIC-400 Network Interconnect, and should be always on since bootloader.
> 
> OK, makes sense.  I suggest a minor change to the comment to remind that
> this is an interconnect:
> 
>    /* NIC is for the Arm NIC-400 interconnect, and should be always on */
> 
OK, I will update it, and thanks for the advice.
> Thanks,
> 
> Kevin
> 
> .
> 

