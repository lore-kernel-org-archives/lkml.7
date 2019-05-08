Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9087DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE98216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfEHRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:02:50 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:48850 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728351AbfEHRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:02:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AC1F5180A887B;
        Wed,  8 May 2019 17:02:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wall32_8c725d4b2633f
X-Filterd-Recvd-Size: 1823
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed,  8 May 2019 17:02:44 +0000 (UTC)
Message-ID: <49e0fb2cd3b0a80848f67212167fdbab4b5b8a97.camel@perches.com>
Subject: Re: [PATCH 4/4] checkpatch: replace magic value for TAB size
From:   Joe Perches <joe@perches.com>
To:     Antonio Borneo <borneo.antonio@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 10:02:42 -0700
In-Reply-To: <CAAj6DX3LahQK_t0paVzcTfTsavANXnatgc_vX_1VLPJ9RhsdHQ@mail.gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
         <20190508122721.7513-4-borneo.antonio@gmail.com>
         <73a79b49d0183468a63876b170d1318d38c78d73.camel@perches.com>
         <CAAj6DX3LahQK_t0paVzcTfTsavANXnatgc_vX_1VLPJ9RhsdHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 17:32 +0200, Antonio Borneo wrote:
> On Wed, May 8, 2019 at 4:52 PM Joe Perches <joe@perches.com> wrote:
> ...
> > > In these cases the script will be probably modified and adapted,
> > > so there is no need (at least for the moment) to expose this
> > > setting on the script's command line.
> > 
> > Disagree.  Probably getter to add a --tabsize=<foo> option now.
> 
> Ok, will send a V2 including the command line option.
> Exposing TAB size, makes the option name relevant; should I keep
> "--tabsize" or is "--tab-stop" more appropriate?

--tabsize is probably more appropriate as tab stops are not
always a multiple of a single number.

Unless you really want to get funky and support something like
--tab-stops=7,13,17,...

I don't suggest that.


