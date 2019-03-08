Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F692C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D8C20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCHN0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:26:15 -0500
Received: from verein.lst.de ([213.95.11.211]:53833 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfCHN0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:26:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5085E68C4E; Fri,  8 Mar 2019 14:26:09 +0100 (CET)
Date:   Fri, 8 Mar 2019 14:26:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
Message-ID: <20190308132608.GB18218@lst.de>
References: <20190221182234.22345-1-jthumshirn@suse.de> <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com> <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de> <71982410-d373-a659-0c0f-8aadf06d1d96@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71982410-d373-a659-0c0f-8aadf06d1d96@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 01:18:10PM -0800, Sagi Grimberg wrote:
>
>> Frankly, we have a ton of testing related special cases in the kernel.
>>
>> This one is a) simple and small, only 10 LoC, b) far away from the fast
>> path or any other place where it could have any impact on legitimate
>> users and c) it prints an informal message showing you what happened.
>>
>> Sorry but this is a https://xkcd.com/386/ moment.
>
> How about we just fail it with a proper error message and let the
> user set buffered_io instead of trying to get smart here...

Yes, would be my preference.
