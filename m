Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6452C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB852808C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfFCKMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:12:09 -0400
Received: from foss.arm.com ([217.140.101.70]:48190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfFCKMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:12:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6F5F374;
        Mon,  3 Jun 2019 03:12:08 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 047593F5AF;
        Mon,  3 Jun 2019 03:12:07 -0700 (PDT)
Subject: Re: [PATCH v4 26/30] coresight: Use platform agnostic names
To:     mike.leach@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org
References: <1558521304-27469-1-git-send-email-suzuki.poulose@arm.com>
 <1558521304-27469-27-git-send-email-suzuki.poulose@arm.com>
 <CAJ9a7VhwHeN5uSEwDhLVR=CL=vgCfKHtWZ3o8NnLnxw_=mYBOg@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <80e9fc21-cf1b-4118-52d5-7268f5470d1c@arm.com>
Date:   Mon, 3 Jun 2019 11:12:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VhwHeN5uSEwDhLVR=CL=vgCfKHtWZ3o8NnLnxw_=mYBOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 29/05/2019 10:32, Mike Leach wrote:
> Hi,
> 
> Why am I not seeing references to coresight-cpu-debug in here? In
> other places in this patchset CPU debug has been changed, but there
> appears to be no platform agnostic name here, nor any ACPI type name
> either. Is cpu-debug remaining device tree only? Should CPU debug not
> be treated like ETM and get a cpu centric name?

Thats because they are not registered as coresight devices and thus do
not appear on the CoreSight bus under /sys/bus/coresight/. This set is
only tuning the "coresight" device names, linked to the real amba device.

Cheers
Suzuki
