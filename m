Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43313C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F4320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfFMPHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:07:25 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:48888 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbfFMPHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:07:17 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 0F8B73C00C6;
        Thu, 13 Jun 2019 16:57:50 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yUx7f7DGOYhW; Thu, 13 Jun 2019 16:57:44 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 80FA73C00BE;
        Thu, 13 Jun 2019 16:57:44 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 13 Jun
 2019 16:57:44 +0200
Date:   Thu, 13 Jun 2019 16:57:41 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Jonas Stenvall <jonas.stenvall.umea@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <vladimir_zapolskiy@mentor.com>, <joshua_frkuska@mentor.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Subject: Re: [PATCH] usb: gadget: u_audio: Fixed variable declaration coding
 style issue
Message-ID: <20190613145741.GA30884@vmlxhi-102.adit-jv.com>
References: <20190613093433.GA3878@ub1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190613093433.GA3878@ub1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

On Thu, Jun 13, 2019 at 11:34:33AM +0200, Jonas Stenvall wrote:
> Fixed a coding style issue, replacing unsigned with unsigned int.

No concerns on my side. FWIW, the 'bare use of unsigned' coding style
inconsistency is quite common in the USB gadget framework [1-2].

Depending on the feedback from the maintainers, I see below potential
outcomes for this patch (sorted by my personal estimation of chance):
 - we take it and we fix the rest on best-effort basis.
 - we kindly ask you to fix the issue globally in USB gadget space.
 - we don't care, as this is not a functional issue. We rather prefer to
   concentrate on functional problems.

Deciding on the above is a matter of maintainer's preference.

> 
> Signed-off-by: Jonas Stenvall <jonas.stenvall.umea@gmail.com>
> ---
>  drivers/usb/gadget/function/u_audio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

From my end:

Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>

[1] git grep -E "unsigned [^(int|short|char|long)]" -- drivers/usb/gadget/function | wc -l
32
[2] git grep -E "unsigned [^(int|short|char|long)]" -- drivers/usb/gadget | wc -l                    
99

-- 
Best Regards,
Eugeniu.
