Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F76FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA0021473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfDAQ3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:29:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49333 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfDAQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:29:44 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7733660006;
        Mon,  1 Apr 2019 16:29:42 +0000 (UTC)
Date:   Mon, 1 Apr 2019 18:29:41 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] rtc: pcf85063: convert to SPDX identifier
Message-ID: <20190401162941.GO3430@piout.net>
References: <20190401160816.17859-1-alexandre.belloni@bootlin.com>
 <20190401160816.17859-2-alexandre.belloni@bootlin.com>
 <371999940784dbd281669122c3027805ab0ecfd9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371999940784dbd281669122c3027805ab0ecfd9.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 09:16:58-0700, Joe Perches wrote:
> On Mon, 2019-04-01 at 18:08 +0200, Alexandre Belloni wrote:
> > Use SPDX-License-Identifier instead of a verbose license text.
> > 
> > The original text refers to version 2 so also update MODULE_LICENSE() to
> > "GPL v2" instead of "GPL".
> 
> This is not necessary as GPL is the same as GPL v2
> 

Ok, thanks for clearing that up.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
