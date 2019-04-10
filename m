Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A20C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D99420830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbfDJKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:44:08 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:38851 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfDJKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:44:07 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EAi4hXt5niLOmEAi5h6o44; Wed, 10 Apr 2019 12:44:05 +0200
Subject: Re: [PATCH] staging: media: zoran: fix trailing whitespaces
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
References: <20190408043530.21594-1-arthurmoraeslago@gmail.com>
 <20190408065103.GA6095@kadam>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <65b52cdf-740c-6bc5-ef95-781ddd15fd02@xs4all.nl>
Date:   Wed, 10 Apr 2019 12:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190408065103.GA6095@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI311SIw0lUwyxaKIfehUbr6ibBICobx/zk9d+i27rnAFaLJtt5zYKVootN4xYz2qCXKfjlQQ0qhThxzCFmPsXAKB9sd2Fu/X+dsr6uuEQ61zs/ciyqr
 T9O6DnZjOVW7BsjUQE9aMR0IRWlXjWIYJk3kjcpdRlrlKRKifzNze7lsCtmrGC0LRGRiKygaKG/7eyHpVjta3Bbk9Zf9yzSlfNN92dk1EE1h//3l1wkgzBsN
 frxcvGbJK4gek5AnucZDJ9R6YbFxipaAi5647dtNzBDq2ClISnCgL2dmZo5EjugMWPvI4BRtYiWF7iHtrMSnaHXPqHLLCsEoS3BdLh+Mdgs17aO37pWaEsAx
 Wu0I6Vzvqvm+51uhfWfsZsczJuKeIthAoY1gfAfuiz4PFrSXDbyPQ7mLoVBhfcdo3NEKiApNAYrjdg7bAEwygGhE3PO//EmHi5Eiox2Bkfhi0HdMZbyIChH+
 SkdVoB3/gjns/CHNu+FvyIuiMopO+7q+2wDOuiB42tm5nPH5QoDZvZ5Rtv6XqPFzietVYDuYB14+gUVijmjztIXGRDT+dY8uBnaARhF0kH8qbwJuZBXfnoSx
 FKUDSYDvolum2yy3QNhCH4/c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 8:51 AM, Dan Carpenter wrote:
> On Mon, Apr 08, 2019 at 01:35:30AM -0300, Arthur Moraes do Lago wrote:
>> There were several form feeds(^L) in the file, this patch removes them
>> to conform with the coding style.
>>
>> Signed-off-by: Arthur Moraes do Lago <arthurmoraeslago@gmail.com>
>> ---
>>  drivers/staging/media/zoran/videocodec.h | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/staging/media/zoran/videocodec.h b/drivers/staging/media/zoran/videocodec.h
>> index 4946791fce0d..c37c0e4fb624 100644
>> --- a/drivers/staging/media/zoran/videocodec.h
>> +++ b/drivers/staging/media/zoran/videocodec.h
>> @@ -49,7 +49,7 @@
>>     device dependent and vary between MJPEG/MPEG/WAVELET/... devices. (!!!!)
>>     ----------------------------------------------------------------------------
>>  */
>> -
>> +
>>  
> 
> Checkpatch also complains if you have two consecutive blank lines so
> really we should just delete the lines entirely...  But this driver is
> scheduled for deletion in May.  Let's not bother with cleaning it up.
> 
> regards,
> dan carpenter
> 

I will in fact post a pull request to remove this driver today.

Regards,

	Hans
