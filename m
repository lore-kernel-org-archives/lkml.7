Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB5C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B70F218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfGCIle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:41:34 -0400
Received: from foss.arm.com ([217.140.110.172]:41344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbfGCIle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:41:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6D0D344;
        Wed,  3 Jul 2019 01:41:33 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B4C93F718;
        Wed,  3 Jul 2019 01:41:32 -0700 (PDT)
Subject: Re: linux-next: manual merge of the char-misc tree with the
 driver-core tree
To:     sfr@canb.auug.org.au, mst@redhat.com, greg@kroah.com
Cc:     joro@8bytes.org, Jean-Philippe.Brucker@arm.com,
        natechancellor@gmail.com, arnd@arndb.de,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org
References: <20190701190940.7f23ac15@canb.auug.org.au>
 <20190701200418.GA72724@archlinux-epyc>
 <20190702141803.GA13685@ostrya.localdomain>
 <20190702151817.GD3310@8bytes.org>
 <20190702112125-mutt-send-email-mst@kernel.org>
 <20190702155851.GF3310@8bytes.org>
 <20190702130511-mutt-send-email-mst@kernel.org>
 <20190703074109.4b2ca5bc@canb.auug.org.au>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7b1b518b-1ca6-3650-a6ed-c2f63859a160@arm.com>
Date:   Wed, 3 Jul 2019 09:41:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190703074109.4b2ca5bc@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Stephen, All,

On 02/07/2019 22:41, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 2 Jul 2019 13:05:59 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>> On Tue, Jul 02, 2019 at 05:58:51PM +0200, Joerg Roedel wrote:
>>> On Tue, Jul 02, 2019 at 11:23:34AM -0400, Michael S. Tsirkin wrote:
>>>> I can drop virtio iommu from my tree. Where's yours? I'd like to take a
>>>> last look and send an ack.
>>>
>>> It is not in my tree yet, because I was waiting for your ack on the
>>> patches wrt. the spec.
>>>
>>> Given that the merge window is pretty close I can't promise to take it
>>> into my tree for v5.3 when you ack it, so if it should go upstream this
>>> time its better to keep it in your tree.
>>
>> Hmm. But then the merge build fails. I guess I will have to include the
>> patch in the pull request then?
>>
> 
> All you (and the driver-core maintainer) need to do is make sure you
> tell Linus that the merge requires the fix ... he can then apply it to
> the merge commit just as I have.  Linus has asked that maintainers do
> not (in general) cross merge to avoid these (semantic) conflicts.
> Sometimes, in more complex cases, it may be necessary for maintainers
> to share a (non changing) subset of their trees, but this case is
> pretty trivial.
> 

Please let me know if there is something I could help with.

Cheers
Suzuki
