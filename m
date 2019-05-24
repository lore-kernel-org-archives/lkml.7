Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF9DC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0454B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 00:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfEXAMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 20:12:44 -0400
Received: from mx.allycomm.com ([138.68.30.55]:47689 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfEXAMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 20:12:43 -0400
Received: from jkletsky-mbp15.guidewire.com (inet.guidewire.com [199.91.42.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id E376D3D38F;
        Thu, 23 May 2019 17:12:41 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190522220555.11626-1-lede@allycomm.com>
 <20190522220555.11626-4-lede@allycomm.com>
 <e438022f-3444-9aae-adac-2dd3dd0071b7@kontron.de>
From:   Jeff Kletsky <lede@allycomm.com>
Message-ID: <e0682730-b69d-d774-d98f-53858e390d8b@allycomm.com>
Date:   Thu, 23 May 2019 17:12:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e438022f-3444-9aae-adac-2dd3dd0071b7@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(reduced direct addressees, though still on lists)

On 5/22/19 11:42 PM, Schrempf Frieder wrote:

> On 23.05.19 00:05, Jeff Kletsky wrote:
>> From: Jeff Kletsky <git-commits@allycomm.com>
>>
>> The GigaDevice GD5F1GQ4UFxxG SPI NAND is in current production devices
>> and, while it has the same logical layout as the E-series devices,
>> it differs in the SPI interfacing in significant ways.
>>
>> This support is contingent on previous commits to:
>>
>>     * Add support for two-byte device IDs
>>     * Define macros for page-read ops with three-byte addresses
>>
>> http://www.gigadevice.com/datasheet/gd5f1gq4xfxxg/
>>
>> Signed-off-by: Jeff Kletsky <git-commits@allycomm.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>> Reported-by: kbuild test robot <lkp@intel.com>
> I dont't think that this Reported-by tag should be used here. The bot
> reported build errors caused by your patch and you fixed it in a new
> version. As far as I understand this tag, it references someone who
> reported a flaw/bug that led to this change in the first place.
> The version history of the changes won't be visible in the git history
> later, but the tag will be and would be rather confusing.

Thank you for your patience and explanations. I've been being conservative
as I'm not a "seasoned, Linux professional" and am still getting my
git send-email config / command line for Linux properly straightened out.

Should I send another patch set with the `kbuild...` tag removed,
or would it be removed in the process of an appropriate member
of the Linux MTD team adding their tag for approval, if and when
that happens?

Jeff

