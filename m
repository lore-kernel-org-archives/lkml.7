Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA58FC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D42064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939895;
	bh=H1tDZvzwDTD/HEEn/0lKOv0+7a2JbpsvU5Jknab2IBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xsoWtyRLBz8nxR+fBa9cTEXKTOAb3G2vRyEdCPv3Hxf9S1wTrUikYV405LFnmDiTV
	 VyiYiKr2e4rQ5o6D0adnFijA2ZDlKr+6YR1aBJP3NPD637Z38uH8Tyt+qJqj2rirt3
	 Ee+l09mQUGxW9a6IRg4kny9ynn/ZKOn5F0R8XZIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfDVNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:31:34 -0400
Received: from casper.infradead.org ([85.118.1.10]:57646 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfDVNbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q6KL5I4jVoQO8RAy9pB/vCGH8qrbuTSbr0+4nRI4u78=; b=PYGwrJSI+PJfANSallDvOmdv3f
        AGZQWl8SckrfnUjk/9s5mANwHc9zvYTzDeYDNgWBCGwesfTqxB5KvZTNTUSLQrJDGzMzAfdlV6XBF
        IH7bufbh/lv8oN+Qusj4t0/EBEAvhhLhwIil/iqXDIwtvPciKvkcQ9ALq0KU3wmp7wPxhTdvLElOA
        FmJ/mnrRM8DM/X73y9ZoBRQFS1iLZPl9+iERGlzYXDbKI5kt93l4qqo33HgjWUtvZ7pyqlAdxbKyU
        RftFX9GHajGqKP/8tTVxeLNjZpZ/9WdbP6hHFSNYEYvmHlugNBGMoFZQnjV+1GbzFEnckKzyhUlsp
        ar17Qp2A==;
Received: from 179.176.125.229.dynamic.adsl.gvt.net.br ([179.176.125.229] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIZ2K-0003bB-8c; Mon, 22 Apr 2019 13:31:08 +0000
Date:   Mon, 22 Apr 2019 10:31:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/57] docs: acpi: convert text files to ReST
Message-ID: <20190422103102.03f9548a@coco.lan>
In-Reply-To: <20190416145518.xigzqsawvbrospir@mail.google.com>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
        <10802a7ac16958a2786c2fc083fb5cb50eb7ebb9.1555382110.git.mchehab+samsung@kernel.org>
        <CAJZ5v0hZK07zQzmD6J0J5dBUAecpE_31_W5Ade5UpWrsWBeU+Q@mail.gmail.com>
        <20190416145518.xigzqsawvbrospir@mail.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Apr 2019 14:55:19 +0000
Changbin Du <changbin.du@gmail.com> escreveu:

> On Tue, Apr 16, 2019 at 10:17:11AM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 16, 2019 at 5:02 AM Mauro Carvalho Chehab
> > <mchehab+samsung@kernel.org> wrote:  
> > >
> > > Most of the files are already in good shape, making easier to
> > > convert them to ReST by adding proper title markups and
> > > addressing some identation and markups to properly format the
> > > document.  
> > 
> > There is concurrent work on this under way, please see
> > https://marc.info/?t=155381845300002&r=2&w=2
> >   
> I will update the serias asap. I am just a little busy these days. My
> conversion includes pci, acpi and x86, others are not touched.

Ok, I sent a new patch series without pci, acpi and x86.

While these aren't merged upstream, I'm keeping my old patches
on my tree:

	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=805b16dd336dd3c27733f02ec8164b2a182972a3
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=c950031ccb87ea14ff4c56f2433072d580db3572
	https://git.linuxtv.org/mchehab/experimental.git/commit/?h=convert_rst_v2&id=4f8afce866dcd8067206b3ee493ed0b682694f49

If you find anything there that would be interesting for your 
series, feel free to pick from them. Everything is based on
linux-next.

Thanks,
Mauro
