Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1171C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F212084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDIKO4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:14:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbfDIKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6AB98ABD0;
        Tue,  9 Apr 2019 10:14:53 +0000 (UTC)
Date:   Tue, 9 Apr 2019 12:14:49 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 6/6] Input: add IOC3 serio driver
Message-Id: <20190409121449.a6f9a6452751cb61c789365f@suse.de>
In-Reply-To: <20190408190218.GA200740@dtor-ws>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-7-tbogendoerfer@suse.de>
        <20190408190218.GA200740@dtor-ws>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 12:02:18 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Apr 08, 2019 at 04:20:58PM +0200, Thomas Bogendoerfer wrote:
> > This patch adds a platform driver for supporting keyboard and mouse
> > interface of SGI IOC3 chips.
> [...]

Thank you for your feedback, I've changed the code accordingly and will
send a v2 version after testing it.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
