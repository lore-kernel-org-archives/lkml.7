Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6B1C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4829023B53
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfE2O77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:59:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:42541 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfE2O77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:59:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 07:59:58 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 29 May 2019 07:59:58 -0700
Subject: Re: [PATCHv4 2/4] firmware: add Intel Stratix10 remote system update
 driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sen.li@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232400.GB29225@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <ac379a9a-9613-3f66-78ff-a38c0045764d@linux.intel.com>
Date:   Wed, 29 May 2019 10:12:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528232400.GB29225@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

On 5/28/19 6:24 PM, Greg KH wrote:
> On Tue, May 28, 2019 at 03:20:31PM -0500, richard.gong@linux.intel.com wrote:
>> +static int rsu_send_msg(struct stratix10_rsu_priv *priv,
>> +			enum stratix10_svc_command_code command,
>> +	unsigned long arg,
>> +	void (*callback)(struct stratix10_svc_client *client,
>> +			 struct stratix10_svc_cb_data *data))
> 
> Odd indentation for arg, and then callback.
> 
> Why isn't callback a typedef to make this simpler to use?
> 

I will make correction in the next submission.

> thanks,
> 
> greg k-h
> 

Regards,
Richard
