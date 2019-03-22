Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF466C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6685218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 06:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfCVGfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 02:35:22 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56249 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVGfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 02:35:21 -0400
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E3B1D100006;
        Fri, 22 Mar 2019 06:35:18 +0000 (UTC)
Date:   Fri, 22 Mar 2019 07:35:13 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rtc: omap: checkpatch cleanup
Message-ID: <20190322063513.GX29054@piout.net>
References: <20190320124535.14606-1-alexandre.belloni@bootlin.com>
 <20190320124535.14606-3-alexandre.belloni@bootlin.com>
 <20190320133153.GH15782@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320133153.GH15782@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2019 14:31:53+0100, Johan Hovold wrote:
> On Wed, Mar 20, 2019 at 01:45:35PM +0100, Alexandre Belloni wrote:
> > Properly align code with opening parenthesis.
> 
> FWIW, this is a checkpatch --strict warning you're addressing, and not
> something that is enforced by the coding standard.
> 
> Indenting continuation lines at least two tabs further conforms with the
> coding style which says to indent lines substantially to the right (and
> you don't have to run around realigning things should a function call be
> renamed, etc).
> 
> But your call.
> 

That's fine, I can drop that one.

> Johan

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
