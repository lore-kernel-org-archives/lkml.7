Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE560C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974620851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCHX4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:56:07 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:58218 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfCHX4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:56:07 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23993001AbfCHX4D42p0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sat, 9 Mar 2019 00:56:03 +0100
Date:   Fri, 8 Mar 2019 23:56:03 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexandre Oliva <lxoliva@fsfla.org>
cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, Tom Li <tomli@tomli.me>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
In-Reply-To: <orwolaw5u1.fsf@lxoliva.fsfla.org>
Message-ID: <alpine.LFD.2.21.1903082347330.31648@eddie.linux-mips.org>
References: <20190208083038.GA1433@localhost.localdomain>        <orbm3i5xrn.fsf@lxoliva.fsfla.org>        <20190211125506.GA21280@localhost.localdomain>        <orimxq3q9j.fsf@lxoliva.fsfla.org>        <20190211230614.GB22242@darkstar.musicnaut.iki.fi>   
     <orva1jj9ht.fsf@lxoliva.fsfla.org>        <20190217235951.GA20700@darkstar.musicnaut.iki.fi>        <orpnrpj2rk.fsf@lxoliva.fsfla.org>        <alpine.LFD.2.21.1902180227090.15915@eddie.linux-mips.org>        <orlg1ryyo2.fsf@lxoliva.fsfla.org>       
 <alpine.LFD.2.21.1903071744560.7728@eddie.linux-mips.org> <orwolaw5u1.fsf@lxoliva.fsfla.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019, Alexandre Oliva wrote:

> > Does your platform use `war_io_reorder_wmb'?
> 
> Err...  I'm not sure I understand your question.
> 
> It uses it in __BUILD_IOPORT_SINGLE within the expanded out function,
> given !barrier, but you already knew that.
> 
> Did you mean to ask what war_io_reorder_wmb expand to, or whether there
> are other uses of war_io_reorder_wmb, or what?

 Umm, my question was ill-formed, sorry.  There's a convoluted history 
recorded for that macro in the repo and it could be that it can be removed 
now that we have proper barriers in place, except possibly to avoid the 
Octeon Errata Core-301 (whatever that is).

 Anyway I meant: does `war_io_reorder_wmb' expand to `wmb' on your system?

  Maciej
