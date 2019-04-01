Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06E12070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Kr2gi4Um"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfDAVnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:43:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36771 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfDAVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:43:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so5427714pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mmqtOMVvscb+HQxFUwrIPhKliYEQlR+drfZoUODE5cw=;
        b=Kr2gi4UmPseexza2lNrI5lAWb6eeHVzrzpiPdNzyxivyINGumWHm//CwtR9udn8zDV
         hckm1c38RnVwrch2jSpFJqQ4VLUcrY4aPi5M6bky5Lvw47MRuCcx3QyQ29uQUE3y7mn6
         VojRcDbw3KuFEYLRix5qNM84Hg0WTrcaPBkyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mmqtOMVvscb+HQxFUwrIPhKliYEQlR+drfZoUODE5cw=;
        b=CmXBpsbojMyX5Hb4waJiqNZ84171ERgrWXZCAqqo67dJvjbB2Y7D7gv54RrF3GftFt
         DLQO/V7frD558HKloRFgCdPjd9J+BosSJV26rV1/PcQcgUQmIV3qoMhgW3m8dHODVbsc
         CqnK+IeEbpTKxB54Lb7KGH79tQrD9qKXyCHye1/yTAgGO1585okRL0LmRWUCGk6WoQwT
         O1FmFuqcIF8Y2NzdpsSTf2pAlE1ETK1SBj9TKEKPCniQD6JtsX0doZN/1nPReLWwqPn8
         8FJQbWrn85soAWWzc4/HJAdW2V6kocL+P0refNsSJRWM645MwwlSsyJ+rwhxcAa8QfS4
         Y+EQ==
X-Gm-Message-State: APjAAAU++2uX2NYgn58EAvb86epEqYSFpFzVy7FOGjKf011n8HRsYvTf
        fXen5saWYrVSgHPUtAWrpKlBDjzkxP95PA==
X-Google-Smtp-Source: APXvYqxVksZDeqtoKHcY5c1W3H+yaf2/gWs21lQ6Y+aA10s7/9HUYc7h3/a8RF7sQ9REgBB8UX8xMQ==
X-Received: by 2002:a65:6289:: with SMTP id f9mr50765840pgv.380.1554155002556;
        Mon, 01 Apr 2019 14:43:22 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q81sm19895229pfi.102.2019.04.01.14.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:43:21 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c"
 compatible string
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190214175725.60462-7-ray.jui@broadcom.com> <20190327222439.GC15396@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <0b97cacd-9bf4-135a-b2ee-1d51ab380b1c@broadcom.com>
Date:   Mon, 1 Apr 2019 14:43:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327222439.GC15396@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 3/27/2019 3:24 PM, Wolfram Sang wrote:
> 
>> Update iProc I2C binding document to add new compatible string
>> "brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
>> also added that allows configuration of the host view into the APE's
>> address for "brcm,iproc-nic-i2c"
> 
> I don't know the platform, but wouldn't it be more DT-like to describe
> the APE in DT and derive the mask from that information? Custom bindings
> with values which are directly poked into a register usually raise my
> eyebrow.
> 

Note APE is a co-processor that is not visible from the Linux running
from the host processor.

"brcm,iproc-nic-i2c" here is introduced to allow the I2C port from APE
to be completely owned by the host CPU, to meet the requirement of
certain use cases. At the same time, the control of the I2C port from
APE will be disabled.

The "brcm,ape-hsls-addr-mask" defines the address translation and be
programmed into some configuration registers to allow the host to
directly access the I2C registers of APE. Note those configuration
registers are owned by the host, and that address is not APE's address
space nor the host is intending to take over the control of APE.

Therefore, I think it makes way more sense to use an address mask type
of DT property here.

Thanks,

Ray
