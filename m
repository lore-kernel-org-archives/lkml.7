Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DFCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CE82072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRIDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:03:53 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:33136 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfLRIDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:03:53 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C1D6C200AC8;
        Wed, 18 Dec 2019 08:03:51 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 935BD20BAC; Wed, 18 Dec 2019 09:03:47 +0100 (CET)
Date:   Wed, 18 Dec 2019 09:03:47 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     youling 257 <youling257@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] init: unify opening /dev/console as
 stdin/stdout/stderr
Message-ID: <20191218080347.GA324400@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <20191217051751.7998-1-youling257@gmail.com>
 <20191217064254.GB3247@light.dominikbrodowski.net>
 <CAOzgRdZR0bO14fyOk5jLBUkWwgsf7fx41JMQr-Hr6nss1KSmLw@mail.gmail.com>
 <CAHk-=whN00UTq76bDT-WXm72VhttLv8tcchqEkcUoGXt38XXRg@mail.gmail.com>
 <CAOzgRda=q0mBeBx_i8N0VT_a_ud8EVcf9hVC5Y_Oz2sdAdGGLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOzgRda=q0mBeBx_i8N0VT_a_ud8EVcf9hVC5Y_Oz2sdAdGGLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 12:10:08PM +0800, youling 257 wrote:
> only Revert "fs: remove ksys_dup()", not see the warning
> "/system/bin/sh: No controlling tty: open /dev/tty: No such device or
> address."
> 
> yes, "fs: remove ksys_dup()" caused my system/bin/sh problem.
> 
> but test "early init: fix error handling when opening /dev/console",
> still can see "/system/bin/sh: No controlling tty" warning, it not
> solve my problem.

FWIW, I see a similar (seemingly harmless) warning both _before_ and
after my patches, so I am not sure that this is a real regression.

Thanks,
	Dominik
