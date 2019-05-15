Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5937AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8052084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfEOJxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:53:07 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:53:06 -0400
Received: from [192.168.178.167] ([109.104.37.15]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MpDa5-1gtz4V2OlD-00qm1F; Wed, 15 May 2019 11:52:44 +0200
Subject: Re: [PATCH v3 1/4] staging: vchiq_2835_arm: revert "quit using custom
 down_interruptible()"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org
References: <20190509143137.31254-1-nsaenzjulienne@suse.de>
 <20190509143137.31254-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <32aa420a-abff-4c47-5f3c-2d4bdf36781c@i2se.com>
Date:   Wed, 15 May 2019 11:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509143137.31254-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:+2mE9d+u8gqtHxlIg9i/VWYK0DwNnPyY/oJuxZ3r/F7A3KhK9W5
 cCp7pwbA9bAjNpdxlK6/Iep9THU4dI6RvjpdTDtzvJY+58aqLLldc5xNr7PRhB9I86LmFKN
 LHCh1pkG91gS0EVAN2BnJ5cvewcs0PU/OIpW0n1Eae5noiidxp3qdh90d/vDYFuHLjNHC2p
 5n6T2maOg8eOxqC5nOgqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bG040yyGSrk=:IY/R0MsMaeOXHWlVqHUCLc
 Ab49FrqKWtQHzDyX1FqJXOxL8lqsOL0kN/Y7NCGyy8+UDEn/Am61+iCMA0wT25byRrvMZxD2p
 Vdv/l8YCNQDMTY3cR1Vx+Y34raHgM1CDYeX0+1f098O7ylSHTobIWa1TKpEr6LL3ahmbnWUq8
 gwEGuFTHCizj4BS3/LLXXoE8ytB/8sUiClJ1kvU2XzoTt1dBWz4EJjbNGe2AnHdzFm/EUaB5T
 zTnG4gedNErS7PNnwC6UeWBBzWoE0f1sV/gxR2ZvC//QkS1yBCCYO7xVe7NHMvWlSs0NG/Lpv
 VT230YoyV8WIPQ+XzCwa9CTFxZ4wv9T/zwWQMUXQ5WJBiiYzLnpJ2exZqNjoVg39Idhurb4nt
 4QPzCQRzXzk05ChMqk8eS3UBtQAAkXfsYqZjbtkDF8uRuZmTPxhysvyu3f3CE7C57TM91KaUh
 Ev/B9krLUayURXbRJo8Bb50/jZthCLjM9Yxh4VHdArHeLEamadd032nzfYRggpArjkgcunPWU
 kYxLOG0Ti7QvDTP5J+GXzOF1V2L7CNwLbaPmQFF7VkgoK6onYMdyAGxy4+QzNoBAwQcRks1Mi
 /v3xLzwun1zn6WmY5yJRkrN+N7lWDNMVewFUh1lBdzBoSesiu6JnkcDPhwZwwPyRo7ecJArOZ
 ErYlDk3nTR7aqj517fCWQc3kgy7rHVH7Biqw8C8BcnlvSLapFGn1BXacH39mT+nvq/tZ/D0Vb
 yPNUa4PHCrXh5aVABT/y2Zan8pMr8fOHC7NXYqcY4lGd7EYk3stnmXIQ+5A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 16:31, Nicolas Saenz Julienne wrote:
> The killable version of down() is meant to be used on situations where
> it should not fail at all costs, but still have the convenience of being
> able to kill it if really necessary. VCHIQ doesn't fit this criteria, as
> it's mainly used as an interface to V4L2 and ALSA devices.
>
> Fixes: ff5979ad8636 ("staging: vchiq_2835_arm: quit using custom down_interruptible()")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

This whole series is:

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

