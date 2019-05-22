Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7CC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7129120856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbfEVTpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:45:13 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:47657 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731413AbfEVTpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:45:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 4EEC218224D70;
        Wed, 22 May 2019 19:45:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: curve67_2d0c89522f351
X-Filterd-Recvd-Size: 1329
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 19:45:09 +0000 (UTC)
Message-ID: <7b7287463e830fa8d981dc440f8165622cbc628e.camel@perches.com>
Subject: Re: PSA: Do not use "Reported-By" without reporter's approval
From:   Joe Perches <joe@perches.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 12:45:06 -0700
In-Reply-To: <20190522193011.GB21412@chatter.i7.local>
References: <20190522193011.GB21412@chatter.i7.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 15:30 -0400, Konstantin Ryabitsev wrote:
> Hello, all:
> 
> It is common courtesy to include this tagline when submitting patches: 
> 
> Reported-By: J. Doe <jdoe@example.com>
> 
> Please ask the reporter's permission before doing so (even if they'd 
> submitted a public bugzilla report or sent a report to the mailing 
> list).

I disagree with this.

If the report is public, and lists like vger are public,
then using a Reported-by: and/or a Link: are simply useful
history and tracking information.


