Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75400C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59623BF6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfE2PVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:21:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:29774 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:21:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 08:21:04 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga008.fm.intel.com with ESMTP; 29 May 2019 08:21:03 -0700
Subject: Re: [PATCHv4 3/4] firmware: rsu: document sysfs interface
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-4-git-send-email-richard.gong@linux.intel.com>
 <20190528231908.GB28886@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <273db79b-97bb-f40c-3dee-fe48633c3edd@linux.intel.com>
Date:   Wed, 29 May 2019 10:33:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528231908.GB28886@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 5/28/19 6:19 PM, Greg KH wrote:
> On Tue, May 28, 2019 at 03:20:32PM -0500, richard.gong@linux.intel.com wrote:
>> +What:		/sys/devices/.../stratix10-rsu.0/driver/fail_image
>> +Date:		May 2019
>> +KernelVersion:	5.3
>> +Contact:	Richard Gong <richard.gong@intel.com>
>> +Description:
>> +		(RO) the version number of RSU firmware.
> 
> "fail_image" is the version number?  That doesn't match up with what the
> code says :(
> 
> What happened to the version sysfs file?
> 

Sorry, my typo.

It should be /sys/devices/.../stratix10-rsu.0/driver/version, (RO) the 
version number of RSU firmware.

I will correct that in the next submission.

> thanks,
> 
> greg k-h
> 
Regards,
Richard
