Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C86C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC2420857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbfDAH4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:56:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46659 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731944AbfDAH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:56:19 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8F99F2000A;
        Mon,  1 Apr 2019 07:56:16 +0000 (UTC)
Date:   Mon, 1 Apr 2019 09:56:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] rtc: xgene: convert to SPDX identifier
Message-ID: <20190401075614.GB3430@piout.net>
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
 <20190320123233.13519-3-alexandre.belloni@bootlin.com>
 <6dc833be-ed4b-a090-2df7-846ac1c59fc4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc833be-ed4b-a090-2df7-846ac1c59fc4@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 11:20:23+0530, Mukesh Ojha wrote:
> 
> On 3/20/2019 6:02 PM, Alexandre Belloni wrote:
> > Use SPDX-License-Identifier instead of a verbose license text.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com
> 
> 
> Please refer https://lkml.org/lkml/2019/2/13/570 for more discussion on
> this.
> once you fix that in all your SPDX license patches,you can take mine.,
> 

You refer to a totally irrelevant discussion. Please point to what you
think is wrong with that patch.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
