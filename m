Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B801C28CC1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91A922CD2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfE2Nv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:51:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE2Nv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:51:27 -0400
Received: from [207.225.69.115] (helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hVyzD-0003i8-Nl; Wed, 29 May 2019 15:51:24 +0200
Date:   Wed, 29 May 2019 06:51:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
In-Reply-To: <20190529131300.GV3274@piout.net>
Message-ID: <alpine.DEB.2.21.1905290645490.2940@nanos.tec.linutronix.de>
References: <20190521133257.GA21471@kroah.com> <20190529131300.GV3274@piout.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre,

On Wed, 29 May 2019, Alexandre Belloni wrote:

> Hello,
> 
> On 21/05/2019 15:32:57+0200, Greg KH wrote:
> >   - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
> 
> I'm very confused by those two tags because they are not mentioned in
> the SPDX 2.1 specification or the kernel documentation and seem to just
> be from https://spdx.org/ids-howi which doesn't seem to be versionned
> anywhere.

  https://spdx.org/licenses/

is versioned. It's at version 3.5 and the -only/-or-later tags have been
introduced in version 3.0. See 

  https://spdx.org/licenses/GPL-2.0

> While I understand the rationale behind those, I believe the correct way
> of introducing them would be first to add them in the spec and
> documentation and then make use of them.

Well, the problem was that people started to use them and argued that they
are the new standard, which is true. So we decided to allow both. See:

  9376ff9ba298 ("LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid identifiers")

> Now, what should we do with all the GPL-2.0 and GPL-2.0+ tags that we
> have?

Nothing. Leave them alone. Both are valid and tools have to deal with them
anyway.

Thanks,

	tglx
