Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BA0C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F362084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfFSGrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:47:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfFSGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36123AFBE;
        Wed, 19 Jun 2019 06:47:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 45EDE1E4329; Wed, 19 Jun 2019 08:47:11 +0200 (CEST)
Date:   Wed, 19 Jun 2019 08:47:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: Re: [PATCH 1/1] udf: Fix incorrect final NOT_ALLOCATED (hole) extent
 length
Message-ID: <20190619064711.GA27954@quack2.suse.cz>
References: <20190604123158.12741-1-steve@digidescorp.com>
 <20190604123158.12741-2-steve@digidescorp.com>
 <a6275c24-7625-d532-0842-f8b16fea5b30@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6275c24-7625-d532-0842-f8b16fea5b30@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve!

On Sun 16-06-19 11:28:46, Steve Magnani wrote:
> On 6/4/19 7:31 AM, Steve Magnani wrote:
> 
> > In some cases, using the 'truncate' command to extend a UDF file results
> > in a mismatch between the length of the file's extents (specifically, due
> > to incorrect length of the final NOT_ALLOCATED extent) and the information
> > (file) length. The discrepancy can prevent other operating systems
> > (i.e., Windows 10) from opening the file.
> > 
> > Two particular errors have been observed when extending a file:
> > 
> > 1. The final extent is larger than it should be, having been rounded up
> >     to a multiple of the block size.
> > 
> > B. The final extent is shorter than it should be, due to not having
> >     been updated when the file's information length was increased.
> 
> Wondering if you've seen this, or if something got lost in a spam folder.

Sorry for not getting to you earlier. I've seen the patches and they look
reasonable to me. I just wanted to have a one more closer look but last
weeks were rather busy so I didn't get to it. I'll look into it this week.
Thanks a lot for debugging the problem and sending the fixes!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
