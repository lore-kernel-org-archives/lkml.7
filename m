Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5868CC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 14:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593B20673
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 14:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF3OMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 10:12:48 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:54360 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbfF3OMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 10:12:48 -0400
Received: from [192.168.2.27] (p4FF11F7C.dip0.t-ipconnect.de [79.241.31.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id E33431F435;
        Sun, 30 Jun 2019 16:12:44 +0200 (CEST)
Subject: Re: [PATCH 1/2] staging: rts5208: Rewrite redundant if statement to
 improve code style
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Sabrina Gaube <sabrina-gaube@web.de>,
        linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de
References: <20190626142857.30155-1-tobias.niessen@stud.uni-hannover.de>
 <20190626142857.30155-2-tobias.niessen@stud.uni-hannover.de>
 <20190626145636.GG28859@kadam>
From:   =?UTF-8?Q?Tobias_Nie=c3=9fen?= 
        <tobias.niessen@stud.uni-hannover.de>
Message-ID: <a0f3ac8b-541a-d3d0-e25e-26da11e29748@stud.uni-hannover.de>
Date:   Sun, 30 Jun 2019 16:12:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626145636.GG28859@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.06.2019 um 16:56 schrieb Dan Carpenter:
> Both these patches seem fine.
> 
> On Wed, Jun 26, 2019 at 04:28:56PM +0200, Tobias Nießen wrote:
>> This commit uses the fact that
>>
>>     if (a) {
>>             if (b) {
>>                     ...
>>             }
>>     }
>>
>> can instead be written as
>>
>>     if (a && b) {
>>             ...
>>     }
>>
>> without any change in behavior, allowing to decrease the indentation
>> of the contained code block and thus reducing the average line length.
>>
>> Signed-off-by: Tobias Nießen <tobias.niessen@stud.uni-hannover.de>
>> Signed-off-by: Sabrina Gaube <sabrina-gaube@web.de>
> 
> Signed-off-by is like signing a legal document that you didn't put any
> of SCO's secret UNIXWARE source code into your patch or do other illegal
> activities.  Everyone who handles a patch is supposed to Sign it.
> 
> It's weird to see Sabrina randomly signing your patches.  Probably there
> is a more appropriate kind of tag to use as well or instead such as
> Co-Developed-by, Reviewed-by or Suggested-by.
> 
> regards,
> dan carpenter
> 

Thank you, Dan. This patch series is a mandatory part of a course Sabrina and I are taking at university. We were told to add Signed-off-by for both of us. I can add Co-Developed-by if that helps? Or should she just verify via email that she did indeed sign off?

Regards,
Tobias
