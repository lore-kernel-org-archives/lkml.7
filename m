Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DEC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA28725314
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfE3EUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:20:48 -0400
Received: from smtprelay0033.hostedemail.com ([216.40.44.33]:37168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731287AbfE3EUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:20:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C3C53182251B2;
        Thu, 30 May 2019 04:20:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nose55_5a26eccd8617
X-Filterd-Recvd-Size: 1484
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 May 2019 04:20:38 +0000 (UTC)
Message-ID: <a47d7093b10d671ae89fa6f6962d69d6913a30f7.camel@perches.com>
Subject: Re: [PATCH v2] drivers/media/dvb-frontends: Implement probe/remove
 for stv6110x
From:   Joe Perches <joe@perches.com>
To:     Tobias Klausmann <tobias.johannes.klausmann@mni.thm.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, sean@mess.org
Date:   Wed, 29 May 2019 21:20:37 -0700
In-Reply-To: <d1afd4d3-0dc5-718d-f7b4-f763f367ca1e@mni.thm.de>
References: <20190509195118.23027-1-tobias.johannes.klausmann@mni.thm.de>
         <20190529165633.8779-1-tobias.johannes.klausmann@mni.thm.de>
         <bcd12350374533ef090ae911be444e702e85134b.camel@perches.com>
         <d1afd4d3-0dc5-718d-f7b4-f763f367ca1e@mni.thm.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-29 at 21:03 +0200, Tobias Klausmann wrote:
> thanks for the comments! If really desired i can change the code 
> further, adapting to your comments, but note that the code was 
> essentially just moved around to cater to both _probe() and attach(), 
> intentionally leaving it as it was before the patch!

Up to you.
My general preference is for human intelligible and simple code.

