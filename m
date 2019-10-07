Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E50206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJGLtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:49:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:50965 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfJGLtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:49:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46mzL61NxZz1rM6G;
        Mon,  7 Oct 2019 13:49:49 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46mzL54rHRz1qqkC;
        Mon,  7 Oct 2019 13:49:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id dg3KZtu9NJDS; Mon,  7 Oct 2019 13:49:48 +0200 (CEST)
X-Auth-Info: 9Q8SrRF+8ctDnx+xqQISX2DPn1xOGxTgU3w14/WB3SZr3gofEZcQeLfsxFZGf3TR
Received: from igel.home (ppp-46-244-165-160.dynamic.mnet-online.de [46.244.165.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  7 Oct 2019 13:49:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id F41BB2C0181; Mon,  7 Oct 2019 13:49:47 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Dmitry Goldin <dgoldin@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel\@joelfernandes.org" <joel@joelfernandes.org>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH v2] kheaders: making headers archive reproducible
References: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
X-Yow:  It was a JOKE!!  Get it??  I was receiving messages
 from DAVID LETTERMAN!!  YOW!!
Date:   Mon, 07 Oct 2019 13:49:47 +0200
In-Reply-To: <z4zhwEnRqCVnnV8RYwKbY9H_TEnHePR6grYfw1toELFA-iZidlp3T18y0w35JtWNghJQ3hwL23RrsKXIVJHYiv9wOsqmow33NU6LcHcFWyw=@protonmail.ch>
        (Dmitry Goldin's message of "Fri, 04 Oct 2019 10:40:07 +0000")
Message-ID: <874l0k3hd0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  GEN     kernel/kheaders_data.tar.xz
tar: unrecognized option '--sort=name'
Try `tar --help' or `tar --usage' for more information.
make[2]: *** [kernel/kheaders_data.tar.xz] Error 64
make[1]: *** [kernel] Error 2
make: *** [sub-make] Error 2
$ tar --version
tar (GNU tar) 1.26
Copyright (C) 2011 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by John Gilmore and Jay Fenlason.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
