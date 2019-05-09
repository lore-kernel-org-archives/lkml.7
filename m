Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A36C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B5621479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557430233;
	bh=cMhmcHQsmM0B/RQs7X2nNWy6VgH04nsWM/mSnlvw/g0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=COKENnmZQUVTGjDpRvT+G+Q5euxH5DVPnGSnSsiPPxEBapcnR/F802K+fn71bgPxh
	 YjmXIQ1LKselv9hod8gk0/U+EL1kyOAtiR1RH7KY26MH6dnVNWWoehJ/MosIVgNNs7
	 nUjq7JU2Y8O8ItY4ztKsvnzq1csHHyJ5bjYUIL9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEITac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEITac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 15:30:32 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A47D21479;
        Thu,  9 May 2019 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557430231;
        bh=cMhmcHQsmM0B/RQs7X2nNWy6VgH04nsWM/mSnlvw/g0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=eAUL01qRqqcbmOGTUH2vQ9YC+Ii0qPHtYrz5AWsN+5vfuc9zDJzkPZ/3ASTU+Kn4C
         R5XsmLF5eyB3Q54heCJPc5cqzWduI+eiwEubBpHB1ufyLAQbz8orLw4aw+oo51krep
         f9OFgtB/jY8/WSncwnn9rr0ovm7RGtrEA/+e/CtE=
Date:   Thu, 9 May 2019 21:30:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Ronald_Tschal=E4r?= <ronald@innovation.ch>
Subject: Re: [PATCH] HID: Increase maximum report size allowed by
 hid_field_extract()
In-Reply-To: <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
Message-ID: <nycvar.YFH.7.76.1905092130010.17054@cbobk.fhfr.pm>
References: <20190308051117.21899-1-kai.heng.feng@canonical.com> <CAO-hwJLDuMZuqKiawnkq3YxL6T9SqNGqQ1Q_Vs=kMKmsx6SD0w@mail.gmail.com> <08CA35F5-1ADC-4C55-ACF5-04B19CC77A25@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019, Kai-Heng Feng wrote:

> >Ronald (Cc-ed) raised quite a good point:
> >what's the benefit of removing the error message if this function (and
> >__extract) can only report an unsigned 32 bits value?
> 
> I didn’t spot this, sorry.
> 
> >
> >My take is we should revert 94a9992f7dbdfb28976b upstream and think at
> >a better solution.
> 
> I think using a new fix to replace it will be a better approach, as it at
> least partially solves the issue.

Guys, did this fall in between cracks? Is anyone planning to send a fixup?

Thanks,

-- 
Jiri Kosina
SUSE Labs

