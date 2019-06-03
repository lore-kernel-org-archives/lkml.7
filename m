Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963AAC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A28A274B9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfFCRED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:04:03 -0400
Received: from foss.arm.com ([217.140.101.70]:55974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfFCREB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:04:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F8980D;
        Mon,  3 Jun 2019 10:04:01 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694F53F5AF;
        Mon,  3 Jun 2019 10:04:00 -0700 (PDT)
Subject: Re: [RFC PATCH 02/57] drivers: ipmi: Drop device reference
To:     minyard@acm.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, arnd@arndb.de
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-3-git-send-email-suzuki.poulose@arm.com>
 <20190603170125.GM2742@minyard.net>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f1278aea-9992-f9de-95a8-487aae1d36da@arm.com>
Date:   Mon, 3 Jun 2019 18:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603170125.GM2742@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 03/06/2019 18:01, Corey Minyard wrote:
> On Mon, Jun 03, 2019 at 04:49:28PM +0100, Suzuki K Poulose wrote:
>> Drop the reference to a device found via bus_find_device()
> 
> This change is correct, but it probably doesn't belong in this
> series.  Would you like me to take it as a stand-alone change?
> 

Sure, please go ahead and I can drop it.

Thanks
Suzuki
