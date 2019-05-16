Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF41C04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C520843
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557971273;
	bh=2v+hlEz/yrmGYADv91bHYZMB1uhZ4XHGf9OpJ+kHSJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0SWNBdBv9oTxsj0B11Hh5AglKuSryjCXJAuxyFdcZBpzz6TE9kU+fB4T8YIlnU399
	 tJ8V/KFvH2u9W6FAjIbBkcisX4L3svQY1vZDuQfhSHo40VgHmCX9PjCAxCE+8UlCFI
	 jqhfI7TYQND2RNXYdhD3bIO3W1DfD2tc/e+VNBtI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEPBq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfEPAjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:39:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE5520862;
        Thu, 16 May 2019 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557967156;
        bh=2v+hlEz/yrmGYADv91bHYZMB1uhZ4XHGf9OpJ+kHSJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SbtJXvxEW5/VqzC0HtrSaKnuTfuPa/fPogImNgBG+dvzZyeuLYshz2VS46g8TFfX4
         M7NSCTX+KskYow+a0t8vVqxHnZapUIFXEyVKsNUSs69jAGa01kzWonTi2XajvGcU6r
         St3gobMd0Cdce3HqiqwXt56tofaSzL4szr/vOXbA=
Date:   Wed, 15 May 2019 20:39:15 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Tim Bird <tbird20d@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>,
        Eliska Slobodova <eslobodo@redhat.com>,
        Tim Bird <tim.bird@sony.com>
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190516003915.GT11972@sasha-vm>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <199564879.15267174.1556199472004.JavaMail.zimbra@redhat.com>
 <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+bK7J7tHOkz5KMVHpaV1x_dy6X6A7gtxcBYXJO8jj98qvWETw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:02:53PM -0700, Tim Bird wrote:
>I'm in the process now of planning Automated Testing Summit 2019,
>which is tentatively planned for Lyon, France on October 31.  This is
>the day after Embedded Linux Conference Europe and Open Source Summit
>Europe, in Lyon.  I've been working with the
>Linux Foundation event staff to set this up.
>
>The focus of that event is test standards, including standards for
>test definition, results formats, lab and board management, and APIs
>between elements of the Automated Testing and CI stack.
>
>I think that the set of things to discuss is somewhat different
>between the Plumbers testing microconference and ATS.  But I hope that
>I'm not fragmenting the space too much.
>
>With regards to the Testing microconference at Plumbers, I would like
>to do a presentation on the current status of test standards and test
>framework interoperability.  We recently had some good meetings
>between the LAVA and Fuego people at Linaro Connect
>on this topic.

Hi Tim,

Sorry for the delayed response, this mail got marked as read as a result
of fat fingers :(

I'd want to avoid having an 'overview' talk as part of the MC. We have
quite a few discussion topics this year and in the spirit of LPC I'd
prefer to avoid presentations.

Maybe it's more appropriate for the refereed track?

--
Thanks,
Sasha
