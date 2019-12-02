Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B2C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7C22146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfLBO34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:29:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:45410 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfLBO34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:29:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 741964FA;
        Mon,  2 Dec 2019 14:29:55 +0000 (UTC)
Date:   Mon, 2 Dec 2019 07:29:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PULL] Documentation for 5.5
Message-ID: <20191202072954.0e00ac92@lwn.net>
In-Reply-To: <20191202001928.GA4146@latitude>
References: <20191126093002.06ece6dd@lwn.net>
        <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
        <20191130171428.6c09f892@lwn.net>
        <20191202001928.GA4146@latitude>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 01:19:28 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> On a somewhat related note: "Documentation: networking: device drivers:
> Remove stray asterisks" was also picked up via the networking tree.
> Perhaps I should have mentioned that when I became aware(?)

Yeah, I'm not quite sure why that happened.  Dave M. suggested I take it
and sent an ack, then it looks like Jeff Kirsher grabbed it as well
anyway for some reason...?  Oh well, the resulting conflict brought the
problem to light, at least :)

Thanks,

jon
