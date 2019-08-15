Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC5C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1742086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565878278;
	bh=MK9pYDd/pRkYq15ySrVY/G8VYSCibcH28hj42sQPutU=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pQd4jP9kEW6igg8qkaO7UPdZV6adclAWSSx6lFsrO39IpWmBQd+oEoIlsHoaQLUH9
	 b8R58r+MbtH646W5G7NUj3K53a7M7jb6NqBTLK56P0V27WuTRo2hFQjRL1EnsVmgQE
	 BhRpKvGMRUWsNC5PNsCKkx3IrpUQSXgU/t91+Txc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbfHOOLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732784AbfHOOLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:11:17 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5C9206C2;
        Thu, 15 Aug 2019 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565878276;
        bh=MK9pYDd/pRkYq15ySrVY/G8VYSCibcH28hj42sQPutU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fh7wLHe55Sx3SEiOAYQq+MSIm3VGalOMrHqD3ygCTAbH4q/zL0T56AuRKRALpbgNS
         q3e5qT3Ea8YMS6i7l1+8NivtOIPInIEc4reypEwATXJgIpDbyUsqEKGPuZIKfpO/D3
         YNoxxDWFDE9fgpaVrDbXnbAaUm+JHJYBq8MbZesI=
Subject: Re: [PATCH v5 0/2] usbip: Implement SG support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Suwan Kim <suwan.kim027@gmail.com>, valentina.manea.m@gmail.com,
        stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190814131951.GA1437@infradead.org> <20190815132356.GB27208@kroah.com>
From:   shuah <shuah@kernel.org>
Message-ID: <0cf92881-53c7-09d4-18ac-593034a1a56c@kernel.org>
Date:   Thu, 15 Aug 2019 08:10:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815132356.GB27208@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 7:23 AM, Greg KH wrote:
> On Wed, Aug 14, 2019 at 06:19:51AM -0700, Christoph Hellwig wrote:
>> FYI, I think my
>>
>>     "usb: add a HCD_DMA flag instead of guestimating DMA capabilities"
>>
>> is the proper core fix for what your patch 1 works around, as the USB
>> core should not assume DMA capabilities based on the presence of a DMA
>> mask.
> 
> I agree.  Let's wait for Christoph's series to be applied before taking
> this one.
> 

Great. Thanks you both looking at these. Makes sense.

thanks,
-- Shuah

