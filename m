Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA11C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455D420857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfDBJ7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:59:13 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:36269 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfDBJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:59:11 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 05:59:10 EDT
X-IronPort-AV: E=Sophos;i="5.60,300,1549922400"; 
   d="scan'208";a="215525615"
Subject: Re: [RFC PATCH 0/1] Verify if register is writeable before a write
 operation
To:     Mark Brown <broonie@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190402080100.4875-1-nandor.han@vaisala.com>
 <20190402090601.GB2059@sirena.org.uk>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <3bd435a1-e6fa-5165-70e1-17a881423280@vaisala.com>
Date:   Tue, 2 Apr 2019 12:49:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190402090601.GB2059@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2019 09:49:19.0188 (UTC) FILETIME=[578D6940:01D4E939]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 12:06 PM, Mark Brown wrote:
> On Tue, Apr 02, 2019 at 08:01:21AM +0000, Han Nandor wrote:
>> Description
>> -----------
>> This is an RFC because I don't know if this is a bug or a normal use
>> case. It seems that the function `_regmap_raw_write_impl` from the regmap
>> framework verifies that a register is writable only using
>> the callback function, ignoring the other two (max allowed register,
>> register ranges)
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.
> 

Copy that. If is OK, we can still discuss about this using this patch 
and I can send a single patch once the things are clear.
