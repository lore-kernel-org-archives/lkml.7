Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9419C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA7420656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfF1E6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:58:53 -0400
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:56084 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1E6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:58:53 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jun 2019 00:58:51 EDT
X-IronPort-AV: E=Sophos;i="5.63,426,1557176400"; 
   d="scan'208";a="223942606"
Subject: Re: [PATCH v4 0/2] Use NVMEM as reboot-mode write interface
To:     Sebastian Reichel <sre@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20190515104658.25535-1-nandor.han@vaisala.com>
 <20190627183330.aole6zumw3l2vyet@earth.universe>
From:   Nandor Han <nandor.han@vaisala.com>
Message-ID: <75db3e6e-cf95-cdd0-7446-380a686992d2@vaisala.com>
Date:   Fri, 28 Jun 2019 07:49:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190627183330.aole6zumw3l2vyet@earth.universe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2019 04:49:11.0053 (UTC) FILETIME=[D3CE53D0:01D52D6C]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> Changes since v3:
>> ----------------
>>   - documentation updated according to the comments
> 
> Thanks, queued. Please fix your git/mail setup, I had to fix the
> line endings (\r\n -> \n) to apply this.
> 
> -- Sebastian
> 

Ok. Thanks Sebastian.

--
Nandor
