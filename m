Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2FC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B6D218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfDYHTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:19:11 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:33541 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfDYHTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:19:11 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JYevhQJ7SZVjxJYeyhdeWd; Thu, 25 Apr 2019 09:19:09 +0200
Subject: Re: [PATCH v2 3/4] media: dt-bindings: aspeed-video: Add missing
 memory-region property
To:     Rob Herring <robh@kernel.org>, Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org
References: <1556119020-7609-1-git-send-email-eajames@linux.ibm.com>
 <1556119020-7609-4-git-send-email-eajames@linux.ibm.com>
 <20190424211732.GA18914@bogus>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <6a8601d6-ad30-132c-f47a-adc3b4d39958@xs4all.nl>
Date:   Thu, 25 Apr 2019 09:19:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190424211732.GA18914@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCtoo9rYKWTgylJx6KmzVfVLqTrto/bB6UeLKqHf9zL8ZzPwCid3pO9BmHnAPlED9zWODgDhOQAOrc+aEN8Z6jx0OYDr8BptTz7gjDTFN79VpD0v5ecM
 HRQnOk0lHl4CSyM0drczI7olrrZNz5p01lOsCmhI0gEY+40w+BmUmXzhqnN8L3hE1v+T9WAO8V+GHWngqT+9AHvTCLQXx1n0Tz1DKCawMWz9IK7oW0Du/vuk
 06uIjqJnQJzE38u4cPJfUWEUS7wLkxEa5ep5Yqpb/LLKeHt7qgh98UXZ4oUAVL1hiZ0R6vbpVn7rN9zuy6DAm7jEU8PGDqpauoAFyYSSqwZ+riTVHXwpFMkQ
 RAROPyOSTUmTZ3jcCHgQ/Jss7HB8GJh8dkuTgKyz7JrV3LEhatR+qAuN4lxPLV7UdI4Uu2dVSphUR/Jn2uXp3Y0s4SPoRPuf+UdAvl5TrjgsnjgLYtJKGD/R
 BbR32C0+Gskl3iZ4GmYhzMaAZ8hmjYGM7WStsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 11:17 PM, Rob Herring wrote:
> On Wed, 24 Apr 2019 10:16:59 -0500, Eddie James wrote:
>> Missed documenting this property in the initial commit.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>> Changes since v1:
>>  - Add missing semi-colon
>>
>>  Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 

I noticed the same when I was processing this patch. I've added back your
'Reviewed-by' tag.

So there is no need to repost, Eddie. Just remember this for the next
time :-)

Regards,

	Hans
