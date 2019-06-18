Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCA9C46477
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5920863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O4i7eAzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfFRXGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53998 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfFRXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UeGvfOSgh0lmIfsrQ9r/naqdVM5Ysl4qpJE0tYJsMho=; b=O4i7eAzfxTQyBaQPayFivDhE+d
        jhaxbVYb7sfwhDqakONp4icdY9cyK6BaK9LUVlfnsEr9dsCKSoqRpwNxAvVQ9jaDnohmdCXdqeDUl
        9hH0pRnRFoD0Q9y79cDWmullmowJnP2ygN70x371aJPiCvPxqoE53F7G/XPlVfBJX1XbKjMsGZwN1
        dwfN+4PBZJ2eOHo9/+9bWTO4OSVEEF6UrZfS5VhEGD9i82OmsbW1f0fAlzKAAMJeeHjOO4xfRSQm+
        vqDp45A0e8817rLg4LnbA2EywlHV66rUAMcgtojPz/JQFD2npP8tsIYPKwyz4pXshG7RI0W4tBDQR
        XZWL+6nw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdNAv-0002qo-AR; Tue, 18 Jun 2019 23:06:01 +0000
Subject: Re: [PATCH RFC 2/3] fonts: Use BUILD_BUG_ON() for checking empty font
 table
To:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190618203425.10723-1-tiwai@suse.de>
 <20190618203425.10723-3-tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <896583b9-3231-9e31-e51b-c76b889db85b@infradead.org>
Date:   Tue, 18 Jun 2019 16:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618203425.10723-3-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/19 1:34 PM, Takashi Iwai wrote:
> We have a nice macro, and the check of emptiness of the font table can
> be done in a simpler way.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Hi,

Looks good to me.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Also, would you mind adding TER16x32 to Documentation/fb/fbcon.rst, here:
(AFAIK that would be appropriate.)

1. fbcon=font:<name>

	Select the initial font to use. The value 'name' can be any of the
	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.

> ---
>  lib/fonts/fonts.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Thanks.
-- 
~Randy
