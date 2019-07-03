Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A62218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGCTQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:16:08 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:35678 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbfGCTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:16:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9890718021864;
        Wed,  3 Jul 2019 19:16:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: farm73_34d274a800e47
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  3 Jul 2019 19:16:02 +0000 (UTC)
Message-ID: <2f19693f2f720dcc037465d4ae517fb846c7eb4f.camel@perches.com>
Subject: Re: [patch v3 1/5] AST2500 DMA UART driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date:   Wed, 03 Jul 2019 12:16:01 -0700
In-Reply-To: <20190703174926.GA12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
         <1561459476-14268-2-git-send-email-open.sudheer@gmail.com>
         <20190703174926.GA12813@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-03 at 19:49 +0200, Greg KH wrote:
> On Tue, Jun 25, 2019 at 04:14:32PM +0530, sudheer.v wrote:
> > +#define UART_TX_R_POINT(x) (0x40 + (x * 0x20))
> > +#define UART_TX_W_POINT(x) (0x44 + (x * 0x20))
> > +#define UART_TX_SDMA_ADDR(x) (0x48 + (x * 0x20))
> > +#define UART_RX_R_POINT(x) (0x50 + (x * 0x20))
> > +#define UART_RX_W_POINT(x) (0x54 + (x * 0x20))
> > +#define UART_RX_SDMA_ADDR(x) (0x58 + (x * 0x20))
> 
> Please use a tab to line these up.

Also x should be surrounded by parentheses

#define UART_TX_R_POINT(x)	(0x40 + ((x) * 0x20))

etc...


